From: Markus Mayer <code@mmayer.net>
Subject: Re: [PATCH 2/2] thermal: add brcmstb AVS TMON driver
Date: Fri, 9 Jun 2017 16:07:15 -0700
Message-ID: <CANEuBv69B+dWruiAFtS3kmBNyqcHJaHH=KjbTztqJ49cqj+cxw@mail.gmail.com>
References: <20170605210930.65432-1-code@mmayer.net> <20170605210930.65432-3-code@mmayer.net>
 <fdccd1ebb4ec0eb4f675168bdcb15fe4@milecki.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34364 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdFIXHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 19:07:16 -0400
Received: by mail-vk0-f65.google.com with SMTP id 191so4630786vko.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2017 16:07:16 -0700 (PDT)
In-Reply-To: <fdccd1ebb4ec0eb4f675168bdcb15fe4@milecki.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Markus Mayer <code@mmayer.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On 6 June 2017 at 05:27, Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> wrote:
> On 2017-06-05 23:09, Markus Mayer wrote:
>>
>> --- /dev/null
>> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
>> @@ -0,0 +1,361 @@
>> +/*
>> + * Broadcom STB AVS TMON thermal sensor driver
>> + *
>> + * Copyright (c) 2015-2017 Broadcom
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>
> The headers says GPL v2 but it doesn't match MODULE_LICENSE. Please be
> consistent.

Fixed.

>> +/* Convert a HW code to a temperature reading (millidegree celsius) */
>> +static inline int avs_tmon_code_to_temp(u32 code)
>> +{
>> +       return (410040 - (int)((code & 0x3FF) * 487));
>> +}
>
> I got similar hardcoded values and Eduardo told me to move them to the DT=
.
> See discussion in: https://patchwork.kernel.org/patch/9642119/
>
> Hint: thermal_zone_get_offset + thermal_zone_get_slope

I implemented this and played around a little bit, and I believe I
found a problem with how the framework is initializing the thermal
zone. Please bear with my while I try to describe the issue I ran
into:

In brcmstb_thermal_probe(), we call

    struct thermal_zone_device *thermal;
    [...]
    thermal =3D thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &of_op=
s);

to get the thermal zone for the driver. This is necessary for
thermal_zone_get_offset() and thermal_zone_get_slope() to be able to
return the proper coefficients, as the thermal zone pointer needs to
be passed to both functions.

Now, calling thermal_zone_of_sensor_register() has some side effects
that call thermal_zone_get_slope () and thermal_zone_get_offset() via
callback function before the "thermal" pointer is assigned, because
thermal_zone_of_sensor_register() hasn't returned to the caller yet.
Specifically, this call sequence happens:

thermal_zone_of_sensor_register() -> tzd->ops->set_mode [which is
of_thermal_set_mode()] -> thermal_zone_device_update() ->
update_temperature() -> thermal_zone_get_temp() -> tz->ops->get_temp()
[which is brcmstb_get_temp()] -> avs_tmon_code_to_temp() ->
avs_tmon_get_coeffs() -> thermal_zone_get_slope() -> *UNDESIRED
RESULT*

This is problematic, because thermal_zone_get_slope() is now being
called while our thermal pointer inside the driver is still NULL, so
it returns its default value of 1 and *NOT* the value that is stored
in device tree. The same happens for thermal_zone_get_offset(). This
returns the default value of 0.

thermal_zone_get_temp() also calls thermal_zone_set_trips() right
after thermal_zone_get_temp(). That call path runs into the exact same
issue.

It is only after the call to thermal_zone_of_sensor_register()
completes that the "thermal" variable in the driver has the proper
value and, thus, thermal_zone_get_temp() and thermal_zone_set_trips()
return the device tree values from then on out.

At run time, it looks like this (with some debug output enabled):

[    1.251126] brcmstb_thermal: avs_tmon_code_to_temp, 170: val=3D773/0x305
[    1.257676] brcmstb_thermal: avs_tmon_get_coeffs, 135: slope=3D1,
offset=3D0, tz=3D  (null)
[    1.265534] brcmstb_thermal: set trips -2147483647 <--> 95000
[    1.271297] brcmstb_thermal: set temp 0 to -2147483647
[    1.276452] brcmstb_thermal: avs_tmon_temp_to_code, 191: temp=3D-2147483=
647
[    1.283257] brcmstb_thermal: avs_tmon_set_trip_temp, 276: val=3D1023
[    1.289457] brcmstb_thermal: enable trip, type 0
[    1.294089] brcmstb_thermal: set temp 1 to 95000
[    1.298721] brcmstb_thermal: avs_tmon_temp_to_code, 191: temp=3D95000
[    1.305006] brcmstb_thermal: avs_tmon_get_coeffs, 135: slope=3D1,
offset=3D0, tz=3D  (null)
[    1.312859] brcmstb_thermal: avs_tmon_set_trip_temp, 276: val=3D0
[    1.318797] brcmstb_thermal: enable trip, type 1

Finally inititialization has progressed far enough that our tz pointer
is not NULL anymore, and now it returns the proper values:

[    1.323470] brcmstb_thermal: avs_tmon_get_coeffs, 135: slope=3D-487,
offset=3D410040, tz=3Deeb55800

It doesn't seem right to me that the framework calls back into the
driver before the driver has had a chance to initialize all data
structures it needs. Am I missing anything obvious here that would
avoid this issue?

Thanks,
-Markus
