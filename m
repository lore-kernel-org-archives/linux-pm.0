From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/2] arm64: dts: mt8173: Add thermal zone node for mt8173.
Date: Mon, 7 Sep 2015 12:00:25 +0800
Message-ID: <CAGS+omAxWDj+fHsJQhJ-KhFdWPZ-ymcVr63v5Q7ho2bAL_7PBQ@mail.gmail.com>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com> <1441357309-61669-3-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441357309-61669-3-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Howard Chen <howard.chen@linaro.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream <srv>
List-Id: linux-pm@vger.kernel.org

Hi Dawei,

On Fri, Sep 4, 2015 at 5:01 PM, Dawei Chien <dawei.chien@mediatek.com> wrote:
> Add thermal zone node to mt8173.dtsi.
>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on following patches
> https://patchwork.kernel.org/patch/6969581/
> https://patchwork.kernel.org/patch/6969571/
> https://patchwork.kernel.org/patch/6969381/
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 208051a..6493bfd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -17,6 +17,7 @@
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/reset-controller/mt8173-resets.h>
>  #include "mt8173-pinfunc.h"
> +#include <dt-bindings/thermal/thermal.h>

This include is not necessary, however...

>
>  / {
>         compatible = "mediatek,mt8173";
> @@ -116,6 +117,49 @@
>                 clock-output-names = "clk32k";
>         };
>
> +       thermal-zones {
> +               cpu_thermal: cpu_thermal {
> +                       polling-delay-passive = <1000>; /* milliseconds */
> +                       polling-delay = <1000>; /* milliseconds */
> +
> +                       thermal-sensors = <&thermal MT8173_THERMAL_ZONE_CA57>;

this fails to compile, because MT8173_THERMAL_ZONE_CA57 is defined in:

include/dt-bindings/thermal/mt8173.h

-Dan


> +                       sustainable-power = <1500>;
> +
> +                       trips {
> +                               threshold: trip-point@0 {
> +                                       temperature = <68000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               target: trip-point@1 {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit: cpu_crit@0 {
> +                                       temperature = <115000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map@0 {
> +                                       trip = <&target>;
> +                                       cooling-device = <&cpu0 0 0>;
> +                                       contribution = <1024>;
> +                               };
> +                               map@1 {
> +                                       trip = <&target>;
> +                                       cooling-device = <&cpu2 0 0>;
> +                                       contribution = <2048>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupt-parent = <&gic>;
> --
> 1.7.9.5
>
