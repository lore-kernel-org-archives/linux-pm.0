From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional
 properties
Date: Mon, 27 Apr 2015 16:54:27 +0100
Message-ID: <20150427155427.GB16191@leverpostej>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430146811-29862-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 27, 2015 at 04:00:11PM +0100, Geert Uytterhoeven wrote:
> On some SoCs, the GIC may be part of a PM Domain (hardware Power and/or
> Clock Domain).  Document the related optional DT properties.
> 
> Note: As the current GIC driver doesn't support Runtime PM yet, PM
> Domain constraints must be handled elsewhere in e.g. platform code.

I'm worried that without a current user these properties aren't going to
see any testing...

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> To preserve DT stability, we would like to add these properties to the
> affected shmobile dtsi files.

... which means that they could be wrong, and will get in the way of
stability rather than aiding it.

I'm also concerned that the carving up of clock inputs, power domains,
and other physical details is implementation-specific. I imagine that
pretty much every user that will care about this is using GIC-400, so
could we make this specific to GIC-400?

> On Thu, Mar 26, 2015 at 11:39 AM, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
> > On 25/03/15 21:19, Geert Uytterhoeven wrote:
> >> I would like to add the clock and GIC dependency on the clock in the DTS now,
> >> for reasons of DTS stability. But that means I need a temporary workaround
> >> to avoid the clock from being disabled, until the GIC driver handles this.
> >>
> >> I don't expect a fix for the GIC code to just show up magically. I just wanted
> >> you to be aware of the problem. GIC is not the only problematic module here,
> >> there are others, cfr. the last slide of [2].
> >
> > As long as there is an agreement from the DT people on the presence of
> > that extra property in the GIC node, I'm happy with that. I'd like it to
> > be documented though.
> 
> Full thread at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331876.html
> 
>  Documentation/devicetree/bindings/arm/gic.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 2da059a4790cb3c6..b21113b35f085f27 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -58,6 +58,14 @@ Optional
>    regions, used when the GIC doesn't have banked registers. The offset is
>    cpu-offset * cpu-nr.
>  
> +- power-domains : A phandle and PM domain specifier as defined by bindings of
> +		  the power controller specified by phandle, used when the GIC
> +		  is part of a Power or Clock Domain.

I imagine that it's possible for the distributor and CPU interfaces to
be in separate power domains in some implementaitons.

Which components of the GIC does the apply to? The whole thing? Just the
GICD?

> +- clocks        : A phandle and clock specifier as defined by bindings of
> +		  the clock controller specified by phandle, used when the GIC
> +		  is part of a Clock Domain.

Depending on implementation, a GIC could require multiple clocks, and
their names would be implementation-specific (that said, GIC-400 has a
single "CLK" input).

Assuming that you're using GIC-400, could we use clock-names to make
that explicit?

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
