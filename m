From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: add binding documentation for
 UniPhier thermal monitor
Date: Tue, 6 Jun 2017 11:46:26 +0900
Message-ID: <CAK7LNAS-1+p7u4RMuF5FVNyuSHvX+SfAYk4+YbQSdEaAVma=zg@mail.gmail.com>
References: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com> <1496049345-14649-3-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496049345-14649-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-pm@vger.kernel.org

2017-05-29 18:15 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add devicetree binding documentation for thermal monitor implemented on
> Socionext UniPhier SoCs.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/thermal/uniphier-thermal.txt          | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
> new file mode 100644
> index 0000000..72834e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
> @@ -0,0 +1,54 @@
> +* UniPhier Thermal bindings
> +
> +This describes the devicetree bindings for thermal monitor supported by
> +PVT(Process, Voltage and Temperature) monitoring unit implemented on Socionext
> +UniPhier SoCs.

This paragraph implies this might be a HWMON driver if more features
are implemented,
but I assume you use only the Temperature part for a thermal driver at
the moment.
(I do not know if other sensors are useful or not, so I do not mind it much.)



> +Required properties:
> +- compatible :
> +  - "socionext,uniphier-pxs2-thermal" : For UniPhier PXs2 SoC
> +  - "socionext,uniphier-ld20-thermal" : For UniPhier LD20 SoC
> +- reg : Offset address of the thermal registers from sysctrl


This "reg" does not exist in the example.

Your driver code uses regmap for register access.




> +- interrupts : IRQ for the temperature alarm
> +- #thermal-sensor-cells : Should be 0. See ./thermal.txt for details.
> +
> +Optional properties:
> +- socionext,tmod-calibration: A pair of calibrated values referred from PVT,
> +                              in case that the values aren't set on SoC,
> +                              like a reference board.
> +
> +Example:
> +
> +       sysctrl@61840000 {
> +               compatible = "socionext,uniphier-ld20-sysctrl",
> +                            "simple-mfd", "syscon";
> +               reg = <0x61840000 0x10000>;
> +               ...
> +               pvtctl: pvtctl {
> +                       compatible = "socionext,uniphier-ld20-thermal";
> +                       interrupts = <0 3 1>;
> +                       #thermal-sensor-cells = <0>;
> +               };
> +               ...
> +       };
> +
> +       thermal-zones {
> +               cpu_thermal {
> +                       polling-delay-passive = <250>;  /* 250ms */
> +                       polling-delay = <1000>;         /* 1000ms */
> +                       thermal-sensors = <&pvtctl>;
> +
> +                       trips {
> +                               cpu_crit: cpu_crit {
> +                                       temperature = <95000>;  /* 95C */
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                               cpu_alert: cpu_alert {
> +                                       temperature = <85000>;  /* 85C */
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                       };
> +               };
> +       };
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
