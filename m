From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] power: add power sequence library
Date: Sat, 4 Feb 2017 09:56:18 +0800
Message-ID: <20170204015618.GB25013@b29397-desktop>
References: <1483425211-14473-1-git-send-email-peter.chen@nxp.com>
 <20170201080817.GD17968@kroah.com>
 <20170203081614.GA24614@b29397-desktop>
 <16336642.sihi7izbLX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16336642.sihi7izbLX-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 03, 2017 at 10:14:31PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 03, 2017 04:16:15 PM Peter Chen wrote:
> > On Wed, Feb 01, 2017 at 09:08:17AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Feb 01, 2017 at 12:10:17AM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Jan 3, 2017 at 7:33 AM, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org> wrote:
> > > > > We have an well-known problem that the device needs to do some power
> > > > > sequence before it can be recognized by related host, the typical
> > > > > example like hard-wired mmc devices and usb devices.
> > > > >
> > > > > This power sequence is hard to be described at device tree and handled by
> > > > > related host driver, so we have created a common power sequence
> > > > > library to cover this requirement. The core code has supplied
> > > > > some common helpers for host driver, and individual power sequence
> > > > > libraries handle kinds of power sequence for devices. The pwrseq
> > > > > librares always need to allocate extra instance for compatible
> > > > > string match.
> > > > >
> > > > > pwrseq_generic is intended for general purpose of power sequence, which
> > > > > handles gpios and clocks currently, and can cover other controls in
> > > > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > > > >
> > > > > For new power sequence library, it can add its compatible string
> > > > > to pwrseq_of_match_table, then the pwrseq core will match it with
> > > > > DT's, and choose this library at runtime.
> > > > >
> > > > > Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > > > > Tested-by: Maciej S. Szmigiero <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
> > > > > Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > > Tested-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > 
> > > > Quite honestly, I have a really hard time with trying to follow this
> > > > code and the total lack of documentation makes it even harder. 
> > 
> > Sorry about that, Is it ok I add the design doc at:
> > Documentation/power/power-sequence/design.rst?
> 
> You can do that if you think it will address the request to explain the design.
> 
> > > > particular, the generic power sequence code is not even commented at
> > > > all, 
> > 
> > The generic power sequence code just implements the APIs which are 
> > called at power/pwrseq/core.c, and those API are commented at
> > include/linux/power/pwrseq.h. Anyway, I will add more comments at it.
> 
> It actually seems to be doing more than that and I'm not sure why the code in
> core.c is necessary at all.  The "generic" thing seems to be the only user of
> it anyway and the callbacks seem to be tailored to its needs.
> 

Currently, the "generic" pwrseq is the only use case. But some devices may have
custom power sequence [1], and MMC devices (mmc card/wifi) have two
power sequences (drivers/mmc/core/pwrseq_emmc.c, drivers/mmc/core/pwrseq_simple.c)

I have an example use case at v7 named pwrseq_compatible_sample.c for
those custom use case [2].

[1] https://www.spinics.net/lists/devicetree/msg139756.html
[2] https://lkml.org/lkml/2016/9/19/972

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
