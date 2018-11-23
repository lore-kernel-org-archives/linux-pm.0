From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
Date: Fri, 23 Nov 2018 11:01:21 +0100
Message-ID: <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
        <5BF61B3A.9050402@samsung.com>
        <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
        <5BF7419E.90006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5BF7419E.90006@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo Choi,

On 11/23/18 12:54 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I add one more comment about devfreq_resume_device().
> 
> On 2018년 11월 22일 20:00, Lukasz Luba wrote:
>>
>>
>> On 11/22/18 3:58 AM, Chanwoo Choi wrote:
>>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>>> The patch adds support for handling suspend/resume process.
>>>> It uses atomic variables to make sure no race condition
>>>> affects the process.
>>>>
>>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>>> solve issue with devfreq device's frequency during suspend/resume.
>>>> During the discussion on LKML some corner cases and comments appeared
>>>> related to the design. This patch address them keeping in mind suggestions
>>>> from Chanwoo Choi.
>>>
>>> Please remove the duplicate information about patch history.
>>>
>>>>
>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>>>    1 file changed, 39 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index cf9c643..7e09de8 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>     */
>>>>    int devfreq_suspend_device(struct devfreq *devfreq)
>>>>    {
>>>> -	if (!devfreq)
>>>> -		return -EINVAL;
>>>> +        int ret;
>>>
>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>> because 'ret' is used if suspend_freq isn't zero.
>> Not only there, 6 lines above 'ret' is used for
>> devfreq->governor->event_handler().
> 
> OK.
> 
>>>
>>>> +        unsigned long prev_freq;
>>>> +        u32 flags = 0;
>>>> +
>>>> +        if (!devfreq)
>>>> +                return -EINVAL;
>>>> +
>>>> +        if (devfreq->governor) {
>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>>    
>>>> -	if (!devfreq->governor)
>>>> -		return 0;
>>>> +	if (devfreq->suspend_freq) {
>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>> +			return 0;
>>>>    
>>>> -	return devfreq->governor->event_handler(devfreq,
>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>>>> +					 &prev_freq, flags);
>>>
>>> Remove the 'prev_freq' parameter.
>> OK
>>>
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		devfreq->resume_freq = prev_freq;
>>>
>>> As I commented on patch2, if devfreq_set_taget save the current frequency
>>> to 'devfreq->resume_freq', this line is not needed.
>> OK
>>>
>>>
>>>> +	}
>>>> +
>>>> +        return 0;
>>>>    }
>>>>    EXPORT_SYMBOL(devfreq_suspend_device);
>>>>    
>>>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>     */
>>>>    int devfreq_resume_device(struct devfreq *devfreq)
>>>>    {
>>>> +        int ret;
>>>
>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>> because 'ret' is used if suspend_freq isn't zero.
>> OK
> 
> If you change the devfreq_resume_device() according to my new comment,
> please ignore it.
> 
>>>
>>>> +        unsigned long prev_freq;
>>>
>>> Remove prev_freq variable which is not used on this function.
>>> After calling devfreq_set_target, prev_freq is not used.
>> OK
>>>
>>>> +        u32 flags = 0;
>>>> +
>>>>    	if (!devfreq)
>>>>    		return -EINVAL;
>>>>    
>>>> +	if (devfreq->suspend_freq) {
>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>> +			return 0;
>>>> +
>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>>>> +					 &prev_freq, flags);
>>>
>>> Remove the 'prev_freq' parameter.
>> OK
>>>
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>>    	if (!devfreq->governor)
>>>>    		return 0;
> 
> Please change the code as following because you uses the following type
> in the devfreq_suspend_device(). If there is any special issue, please
> keep the same format in order to improve the readability.
> 
> 	if (devfreq->governor) {
> 		ret = devfreq->governor->event_handler(devfreq,
> 				DEVFREQ_GOV_RESUME, NULL);
> 		if (ret)
> 			return ret;
> 	}
> 
> 
OK, I will change the code to keep the same format.
Thank you for the review.

Regards,
Lukasz
