From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the
 controller is idle
Date: Mon, 4 Mar 2019 10:14:50 -0700
Message-ID: <20190304171450.GB10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
 <20190221121827.32427-3-rplsssn@codeaurora.org>
 <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
 <20190227222913.GA10971@codeaurora.org>
 <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 01 2019 at 10:58 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-02-27 14:29:13)
>> Hi Stephen,
>>
>> On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
>> >Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
>> >> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> >> index d6b834eeeb37..9cc303e88a06 100644
>> >> --- a/drivers/soc/qcom/rpmh-rsc.c
>> >> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> >> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> >>         return ret;
>> >>  }
>> >>
>> >> +/**
>> >> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> >> + *
>> >> + *  @drv: The controller
>> >> + *
>> >> + *  Returns true if the TCSes are engaged in handling requests.
>
>By the way, this says AMCs are busy and then TCSes are engaged. Which
>one is it?
>
>> >> + */
>> >> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> >> +{
>> >
>> >This API seems inherently racy. How do we know that nothing else is
>> >going to be inserted into the TCS after this function returns true? Do
>> >you have a user of this API? It would be good to know how it is used
>> >instead of adding some code that never gets called.
>> >
>> This API is called from the last CPU that is powering down in an
>> interrupt locked context (say during suspend). If we are waiting on a
>> request, we would bail out of the suspend process. There can be no issue
>> requested during the last step in suspend. The PM driver itself does not
>> make any TCS request. Currently, this API is used by the downstream code
>> in its last man activities. The usage by platform coordinated mode is
>> still under discussion.
>>
>
>Ok, can you explain why it's even a problem for the TCSes to be active
>during suspend? I would hope that for suspend/resume, if this is
>actually a problem, the RPMh driver itself can block suspend with a
>driver suspend callback that checks for idleness.
The RSC can transmit TCS executed from Linux and when all the CPUs have
powered down, could execute a firmware in the RSC to deliver the sleep
state requests. The firmware cannot run when there are active requests
being processed. To ensure that case, we bail out of sleep or suspend,
when the last CPU is powering down, if there are active requests.

>But I suspect that in
>the system wide suspend/resume case, any callers that could make TCS
>requests are child devices of the RPMh controller and therefore they
>would already be suspended if they didn't have anything pending they're
>waiting for a response on or they would be blocking suspend themselves
>if they're waiting for the response. So why are we even checking the
>TCSes in system suspend path at all? Assume that callers know what
>they're doing and will block suspend if they care?
>
In suspend, they probably would do what you mention above. All CPUs
might conincidentally be idle at the same idle, when a request is being
processed.

>Following that same logic, is this more of an API that is planned for
>use by CPU idle? Where the case is much more of a runtime PM design.
>Even then, I don't get it. A device that's runtime active and making
>RPMh requests might need to block some forms of CPU idle states because
>a request hasn't been processed yet that may change the decision for
>certain deep idle states?
>
A process waiting on a RPMH request, may let the CPU go to sleep and
therefore this is a possibility.

--Lina
