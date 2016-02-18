From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
Date: Thu, 18 Feb 2016 17:18:49 +0100
Message-ID: <56C5EEE9.4020407@gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448883753-19068-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Sascha,

On 30/11/15 12:42, Sascha Hauer wrote:
> This adds the thermal controller and auxadc nodes to the Mediatek MT8173
> dtsi file.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 06a1564..e2ddd03 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -277,6 +277,11 @@
>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   		};
>
> +		auxadc: auxadc@11001000 {
> +			compatible = "mediatek,mt8173-auxadc";

Can you please write a small Documentation about the binding.
I suppose it will be mediatek,auxadc and mediatek,mt8173-auxadc.

I can't do it my self, as my datasheet lacks the auxadc registers.

Thanks,
Matthias

> +			reg = <0 0x11001000 0 0x1000>;
> +		};
> +
>   		uart0: serial@11002000 {
>   			compatible = "mediatek,mt8173-uart",
>   				     "mediatek,mt6577-uart";
> @@ -487,6 +492,18 @@
>   			clock-names = "source", "hclk";
>   			status = "disabled";
>   		};
> +
> +		thermal: thermal@1100b000 {
> +			#thermal-sensor-cells = <0>;
> +			compatible = "mediatek,mt8173-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +		};
>   	};
>   };
>
>
