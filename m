From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] clk: sunxi: Add driver for the H3
 THS clock
Date: Mon, 23 Nov 2015 15:37:08 -0600
Message-ID: <20151123213708.GA12308@rob-hp-laptop>
References: <cover.1448263428.git.atx@atx.name>
 <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx@atx.name>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJIP47K7MERBDEOZ2ZAKGQEOHWJDUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx-MwjtXicnQwU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 23, 2015 at 09:02:49AM +0100, Josef Gajdusek wrote:
> This patch adds a driver for the THS clock which is present on the
> Allwinner H3.
> 
> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/Makefile                        |  1 +
>  drivers/clk/sunxi/clk-h3-ths.c                    | 98 +++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-h3-ths.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 23e7bce..6d63b35 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -73,6 +73,7 @@ Required properties:
>  	"allwinner,sun8i-h3-usb-clk" - for usb gates + resets on H3
>  	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>  	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
> +	"allwinner,sun8i-h3-ths-clk" - for THS on H3
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index f520af6..1bf8e1c 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -8,6 +8,7 @@ obj-y += clk-a10-hosc.o
>  obj-y += clk-a10-mod1.o
>  obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
> +obj-y += clk-h3-ths.o
>  obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
>  obj-y += clk-sun8i-bus-gates.o
> diff --git a/drivers/clk/sunxi/clk-h3-ths.c b/drivers/clk/sunxi/clk-h3-ths.c
> new file mode 100644
> index 0000000..663afc0
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-h3-ths.c
> @@ -0,0 +1,98 @@
> +/*
> + * Sunxi THS clock driver
> + *
> + * Copyright (C) 2015 Josef Gajdusek
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN8I_H3_THS_CLK_ENABLE				31
> +#define SUN8I_H3_THS_CLK_DIVIDER_SHIFT		0
> +#define SUN8I_H3_THS_CLK_DIVIDER_WIDTH		2
> +
> +static DEFINE_SPINLOCK(sun8i_h3_ths_clk_lock);
> +
> +static const struct clk_div_table sun8i_h3_ths_clk_table[] __initconst = {
> +	{ .val = 0, .div = 1 },
> +	{ .val = 1, .div = 2 },
> +	{ .val = 2, .div = 4 },
> +	{ .val = 3, .div = 6 },
> +	{ } /* sentinel */
> +};
> +
> +static void __init sun8i_h3_ths_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	struct clk_gate *gate;
> +	struct clk_divider *div;
> +	const char *parent;
> +	const char *clk_name = node->name;
> +	void __iomem *reg;
> +	int err;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +
> +	if (IS_ERR(reg))
> +		return;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		goto err_unmap;
> +
> +	div = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!div)
> +		goto err_gate_free;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +	parent = of_clk_get_parent_name(node, 0);
> +
> +	gate->reg = reg;
> +	gate->bit_idx = SUN8I_H3_THS_CLK_ENABLE;
> +	gate->lock = &sun8i_h3_ths_clk_lock;
> +
> +	div->reg = reg;
> +	div->shift = SUN8I_H3_THS_CLK_DIVIDER_SHIFT;
> +	div->width = SUN8I_H3_THS_CLK_DIVIDER_WIDTH;
> +	div->table = sun8i_h3_ths_clk_table;
> +	div->lock = &sun8i_h3_ths_clk_lock;
> +
> +	clk = clk_register_composite(NULL, clk_name, &parent, 1,
> +				     NULL, NULL,
> +				     &div->hw, &clk_divider_ops,
> +				     &gate->hw, &clk_gate_ops,
> +				     CLK_SET_RATE_PARENT);
> +
> +	if (IS_ERR(clk))
> +		goto err_div_free;
> +
> +	err = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	if (err)
> +		goto err_unregister_clk;
> +
> +	return;
> +
> +err_unregister_clk:
> +	clk_unregister(clk);
> +err_gate_free:
> +	kfree(gate);
> +err_div_free:
> +	kfree(div);
> +err_unmap:
> +	iounmap(reg);
> +}
> +
> +CLK_OF_DECLARE(sun8i_h3_ths_clk, "allwinner,sun8i-h3-ths-clk",
> +	       sun8i_h3_ths_clk_setup);
> -- 
> 2.4.10
> 
