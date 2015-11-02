From: dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8173: Add thermal zone node for
 mt8173.
Date: Mon, 2 Nov 2015 18:51:27 +0800
Message-ID: <1446461487.10039.33.camel@mtksdaap41>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
	 <1445515359-8587-3-git-send-email-dawei.chien@mediatek.com>
	 <20151028153944.GG3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151028153944.GG3716@ubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-10-28 at 21:09 +0530, Viresh Kumar wrote:
> On 22-10-15, 20:02, Dawei Chien wrote:
> > Add thermal zone node to mt8173.dtsi.
> > 
> > Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> > This patch is base on
> > https://patchwork.kernel.org/patch/7249821/
> > https://patchwork.kernel.org/patch/7249861/
> > https://patchwork.kernel.org/patch/7249891/
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   90 ++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 3b18f37..eaf12bf 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -16,6 +16,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> > +#include <dt-bindings/thermal/mt8173.h>
> >  #include "mt8173-pinfunc.h"
> >  
> >  / {
> > @@ -54,6 +55,18 @@
> >  			reg = <0x000>;
> >  			enable-method = "psci";
> >  			cpu-idle-states = <&CPU_SLEEP_0>;
> > +			static-power-points = <
> > +				859000  43
> > +				908000  52
> > +				983000  86
> > +				1009000 123
> > +				1028000 138
> > +				1083000 172
> > +				1110900 180
> > +				1125000 192
> 
> What's the unit of power here? Is this power accurate? Or just a
> number representing the power ?

The unit is mW. This power was measured by tools, but it may be not
accurate enough since this tool has a error range.

> > +			>;
> > +			dynamic-power-coefficient = <263>;
> > +			#cooling-cells = <2>;
> >  		};
> 
> @Rob: Looks like another good candidate for the OPP-v2 table? Power.
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
