From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8173: Add thermal zone node for
 mt8173.
Date: Wed, 28 Oct 2015 21:09:44 +0530
Message-ID: <20151028153944.GG3716@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-3-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445515359-8587-3-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 22-10-15, 20:02, Dawei Chien wrote:
> Add thermal zone node to mt8173.dtsi.
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on
> https://patchwork.kernel.org/patch/7249821/
> https://patchwork.kernel.org/patch/7249861/
> https://patchwork.kernel.org/patch/7249891/
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   90 ++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 3b18f37..eaf12bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -16,6 +16,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/reset-controller/mt8173-resets.h>
> +#include <dt-bindings/thermal/mt8173.h>
>  #include "mt8173-pinfunc.h"
>  
>  / {
> @@ -54,6 +55,18 @@
>  			reg = <0x000>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			static-power-points = <
> +				859000  43
> +				908000  52
> +				983000  86
> +				1009000 123
> +				1028000 138
> +				1083000 172
> +				1110900 180
> +				1125000 192

What's the unit of power here? Is this power accurate? Or just a
number representing the power ?

> +			>;
> +			dynamic-power-coefficient = <263>;
> +			#cooling-cells = <2>;
>  		};

@Rob: Looks like another good candidate for the OPP-v2 table? Power.

-- 
viresh
