From: Siarhei Siamashka <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: Add support for Sunxi THS on the
 Allwinner H3
Date: Thu, 19 Nov 2015 05:20:31 +0200
Message-ID: <20151119052031.58d25778@i7>
References: <20151118205147.GA19779@maud.lan>
Reply-To: siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCH4DA7NUEBBBEEAWWZAKGQEYMT7RLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151118205147.GA19779-G3LsmoRFMBI@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, 18 Nov 2015 21:51:48 +0100
Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org> wrote:

> This patch adds support for the Sunxi thermal sensor on the Allwinner H3.
> Also adds declaration of the H3 THS clock to clk-sunxi.c ignoring the
> dividers as they are not continuous (clk-divider.c cannot be used as it
> does not support setting an enable bit).
> Should be easily extendable for the A33/A83T/... as they have similar but
> not completely identical sensors.
> 
> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>

Thanks for working on this. The thermal sensor is very useful on
H3 because this SoC tends to be running rather hot at high clock
frequencies.

Do you also have plans for making use of an irq handler?

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
>  .../devicetree/bindings/thermal/sunxi-ths.txt      |  24 ++
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  27 +++
>  drivers/clk/sunxi/clk-sunxi.c                      |  16 ++
>  drivers/thermal/Kconfig                            |   7 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/sunxi_ths.c                        | 263 +++++++++++++++++++++
>  7 files changed, 339 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunxi-ths.txt
>  create mode 100644 drivers/thermal/sunxi_ths.c

[...]

> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -604,6 +604,13 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
>  	*p = calcp;
>  }
>  
> +static void sun8i_h3_get_ths_factors(u32 *freq, u32 parent_rate,
> +				      u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	/* Ignore the dividers as they are not continuous */
> +	*freq = parent_rate;
> +}

Can you elaborate on this? What's wrong with the dividers? Which clock
frequency happens to be used for THS in the end?

> +static int sunxi_ths_h3_init(struct sunxi_ths_data *data)
> +{
> +	if (data->calreg)
> +		writel(readl(data->calreg) & 0xfff, data->regs + THS_H3_CDATA);
> +	/* Magical constants mostly taken from Allwinner 3.4 kernel.
> +	 * Seem to work fine, though this could be configurable in DT/sysft
> +	 */
> +	writel(0xff << THS_H3_CTRL0_SENSOR_ACQ0,
> +			data->regs + THS_H3_CTRL0);
> +	writel((0x3f << THS_H3_CTRL2_SENSOR_ACQ1) | BIT(THS_H3_CTRL2_SENSE_EN),
> +			data->regs + THS_H3_CTRL2);
> +	writel((0x390 << THS_H3_INT_CTRL_THERMAL_PER) | BIT(THS_H3_INT_CTRL_DATA_IRQ_EN),
> +			data->regs + THS_H3_INT_CTRL);
> +	writel(BIT(THS_H3_FILTER_EN) | (0x2 << THS_H3_FILTER_TYPE),
> +			data->regs + THS_H3_FILTER);
> +	return 0;
> +}

The H3 manual has some nice description of these registers and explains
how these parameters should be calculated (they depend on the THS clock
frequency). No magic involved.

Currently the H3 manual is available from Orange Pi people and OLIMEX.
There is also an open request about releasing it "officially":
    https://github.com/allwinner-zh/documents/issues/9

-- 
Best regards,
Siarhei Siamashka
