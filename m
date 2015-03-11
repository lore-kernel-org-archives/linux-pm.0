From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] power: reset: Add generic SYSCON register mapped
 poweroff.
Date: Thu, 12 Mar 2015 00:18:56 +0100
Message-ID: <1426115936.4244.132.camel@x220>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
	 <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
	 <1426066272.4244.37.camel@x220>
	 <CAAtXAHetS9354mN5LAneMBk07U23hq2eZfqOxoXapG384=+EzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:56308 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381AbbCKXS7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 19:18:59 -0400
In-Reply-To: <CAAtXAHetS9354mN5LAneMBk07U23hq2eZfqOxoXapG384=+EzQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Moritz,

On Wed, 2015-03-11 at 15:00 -0700, Moritz Fischer wrote:
> thanks for your feedback. While developing this I looked at other drivers in
> the tree and many of your comments would apply to them, too?

Could be. I didn't check. It's basically stuff that get's silently
handled by the preprocessor. So I wouldn't be surprised if a lot of
drivers do similar things.

> On Wed, Mar 11, 2015 at 2:31 AM, Paul Bolle <pebolle@tiscali
> 
> >> +config POWER_RESET_SYSCON_POWEROFF
> >> +     bool "Generic SYSCON regmap poweroff driver"
> >
> > This adds a bool symbol.
> 
> Is that an issue or is it just to substantiate the rest of your comments below?

It's just an observation.

> >> +obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
> >
> > So this objectfile can never be part of a module.
> 
> Same comment would apply for power/reset/qnap-poweroff.c, right?

That could be. I didn't check it while looking at this patch.

> >> +#include <linux/module.h>
> >
> > Is that include needed?
> 
> Wouldn't that be needed if MODULE_DEVICE_TABLE etc, is used?

Perhaps, but I don't think those macros are used.

> >> +MODULE_DEVICE_TABLE(of, syscon_poweroff_of_match);
> >
> > This will be preprocessed away.
> 
> In my experiments it didn't work without this, are you sure it's not needed?

MODULE_DEVICE_TABLE() is defined only in include/linux/module.h. The few
related lines read (in next-20150311):
    #ifdef MODULE
    /* Creates an alias so file2alias.c can find device table. */
    #define MODULE_DEVICE_TABLE(type, name)					\
    extern const typeof(name) __mod_##type##__##name##_device_table		\
      __attribute__ ((unused, alias(__stringify(name))))
    #else  /* !MODULE */
    #define MODULE_DEVICE_TABLE(type, name)
    #endif

So I think MODULE_DEVICE_TABLE() is always preprocessed away for boolean
code. Did I get that right? 

> >> +module_platform_driver(syscon_poweroff_driver);
> >
> > I think the built-in equivalent of this would be adding a wrapper that
> > only does
> >     platform_driver_register(&syscon_poweroff_driver);
> 
> I couldn't find other examples in the tree doing this. Any pointers?

Please note "think". But see drivers/cpufreq/dbx500-cpufreq.c:
    static int __init dbx500_cpufreq_register(void)
    {
            return platform_driver_register(&dbx500_cpufreq_plat_driver);
    }
    device_initcall(dbx500_cpufreq_register);

or drivers/gpio/gpio-vf610.c:
    static int __init gpio_vf610_init(void)
    {
            return platform_driver_register(&vf610_gpio_driver);
    }
    device_initcall(gpio_vf610_init);

(There are probably more.) Please note that both files use MODULE_*
macros but can actually only be built-in.

> >> +MODULE_LICENSE("GPL v2");
> >
> > You probably meant
> >     MODULE_LICENSE("GPL");
> 
> Sorry about that. Will fix.

That's a very easy mistake to make anyway. There's currently a thread
were (another) Dmitry and I discuss the merits of differentiating
between "GPL" and "GPL v2" in MODULE_LICENSE().

> >> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
> >> +MODULE_DESCRIPTION("Generic SYSCON poweroff driver");
> >> +MODULE_ALIAS("platform:syscon-poweroff");
> >
> > But these four macros will all be effectively preprocessed away, anyhow.
> 
> I'll remove them.

Thanks,


Paul Bolle

