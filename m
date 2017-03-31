From: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 31 Mar 2017 10:23:49 -0400
Message-ID: <CAC3K-4q=npvHBjb2YeWmyCv89r14=vXdUzRW74mcrETs+NRh1Q@mail.gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com> <20170323223045.15786-1-zajec5@gmail.com>
 <20170323223045.15786-2-zajec5@gmail.com> <20170324143535.GA31953@broadcom.com>
 <d678d252-a95a-58c0-8098-4401c67040a1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d678d252-a95a-58c0-8098-4401c67040a1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 31, 2017 at 3:03 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> On 03/24/2017 03:35 PM, Jon Mason wrote:
>>
>> On Thu, Mar 23, 2017 at 11:30:45PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
>>>
>>> diff --git a/drivers/thermal/broadcom/ns-thermal.c
>>> b/drivers/thermal/broadcom/ns-thermal.c
>>> new file mode 100644
>>> index 000000000000..acf3a4de62a4
>>> --- /dev/null
>>> +++ b/drivers/thermal/broadcom/ns-thermal.c
>>> @@ -0,0 +1,98 @@
>>> +/*
>>> + * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/thermal.h>
>>> +
>>> +#define PVTMON_CONTROL0                                        0x00
>>> +#define PVTMON_CONTROL0_SEL_MASK                       0x0000000e
>>> +#define PVTMON_CONTROL0_SEL_TEMP_MONITOR               0x00000000
>>> +#define PVTMON_CONTROL0_SEL_TEST_MODE                  0x0000000e
>>> +#define PVTMON_STATUS                                  0x08
>>> +
>>> +struct ns_thermal {
>>> +       void __iomem *pvtmon;
>>> +};
>>> +
>>> +static int ns_thermal_get_temp(void *data, int *temp)
>>> +{
>>> +       struct ns_thermal *ns_thermal =3D data;
>>> +       u32 val;
>>> +
>>> +       val =3D readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
>>> +       if ((val & PVTMON_CONTROL0_SEL_MASK) !=3D
>>> PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
>>> +               val &=3D ~PVTMON_CONTROL0_SEL_MASK;
>>> +               val |=3D PVTMON_CONTROL0_SEL_TEMP_MONITOR;
>>
>>
>> I think this is slightly confusing here.  If this was off, ORing in 0
>> will not enable it.  I think we need to flip the #define to make it
>> PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE (or a less crappy name).
>> then use this line here to toggle it.  Something like
>>
>>                 val &=3D ~PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE;
>
>
> I don't understand this, can you help me further?
>
> OR-ing with 0 is only a cosmetic thing obviously - just to make it clear
> which
> value we expect to be set in bits 1:3. The important part is:
> val &=3D ~PVTMON_CONTROL0_SEL_MASK;

You are using a side effect of the masking to clear/enable the block.
I'm simply saying that we should be explicit about enabling it.  My
concern is that using the side effect hides what is being done and
could result in a bug somewhere down the line.  I think this is
improbable based on the code, but wanted to err on the side of
caution.

>
> AFAIU selecting any mode other than TEMP_MONITOR will disable monitor
> access.
> AFAIU even switchint to TEST_MODE will prevent access to temp, so I don't
> see
> how we could use PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE. It could be an=
y
> value other than 0.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
