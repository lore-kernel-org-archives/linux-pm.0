From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Wed, 09 Sep 2015 13:17:11 +0900
Message-ID: <55EFB2C7.30800@samsung.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <20150909022617.GA32255@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:33528 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbIIERV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 00:17:21 -0400
In-reply-to: <20150909022617.GA32255@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>

On 09.09.2015 11:26, Andreas Dannenberg wrote:
> On Mon, Sep 07, 2015 at 12:57:56PM +0900, Krzysztof Kozlowski wrote:
>> 2015-09-07 2:23 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala@intel.com>:
>>>
>>> Add new charger driver support for BQ24261 charger IC.
>>>
>>> BQ24261 charger driver relies on extcon notifications to get the
>>> charger cable type and based on that it will set the charging parameters.
>>>
>>> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>>> Signed-off-by: Jennt TC <jenny.tc@intel.com>
>>> ---
>>>  .../devicetree/bindings/power/bq24261.txt          |   37 +
>>>  drivers/power/Kconfig                              |    6 +
>>>  drivers/power/Makefile                             |    1 +
>>>  drivers/power/bq24261_charger.c                    | 1208 ++++++++++++++++++++
>>>  include/linux/power/bq24261_charger.h              |   27 +
>>>  5 files changed, 1279 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/bq24261.txt
>>>  create mode 100644 drivers/power/bq24261_charger.c
>>>  create mode 100644 include/linux/power/bq24261_charger.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/bq24261.txt b/Documentation/devicetree/bindings/power/bq24261.txt
>>> new file mode 100644
>>> index 0000000..25fc5c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/bq24261.txt
>>> @@ -0,0 +1,37 @@
>>> +Binding for TI bq24261 Li-Ion Charger
>>
>> Please split the bindings into separate patch (the first patch in patchset).
>>
>>> +
>>> +Required properties:
>>> +- compatible: Should contain one of the following:
>>> +    * "ti,bq24261"
>>> +- reg: integer, i2c address of the device.
>>> +- ti,charge-current: integer, default charging current (in mA);
>>> +- ti,charge-voltage: integer, default charging voltage (in mV);
>>> +- ti,termination-current: integer, charge will be terminated when current in
>>> +    constant-voltage phase drops below this value (in mA);
>>> +- ti,max-charge-current: integer, maximum charging current (in mA);
>>> +- ti,max-charge-voltage: integer, maximum charging voltage (in mV);
>>> +- ti,min-charge-temperature: integer, minimum charging temperature (in DegC);
>>> +- ti,max-charge-temperature: integer, maximum charging temperature (in DegC).
>>
>> Before accepting "[PATCH 13/13] dt: power: bq24257-charger: Cover
>> additional devices"
>> http://www.spinics.net/lists/devicetree/msg92134.html
>>
>> could you and Andreas figure out common bindings? Look at this:
>>
>> +- ti,charge-current: integer, maximum charging current in uA.
>> +- ti,charge-current: integer, default charging current (in mA);
>>
>> Different meaning and different units. This is madness! :)
>>
>> In the same time you are adding TI-common bindings (not device
>> specific, there is no prefix) so I would expect exactly the same
>> bindings if it is possible.
> 
> Krzysztof, good observation! In bq2425x_charger.c (formerly known as
> bq24257_charger.c :) that I worked on the unit used was uA. At that time
> I did a quick check and there didn't seem to be a clear standard whether
> to use the "micro" or "milli" units - different drivers use different
> units. However there seems to be a tendency for the TI drivers to prefer
> "milli" (bq2415x_charger.c, bq24735-charger.c)
> 
> Personally I think "milli" units are more appropriate for chargers since
> they provide sufficient granularity and the numbers don't become too big
> (try typing a voltage in the Volt-range in uV, it's very easy to get the
> number of 0s wrong). However since the driver was already there I left
> that aspect alone to preserve compatibility.

I am fine with both units but milli indeed seems easier to judge by fast
looking and less error-prone. Whatever you choose - choose the same one. :)


>>> +
>>> +Optional properties:
>>> +- ti,thermal-sensing: boolean, if present thermal regulation will be enabled;
>>
>> What is the requirement for thermal-sensing? Can it be enabled always?
>> If yes, then this is not really a hardware property.
>>
>>> +- ti,enable-user-write: boolean, if present driver will allow the user space
>>> +    to control the charging current and voltage through sysfs;
>>
>> This is not DT property. It does not describe hardware.
> 
> I take responsibility for this one :) In an earlier thread we were
> discussing that it will be better to prevent sysfs write access to
> "dangerous" charger parameters (charge voltage, current, ...) but I
> argued that such access might still be desirable during development and
> debug, and that a DT property could be used to allow such write access
> (with the default being the charger properties being made read-only) -
> this way giving the best of both worlds. However then when I updated the
> bq24157_charger.c driver I ended up not really needing and implementing
> this feature.
> 
> Out of curiosity, if it against best-practice to expose non hardware
> properties, how would one best address the above use case? Compile time
> switch? A sysfs property that allows write-enabling the other sysfs
> properties (doesn't sound right). Or...?

Device Tree describes only the hardware configuration. This means that
it does not fully replaces platform data. Definitely DT should not be
used to configure debug options.

AFAIU, you have some board (always the same type of board) and:
1. during development you want to enable certain sysfs dangerous
operation/feature,
2. for production use you want to disable this feature?

This means that the "feature" would be present in mainline kernel always
so it is not possible to disallow the use of it. For example if this was
implemented in DT, the user could replace a DT with different one.

Assuming that this feature should be in mainline kernel at all, then
probably compile time option is the best way. Some subsystems don't
offer dangerous operations (e.g. setting voltage for regulators or force
suspending devices) but they provide certain development drivers which
expose such interfaces. Such cases should be rather done per subsystem,
not per device.

Best regards,
Krzysztof

