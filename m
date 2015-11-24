From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Tue, 24 Nov 2015 22:02:51 +0100
Message-ID: <20151124210249.GA4270@omega>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
 <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?B?UGF3ZcWC?= Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm@vger
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Nov 24, 2015 at 09:44:59PM +0100, Ulf Hansson wrote:
> [...]
> 
> > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> > index 8c53c55..20479d7 100644
> > --- a/arch/arm/mach-bcm/Kconfig
> > +++ b/arch/arm/mach-bcm/Kconfig
> > @@ -134,6 +134,16 @@ config ARCH_BCM2835
> >           This enables support for the Broadcom BCM2835 SoC. This SoC is
> >           used in the Raspberry Pi and Roku 2 devices.
> >
> > +config RASPBERRYPI_POWER
> 
> You don't need a new Kconfig option I think. If you fold in the below
> "select" under ARCH_BCM2835, that should work as well, right?
> 
> select PM_GENERIC_DOMAINS if (RASPBERRYPI_FIRMWARE && PM && OF)
> 

I think this depends on what the maintainers like to have here.

The raspberrypi firmware isn't BCM2835 specific, when some SoC which is
BCM2835 and enabled the RASPBERRYPI_FIRMWARE (for what reason ever) it will
enable also the power domain driver for the RPi.

When some BCM2835 enable it, then it will do nothing because the
devicetree entries should not match then.

> > +       bool "Raspberry Pi power domain driver"
> > +       depends on ARCH_BCM2835
> > +       depends on RASPBERRYPI_FIRMWARE
> > +       select PM_GENERIC_DOMAINS if PM
> > +       select PM_GENERIC_DOMAINS_OF if PM
> > +       help
> > +         This enables support for the RPi power domains which can be enabled
> > +         or disabled via the RPi firmware.
> > +
> >  config ARCH_BCM_63XX
> >         bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
> >         depends on MMU
> > diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> > index 892261f..fec2d6b 100644
> > --- a/arch/arm/mach-bcm/Makefile
> > +++ b/arch/arm/mach-bcm/Makefile
> > @@ -36,6 +36,7 @@ endif
> >
> >  # BCM2835
> >  obj-$(CONFIG_ARCH_BCM2835)     += board_bcm2835.o
> > +obj-$(CONFIG_RASPBERRYPI_POWER)        += raspberrypi-power.o
> 
> According to above, then this should become:
> 
> obj-$(CONFIG_PM_GENERIC_DOMAINS) += raspberrypi-power.o
> 

What about other BCM$FOOBAR arch's which might select/enables
CONFIG_PM_GENERIC_DOMAINS somehow?

Like ARCH_BCM_63XX.

Possible other solution would be to make the CONFIG_RASPBERRYPI_POWER as
a hidden entry inside Kconfig without a prompt.

Then it should look like this:

config RASPBERRYPI_POWER
	bool
	select PM_GENERIC_DOMAINS
	select PM_GENERIC_DOMAINS_OF

config ARCH_BCM2835
	...
	select RASPBERRYPI_POWER if (RASPBERRYPI_FIRMWARE && PM && OF)
	...

and leave the Makefile as it is.

- Alex
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
