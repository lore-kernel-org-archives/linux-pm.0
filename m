From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the
 controller is idle
Date: Wed, 27 Feb 2019 15:29:13 -0700
Message-ID: <20190227222913.GA10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
 <20190221121827.32427-3-rplsssn@codeaurora.org>
 <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
>Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index d6b834eeeb37..9cc303e88a06 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>         return ret;
>>  }
>>
>> +/**
>> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> + *
>> + *  @drv: The controller
>> + *
>> + *  Returns true if the TCSes are engaged in handling requests.
>> + */
>> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> +{
>
>This API seems inherently racy. How do we know that nothing else is
>going to be inserted into the TCS after this function returns true? Do
>you have a user of this API? It would be good to know how it is used
>instead of adding some code that never gets called.
>
This API is called from the last CPU that is powering down in an
interrupt locked context (say during suspend). If we are waiting on a
request, we would bail out of the suspend process. There can be no issue
requested during the last step in suspend. The PM driver itself does not
make any TCS request. Currently, this API is used by the downstream code
in its last man activities. The usage by platform coordinated mode is
still under discussion.

-- Lina
>> +       int m;
>> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +
>> +       spin_lock(&drv->lock);
>> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +               if (!tcs_is_free(drv, m)) {
>> +                       spin_unlock(&drv->lock);
>> +                       return false;
>> +               }
>> +       }
>> +       spin_unlock(&drv->lock);
>> +
>> +       return true;
>> +}
>> +
>>  /**
>>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>>   *
>
