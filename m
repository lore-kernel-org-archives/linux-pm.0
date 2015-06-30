From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC v2 09/16] arm: domain: Add platform callbacks for
 domain power on/off
Date: Tue, 30 Jun 2015 17:10:36 +0200
Message-ID: <CAMuHMdWL09Loe2EFUMc-kRML7Ckn7a6G1_hvPnaqkDYnhkXjog@mail.gmail.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
	<1435374156-19214-10-git-send-email-lina.iyer@linaro.org>
	<CAMuHMdULThWEZmyLEK_9WeK6DSNhrQdiZQLWNhi1Q6dwZTkkMg@mail.gmail.com>
	<20150629163201.GA1524@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32880 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbF3PKh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 11:10:37 -0400
Received: by oiyy130 with SMTP id y130so9662688oiy.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2015 08:10:36 -0700 (PDT)
In-Reply-To: <20150629163201.GA1524@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, agross@codeaurora.org

Hi Lina,

On Mon, Jun 29, 2015 at 6:32 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Mon, Jun 29 2015 at 07:36 -0600, Geert Uytterhoeven wrote:
>>> --- /dev/null
>>> +++ b/arch/arm/include/asm/pm_domain.h
>>> @@ -0,0 +1,27 @@
>>> +/*
>>> + *  arch/arm/include/asm/pm_domain.h
>>> + *
>>> + *  Copyright (C) 2015 Linaro Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +#ifndef __ASM_ARM_PM_DOMAIN_H
>>> +#define __ASM_ARM_PM_DOMAIN_H
>>> +
>>> +#include <linux/pm_domain.h>
>>> +
>>> +#if IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)
>>> +extern int register_platform_domain_handlers(struct of_phandle_args
>>> *args,
>>> +               int (*pd_down)(struct generic_pm_domain *),
>>> +               int (*pd_up)(struct generic_pm_domain *));
>>
>>
>> This looks a bit convoluted to me...
>>
>>> --- a/arch/arm/kernel/domains.c
>>> +++ b/arch/arm/kernel/domains.c
>>> @@ -9,10 +9,19 @@
>>>  #include <linux/module.h>
>>>  #include <linux/platform_device.h>
>>>
>>> +#include <asm/pm_domain.h>
>>> +
>>>  #define NAME_MAX 16
>>>
>>> +struct platform_cb {
>>> +       int (*power_off)(struct generic_pm_domain *);
>>> +       int (*power_on)(struct generic_pm_domain *);
>>> +};
>>> +
>>>  struct arm_pm_domain {
>>>         struct generic_pm_domain genpd;
>>> +       struct platform_cb plat_handler;
>>> +       struct spinlock_t lock;
>>>  };
>>>
>>>  static inline
>>> @@ -23,16 +32,85 @@ struct arm_pm_domain *to_arm_pd(struct
>>> generic_pm_domain *d)
>>>
>>>  static int arm_pd_power_down(struct generic_pm_domain *genpd)
>>>  {
>>> +       struct arm_pm_domain *arm_pd = to_arm_pd(genpd);
>>> +
>>> +       if (arm_pd->plat_handler.power_off)
>>> +               return arm_pd->plat_handler.power_off(genpd);
>>> +
>>>         /* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
>>>         return 0;
>>>  }
>>>
>>>  static int arm_pd_power_up(struct generic_pm_domain *genpd)
>>>  {
>>> +       struct arm_pm_domain *arm_pd = to_arm_pd(genpd);
>>> +
>>> +       if (arm_pd->plat_handler.power_on)
>>> +               return arm_pd->plat_handler.power_on(genpd);
>>> +
>>>         /* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
>>>         return 0;
>>>  }
>>
>>
>>> @@ -152,6 +230,7 @@ static int arm_domain_init(void)
>>>                 pd->genpd.power_off = arm_pd_power_down;
>>>                 pd->genpd.power_on = arm_pd_power_up;
>>
>>
>> Shouldn't these .power_off() and .power_on() be set up from platform code
>> instead, in the platform-specific code that creates the PM domain?
>>
>> The PM Domain containing the CPU may contain other devices, in which
>> case it's already set up from platform-specific code, which would conflict
>> with arm_domain_init()?
>>
> In my first RFC, the platform code was creating a domain. In this RFC,
> we are flaunting an idea that a generic code could setup the domains
> without any intervention from platform code. It will do everything
> common on most ARM platforms. Architectures that do not have anything
> specific in their domain, would benefit from such an initialization.
>
> If we were to export this genpd and then platform code could attach more
> devices to the genpd, or make it a sub of another genpd, would that
> work?
>
>> Cfr. arch/arm/mach-shmobile/pm-rmobile.c, which handles all PM domains
>> (both for devices and CPUs) on R-Mobile, and
>> arch/arm/boot/dts/{r8a73a4,r8a7740,sh73a0}.dtsi.
>>
>> R8a73a4 is the most advanced of these three: it has 2 big.LITTLE clusters,
>> with separate PM Domains for L2/SCU and sub-domains for the CPUs.
>
>
> If you could get the CPU genpd from the ARM common code, you could embed
> that in the L2 domain.
>
> On QCOM's big.LITTLE SoC, there would a PM domain for each of the CPUs
> and then there would be a coherency PM domain that would contain the big
> and LITTLE cluster domains. In that case, the platform code would create
> and initialize the coherency domain and make the CPU domains a sub of
> the coherency domain. Would something like that work?
>
>
>> Unfortunately we don't have SMP support for it, so currently dtsi
>> describes
>> the first cpu core only. The full structure should look like this
>>
>>        cpus {
>>                cpu0: cpu@0 {
>>                        compatible = "arm,cortex-a15";
>>                        power-domains = <&pd_a2sl>;
>>                        next-level-cache = <&L2_CA15>;
>>                };
>>
>>                cpu1: cpu@1 {
>>                        compatible = "arm,cortex-a15";
>>                        power-domains = <&pd_a2sl>;
>>                        next-level-cache = <&L2_CA15>;
>>                };
>>
>>                cpu2: cpu@2 {
>>                        compatible = "arm,cortex-a15";
>>                        power-domains = <&pd_a2sl>;
>>                        next-level-cache = <&L2_CA15>;
>>                };
>>
>>                cpu3: cpu@3 {
>>                        compatible = "arm,cortex-a15";
>>                        power-domains = <&pd_a2sl>;
>>                        next-level-cache = <&L2_CA15>;
>>                };
>>
>>                cpu4: cpu@4 {
>>                        compatible = "arm,cortex-a7";
>>                        power-domains = <&pd_a2kl>;
>>                        next-level-cache = <&L2_CA7>;
>>                };
>>
>>                cpu5: cpu@5 {
>>                        compatible = "arm,cortex-a7";
>>                        power-domains = <&pd_a2kl>;
>>                        next-level-cache = <&L2_CA7>;
>>                };
>>
>>                cpu6: cpu@6 {
>>                        compatible = "arm,cortex-a7";
>>                        power-domains = <&pd_a2kl>;
>>                        next-level-cache = <&L2_CA7>;
>>                };
>>
>>                cpu7: cpu@7 {
>>                        compatible = "arm,cortex-a7";
>>                        power-domains = <&pd_a2kl>;
>>                        next-level-cache = <&L2_CA7>;
>>                };
>>        };
>>
>>        L2_CA15: cache-controller@0 {
>>                compatible = "cache";
>>                power-domains = <&pd_a3sm>;
>>        };
>>
>>        L2_CA7: cache-controller@1 {
>>                compatible = "cache";
>>                power-domains = <&pd_a3km>;
>>        };
>>
>> And the PM Domain part (which is complete in upstream):
>>
>>        pd_c4: c4@0 {
>>                #power-domain-cells = <0>;
>>
>>                pd_a3sm: a3sm@20 {
>>                        reg = <20>;
>>                        #power-domain-cells = <0>;
>>
>>                        pd_a2sl: a2sl@21 {
>>                                reg = <21>;
>>                                #power-domain-cells = <0>;
>>                        };
>>                };
>>
>>                pd_a3km: a3km@22 {
>>                        reg = <22>;
>>                        #size-cells = <0>;
>>                        #power-domain-cells = <0>;
>>
>>                        pd_a2kl: a2kl@23 {
>>                                reg = <23>;
>>                                #power-domain-cells = <0>;
>>                        };
>>                };
>>        };
>>
> Thanks for the example. Would it work, if the platform code initalizes
> the pd_a3sm, pd_a3km and pd_c4 and set up the hierarchy and to add the
> CPU domains, you could query the ARM and then add the domains to the
> pd_a3sm and pd_a3km?

Yes, it could work. But then I have to add _more_ code to ignore the a2sl
and a2kl code in pm-rmobile.c, and call register_platform_domain_handlers(),
as in the end it's pm-rmobile that knows how to power up those PM domains.

I'm a bit reluctant to split responsibility across two drivers: a
platform-specific
one handling PM domains with non-cpu devices, and a generic one handling
PM domains with cpu-devices.

Perhaps the generic one can be optional, and provide helpers for common
CPU operations? Then the platform-specific driver can handle all PM domains,
and delegate to the generic CPU helpers where appropriate.

Does that make sense?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
