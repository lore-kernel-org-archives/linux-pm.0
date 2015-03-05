From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 4/9] power: reset: Add AT91RM9200 reset driver
Date: Thu, 5 Mar 2015 21:34:32 +0100
Message-ID: <20150305203432.GB3989@piout.net>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425570594-13124-5-git-send-email-alexandre.belloni@free-electrons.com>
 <1425584954.24292.243.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425584954.24292.243.camel@x220>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 05/03/2015 at 20:49:14 +0100, Paul Bolle wrote :
> On Thu, 2015-03-05 at 16:49 +0100, Alexandre Belloni wrote:
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -30,6 +30,13 @@ config POWER_RESET_AT91_RESET
> >  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
> >  	  SoCs
> >  
> > +config POWER_RESET_AT91RM9200_RESET
> > +	bool "Atmel AT91RM9200 reset driver"
> 
> This adds a bool symbol.
> 
> > +	depends on ARCH_AT91 && MFD_SYSCON
> > +	default SOC_AT91RM9200
> > +	help
> > +	  This driver supports restart for Atmel AT91RM9200.
> > +
> >  config POWER_RESET_AXXIA
> >  	bool "LSI Axxia reset driver"
> >  	depends on ARCH_AXXIA
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index 11de15bae52e..96e972bbb922 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -1,6 +1,7 @@
> >  obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
> > +obj-$(CONFIG_POWER_RESET_AT91RM9200_RESET) += at91rm9200-reset.o
> 
> This objectfile will never be modular.
> 
> >  obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
> >  obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
> >  obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
> > diff --git a/drivers/power/reset/at91rm9200-reset.c b/drivers/power/reset/at91rm9200-reset.c
> > new file mode 100644
> > index 000000000000..b739ac82b9c9
> > --- /dev/null
> > +++ b/drivers/power/reset/at91rm9200-reset.c
> > @@ -0,0 +1,72 @@
> 
> > +#include <linux/module.h>
> 
> Is this needed?
> 
> > +static struct platform_driver at91rm9200_reset_driver = {
> > +	.probe = at91rm9200_reset_probe,
> > +	.driver = {
> > +		.name = "at91rm9200-reset",
> > +		.of_match_table = at91rm9200_reset_of_match,
> > +	},
> > +};
> > +module_platform_driver(at91rm9200_reset_driver);
> 
> This should, perhaps, be replaced by a wrapper that calls
>     platform_driver_register(at91rm9200_reset_driver)
> 
> while that wrapper is, well, called through
>     device_initcall()
> 
> or something similar. I didn't test this suggestion.
> 
> > +MODULE_ALIAS("platform:at91rm9200-reset");
> > +MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
> > +MODULE_DESCRIPTION("Atmel at91rm9200 System Timer Reset driver");
> > +MODULE_LICENSE("GPL v2");
> 
> All these macros will be, basically, preprocessed away.
> 
> 

Indeed, a lot got cargo culted/copy-pasted. I'll fix it and the
at91-reset driver too.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
