From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [FOR DISCUSSION 0/9] Dove PMU support
Date: Fri, 13 Mar 2015 12:57:11 +0100
Message-ID: <5579362.zNki0VzW6v@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312183020.GU8656-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thursday 12 March 2015 18:30:21 Russell King - ARM Linux wrote:
> This is a re-posting of the patch set which I posted almost 10 months
> ago to support the Dove PMU, with a few additional changes.  This set
> is based upon 3.19.
> 
> In this set are:
> 
> * two patches which Rafael originally acked, but there was indecision
>   last time around how to handle them due to potential conflicts with
>   work that Ulf was doing.  These patches have been updated to apply
>   cleanly to 3.19.  I don't know if people want to take these as
>   fixes to the PM domain code or not (hence why I'm posting this
>   series during the merge window - if it weren't for this, I'd hold
>   it off.)

I don't seem to have received the first three patches for some reason.
Can you check if you got them back from the mailing list?

> 
>  Documentation/devicetree/bindings/soc/dove/pmu.txt |  49 +++
>  arch/arm/boot/dts/dove.dtsi                        |  25 ++
>  arch/arm/mach-mvebu/Kconfig                        |   1 +
>  drivers/base/platform.c                            |   2 +
>  drivers/base/power/common.c                        |  15 +
>  drivers/base/power/domain.c                        |  33 +-
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/dove/Makefile                          |   1 +
>  drivers/soc/dove/pmu.c                             | 399 +++++++++++++++++++++
>  include/linux/pm.h                                 |   1 +
>  include/linux/pm_domain.h                          |   4 +
>  include/linux/soc/dove/pmu.h                       |   6 +
>  12 files changed, 532 insertions(+), 5 deletions(-)

I see add the header file and the global dove_init_pmu() function,
but I don't see a caller of that function. Is that intentional, or
did you accidentally leave out another patch that you meant to include?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
