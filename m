From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/11] pwm: tegra-dfll: Add driver for Tegra DFLL PWM
 controller
Date: Fri, 22 Apr 2016 14:55:13 +0200
Message-ID: <20160422125513.GJ9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-6-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461321071-6431-6-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Penny Chiu <pchiu@nvidia.com>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 06:31:05PM +0800, Penny Chiu wrote:
> Tegra DFLL IP block controls off-chip PMIC via I2C bus or PWM
> signals. This driver exposes DFLL as a PWM controller to generate
> PWM signals to PWM regulator.
>=20
> Tegra DFLL HW changes regulator voltage by adjusting PWM signals
> duty cycle automatically based on required DVCO frequency, so PWM
> regulator client doesn't need to change voltage by SW.
>=20
> In this driver, it only configs proper PWM rate in the driver
> initialization, and provides two APIs for clients to determine when
> to enable and disable generating PWM signals by setting related
> pinmux tristate.
>=20
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  .../bindings/pwm/nvidia,tegra-dfll-pwm.txt         |  48 +++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-tegra-dfll.c                       | 322 +++++++++++++++=
++++++
>  include/soc/tegra/pwm-tegra-dfll.h                 |  27 ++
>  5 files changed, 408 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra-df=
ll-pwm.txt
>  create mode 100644 drivers/pwm/pwm-tegra-dfll.c
>  create mode 100644 include/soc/tegra/pwm-tegra-dfll.h
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.=
txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
> new file mode 100644
> index 0000000..bd0d247
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
> @@ -0,0 +1,48 @@
> +Tegra SoC DFLL PWM controller

Does this exist on Tegra124 as well? The reason why I ask is that the
file name should usually contain the name of the first SoC generation
that contains an IP block described by the binding. I'm not sure we've
ever clarified whether it is supposed to be the first chip where a
compatible IP block was introduced or where we've made use of it in the
Linux kernel. I think it's usually the latter, but technically the
former would be more correct (since DT describes hardware, not on OS
implementation for said hardware).

Stephen, we have in the past used tegra124 in names, even if the IP was
already included in tegra114, but we never supported it on Tegra114 and
hence couldn't even verify that the binding was valid. Any preference as
to the name in this particular case?

> +Required properties:
> +- compatible: For Tegra210, must contain "nvidia,tegra210-dfll-pwm".
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: should be 2. See pwm.txt in this directory for a descripti=
on of
> +  the cells format.
> +- clock-names: Must include the "ref" entry.
> +- clocks: Must contain one entry, for the DFLL closed loop reference clo=
ck.
> +  See ../clocks/clock-bindings.txt for details.

I think it would be more idiomatic to describe this the other way
around. That is, describe in the clock-names property what each entry
means, then the clocks property can simply say must contain one entry
for each entry in clock-names.

> +- pwm-regulator: phandle to PWM regulator for using this PWM controller.

Why do we need the back link? I'd expect the regulator to be simply a
user of the PWM. Why do we need to access the regulator from the PWM?
I'm not sure (yet) how you've solved this in the driver, but it seems
like you've just created a circular dependency, which is usually not
good at all.

> +- pinctrl-names: Must contain two entries to enable and disable PWM sign=
als
> +  output pinmux states.
> +- pinctrl-0: pinmux state to enable PWM signals output
> +- pinctrl-1: pinmux state to disable PWM signals output

Here again I think you need to specify what names are expected in the
pinctrl-names property and then pinctrl-N should be described as
representing the phandle to the pinmux state for the Nth entry in
pinctrl-names.

> +
> +Example:
> +
> +	pinmux: pinmux@700008d4 {
> +		dvfs_pwm_active_state: dvfs_pwm_active {
> +			dvfs_pwm_pbb1 {
> +				nvidia,pins =3D "dvfs_pwm_pbb1";
> +				nvidia,tristate =3D <TEGRA_PIN_DISABLE>;
> +			};
> +		};
> +
> +		dvfs_pwm_inactive_state: dvfs_pwm_inactive {
> +			dvfs_pwm_pbb1 {
> +				nvidia,pins =3D "dvfs_pwm_pbb1";
> +				nvidia,tristate =3D <TEGRA_PIN_ENABLE>;
> +			};
> +		};
> +	};
> +
> +	pwm_dfll: pwm@70110000 {
> +		compatible =3D "nvidia,tegra210-dfll-pwm";

The TRM denotes this block as DVFS and in fact on Tegra124 we've added
an entry that exposes this as clock@70110000 and with a different
compatible: nvidia,tegra124-dfll.

I'd like to understand how this works. The DFLL binding suggests that
this PWM mode is supported on Tegra124 as well, so I'm presuming that
Tegra210 has pretty much the same IP and supports both I2C and PWM
modes.

Does this binding then effectively replace the nvidia,tegra124-dfll one
and uses the IP block in some different mode?

> +		reg =3D <0x0 0x70110000 0x0 0x400>;
> +		clocks =3D <&tegra_car TEGRA210_CLK_DFLL_REF>;
> +		clock-names =3D "ref";
> +		#pwm-cells =3D <2>;
> +		pwm-regulator =3D <&cpu_ovr_reg>;
> +
> +		pinctrl-names =3D "dvfs_pwm_enable", "dvfs_pwm_disable";

"enable" and "disable" should be enough, since these are scoped within
the pwm_dfll node anyway.

> diff --git a/drivers/pwm/pwm-tegra-dfll.c b/drivers/pwm/pwm-tegra-dfll.c
> new file mode 100644
> index 0000000..74d6b97
> --- /dev/null
> +++ b/drivers/pwm/pwm-tegra-dfll.c
> @@ -0,0 +1,322 @@
> +/*
> + * drivers/pwm/pwm-tegra-dfll.c
> + *
> + * Tegra DFLL PWM controller driver
> + *
> + * Copyright (c) 2016, NVIDIA Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <soc/tegra/pwm-tegra-dfll.h>
> +
> +/* DFLL_CTRL: DFLL control register */
> +#define DFLL_CTRL			0x00
> +
> +/* DFLL_OUTPUT_CFG: closed loop mode control registers */
> +#define DFLL_OUTPUT_CFG			0x20
> +#define OUT_MASK			0x3f
> +#define DFLL_OUTPUT_CFG_PWM_DELTA	(0x1 << 7)
> +#define DFLL_OUTPUT_CFG_PWM_ENABLE	(0x1 << 6)

If these are simple bits you should leave away the 0x prefix. 0x prefix
suggests that it is one particular value of a multi-bit field.

> +#define DFLL_OUTPUT_CFG_PWM_DIV_SHIFT	0
> +#define DFLL_OUTPUT_CFG_PWM_DIV_MASK	\
> +		(OUT_MASK << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT)
> +
> +/* MAX_DFLL_VOLTAGES: number of LUT entries in the DFLL IP block */
> +#define DFLL_MAX_VOLTAGES		33
> +
> +#define DFLL_OF_PWM_PERIOD_CELL		1
> +
> +/**
> + * struct tegra_dfll_pwm_chip - DFLL PWM controller data
> + * @pwm_pin: pinmux for PWM signals output
> + * @pwm_enable_state: enabled states of pinmux for PWM signals output
> + * @pwm_disable_state: disabled states of pinmux for PWM signals output
> + * @mmio_base: mmio base for access DFLL registers
> + * @ref_clk: referenced source clock
> + * @pwm_rate: PWM rate for DFLL PWM output config register
> + */
> +struct tegra_dfll_pwm_chip {
> +	struct pwm_chip		chip;
> +	struct device		*dev;

struct pwm_chip already has a struct device *dev member, perhaps reuse
that instead of keeping another copy?

> +
> +	struct pinctrl		*pwm_pin;
> +	struct pinctrl_state	*pwm_enable_state;
> +	struct pinctrl_state	*pwm_disable_state;
> +
> +	void __iomem		*mmio_base;
> +	struct clk		*ref_clk;
> +
> +	unsigned long		ref_rate;
> +	unsigned long		pwm_rate;
> +};
> +
> +static struct tegra_dfll_pwm_chip *tdpc;

Try to avoid this global variable, please.

> +
> +/*
> + * Register accessors
> + */
> +static inline u32 pwm_readl(u32 offs)

I prefer the offset to be unsigned int, otherwise it might be mistaken
for a register value (because of the explicit width). Also I find it
easier to read if offs here...

> +{
> +	return __raw_readl(tdpc->mmio_base + offs);
> +}
> +
> +static inline void pwm_writel(u32 val, u32 offs)

and val here are spelled out as offset and value.

> +{
> +	__raw_writel(val, tdpc->mmio_base + offs);

Any particular reason why you use __raw_*() accessors here?

> +	pwm_readl(DFLL_CTRL);

Why is this required?

> +}
> +
> +static int tegra_dfll_pwm_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				int duty_ns, int period_ns)
> +{
> +	return 0;
> +}

Huh? How come this doesn't need to be implemented?

> +static int tegra_dfll_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	u32 val;
> +
> +	val =3D pwm_readl(DFLL_OUTPUT_CFG);
> +	val |=3D DFLL_OUTPUT_CFG_PWM_ENABLE;
> +	pwm_writel(val, DFLL_OUTPUT_CFG);
> +
> +	dev_info(tdpc->dev, "DFLL_PWM is enabled\n");

dev_info() is a little strong here, don't you think?

> +
> +	return 0;
> +}
> +
> +static void tegra_dfll_pwm_disable(struct pwm_chip *chip,
> +				   struct pwm_device *pwm)
> +{
> +	u32 val;
> +
> +	val =3D pwm_readl(DFLL_OUTPUT_CFG);
> +	val &=3D ~DFLL_OUTPUT_CFG_PWM_ENABLE;
> +	pwm_writel(val, DFLL_OUTPUT_CFG);
> +
> +	dev_info(tdpc->dev, "DFLL_PWM is disabled\n");

Same here. This is debugging information and should at most be dev_dbg()
if anything at all.

> +
> +	return 0;
> +}
> +
> +/**
> + * tegra_dfll_pwm_output_enable - enable DFLL PWM signals output
> + *
> + * Enable DFLL PWM signals output by changing related pinmux state
> + */
> +int tegra_dfll_pwm_output_enable(void)
> +{
> +	int ret;
> +
> +	ret =3D pinctrl_select_state(tdpc->pwm_pin, tdpc->pwm_enable_state);
> +	if (ret < 0) {
> +		dev_err(tdpc->dev, "setting enable state failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tegra_dfll_pwm_output_enable);
> +
> +/**
> + * tegra_dfll_pwm_output_disable - disable DFLL PWM signals output
> + *
> + * Disable DFLL PWM signals output by changing related pinmux state
> + */
> +int tegra_dfll_pwm_output_disable(void)
> +{
> +	int ret;
> +
> +	ret =3D pinctrl_select_state(tdpc->pwm_pin, tdpc->pwm_disable_state);
> +	if (ret < 0) {
> +		dev_err(tdpc->dev, "setting enable state failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tegra_dfll_pwm_output_disable);

I don't get why you need to export these symbols as custom API. Why not
simply make this part of the ->enable() and ->disable() implementations?

> +
> +static const struct pwm_ops tegra_dfll_pwm_ops =3D {
> +	.config =3D tegra_dfll_pwm_config,
> +	.enable =3D tegra_dfll_pwm_enable,
> +	.disable =3D tegra_dfll_pwm_disable,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +/**
> + * dt_parse_pwm_regulator - parse PWM regulator from device-tree
> + *
> + * Parse DFLL PWM controller client to get and calcluate initialized
> + * DFLL PWM rate.
> + */
> +static int dt_parse_pwm_regulator(void)
> +{
> +	struct device_node *r_dn =3D
> +		of_parse_phandle(tdpc->dev->of_node, "pwm-regulator", 0);
> +	struct of_phandle_args args;
> +	unsigned long val;
> +	int ret;
> +
> +	/* pwm regulator device */
> +	if (!r_dn) {
> +		dev_err(tdpc->dev, "DT: missing pwm-regulator property\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D of_parse_phandle_with_args(r_dn, "pwms", "#pwm-cells", 0, &args=
);
> +	if (ret) {
> +		dev_err(tdpc->dev, "DT: failed to parse pwms property\n");
> +		return -EINVAL;
> +	}
> +	of_node_put(args.np);

That's completely backwards, isn't it? Isn't the regulator using this
very PWM to control the voltage? Would args.np not always be the same as
tdpc->dev->of_node?

> +
> +	if (args.args_count <=3D DFLL_OF_PWM_PERIOD_CELL) {
> +		dev_err(tdpc->dev, "DT: low #pwm-cells %d\n", args.args_count);

You may want to provide at least some information about how many cells
you expect.

> +		return -EINVAL;
> +	}
> +
> +	/* convert pwm period in ns to DFLL pwm rate in Hz */
> +	val =3D args.args[DFLL_OF_PWM_PERIOD_CELL];
> +	val =3D (NSEC_PER_SEC / val) * (DFLL_MAX_VOLTAGES - 1);
> +	tdpc->pwm_rate =3D val;
> +	dev_info(tdpc->dev, "DFLL pwm-rate: %lu\n", val);

Again, this is much too verbose.

> +
> +	return 0;
> +}
> +
> +/**
> + * tegra_dfll_pwm_init - init Tegra DFLL PWM controller
> + *
> + * Calculate the DIV value and write into DFLL register
> + */
> +static int tegra_dfll_pwm_init(void)
> +{
> +	u32 div, val;
> +
> +	pwm_writel(0, DFLL_OUTPUT_CFG);

Why write it with 0 if you're going to overwrite it below again?

> +
> +	div =3D DIV_ROUND_UP(tdpc->ref_rate, tdpc->pwm_rate);
> +	val =3D (div << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT) &
> +	      DFLL_OUTPUT_CFG_PWM_DIV_MASK;
> +	pwm_writel(val, DFLL_OUTPUT_CFG);
> +
> +	return 0;
> +}
> +
> +static int tegra_dfll_pwm_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +
> +	tdpc =3D devm_kzalloc(&pdev->dev, sizeof(*tdpc), GFP_KERNEL);
> +	if (!tdpc)
> +		return -ENOMEM;
> +
> +	tdpc->dev =3D &pdev->dev;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tdpc->mmio_base =3D devm_ioremap_resource(tdpc->dev, res);
> +	if (IS_ERR(tdpc->mmio_base))
> +		return PTR_ERR(tdpc->mmio_base);
> +
> +	platform_set_drvdata(pdev, tdpc);
> +
> +	tdpc->chip.dev =3D tdpc->dev;
> +	tdpc->chip.ops =3D &tegra_dfll_pwm_ops;
> +	tdpc->chip.base =3D -1;
> +	tdpc->chip.npwm =3D 1;
> +
> +	ret =3D pwmchip_add(&tdpc->chip);
> +	if (ret < 0) {
> +		dev_err(tdpc->dev, "pwmchip_add() failed: %d\n", ret);
> +		return ret;
> +	}

This should be the very last thing you do. pwmchip_add() will otherwise
make the PWM chip available to all users in the system and keep it
around even if any of the below fails. You could always remove it again
on failure, but then why go through the trouble of registering something
that you may fail to set up?

> +
> +	tdpc->ref_clk =3D devm_clk_get(tdpc->dev, "ref");
> +	if (IS_ERR(tdpc->ref_clk)) {
> +		dev_err(tdpc->dev, "DT: missing ref clock\n");
> +		return PTR_ERR(tdpc->ref_clk);
> +	}
> +
> +	tdpc->ref_rate =3D clk_get_rate(tdpc->ref_clk);
> +
> +	tdpc->pwm_pin =3D devm_pinctrl_get(tdpc->dev);
> +	if (IS_ERR(tdpc->pwm_pin)) {
> +		dev_err(tdpc->dev, "DT: missing pinctrl device\n");
> +		return PTR_ERR(tdpc->pwm_pin);
> +	}
> +
> +	tdpc->pwm_enable_state =3D pinctrl_lookup_state(tdpc->pwm_pin,
> +						"dvfs_pwm_enable");
> +	if (IS_ERR(tdpc->pwm_enable_state)) {
> +		dev_err(tdpc->dev, "DT: missing pwm enabled state\n");
> +		return PTR_ERR(tdpc->pwm_enable_state);
> +	}
> +
> +	tdpc->pwm_disable_state =3D pinctrl_lookup_state(tdpc->pwm_pin,
> +						"dvfs_pwm_disable");
> +	if (IS_ERR(tdpc->pwm_disable_state)) {
> +		dev_err(tdpc->dev, "DT: missing pwm disabled state\n");
> +		return PTR_ERR(tdpc->pwm_disable_state);
> +	}
> +
> +	ret =3D dt_parse_pwm_regulator();
> +	if (ret < 0) {
> +		dev_err(tdpc->dev, "failed to parse pwm regulator\n");
> +		return ret;
> +	}
> +
> +	ret =3D tegra_dfll_pwm_init();
> +	if (ret < 0) {
> +		dev_err(tdpc->dev, "failed to init DFLL pwm\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_dfll_pwm_remove(struct platform_device *pdev)
> +{
> +	return pwmchip_remove(&tdpc->chip);
> +}
> +
> +static const struct of_device_id tegra_dfll_pwm_of_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra210-dfll-pwm" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, tegra_dfll_pwm_of_match);
> +
> +static struct platform_driver tegra_dfll_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "tegra-dfll-pwm",
> +		.of_match_table =3D tegra_dfll_pwm_of_match,
> +	},
> +	.probe =3D tegra_dfll_pwm_probe,
> +	.remove =3D tegra_dfll_pwm_remove,
> +};
> +
> +module_platform_driver(tegra_dfll_pwm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("NVIDIA Corporation");

You should put the name of a real person here. It's meant as contact
information if anyone wants to contact the author about issues with the
driver, so ideally it'd include an email address as well.

> +MODULE_ALIAS("platform:tegra-dfll-pwm");
> diff --git a/include/soc/tegra/pwm-tegra-dfll.h b/include/soc/tegra/pwm-t=
egra-dfll.h
> new file mode 100644
> index 0000000..d34c6e8
> --- /dev/null
> +++ b/include/soc/tegra/pwm-tegra-dfll.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2016 NVIDIA Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_TEGRA_PWM_TEGRA_DFLL_H__
> +#define __SOC_TEGRA_PWM_TEGRA_DFLL_H__
> +
> +#ifdef CONFIG_PWM_TEGRA_DFLL
> +int tegra_dfll_pwm_output_enable(void);
> +int tegra_dfll_pwm_output_disable(void);
> +#else
> +static inline int tegra_dfll_pwm_output_enable(void)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int tegra_dfll_pwm_output_disable(void)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif
> +
> +#endif /* __SOC_TEGRA_PWM_TEGRA_DFLL_H__ */

I'd prefer to avoid this header if at all possible.

Thierry

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGh8sAAoJEN0jrNd/PrOh3PsQAIIyyjgsZ29DcLNpO6U8nKlq
959a4RchsqViW7+5qxWccd8WYTe3Zw6ysiao8KKV0gD/OrOgIV1GZSQ+KqY0jEjV
tAMz8TPbHF/0wOgRyYOc9r1k2WldEX9xwSALTqE8cYEjXGxWBnDHSNEQ7+VeQAJb
XlmO6OtmSxYlEyty3c2hBtCiKmZTzLfPF+BTyhfuhKAf9qWaBpU6o63jPQ+g+xOX
wTzkdfUUiYq0+VO9EvKx0OOSRqkCYUVv/l777go17sSmaAZrdXSMzZsGwXNuar8g
CKqJrwIpxzarfozTlhQfyMWZpa1mxty2I1mxSwm8qpkElcnuNYxl+SY7o0AvheT5
tpicJWcH4eM1tM4BBfjvvhmp/KqRCcGqko18w1uWQNcvHzdD/B1+p3UQo7o8yhrC
p48cg5yMElN54fyqMCZQIFmR8L3k4YnTq8Au5S2DdvLHTJE9L6vSY5EHCab/GApN
N8UYWdgmXnEA6gwl/XjWg1OkSfIb4b0+8d1v2HjVaw5tLloOzTmXSPV/w4oVpF5a
MSSqB94aAx3vh5zVk4Bql1sVO2QSamxzQll2x4sqIT+e/zB0Z4/t7t/AiQrXsn9W
E51Gkb/QvdiZklIG/HpjoZ6Pm4YNMJb/hb4ZZ0qNQONlA+sAbUWrgfISrKqL4+Ia
QSXy10px5TXKO0bkjnLG
=BU/x
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--
