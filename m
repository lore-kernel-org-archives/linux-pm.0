From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Tue, 25 Nov 2014 13:09:40 +0100
Message-ID: <2301239.aDOlWg3gEs@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com> <15074721.IbfeeI3ajE@wuerfel> <54746349.3000306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54746349.3000306-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 November 2014 13:08:57 Grygorii Strashko wrote:
> On 11/25/2014 12:33 PM, Arnd Bergmann wrote:
> > On Monday 24 November 2014 22:44:06 Mike Turquette wrote:
> >> Quoting Arnd Bergmann (2014-11-24 02:50:28)
> >>>
> > 
> > I'm not sure I even understand what you intended the example to look
> > like, it does't parse 
> > 
> > My point above was completely different, the suggestion I made was
> > to not classify the clocks in DT at all, but to leave it all in
> > the client driver.
> 
> I slept with this idea  From one side it sounds good. Pls, Correct me if I'm wrong:
> - there still will be "simple-pmdomain" and all devices will be attached to it by
>    default (or as specified in DT power-domains = <&simple_pmdomain>;);

I would assume only devices that set "power-domains = <&simple_pmdomain>"

> - drivers will use smth. like pm_clk_remove() to remove optional clocks from pm_clk;

Right. Regarding the naming of the function, I would pick something other
than remove, since the main purpose is not to have that clock abandoned
by the pm-domain code (this is still a side-effect), but to have the
clock put under control of the driver itself.

It might be possible to do this implicitly if the driver calls clk_get(),
basically doing clk_get() (or another call if necessary) would prevent the
simple pmdomain from turning it off during suspend.

> From another side:
> - drivers will get dependency from pm_clk;

There are three cases here:

- A device that is always used with a pm-domain, the driver doesn't
  have to worry about it but do need the dependency on having the
  simple-pmdomain code enabled.

- A device that may or may not have clocks, but if it has them, they
  are managed through a pm-domain. In this case, it's platform dependent
  whether we have the dependency. We may want to prevent the device from
  being probed if a power-domain property is present but no driver
  for the domain.

- A device that uses the pm-domain on some machines but not on others:
  this is a bit tricky, because the driver will still have to know
  about all the clocks, although we could choose not to turn off the
  clocks during suspend if the power-domain is not set.

> - HW limitations can't be taken into account - it's possible that some clocks should
>   not be enabled until it's allowed. And only driver know when it's allowed.
>   Otherwise, HW state may become unspecified or wrong output can be generated.

Correct: if you have a device that you don't want to be handled by a simple
pm-domain, then you have to connect it to a different pm-domain, e.g. one that
manages a fixed set of clocks itself.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
