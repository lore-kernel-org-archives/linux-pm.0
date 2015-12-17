From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 0/4] Raspberry Pi power domains
Date: Thu, 17 Dec 2015 21:11:43 +0100
Message-ID: <2899341.Os5E8ounKE@wuerfel>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com> <878u4sx5gs.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878u4sx5gs.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 17 December 2015 11:03:47 Eric Anholt wrote:
> >>
> >>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
> >>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
> >>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
> >>  arch/arm/mach-bcm/Kconfig                          |  10 +
> >>  arch/arm/mach-bcm/Makefile                         |   1 +
> >>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
> >>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
> >>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
> >>  8 files changed, 360 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> >>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
> >>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
> >>
> >> --
> >> 2.6.2
> >>
> >
> > Besides a nitpick for patch2, I would also reverse the order of patch3
> > and patch2. DT docs should go in before the actual parsing of the new
> > bindings/compatibles.
> >
> > Anyway, for the hole series, you may add my:
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Would your tree be pulling the series (since it's power domains), or
> should I (since it's SOC stuff)?
> 

All of the above files go through the arm-soc tree by default.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
