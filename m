From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
Date: Fri, 31 Mar 2017 13:29:50 -0400
Message-ID: <CAC3K-4p5r=a+zM25xApf4Sxr2mGnaY8z0ugKdzw=WqCxrY8MEA@mail.gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com> <20170323223045.15786-1-zajec5@gmail.com>
 <20170323223045.15786-2-zajec5@gmail.com> <20170324143535.GA31953@broadcom.com>
 <d678d252-a95a-58c0-8098-4401c67040a1@gmail.com> <CAC3K-4q=npvHBjb2YeWmyCv89r14=vXdUzRW74mcrETs+NRh1Q@mail.gmail.com>
 <cfbb429d-5dd9-88b4-eeae-a288def7b56f@milecki.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35274 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbdCaR3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 13:29:53 -0400
Received: by mail-it0-f53.google.com with SMTP id y18so17021992itc.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 10:29:52 -0700 (PDT)
In-Reply-To: <cfbb429d-5dd9-88b4-eeae-a288def7b56f@milecki.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 31, 2017 at 10:49 AM, Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl=
> wrote:
> On 03/31/2017 04:23 PM, Jon Mason wrote:
>>
>> On Fri, Mar 31, 2017 at 3:03 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.c=
om> wrote:
>>>
>>> On 03/24/2017 03:35 PM, Jon Mason wrote:
>>>>
>>>>
>>>> On Thu, Mar 23, 2017 at 11:30:45PM +0100, Rafa=C5=82 Mi=C5=82ecki wrot=
e:
>>>>>
>>>>>
>>>>> diff --git a/drivers/thermal/broadcom/ns-thermal.c
>>>>> b/drivers/thermal/broadcom/ns-thermal.c
>>>>> new file mode 100644
>>>>> index 000000000000..acf3a4de62a4
>>>>> --- /dev/null
>>>>> +++ b/drivers/thermal/broadcom/ns-thermal.c
>>>>> @@ -0,0 +1,98 @@
>>>>> +/*
>>>>> + * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or
>>>>> modify
>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>> + * published by the Free Software Foundation.
>>>>> + */
>>>>> +
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/thermal.h>
>>>>> +
>>>>> +#define PVTMON_CONTROL0                                        0x00
>>>>> +#define PVTMON_CONTROL0_SEL_MASK                       0x0000000e
>>>>> +#define PVTMON_CONTROL0_SEL_TEMP_MONITOR               0x00000000
>>>>> +#define PVTMON_CONTROL0_SEL_TEST_MODE                  0x0000000e
>>>>> +#define PVTMON_STATUS                                  0x08
>>>>> +
>>>>> +struct ns_thermal {
>>>>> +       void __iomem *pvtmon;
>>>>> +};
>>>>> +
>>>>> +static int ns_thermal_get_temp(void *data, int *temp)
>>>>> +{
>>>>> +       struct ns_thermal *ns_thermal =3D data;
>>>>> +       u32 val;
>>>>> +
>>>>> +       val =3D readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
>>>>> +       if ((val & PVTMON_CONTROL0_SEL_MASK) !=3D
>>>>> PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
>>>>> +               val &=3D ~PVTMON_CONTROL0_SEL_MASK;
>>>>> +               val |=3D PVTMON_CONTROL0_SEL_TEMP_MONITOR;
>>>>
>>>>
>>>>
>>>> I think this is slightly confusing here.  If this was off, ORing in 0
>>>> will not enable it.  I think we need to flip the #define to make it
>>>> PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE (or a less crappy name).
>>>> then use this line here to toggle it.  Something like
>>>>
>>>>                 val &=3D ~PVTMON_CONTROL0_SEL_TEMP_MONITOR_DISABLE;
>>>
>>>
>>>
>>> I don't understand this, can you help me further?
>>>
>>> OR-ing with 0 is only a cosmetic thing obviously - just to make it clea=
r
>>> which
>>> value we expect to be set in bits 1:3. The important part is:
>>> val &=3D ~PVTMON_CONTROL0_SEL_MASK;
>>
>>
>> You are using a side effect of the masking to clear/enable the block.
>> I'm simply saying that we should be explicit about enabling it.  My
>> concern is that using the side effect hides what is being done and
>> could result in a bug somewhere down the line.  I think this is
>> improbable based on the code, but wanted to err on the side of
>> caution.
>
>
> Well, I'm clearing current mode selection and "selecting" the mode I want=
.
> By
> OR-ing PVTMON_CONTROL0_SEL_TEMP_MONITOR I'm clearly indicating I want tem=
p
> monitor more.
>
> How else I could make it more obvious? Should I add some comment maybe?

I think it would be acceptable to remove the ORing of the 0, and
simply put a comment there that the masking of it is clearing the 0th
bit, thus enabling the IP block.
