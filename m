From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Date: Wed, 5 Dec 2018 12:07:37 +0100
Message-ID: <60b64304-2aa9-2831-d94f-610be31b4e8e@partner.samsung.com>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
        <5C061A57.7040002@samsung.com>
        <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
        <5C071740.7090000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C071740.7090000@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 12/5/18 1:09 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 04일 18:53, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 12/4/18 7:10 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> I add the comment about 'suspend_count'.
>>>
>>> On 2018년 12월 04일 14:43, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2018년 12월 04일 14:36, Chanwoo Choi wrote:
>>>>> Hi Lukasz,
>>>>>
>>>>> Looks good to me. But, I add the some comments.
>>>>> If you will fix it, feel free to add my tag:
>>>>> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>>>>
>>>> Sorry. Fix typo 'choi' to 'Choi' as following.
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>>>
>>>>> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>>>>>> The patch prepares devfreq device for handling suspend/resume
>>>>>> functionality.  The new fields will store needed information during this
>>>>>
>>>>> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'.
>>>>>
>>>>>> process.  Devfreq framework handles opp-suspend DT entry and there is no
>>>>>
>>>>> ditto.
>>>>>
>>>>>> need of modyfications in the drivers code.  It uses atomic variables to
>>>>>
>>>>> ditto.
>>>>>
>>>>>> make sure no race condition affects the process.
>>>>>>
>>>>>> The patch is based on earlier work by Tobias Jakobi.
>>>>>
>>>>> Please remove it from each patch description.
>>>>>
>>>>>>
>>>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>>> ---
>>>>>>    drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>>>>>    include/linux/devfreq.h   |  7 +++++++
>>>>>>    2 files changed, 50 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index a9fd61b..36bed24 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>>>>    			"Couldn't update frequency transition information.\n");
>>>>>>    
>>>>>>    	devfreq->previous_freq = new_freq;
>>>>>> +
>>>>>> +	if (devfreq->suspend_freq)
>>>>>> +		devfreq->resume_freq = cur_freq;
>>>>>> +
>>>>>>    	return err;
>>>>>>    }
>>>>>>    
>>>>>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>    	}
>>>>>>    	devfreq->max_freq = devfreq->scaling_max_freq;
>>>>>>    
>>>>>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>>>> +	atomic_set(&devfreq->suspend_count, 0);
>>>>>> +
>>>>>>    	dev_set_name(&devfreq->dev, "devfreq%d",
>>>>>>    				atomic_inc_return(&devfreq_no));
>>>>>>    	err = device_register(&devfreq->dev);
>>>>>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>>>     */
>>>>>>    int devfreq_suspend_device(struct devfreq *devfreq)
>>>>>>    {
>>>>>> +	int ret;
>>>>>> +
>>>>>>    	if (!devfreq)
>>>>>>    		return -EINVAL;
>>>>>>    
>>>>>> -	if (!devfreq->governor)
>>>>>> -		return 0;
>>>>>> +	if (devfreq->governor) {
>>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (devfreq->suspend_freq) {
>>>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>>>> +			return 0;
>>>>>> +
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>
>>> In this patch, if some users call 'devfreq_suspend_device' twice,
>>> 'devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL)'
>>> is called twice but devfreq_set_target() is called only one.
>>> I knew that it is no problem for operation.
>>>
>>> But,
>>> I think that you better to use 'suspend_count' as the reference count
>>> of devfreq_suspend/resume_device(). But, if you use 'suspend_count'
>>> in order to check whether this devfreq is suspended or not,
>>> we can reduce the unneeded redundant call when calling it twice.
>>>
>>> clock and regulator used the 'reference count' method in order to
>>> remove the redundant call.
>>
>> I think I've got the point. I will move the atomic check just
>> after the !devfreq check. Something like the code bellow is what you
>> would like to see?
>> ---8<-----
>> if (!devfreq)
>> 	return -EINVAL;
>> if (atomic_inc_return(&devfreq->suspend_count) > 1)
>> 	return0;
> 
> Looks good to me. I agree.
OK
> 
>>
>> ---->8-------
>>>
>>>
>>>>>>    
>>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +	return 0;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>    
>>>>>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>     */
>>>>>>    int devfreq_resume_device(struct devfreq *devfreq)
>>>>>>    {
>>>>>> +	int ret;
>>>>>> +
>>>>>>    	if (!devfreq)
>>>>>>    		return -EINVAL;
>>>>>>    
>>>>>> -	if (!devfreq->governor)
>>>>>> -		return 0;
>>>>>> +	if (devfreq->resume_freq) {
>>>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>>>> +			return 0;
>>>
>>> ditto.
>> Same approach here:
>> ---8<-----
>> if (!devfreq)
>> 	return -EINVAL;
>> if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>> 	return 0;
> 
> Looks good to me.
Thank you. The patch set v3 is going to be sent.

Regards,
Lukasz

> 
>> ---->8-------
>>
>> Regards,
>> Lukasz
>>>
>>>>>>    
>>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>>> -				DEVFREQ_GOV_RESUME, NULL);
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (devfreq->governor) {
>>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>>> +					DEVFREQ_GOV_RESUME, NULL);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(devfreq_resume_device);
>>>>>>    
>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>> index e4963b0..d985199 100644
>>>>>> --- a/include/linux/devfreq.h
>>>>>> +++ b/include/linux/devfreq.h
>>>>>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>>>>>     * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>>>>     * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>>>>     * @stop_polling:	 devfreq polling status of a device.
>>>>>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>>>>>> + * @resume_freq:	 frequency of a device set in resume phase.
>>>>>> + * @suspend_count:	 suspend requests counter for a device.
>>>>>>     * @total_trans:	Number of devfreq transitions
>>>>>>     * @trans_table:	Statistics of devfreq transitions
>>>>>>     * @time_in_state:	Statistics of devfreq states
>>>>>> @@ -167,6 +170,10 @@ struct devfreq {
>>>>>>    	unsigned long scaling_max_freq;
>>>>>>    	bool stop_polling;
>>>>>>    
>>>>>> +	unsigned long suspend_freq;
>>>>>> +	unsigned long resume_freq;
>>>>>> +	atomic_t suspend_count;
>>>>>> +
>>>>>>    	/* information for device frequency transition */
>>>>>>    	unsigned int total_trans;
>>>>>>    	unsigned int *trans_table;
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 
