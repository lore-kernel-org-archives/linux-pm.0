From: Michael Tatarinov <kukabu@gmail.com>
Subject: Re: of: thermal: Introduce "hwmon" optional property
Date: Sat, 2 Sep 2017 09:53:43 +0400
Message-ID: <CABrG=Zzf46SR4a3w5Sxqp_4QaF9Rgxe0_DYL7Usu0-ibkROJMQ@mail.gmail.com>
References: <20170710115146.27313-1-kukabu@gmail.com> <20170831150802.GA16971@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38067 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdIBFxp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2017 01:53:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id u26so1821221wma.5
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 22:53:44 -0700 (PDT)
In-Reply-To: <20170831150802.GA16971@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hello
Thanks for you comments.

2017-08-31 19:08 GMT+04:00, Guenter Roeck <linux@roeck-us.net>:
> On Mon, Jul 10, 2017 at 03:51:46PM +0400, Michael Tatarinov wrote:
>> Introduce an optional property called, hwmon, which enable
>> registration in hwmon subsystems.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Signed-off-by: Michael Tatarinov <kukabu@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt | 6 ++++++
>>  drivers/thermal/of-thermal.c                          | 3 +--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
>> b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index 88b6ea1ad290..4e51fbd4efa2 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -175,6 +175,10 @@ Optional property:
>>  			2000mW, while on a 10'' tablet is around
>>  			4500mW.
>>
>> +- hwmon:		Register the thermal zone in hwmon subsystems
>> +  Type: boolean 	(requires CONFIG_THERMAL_HWMON).
>> +  Size: one cell
>> +
>
> That will probably be unacceptable since it is not a hardware description
> or configuration flag but an implementation problem.

I didn't know it. I agree with change "hwmon" to "linux,hwmon".

> What might be acceptable is to use a device property such as "linux,no-hwmon",
> set it in hwmon drivers prior to calling the registration function, then use
> device_property_present() in the thermal code to check it and assign the flag
> to no_hwmon. An alternative might be to add a "no_hwmon" parameter to the
> thermal registration function, but that would be much more invasive and,
> in my opinion, much less desirable.

I think it should be a thermal driver option. Comment says that the
registration is disabled to prevent dual registration (native hwmon
driver and imported thermal driver).

> Rui, Eduardo, any thoughts ?
>
> Thanks,
> Guenter
>
>>  Note: The delay properties are bound to the maximum dT/dt (temperature
>>  derivative over time) in two situations for a thermal zone:
>>  (i)  - when passive cooling is activated (polling-delay-passive); and
>> @@ -556,6 +560,8 @@ thermal-zones {
>>
>>  		sustainable-power = <2500>;
>>
>> +		hwmon;
>> +
>>  		trips {
>>  			/* Trips are based on resulting linear equation */
>>  			cpu_trip: cpu-trip {
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index d04ec3b9e5ff..ce580a57313b 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -994,8 +994,7 @@ int __init of_parse_thermal_zones(void)
>>  			goto exit_free;
>>  		}
>>
>> -		/* No hwmon because there might be hwmon drivers registering */
>> -		tzp->no_hwmon = true;
>> +		tzp->no_hwmon = !of_property_read_bool(child, "hwmon");
>>
>>  		if (!of_property_read_u32(child, "sustainable-power", &prop))
>>  			tzp->sustainable_power = prop;
>
