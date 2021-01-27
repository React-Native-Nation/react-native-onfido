package com.reactlibrary;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.onfido.android.sdk.capture.DocumentType;
import com.onfido.android.sdk.capture.Onfido;
import com.onfido.android.sdk.capture.ExitCode;
import com.onfido.android.sdk.capture.OnfidoConfig;
import com.onfido.android.sdk.capture.OnfidoFactory;
import com.onfido.android.sdk.capture.errors.OnfidoException;
import com.onfido.android.sdk.capture.ui.camera.face.FaceCaptureStep;
import com.onfido.android.sdk.capture.ui.camera.face.FaceCaptureVariant;
import com.onfido.android.sdk.capture.ui.camera.face.stepbuilder.FaceCaptureStepBuilder;
import com.onfido.android.sdk.capture.ui.options.CaptureScreenStep;
import com.onfido.android.sdk.capture.ui.options.FlowStep;
import com.onfido.android.sdk.capture.upload.Captures;
import com.onfido.android.sdk.capture.utils.CountryCode;

import android.widget.Toast;

import java.util.GregorianCalendar;
import java.util.Locale;


public class OnfidoModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private static final String E_ACTIVITY_DOES_NOT_EXIST = "E_ACTIVITY_DOES_NOT_EXIST";
    private static final String E_FAILED_TO_SHOW_ONFIDO = "E_FAILED_TO_SHOW_ONFIDO";
    private final Onfido client;
    private Callback mSuccessCallback;
    private Callback mErrorCallback;

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(final Activity activity, int requestCode, int resultCode, Intent data) {
            super.onActivityResult(requestCode, resultCode, data);
            client.handleActivityResult(resultCode, data, new Onfido.OnfidoResultListener() {
                @Override
                public void userCompleted(Captures captures) {
                    mSuccessCallback.invoke();
                }

                @Override
                public void userExited(ExitCode exitCode) {
                    mErrorCallback.invoke(exitCode.toString());
                }

                @Override
                public void onError(OnfidoException e) {
                    // mErrorCallback.invoke(e.getMessage());
                }
            });
        }
    };

    public OnfidoModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        client = OnfidoFactory.create(reactContext).getClient();
        this.reactContext.addActivityEventListener(mActivityEventListener);
    }

    @Override
    public String getName() {
        return "Onfido";
    }

    @ReactMethod
    public void startSDK(String type, String token, String applicantId, String countryCode, Callback successCallback, Callback errorCallback) {

        Activity currentActivity = getCurrentActivity();
        mSuccessCallback = successCallback;
        mErrorCallback = errorCallback;

        if (currentActivity == null) {
            mErrorCallback.invoke(E_ACTIVITY_DOES_NOT_EXIST);
            return;
        }

        try {

            OnfidoConfig onfidoConfig = null;
            if(type.equals("full")) {
                final FlowStep[] flowStepsWithOptions = new FlowStep[]{
                        new CaptureScreenStep(DocumentType.NATIONAL_IDENTITY_CARD, CountryCode.CR),
                        new FaceCaptureStep(FaceCaptureVariant.PHOTO),
                };

                onfidoConfig = OnfidoConfig.builder(currentActivity)
                        .withToken(token)
                        .withApplicant(applicantId)
                        .withLocale(new Locale("es", "ES"))
                        .withCustomFlow(flowStepsWithOptions)
                        .build();
            } else if(type.equals("selfie")) {
                FlowStep faceCaptureStep = FaceCaptureStepBuilder.forVideo()
                    .withIntro(false)
                    .build();
                final FlowStep[] flowStepsWithOptions = new FlowStep[]{
                        faceCaptureStep,
                };
                onfidoConfig = OnfidoConfig.builder(currentActivity)
                        .withToken(token)
                        .withApplicant(applicantId)
                        .withLocale(new Locale("es", "ES"))
                        .withCustomFlow(flowStepsWithOptions)
                        .build();
            } else if(type.equals("document")) {
                final FlowStep[] flowStepsWithOptions = new FlowStep[]{
                        new CaptureScreenStep(DocumentType.NATIONAL_IDENTITY_CARD, CountryCode.CR),
                };
                onfidoConfig = OnfidoConfig.builder(currentActivity)
                        .withToken(token)
                        .withApplicant(applicantId)
                        .withLocale(new Locale("es", "ES"))
                        .withCustomFlow(flowStepsWithOptions)
                        .build();
            }
            client.startActivityForResult(currentActivity, 1, onfidoConfig);
        }
        catch (Exception e) {
            mErrorCallback.invoke(E_FAILED_TO_SHOW_ONFIDO);
            mErrorCallback = null;
        }
    }
}