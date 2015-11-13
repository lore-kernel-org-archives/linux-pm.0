From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFCv2 2/2] rpi: add support to enable usb power domain
Date: Fri, 13 Nov 2015 13:22:37 +0100
Message-ID: <20151113122231.GA2959@omega>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
 <563B0217.4030307@lategoodbye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <563B0217.4030307-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 05, 2015 at 08:15:35AM +0100, Stefan Wahren wrote:
...
> >+	bool "Raspberry Pi power domain driver"
> >+	depends on ARCH_BCM2835
> >+	depends on RASPBERRYPI_FIRMWARE
> >+	select PM_GENERIC_DOMAINS if PM
> 
> Since PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS this line should
> be redundant.
> 

I can't remove the line:

select PM_GENERIC_DOMAINS if PM

here. It's true that "PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS",
but Kconfig can't handle the dependency here with select. That's why
sometimes people teaches me "select is evil".

I will get:

warning: (RASPBERRYPI_POWER) selects PM_GENERIC_DOMAINS_OF which has
unmet direct dependencies (PM_GENERIC_DOMAINS && OF)

otherwise.

Nevertheless we can't also use "depends on PM_GENERIC_DOMAINS if PM"
because, PM_GENERIC_DOMAINS is a hidden entry (has no Kconfig prompt).

- Alex
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
