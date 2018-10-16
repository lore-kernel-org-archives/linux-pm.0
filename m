From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 3/7] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
Date: Tue, 16 Oct 2018 12:11:47 +0800
Message-ID: <CAGb2v66mUEOzN97655pz6EWvN4fu+b-bT02JhwrTE+Ru+6gR8Q@mail.gmail.com>
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-4-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013080848.29894-4-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> index e5eae8bafc42..128177178615 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -49,6 +49,37 @@
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
> +       ac_power_supply: ac-power-supply {
> +               compatible = "x-powers,axp813-ac-power-supply";

Even though they seem to be compatible, please add a model specific
compatible string in front for all the new nodes just in case. In
this case it would be "x-powers,axp803-ac-power-supply".

ChenYu

> +               status = "disabled";
> +       };
> +
> +       axp_adc: adc {
> +               compatible = "x-powers,axp813-adc";
> +               #io-channel-cells = <1>;
> +       };
> +
> +       axp_gpio: gpio {
> +               compatible = "x-powers,axp813-gpio";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio0_ldo: gpio0-ldo {
> +                       pins = "GPIO0";
> +                       function = "ldo";
> +               };
> +
> +               gpio1_ldo: gpio1-ldo {
> +                       pins = "GPIO1";
> +                       function = "ldo";
> +               };
> +       };
> +
> +       battery_power_supply: battery-power-supply {
> +               compatible = "x-powers,axp813-battery-power-supply";
> +               status = "disabled";
> +       };
> +
>         regulators {
>                 /* Default work frequency for buck regulators */
>                 x-powers,dcdc-freq = <3000>;
> --
> 2.17.1
>
