From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 04/10] power: bq24257: Allow manual setting of input
 current limit
Date: Thu, 17 Sep 2015 09:10:14 +0900
Message-ID: <55FA04E6.8060903@samsung.com>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-5-git-send-email-dannenberg@ti.com>
 <55F8BACD.6090402@samsung.com> <20150916192257.GB27772@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63905 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbIQAKS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 20:10:18 -0400
In-reply-to: <20150916192257.GB27772@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 17.09.2015 04:23, Andreas Dannenberg wrote:
> On Wed, Sep 16, 2015 at 09:41:49AM +0900, Krzysztof Kozlowski wrote:
>>> -		reset_iilimit = true;
>>> -	} else if (old_state.fault == FAULT_NO_BAT) {    /* battery connected */
>>> -		config_iilimit = true;
>>> -	} else if (new_state->fault == FAULT_TIMER) { /* safety timer expired */
>>> +			reset_iilimit = true;
>>> +		}
>>> +	} else if (!old_state.power_good) {
>>> +		dev_dbg(bq->dev, "Power inserted\n");
>>> +		config_iilimit = !bq->in_ilimit_autoset_disable;
>>> +	} else if (new_state->fault == FAULT_NO_BAT) {
>>> +		dev_warn(bq->dev, "Battery removed\n");
>>
>> dev_warn? This wasn't here before... It's a bit too serious. Is removing
>> a battery an error condition? Maybe user just unplugged it?
>> dev_dbg or dev_info should be sufficient.
>>
>> BTW, it is useful to quickly find boot regressions with "dmesg -l
>> warn,err". Removing a battery probably is not an error?
> 
> I would argue that most devices that use a Li-Ion battery have the
> battery built-in and it's not user removable. Therefore, if the battery
> would ever go disconnected I figured it'll most likely be something
> serious such as a contact breaking loose or something else dramatic,
> warranting at least a warning. Plus, many devices with built in Li-Ion
> batteries are actually designed in a way that they don't really function
> properly with the battery taken out as the HW is often designed to draw
> supplemental current from the battery during times of load in addition
> to the A/C supply (key feature of many charger chips).

Okay, I guess if there ever will be an user annoyed by dmesg's after
removing the battery we can always revisit this. :)

> 
>>
>>> +		if (!bq->in_ilimit_autoset_disable) {
>>> +			cancel_delayed_work_sync(&bq->iilimit_setup_work);
>>> +			reset_iilimit = true;
>>> +		}
>>> +	} else if (old_state.fault == FAULT_NO_BAT) {
>>> +		dev_warn(bq->dev, "Battery connected\n");
>>
>> Definitely not a warn. Inserting a battery is not an error condition.
> 
> Same as above.

OK

> 
>>> +		config_iilimit = !bq->in_ilimit_autoset_disable;
>>> +	} else if (new_state->fault == FAULT_TIMER) {
>>>  		dev_err(bq->dev, "Safety timer expired! Battery dead?\n");
>>>  	}
>>
>> Don't you have a schedule_delayed_work() call here which now will be
>> executed always? Even when work was not INIT and nothing will cancel it?
> 
> It'll be more obvious when looking at the merged code but the schedule_
> delayed_work() call only happens if config_iilimit==true which only
> happens when the input limit current autoset functionality is not
> disabled. If that's the case (autoset functionality is enabled) the INIT
> for that work is executed during probe.
>  

OK

>>>  
>>> @@ -581,7 +601,16 @@ static int bq24257_hw_init(struct bq24257_device *bq)
>>>  	bq->state = state;
>>>  	mutex_unlock(&bq->lock);
>>>  
>>> -	if (!state.power_good)
>>> +	if (bq->in_ilimit_autoset_disable) {
>>> +		dev_dbg(bq->dev, "manually setting iilimit = %d\n",
>>> +			bq->init_data.in_ilimit);
>>
>> Nit, no actual difference but makes more sense to me because field is
>> u8: "%u".
> 
> Yes that should be changed.
> 
>>> +
>>> +		/* program fixed input current limit */
>>> +		ret = bq24257_field_write(bq, F_IILIMIT,
>>> +					  bq->init_data.in_ilimit);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	} else if (!state.power_good)
>>>  		/* activate D+/D- detection algorithm */
>>>  		ret = bq24257_field_write(bq, F_DPDM_EN, 1);
>>>  	else if (state.fault != FAULT_NO_BAT)
>>> @@ -659,6 +688,7 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
>>>  	int ret;
>>>  	u32 property;
>>>  
>>> +	/* Required properties */
>>>  	ret = device_property_read_u32(bq->dev, "ti,charge-current", &property);
>>>  	if (ret < 0)
>>>  		return ret;
>>> @@ -682,6 +712,24 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
>>>  	bq->init_data.iterm = bq24257_find_idx(property, bq24257_iterm_map,
>>>  					       BQ24257_ITERM_MAP_SIZE);
>>>  
>>> +	/* Optional properties. If not provided use reasonable default. */
>>> +	ret = device_property_read_u32(bq->dev, "ti,current-limit",
>>> +				       &property);
>>> +	if (ret < 0)
>>> +		/*
>>> +		 * Explicitly set a default value which will be needed for
>>> +		 * devices that don't support the automatic setting of the input
>>> +		 * current limit through the charger type detection mechanism.
>>> +		 */
>>> +		bq->init_data.in_ilimit = IILIMIT_500;
>>> +	else {
>>> +		bq->in_ilimit_autoset_disable = true;
>>> +		bq->init_data.in_ilimit =
>>> +				bq24257_find_idx(property,
>>> +						 bq24257_iilimit_map,
>>> +						 BQ24257_IILIMIT_MAP_SIZE);
>>> +	}
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -740,8 +788,6 @@ static int bq24257_probe(struct i2c_client *client,
>>>  
>>>  	i2c_set_clientdata(client, bq);
>>>  
>>> -	INIT_DELAYED_WORK(&bq->iilimit_setup_work, bq24257_iilimit_setup_work);
>>> -
>>>  	if (!dev->platform_data) {
>>>  		ret = bq24257_fw_probe(bq);
>>>  		if (ret < 0) {
>>> @@ -752,6 +798,18 @@ static int bq24257_probe(struct i2c_client *client,
>>>  		return -ENODEV;
>>>  	}
>>>  
>>> +	/*
>>> +	 * The BQ24250 doesn't support the D+/D- based charger type detection
>>> +	 * used for the automatic setting of the input current limit setting so
>>> +	 * explicitly disable that feature.
>>> +	 */
>>> +	if (bq->chip == BQ24250)
>>> +		bq->in_ilimit_autoset_disable = true;
>>> +
>>> +	if (!bq->in_ilimit_autoset_disable)
>>
>> In most places you have quite obfuscated negation of
>> "autoset_disable"... So maybe just "bq->in_ilimit_autoset" or
>> "bq->in_ilimit_autoset_enable" and the negation won't be needed? It
>> could be more readable.
> 
> This stems from the fact that this was initially tied to a boolean DT
> property with the same name which is no longer there. The other reason
> was setting this property to non-zero changes the default behavior of
> the driver (that used to have autoset always enabled) so I wanted to
> reflect this behavior in the logic. The driver was tested pretty well so
> unless you feel strongly about this I would rather leave it as-is.

IMHO the code would be more readable but I don't insist.

Best regards,
Krzysztof

