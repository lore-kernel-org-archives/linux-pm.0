From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 09/10] ARM: sun8i: h2+: add SY8113B
 regulator used by Orange Pi Zero board
Date: Mon, 24 Jul 2017 12:09:14 +0800
Message-ID: <CAGb2v65B10VuG6YDKuFmx-7Z5R-PRLiN51g484MA_959y=Le5Q@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-10-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170723102749.17323-10-icenowy-h8G6r0blFSE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
> Orange Pi Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL6 GPIO is set to output 0
> or 1.3V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H2+ SoC.
>
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index 6713d0f2b3f4..28b4433bd7f7 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -94,6 +94,27 @@
>                 reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
>                 post-power-on-delay-ms = <200>;
>         };
> +
> +       reg_sy8113b: gpio-regulator {
> +               compatible = "regulator-gpio";
> +

No need for the newline.

> +               regulator-name = "vdd-cpux";
> +               regulator-type = "voltage";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-ramp-delay = <50>; /* 4ms */

You should also add "enable-active-high". The driver might not
honor the GPIO_ACTIVE_HIGH flag. AFAIK this was a problem with
the old GPIO API.

ChenYu

> +
> +               gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0
> +                         1300000 0x1>;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&reg_sy8113b>;
>  };
>
>  &ehci0 {
> --
> 2.13.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
