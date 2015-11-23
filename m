From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 2/5] clk: sunxi: Add driver for the H3
 THS clock
Date: Mon, 23 Nov 2015 12:28:09 +0200
Message-ID: <1448274489.27496.1.camel@plaes.org>
References: <cover.1448263428.git.atx@atx.name>
	 <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx@atx.name>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBO6UZOZAKGQE7PEQJ2I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <077fddc9c8d41d4cf55b1dd1c7180c4adee0fce4.1448263428.git.atx-MwjtXicnQwU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: atx-MwjtXicnQwU@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-11-23 at 09:02 +0100, Josef Gajdusek wrote:
> This patch adds a driver for the THS clock which is present on the
> Allwinner H3.
>=20
> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
> ---
> =C2=A0Documentation/devicetree/bindings/clock/sunxi.txt |=C2=A0=C2=A01 +
> =C2=A0drivers/clk/sunxi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0drivers/clk/sunxi/clk-h3-ths.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 98
> +++++++++++++++++++++++
> =C2=A03 files changed, 100 insertions(+)
> =C2=A0create mode 100644 drivers/clk/sunxi/clk-h3-ths.c
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt
> b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 23e7bce..6d63b35 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -73,6 +73,7 @@ Required properties:
> =C2=A0	"allwinner,sun8i-h3-usb-clk" - for usb gates + resets on H3
> =C2=A0	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets
> on A80
> =C2=A0	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates +
> resets on A80
> +	"allwinner,sun8i-h3-ths-clk" - for THS on H3
> =C2=A0
> =C2=A0Required properties for all clocks:
> =C2=A0- reg : shall be the control register address for the clock.
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index f520af6..1bf8e1c 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -8,6 +8,7 @@ obj-y +=3D clk-a10-hosc.o
> =C2=A0obj-y +=3D clk-a10-mod1.o
> =C2=A0obj-y +=3D clk-a10-pll2.o
> =C2=A0obj-y +=3D clk-a20-gmac.o
> +obj-y +=3D clk-h3-ths.o
> =C2=A0obj-y +=3D clk-mod0.o
> =C2=A0obj-y +=3D clk-simple-gates.o
> =C2=A0obj-y +=3D clk-sun8i-bus-gates.o
> diff --git a/drivers/clk/sunxi/clk-h3-ths.c b/drivers/clk/sunxi/clk-
> h3-ths.c
> new file mode 100644
> index 0000000..663afc0
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-h3-ths.c
> @@ -0,0 +1,98 @@
> +/*
> + * Sunxi THS clock driver

This should be "Allwinner H3 THS clock driver"

> + *
> + * Copyright (C) 2015 Josef Gajdusek
> + *
> + * This software is licensed under the terms of the GNU General
> Public
> + * License version 2, as published by the Free Software Foundation,
> and
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
> +static const struct clk_div_table sun8i_h3_ths_clk_table[]
> __initconst =3D {
> +	{ .val =3D 0, .div =3D 1 },
> +	{ .val =3D 1, .div =3D 2 },
> +	{ .val =3D 2, .div =3D 4 },
> +	{ .val =3D 3, .div =3D 6 },
> +	{ } /* sentinel */
> +};
> +
> +static void __init sun8i_h3_ths_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	struct clk_gate *gate;
> +	struct clk_divider *div;
> +	const char *parent;
> +	const char *clk_name =3D node->name;
> +	void __iomem *reg;
> +	int err;
> +
> +	reg =3D of_io_request_and_map(node, 0,
> of_node_full_name(node));
> +
> +	if (IS_ERR(reg))
> +		return;
> +
> +	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		goto err_unmap;
> +
> +	div =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!div)
> +		goto err_gate_free;
> +
> +	of_property_read_string(node, "clock-output-names",
> &clk_name);
> +	parent =3D of_clk_get_parent_name(node, 0);
> +
> +	gate->reg =3D reg;
> +	gate->bit_idx =3D SUN8I_H3_THS_CLK_ENABLE;
> +	gate->lock =3D &sun8i_h3_ths_clk_lock;
> +
> +	div->reg =3D reg;
> +	div->shift =3D SUN8I_H3_THS_CLK_DIVIDER_SHIFT;
> +	div->width =3D SUN8I_H3_THS_CLK_DIVIDER_WIDTH;
> +	div->table =3D sun8i_h3_ths_clk_table;
> +	div->lock =3D &sun8i_h3_ths_clk_lock;
> +
> +	clk =3D clk_register_composite(NULL, clk_name, &parent, 1,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL, NULL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&div->hw, &clk_divider_ops,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&gate->hw, &clk_gate_ops,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CLK_SET_RATE_PARENT);
> +
> +	if (IS_ERR(clk))
> +		goto err_div_free;
> +
> +	err =3D of_clk_add_provider(node, of_clk_src_simple_get, clk);
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
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i_h3_ths_clk_setup);
> --=20
> 2.4.10
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
