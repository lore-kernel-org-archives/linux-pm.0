From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 13/13] dt: power: bq24257-charger: Cover additional devices
Date: Thu, 03 Sep 2015 10:31:20 +0900
Message-ID: <55E7A2E8.2060306@samsung.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-14-git-send-email-dannenberg@ti.com>
 <CAJKOXPeyMeUUon0E9Fhm18SHJEaQPEbGAWwU+MKwgt-30AXHiA@mail.gmail.com>
 <20150902140332.GA24076@borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39373 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046AbbICBb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 21:31:27 -0400
In-reply-to: <20150902140332.GA24076@borg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 02.09.2015 23:03, Andreas Dannenberg wrote:
> Hi Krzysztof, thanks for your feedback... comments below.
> 
> On Wed, Sep 02, 2015 at 02:24:05PM +0900, Krzysztof Kozlowski wrote:
>> 2015-09-01 11:10 GMT+09:00 Andreas Dannenberg <dannenberg@ti.com>:
>>> --- a/Documentation/devicetree/bindings/power/bq24257.txt
>>> +++ b/Documentation/devicetree/bindings/power/bq24257.txt
>>> @@ -2,20 +2,71 @@ Binding for TI bq24257 Li-Ion Charger
>>>
>>>  Required properties:
>>>  - compatible: Should contain one of the following:
>>> + * "ti,bq24250"
>>> + * "ti,bq24251"
>>>   * "ti,bq24257"
>>> -- reg:                    integer, i2c address of the device.
>>> +- reg: integer, i2c address of the device.
>>> +- stat-gpio: GPIO used for the devices STAT_IN pin. Alternatively the pin can
>>> +    also be defined through the standard interrupt definition properties (see
>>> +    optional properties section below). Only use one method.
>>
>> Preferred suffix should be "gpios":
>> Documentation/devicetree/bindings/gpio/gpio.txt
> 
> Did not know this. Thanks for pointing to the src document. Will fix.
> 
>>> +Optional properties:
>>> +- ti,in-ilimit-autoset-disable: If this boolean property is present it disables
>>
>> I thought "ilimit" is a typo but apparently not :) . The names of this
>> property and "ti,in-limit-current" below are quite obfuscated. I am
>> thinking about different names but first I would like to understand
>> the feature: what do you mean by "automatic setting of the input
>> current limit"? Like adjusting the limit of possible current to given
>> charger type?
> 
> Yes that's right. Some of the chargers can check the USB D+/D- lines to
> determine what kind of charger is attached (DCP, CDP, SDP, other) - see
> bq24257 device datasheet for more info:
> http://www.ti.com/product/bq24257
> 
> And this feature is being used in the original driver Laurentiu
> developed. However this detection mechanism (or any detection mechanism
> in general) may not always be appropriate hence the new property to
> disable it and manually provide an input current limit of how much can
> be drawn from the charger. Plus it's needed for devices that don't have
> the D+/D- detection feature.

Thanks for explanation. How about leaving only "ti,in-limit-current"
(get rid of "ti,in-ilimit-autoset-disable"). If it is present then the
autodetection/autoset would be disabled.

> 
>>
>>> +    the automatic setting of the input current limit. This property is also set
>>> +    implicitly on devices without charger type detection. If this property is
>>> +    provided the input current limit should be set manually through
>>> +    "ti,in-limit-current".
>>> +- ti,in-limit-current: The maximum current to be drawn from the charger's input
>>> +    (in uA). Use this for devices that don't have charger type detection or if
>>> +    you have have set "ti,in-ilimit-autoset-disable".
>>> +- ti,vovp-voltage: Configures the over voltage protection voltage (in uV).
>>> +- ti,vindpm-voltage:  Configures the threshold input voltage for the dynamic
>>> +    power path management (in uV).
>>
>> I think the leading 'v' could be removed, so "ti,ovp-voltage" and
>> "ti,in-dpm-voltage"?
> 
> Yes I was thinking about this but then went with something that closely
> reflects the device datasheets to maximize correlation. Removing the 'v'
> would make it look cleaner and more universal and I suppose it's not to
> far of a stretch for someone to associate "ti,ovp-voltag" with the VOVP
> bit field in the devices register map. So let's change it.

Thanks. Bindings don't have to follow naming convention of company's
datasheet.

> 
>>
>>> +- ti,pg-gpio-disable: If this boolean property is provided a software-based
>>> +    approach for power good determination is used. Note that the PG-pin based
>>> +    approach is generally preferable.
>>
>> That's confusing. If someone does not want to use pg-gpio then he
>> could just skip the "pg-gpio" property?
> 
> Yes that's right. Somebody might chose to do so because they don't want
> to sacrifice the extra pin. And I need to accommodate for devices that
> don't have a PG pin so the logic behind this had to be implemented
> anyways. I just made it accessible. What about I work on improving that
> explanation hopefully to make it less confusing.

I still don't get why you need extra "ti,pg-gpio-disable" property. It
could work like this:
1. Get rid of "ti,pg-gpio-disable" and make "pg-gpio" optional.
2. If it is present, use it.
3. If it is not present, use software based approach (the same as
setting "ti,pg-gpio-disable" previously).

Would that work?

>>
>>> +- ti,timer-2x-enable: If this boolean property is provided the device's safety
>>> +    timer is extended by a factor of two.
>>
>> Boolean properties like this have disadvantage - they cannot be
>> overridden. Also extending them is difficult (e.g. for some next
>> device the timer could have value of 4). Usually it is better to have
>> a value-based property with "0" meaning default or disabled.
> 
> When I looked through the Kernel headers I found the boolean property
> parse function and figured that's probably what I should be using. But
> as I was implementing it I had similar concerns to what you mentioned.
> If it's general practice to prefer the value based properties I'll be
> happy to change that.

Usually the boolean is a good choice but here you used it for a
numerical property. You are preparing a generic TI bindings so it is
wise to think about other future drivers. Would they have other values
for timer factor? Would you want to set it in common board DTSI and
override it in some one specific child DTS?

Best regards,
Krzysztof

> 
>>
>> Also please look at existing bindings:
>> $ git grep "ti," Documentation/devicetree/bindings/power
>> Maybe you could reuse some? Each of these existing and new bindings
>> are made generic (not device specific) so they should be reused.
> 
> Already spent time with existing bqXXXXX drivers to see if I can recycle
> properties. Will give it another run-through to make sure there is
> maximum re-use.
> 
> Thanks,
> 
> --
> Andreas Dannenberg
> Texas Instruments Inc
> 
>>
>> Best regards,
>> Krzysztof
>>
>>> +- interrupt-parent: Should be the phandle for the interrupt controller. Use in
>>> +    conjunction with "interrupts" and only in case "stat-gpio" is not used.
>>> +- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
>>> +    conjunction with "interrupt-parent" and only in case "stat-gpio" is not
>>> +    used.
>>>
>>>  Example:
>>>
>>>  bq24257 {
>>>         compatible = "ti,bq24257";
>>>         reg = <0x6a>;
>>> +       stat-gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;
>>> +       pg-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>
>>>         ti,battery-regulation-voltage = <4200000>;
>>>         ti,charge-current = <1000000>;
>>>         ti,termination-current = <50000>;
>>>  };
>>> +
>>> +Example:
>>> +
>>> +bq24250 {
>>> +       compatible = "ti,bq24250";
>>> +       reg = <0x6a>;
>>> +       interrupt-parent = <&gpio1>;
>>> +       interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
>>> +
>>> +       ti,battery-regulation-voltage = <4200000>;
>>> +       ti,charge-current = <500000>;
>>> +       ti,termination-current = <50000>;
>>> +       ti,in-limit-current = <900000>;
>>> +       ti,vovp-voltage = <9500000>;
>>> +       ti,vindpm-voltage = <4440000>;
>>> +};
>>> --
>>> 1.9.1
>>>
> 

