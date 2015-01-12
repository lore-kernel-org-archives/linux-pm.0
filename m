From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv7 03/10] devfreq: event: Add resource-managed function for
 devfreq-event device
Date: Mon, 12 Jan 2015 17:55:35 +0900
Message-ID: <54B38C07.2010801@samsung.com>
References: <765071676.891461421049614417.JavaMail.weblogic@epmlwas09a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <765071676.891461421049614417.JavaMail.weblogic@epmlwas09a>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

Thanks for your review.

On 01/12/2015 05:00 PM, MyungJoo Ham wrote:
>>   
>>  This patch add the resource-managed function for devfreq-event device as
>> following functions. The devm_devfreq_event_add_edev() manages automatically
>> the memory of devfreq-event device using resource management.
>> - devm_devfreq_event_add_edev()
>> - devm_devfreq_event_remove_edev()
>>
>> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq-event.c | 63 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/devfreq-event.h   | 16 +++++++++++
>>  2 files changed, 79 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>> index 64c1764..5301e2b 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>> @@ -451,6 +451,69 @@ int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
>>  }
>>  EXPORT_SYMBOL_GPL(devfreq_event_remove_edev);
>>  
>> +static int devm_devfreq_event_match(struct device *dev, void *res, void *data)
>> +{
>> +	struct devfreq_event_dev **r = res;
>> +
>> +	if (WARN_ON(!r || !*r))
>> +		return 0;
>> +
>> +	return *r == data;
>> +}
>> +
>> +static void devm_devfreq_event_release(struct device *dev, void *res)
>> +{
>> +	devfreq_event_remove_edev(*(struct devfreq_event_dev **)res);
>> +}
> 
> Isn't dev-free functions supposed to check if it is already freed or not?

The devfreq_event_remove_edev() function check whether res is NULL or not.
If some instance of devfreq_event_dev is freeed, devfreq_event_remove_edev()
just return.

> 
>> +
>> +/**
>> + * devm_devfreq_event_add_edev() - Resource-managed devfreq_event_add_edev()
>> + * @dev		: the device owning the devfreq-event device being created
>> + * @desc	: the devfreq-event device's decriptor which include essential
>> + *		  data for devfreq-event device.
>> + *
>> + * Note that this function manages automatically the memory of devfreq-event
>> + * device using device resource management and simplify the free operation
>> + * for memory of devfreq-event device.
>> + */
>> +struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
>> +						struct devfreq_event_desc *desc)
>> +{
>> +	struct devfreq_event_dev **ptr, *edev;
>> +
>> +	ptr = devres_alloc(devm_devfreq_event_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	edev = devfreq_event_add_edev(dev, desc);
>> +	if (IS_ERR(edev)) {
>> +		devres_free(ptr);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	*ptr = edev;
>> +	devres_add(dev, ptr);
>> +
>> +	return edev;
>> +}
>> +EXPORT_SYMBOL(devm_devfreq_event_add_edev);
> 
> You are using GPL Symbol in this function (devres_alloc).

I'll fix it. (EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL).

> 
>> +
>> +/**
>> + * devm_devfreq_event_remove_edev()- Resource-managed devfreq_event_remove_edev()
>> + * @dev		: the device owning the devfreq-event device being created
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function manages automatically the memory of devfreq-event
>> + * device using device resource management.
>> + */
>> +void devm_devfreq_event_remove_edev(struct device *dev,
>> +				struct devfreq_event_dev *edev)
>> +{
>> +	WARN_ON(devres_release(dev, devm_devfreq_event_release,
>> +			       devm_devfreq_event_match, edev));
>> +}
>> +EXPORT_SYMBOL(devm_devfreq_event_remove_edev);
> 
> Here you are using GPL symbol as well (devres_release).

I'll fix it. (EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL).

Best Regards,
Chanwoo Choi
