From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv8 1/9] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
Date: Tue, 20 Jan 2015 16:25:39 +0900
Message-ID: <54BE02F3.4060808@samsung.com>
References: <213049974.1319841421737167629.JavaMail.weblogic@epmlwas04a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <213049974.1319841421737167629.JavaMail.weblogic@epmlwas04a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

On 01/20/2015 03:59 PM, MyungJoo Ham wrote:
>>  
>> Dear Myungjoo,
>>
>> On 01/20/2015 01:34 PM, MyungJoo Ham wrote:
>>>>   
> []
>>>> +
>>>> +	mutex_lock(&edev->lock);
>>>> +	if (edev->desc->ops && edev->desc->ops->enable) {
>>>> +		ret = edev->desc->ops->enable(edev);
>>>> +		if (ret < 0)
>>>> +			goto err;
>>>> +	}
>>>
>>> Is there any reason to call enable(edev) even when enable_count is already > 0 
>>> while you do not call disable(edev) while enable_count > 0?
>>>
>>> I think this may incur errors in the related device drivers.
>>> (e.g., incorrect pairing of clk/runtime-pm/regulator enable/disable
>>> at the device driver side)
>>
>> You're right. This part has potential errors. I'll fix it as following:
>> If edev is already enabled, devfreq_event_enable_edev() will just return
>> without any operation because devfreq-event(edev) can handle only one event
>> at the same time.
>>
>> 	mutex_lock(&edev->lock);
>> 	if (edev->enable_count)
>> 		dev_warn(&edev->dev, "%s is already enabled\n", edev->desc->name);
>> 		ret = -EINVAL;
>> 		goto err;
>> 	}
>>
>> 	if (edev->desc->ops && edev->desc->ops->enable) {		
>> 		ret = edev->desc->ops->enable(edev);
>> 		if (ret < 0)
>> 			goto err;
>> 	}
>> 	edev->enable_count++;
> 
> No, your suggested modification creates another bug.
> 
> It should not emit "warn" when enable_count > 0 at enable().
> It is a natural behavior from drivers.
> - You may have multiple drivers using edev.
> - You may have multiple threads using edev.

The devfreq-event cannot be used in multiple drivers in current version
If multiple driver set the event to devfreq-event device by using
devfreq_event_set_event() at the same time, previous event will be ignored.

If multiple drivers want to use devfreq-event device at the same time,
I have to implement additional feature.

> 
> Thus, the above 12 lines should be replaced with:
> 
> 	if (edev->desc->ops && edev->desc->ops->enable &&
> 	    edev->enable_count == 0) {
> 		ret = edev->desc->ops->enable(edev);
> 		if (ret < 0)
> 			goto err;
> 	}
> 	edev->enable_count++;
> 
>> 	
>>
>>>
>>>> +	edev->enable_count++;
>>>> +err:
>>>> +	mutex_unlock(&edev->lock);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(devfreq_event_enable_edev);
>>>> +
>>>> +/**
>>>> + * devfreq_event_disable_edev() - Disable the devfreq-event dev and decrease
>>>> + *				  the enable_count of the devfreq-event dev.
>>>> + * @edev	: the devfreq-event device
>>>> + *
>>>> + * Note that this function decrease the enable_count and disable the
>>>> + * devfreq-event device. After the devfreq-event device is disabled,
>>>> + * devfreq device can't use the devfreq-event device for get/set/reset
>>>> + * operations.
>>>> + */
>>>> +int devfreq_event_disable_edev(struct devfreq_event_dev *edev)
>>>> +{
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!edev || !edev->desc)
>>>> +		return -EINVAL;
>>>> +
>>>> +	mutex_lock(&edev->lock);
>>>> +	if (edev->enable_count > 0) {
>>>> +		edev->enable_count--;
>>>> +	} else {
>>>> +		dev_warn(&edev->dev, "unbalanced enable_count\n");
>>>> +		ret = -EINVAL;
>>>> +		goto err;
>>>> +	}
>>>> +
>>>> +	if (edev->desc->ops && edev->desc->ops->disable) {
>>>> +		ret = edev->desc->ops->disable(edev);
>>>> +		if (ret < 0) {
>>>> +			edev->enable_count++;
>>>> +			goto err;
>>>> +		}
> 
> Anyway, have you seen other subsystems doing fall-back operations as you've
> done by "edev->enable_count++" here? Or is this your own idea on falling back
> from errors with a disable callback?

I removed "edev->enable_count++" when fail to diable devfreq-event
and modify it as following:

	+int devfreq_event_disable_edev(struct devfreq_event_dev *edev)
	+{
	+	int ret = 0;
	+
	+	if (!edev || !edev->desc)
	+		return -EINVAL;
	+
	+	mutex_lock(&edev->lock);
	+	if (!edev->enable_count) {
	+		dev_warn(&edev->dev,
	+			"%s is already disabled\n", edev->desc->name);
	+		goto err;
	+	}
	+	
	+	if (edev->desc->ops && edev->desc->ops->disable) {
	+		ret = edev->desc->ops->disable(edev);
	+		if (ret < 0)
	+			goto err;
	+	}
	+	edev->enable_count--;
	+err:
	+	mutex_unlock(&edev->lock);
	+
	+	return ret;
	+}
	+EXPORT_SYMBOL_GPL(devfreq_event_disable_edev);

> 
>>>> +	}
>>>
>>> You did it correctly with disable here;
>>> not calling it when it is not required.
> 
> Uh..yeah.. the original patch was incorrect..
> 
>>
>> As I explained, I'll fix it as following:
>>
>> 	mutex_lock(&edev->lock);
>> 	if (!edev->enable_count) {
>> 		dev_warn(&edev->dev, "%s is already disabled\n", edev->desc->name);
>> 		ret = -EINVAL;
>> 		goto err;
>> 	}
>>
>> 	if (edev->desc->ops && edev->desc->ops->disable) {
>> 		ret = edev->desc->ops->disable(edev);
>> 		if (ret < 0)
>> 			goto err;		
>> 	}
>> 	edev->enable_count--;
> 
> Uh.... I'd say it is still incorrect.

I explained it about this problem on the upper.

> 
> 	mutex_lock(&edev->lock);
> 	if (!edev->enable_count) {
> 		dev_warn(&edev->dev, "%s is already disabled\n", edev->desc->name);
> 		ret = -EINVAL;
> 		goto err;
> 	}
> 
> 	edev->enable_count--;
> 	if (edev->desc->ops && edev->desc->ops->disable &&
> 	    !edev->enable_count) {
> 		ret = edev->desc->ops->disable(edev);
> 		if (ret < 0)
> 			goto err;		
> 	}

[snip]

Best Regards,
Chanwoo Choi
