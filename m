From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: bcm283x: Add CPU thermal zone with 1
 trip point
Date: Sun, 19 Feb 2017 13:31:49 +0100 (CET)
Message-ID: <1762674971.70633.1487507509664@email.1und1.de>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
 <1486928328-25870-2-git-send-email-stefan.wahren@i2se.com>
 <20170219011753.GB21016@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219011753.GB21016-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 19. Februar 2017 um 02:17 geschrieben:
> 
> 
> On Sun, Feb 12, 2017 at 07:38:48PM +0000, Stefan Wahren wrote:
> > As suggested by Eduardo Valentin this adds the thermal zone for
> > the bcm2835 SoC with its single thermal sensor. We start with
> > the criticial trip point and leave the cooling devices empty
> > since we don't have any at the moment.
> > 
> > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> > ---
> > 
> > Changes in V2:
> > - add missing thermal-sensor-cells property
> > - change gpu-thermal to cpu-thermal
> > 
> >  arch/arm/boot/dts/bcm283x.dtsi |   20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> > index a3106aa..4dc74f6 100644
> > --- a/arch/arm/boot/dts/bcm283x.dtsi
> > +++ b/arch/arm/boot/dts/bcm283x.dtsi
> > @@ -19,6 +19,25 @@
> >  		bootargs = "earlyprintk console=ttyAMA0";
> >  	};
> >  
> > +	thermal-zones {
> > +		cpu_thermal: cpu-thermal {
> > +			polling-delay-passive = <0>;
> > +			polling-delay = <1000>;
> > +
> 
> Check the diff I sent and also add the following for differentiating the
> offsets and slopes depending on which chip the zone describes:
> 			coefficients = <-538 407000>; /* for the zone on bcm2835 and bcm2836 */
> 
> and
> 
> 			coefficients = <-538 412000>; /* for the zone on bcm2837 */
> 
> 
> Despite the changes mentioned for the driver and DT, I am ok with the driver and the DTS descriptors.

thanks for providing the necessary driver changes, but the coefficients above causes a DTC parse error. The Device Tree doesn't provide support for native signed integer. Looking at this old thread [1] suggests to add parentheses which fixed the parse issue. But of-thermal expected u32 for coefficients [2].

Any suggestions?

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/159681.html
[2] - http://elixir.free-electrons.com/source/drivers/thermal/of-thermal.c?v=4.10-rc7#L854

> 
> BR,
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
