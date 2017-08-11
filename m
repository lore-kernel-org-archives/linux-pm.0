From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: add thermal nodes for rk3328 SoC
Date: Fri, 11 Aug 2017 11:48:34 +0200
Message-ID: <1597866.JTNQsbvSkT@phil>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com> <b9f85901-2fb5-d4ed-503c-1c4684d821e7@rock-chips.com> <f0c7ab33-1b7b-8b9d-fd20-aa84001014cc@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f0c7ab33-1b7b-8b9d-fd20-aa84001014cc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "rocky.hao" <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Rocky,

Am Freitag, 11. August 2017, 17:46:55 CEST schrieb rocky.hao:
> Hi Caesar,
> Thanks for your comments.

just to add, there is no need to resend, I can drop the comments
here myself when applying :-)


Heiko

> Best Regards,
> Rocky
> 
> 在 2017/8/11 14:44, Caesar Wang 写道:
> > 在 2017年08月04日 16:06, Rocky Hao 写道:
> >> add thermal zone and dynamic CPU power coefficients for rk3328
> >>
> >> Signed-off-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >> ---
> >> Change in v2:
> >> - remove gerrit Change-Id
> >>
> >>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 43 
> >> ++++++++++++++++++++++++++++++++
> >>   1 file changed, 43 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi 
> >> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> index 186fb93fdffd..68829f808320 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> @@ -47,6 +47,7 @@
> >>   #include <dt-bindings/pinctrl/rockchip.h>
> >>   #include <dt-bindings/power/rk3328-power.h>
> >>   #include <dt-bindings/soc/rockchip,boot-mode.h>
> >> +#include <dt-bindings/thermal/thermal.h>
> >>   / {
> >>       compatible = "rockchip,rk3328";
> >> @@ -74,6 +75,8 @@
> >>               compatible = "arm,cortex-a53", "arm,armv8";
> >>               reg = <0x0 0x0>;
> >>               clocks = <&cru ARMCLK>;
> >> +            #cooling-cells = <2>; /* min followed by max */
> >> +            dynamic-power-coefficient = <120>;
> >>               enable-method = "psci";
> >>               next-level-cache = <&l2>;
> >>           };
> >> @@ -83,6 +86,7 @@
> >>               compatible = "arm,cortex-a53", "arm,armv8";
> >>               reg = <0x0 0x1>;
> >>               clocks = <&cru ARMCLK>;
> >> +            dynamic-power-coefficient = <120>;
> >>               enable-method = "psci";
> >>               next-level-cache = <&l2>;
> >>           };
> >> @@ -92,6 +96,7 @@
> >>               compatible = "arm,cortex-a53", "arm,armv8";
> >>               reg = <0x0 0x2>;
> >>               clocks = <&cru ARMCLK>;
> >> +            dynamic-power-coefficient = <120>;
> >>               enable-method = "psci";
> >>               next-level-cache = <&l2>;
> >>           };
> >> @@ -101,6 +106,7 @@
> >>               compatible = "arm,cortex-a53", "arm,armv8";
> >>               reg = <0x0 0x3>;
> >>               clocks = <&cru ARMCLK>;
> >> +            dynamic-power-coefficient = <120>;
> >>               enable-method = "psci";
> >>               next-level-cache = <&l2>;
> >>           };
> >> @@ -308,6 +314,43 @@
> >>           interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> >>       };
> >> +    thermal-zones {
> >> +        soc_thermal: soc-thermal {
> >> +            polling-delay-passive = <20>; /* milliseconds */
> >> +            polling-delay = <1000>; /* milliseconds */
> >> +            sustainable-power = <1000>; /* milliwatts */
> >> +
> >> +            thermal-sensors = <&tsadc 0>;
> >> +
> >> +            trips {
> >> +                threshold: trip-point0 {
> >> +                    temperature = <70000>; /* millicelsius */
> >> +                    hysteresis = <2000>; /* millicelsius */
> >> +                    type = "passive";
> >> +                };
> >> +                target: trip-point1 {
> >> +                    temperature = <85000>; /* millicelsius */
> >> +                    hysteresis = <2000>; /* millicelsius */
> >> +                    type = "passive";
> >> +                };
> >> +                soc_crit: soc-crit {
> >> +                    temperature = <95000>; /* millicelsius */
> >> +                    hysteresis = <2000>; /* millicelsius */
> > 
> > The document had already described, maybe we should remove the 
> > millicelsius/milliseconds/milliwatts here.
> It is ok for me.
> >> +                    type = "critical";
> >> +                };
> >> +            };
> >> +
> >> +            cooling-maps {
> >> +                map0 {
> >> +                    trip = <&target>;
> >> +                    cooling-device = <&cpu0 THERMAL_NO_LIMIT 
> >> THERMAL_NO_LIMIT>;
> >> +                    contribution = <4096>;
> >> +                };
> >> +            };
> >> +        };
> >> +
> >> +    };
> >> +
> >>       tsadc: tsadc@ff250000 {
> >>           compatible = "rockchip,rk3328-tsadc";
> >>           reg = <0x0 0xff250000 0x0 0x100>;
> > 
> > 
> > 
> > 
> 
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
