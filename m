From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ARM: dts: Add binding documentation
 for AXP20x pmic ac power supply
Date: Sun, 1 May 2016 17:41:45 +0800
Message-ID: <CAGb2v64hzeGc1tbtszVXkiexr--ry5KeOHcqj=MkH9-6HAzNQQ@mail.gmail.com>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org> <1462093047-7885-5-git-send-email-haas@computerlinguist.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB4M6S64QKGQECDWU3EY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1462093047-7885-5-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, degoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, May 1, 2016 at 4:57 PM, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org> wrote:
> Add binding documentation for the ac power supply part of the AXP20x
> pmic.
>
> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/power_supply/axp20x_ac_power.txt      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
>
> diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> new file mode 100644
> index 0000000..1cbdcfb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> @@ -0,0 +1,34 @@
> +AXP20x AC power supply
> +
> +Required Properties:
> +-compatible: "x-powers,axp202-ac-power-supply"
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +Example:
> +
> +axp209: pmic@34 {
> +       compatible = "x-powers,axp209";
> +       reg = <0x34>;
> +       interrupt-parent = <&nmi_intc>;
> +       interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       interrupt-controller;
> +       #interrupt-cells = <1>;
> +
> +       regulators {
> +               x-powers,dcdc-freq = <1500>;
> +
> +               vdd_cpu: dcdc2 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1450000>;
> +                       regulator-name = "vdd-cpu";
> +               };
> +
> +               ...
> +       };

You don't need to include this in the example. Just a "..." would suffice.

> +
> +       ac-power-supply: ac-power-supply {
> +               compatible = "x-powers,axp202-ac-power-supply";
> +       };

Also this should come first in alphabetic order.

Otherwise,

Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

> +};
> --
> 2.8.0
>
