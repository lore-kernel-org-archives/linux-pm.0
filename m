From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/4] max8903: adds documentation for device tree
 bindings.
Date: Thu, 16 Jun 2016 08:35:14 +0200
Message-ID: <576248A2.3030004@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
 <1465561970-18377-2-git-send-email-chris@lapa.com.au>
 <575AC5E5.3020405@samsung.com>
 <001abdba-d10c-90d5-944f-ebeaf236eb12@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:10109 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcFPGfS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 02:35:18 -0400
In-reply-to: <001abdba-d10c-90d5-944f-ebeaf236eb12@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chris@lapa.com.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/14/2016 03:54 AM, Chris Lapa wrote:
> On 10/06/2016 11:51 PM, Krzysztof Kozlowski wrote:
>> On 06/10/2016 02:32 PM, Chris Lapa wrote:
>>> From: Chris Lapa <chris@lapa.com.au>
>>>
>>> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>>> ---
>>>  .../devicetree/bindings/power/max8903-charger.txt  | 30
>>> ++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/power/max8903-charger.txt
>>
>> You again skipped all of the maintainers. Your patch won't be applied.
>> You need to send the patch to the appropriate person so he/she could
>> apply it.
>>
>> From this patch:
>> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
>> DEVICE TREE BINDINGS,commit_signer:9/19=47%)
>> Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND
>> FLATTENED DEVICE TREE BINDINGS)
>>
>> From power suppyy tree:
>> Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY
>> CLASS/SUBSYSTEM and DRIVERS)
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY
>> CLASS/SUBSYSTEM and DRIVERS)
>> David Woodhouse <dwmw2@infradead.org> (maintainer:POWER SUPPLY
>> CLASS/SUBSYSTEM and DRIVERS)
>>
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/power/max8903-charger.txt
>>> b/Documentation/devicetree/bindings/power/max8903-charger.txt
>>> new file mode 100644
>>> index 0000000..e0b5366
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
>>> @@ -0,0 +1,30 @@
>>> +Maxim Semiconductor MAX8903 Battery Charger bindings
>>> +
>>> +Required properties:
>>> +- compatible: "maxim,max8903-charger" for MAX8903 Battery Charger
>>> +- dc_valid: Specifies that the DC portion of the MAX8903 has been
>>> connected up
>>> +        and that dok-gpios should be specified
>>
>> You don't need the dc_valid nor the usb_valid.  If the dok-gpios are
>> present - use DC power. If the uok-gpios - USB power.
>>
> I did think that as well, but I didn't want to break backwards
> compatibility.

What do you mean by backwards compatibility? The driver did not support
DeviceTree before so it is not about DT compatibility. If you think
about platform data then it is different: how you match DT into driver's
structure is up to you.


> 
>> If both or none: print error.
> Its valid to have both connected.

Ah, okay. Just an example.

> 
>>
>> BTW, It would be nice if send also the user of this bindings - DTS/DTSI.
> I'm not sure I understand what you mean here?

I mean I would like to see the DTS file which is using this device and
these bindings. It is not necessary but it would be nice.

Best regards,
Krzysztof

> 
>>
>> Best regards,
>> Krzysztof
>>
>>> +    - dok-gpios: Valid DC power has been detected
>>> +- usb_valid: Specifies that the USB portion of the MAX8903 has been
>>> connected up
>>> +        and that uok-gpios should be specified
>>> +    - uok-gpios: Valid USB power has been detected
>>> +
>>> +Optional properties:
>>> +- cen-gpios: Charge enable pin
>>> +- chg-gpios: Charger status pin
>>> +- flt-gpios: Fault pin
>>> +- dcm-gpios: Current limit mode setting (DC or USB)
>>> +- usus-gpios: USB suspend pin
>>> +
>>> +
>>> +Example:
>>> +
>>> +    max8903-charger {
>>> +        compatible = "maxim,max8903-charger";
>>> +        dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
>>> +        flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
>>> +        chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
>>> +        cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
>>> +        dc_valid;
>>> +        status = "okay";
>>> +    };
>>>
>>
> 
> 
> 

