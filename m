From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 1/2] power: reset: Add generic SYSCON register mapped poweroff.
Date: Wed, 11 Mar 2015 17:52:00 -0700
Message-ID: <CAAtXAHd_imahuXFnGJY7JwpN+zRFG_pvGQbPN+O_u1VAruk8ug@mail.gmail.com>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
	<1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
	<1426066272.4244.37.camel@x220>
	<CAAtXAHetS9354mN5LAneMBk07U23hq2eZfqOxoXapG384=+EzQ@mail.gmail.com>
	<1426115936.4244.132.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44605 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbbCLAwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 20:52:01 -0400
Received: by wivr20 with SMTP id r20so16227271wiv.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2015 17:52:00 -0700 (PDT)
In-Reply-To: <1426115936.4244.132.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Paul,

On Wed, Mar 11, 2015 at 4:18 PM, Paul Bolle <pebolle@tiscali.nl> wrote:

> MODULE_DEVICE_TABLE() is defined only in include/linux/module.h. The few
> related lines read (in next-20150311):
>     #ifdef MODULE
>     /* Creates an alias so file2alias.c can find device table. */
>     #define MODULE_DEVICE_TABLE(type, name)                                     \
>     extern const typeof(name) __mod_##type##__##name##_device_table             \
>       __attribute__ ((unused, alias(__stringify(name))))
>     #else  /* !MODULE */
>     #define MODULE_DEVICE_TABLE(type, name)
>     #endif
>
> So I think MODULE_DEVICE_TABLE() is always preprocessed away for boolean
> code. Did I get that right?

Yeah, looking at that convinced me :) I have it already removed in v2.
>
>> >> +module_platform_driver(syscon_poweroff_driver);
>> >
>> > I think the built-in equivalent of this would be adding a wrapper that
>> > only does
>> >     platform_driver_register(&syscon_poweroff_driver);
>>
>> I couldn't find other examples in the tree doing this. Any pointers?
>
> Please note "think". But see drivers/cpufreq/dbx500-cpufreq.c:
>     static int __init dbx500_cpufreq_register(void)
>     {
>             return platform_driver_register(&dbx500_cpufreq_plat_driver);
>     }
>     device_initcall(dbx500_cpufreq_register);
>
> or drivers/gpio/gpio-vf610.c:
>     static int __init gpio_vf610_init(void)
>     {
>             return platform_driver_register(&vf610_gpio_driver);
>     }
>     device_initcall(gpio_vf610_init);

I included it into v3. Thanks.

Thanks again for your feedback,

Moritz
