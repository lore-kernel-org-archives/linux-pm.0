From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional
 devices
Date: Wed, 09 Sep 2015 13:58:09 +0900
Message-ID: <55EFBC61.1050405@samsung.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-14-git-send-email-dannenberg@ti.com>
 <55EF7CDA.9030505@samsung.com> <20150909024841.GB32255@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:25810 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbIIE6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 00:58:19 -0400
In-reply-to: <20150909024841.GB32255@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 09.09.2015 11:48, Andreas Dannenberg wrote:
> On Wed, Sep 09, 2015 at 09:27:06AM +0900, Krzysztof Kozlowski wrote:
>> On 09.09.2015 09:12, Andreas Dannenberg wrote:
>>> Extend the bq2425x charger's device tree documentation to cover the
>>> bq24250 and bq24257 devices as well as recent feature additions.
>>>
>>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
>>
>> Hi,
>>
>> Thanks for updates. Everything pointed previous looks good. After
>> looking at Ramakrishna Pallala's (Cc-ed) patch ("power: bq24261_charger:
>> Add support for TI BQ24261 charger") I have only one comment below.
> 
> Thanks for all your efforts and time checking those patches!
> 
>>
>>> ---
>>>  .../devicetree/bindings/power/bq24257.txt          | 21 -------
>>>  .../devicetree/bindings/power/bq2425x.txt          | 70 ++++++++++++++++++++++
>>>  2 files changed, 70 insertions(+), 21 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
>>>  create mode 100644 Documentation/devicetree/bindings/power/bq2425x.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
>>> deleted file mode 100644
>>> index 5c9d394..0000000
>>> --- a/Documentation/devicetree/bindings/power/bq24257.txt
>>> +++ /dev/null
>>> @@ -1,21 +0,0 @@
>>> -Binding for TI bq24257 Li-Ion Charger
>>> -
>>> -Required properties:
>>> -- compatible: Should contain one of the following:
>>> - * "ti,bq24257"
>>> -- reg:			   integer, i2c address of the device.
>>> -- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
>>> -- ti,charge-current:	   integer, maximum charging current in uA.
>>> -- ti,termination-current:  integer, charge will be terminated when current in
>>> -			   constant-voltage phase drops below this value (in uA).
>>> -
>>> -Example:
>>> -
>>> -bq24257 {
>>> -	compatible = "ti,bq24257";
>>> -	reg = <0x6a>;
>>> -
>>> -	ti,battery-regulation-voltage = <4200000>;
>>> -	ti,charge-current = <1000000>;
>>> -	ti,termination-current = <50000>;
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/power/bq2425x.txt b/Documentation/devicetree/bindings/power/bq2425x.txt
>>> new file mode 100644
>>> index 0000000..3e171c3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/bq2425x.txt
>>> @@ -0,0 +1,70 @@
>>> +Binding for TI bq2425x Li-Ion Charger
>>> +
>>> +Required properties:
>>> +- compatible: Should contain one of the following:
>>> + * "ti,bq24250"
>>> + * "ti,bq24251"
>>> + * "ti,bq24257"
>>> +- reg: integer, i2c address of the device.
>>> +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
>>> +    also be defined through the standard interrupt definition properties (see
>>> +    optional properties section below). Only use one method.
>>> +- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
>>> +- ti,charge-current: integer, maximum charging current in uA.
>>> +- ti,termination-current: integer, charge will be terminated when current in
>>> +    constant-voltage phase drops below this value (in uA).
>>> +
>>> +Optional properties:
>>> +- pg-gpios: GPIO used for connecting the bq2425x device PG (Power Good) pin.
>>> +    This pin is not available on all devices however it should be used if
>>> +    possible as this is the recommended way to obtain the charger's input PG
>>> +    state. If this pin is not specified a software-based approach for PG
>>> +    detection is used.
>>> +- ti,current-limit: The maximum current to be drawn from the charger's input
>>> +    (in uA). If this property is not specified a USB D+/D- signal based charger
>>> +    type detection is used (if available) and the input limit current is set
>>> +    accordingly. If the D+/D- based detection is not available on a given device
>>> +    a default of 500,000 is used (=500mA).
>>
>> I understand this is different property than "ti,charge-current:
>> integer, default charging current (in mA)" from bq24261_charger patch?
> 
> Correct this is what "ti,current-limit" is for. And I borrowed that
> definition from bq2415x_charger.c where it's used in the same context.
> The reason for this property to exist is for systems where the external
> power supply does more than just charging the battery, such as supplying
> the system while it's charging or after it has finished charging. All
> this only makes sense of course if the "ti,current-limit" is larger than
> "ti,charge-current".
> 
> And if you see a few lines above the bq24257 driver also has a
> "ti,charge-current" property. And yes this is what actually controls how
> much current is delivered to the battery.

Right, I missed that one. Everything is clear now.

So we have different bindings. Existing ones:
bq2415x.txt - ti,charge-current - maximum charging current in mA
bq24257.txt - ti,charge-current - maximum charging current in uA
bq25890.txt - ti,charge-current - maximum charging current in uA
bq24735.txt - ti,charge-current - charge current (?) in mA
bq2415x.txt - ti,current-limit  - maximum current to be drawn in mA

New bindings:
ti,charge-current (bq24261) - default charge current in mA
ti,max-charge-current (bq24261) - maximum charging current in mA
ti,current-limit (bq2425x) - maximum current to be drawn in uA


Damn it... It's a mess. And there is no device prefixes...

The bq24261's bindings look most sensible (max prefix for max charge
current) but they are not compatible with existing bindings for
different devices.

There is no way to unify or make consistent all of these bindings.
However one could try to add new stuff in a more sensible way. For
example how about (for bq2425x-charger and bq24261_charger... BTW notice
even the difference in using underscore and hyphen!):

ti,charge-current - maximum charging current in uA
(that one must be supported, it's for existing bq24257 devices)
ti,default-charge-current (bq24261) - default charge current in *uA*
ti,current-limit (bq2425x) - maximum current to be drawn in *uA*


Best regards,
Krzysztof

