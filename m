From: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH 1/2] cpufreq: Add i.mx8mq support
Date: Tue, 12 Feb 2019 12:43:56 +0000
Message-ID: <20190212124355.tp3l2hm3qi3vhlgp@fsr-ub1664-175>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
 <1549974999.2546.28.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549974999.2546.28.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <FE59C9BFDF6F3C418B84382BF27B7F4F@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Anson Huang <anson.huang@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 19-02-12 13:36:39, Lucas Stach wrote:
> Hi Abel,
>=20
> we really don't want another platform specific cpufreq driver in
> mainline. The CPU clock change dance should be abstracted in the
> imx8mq-clk driver, just like we do on i.MX5 and i.MX7. This would allow
> us to reuse the cpufreq-dt driver, like we do on those platforms.
>=20

Fair enough. This is what we had in our internal tree.
Will rewrite as suggested then.
Thanks.

> Regards,
> Lucas
>=20
> Am Dienstag, den 12.02.2019, 12:21 +0000 schrieb Abel Vesa:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> >=20
> > Add i.MX8MQ cpufreq support, current version of
> > EVK board does NOT support voltage scale, but next
> > version will add this support, so this driver only
> > supports cpu frequency scale, voltage scale will
> > be added later once new board available.
> >=20
> > A53 CPU clock normally is from ARM_PLL, but during
> > ARM_PLL relock window, it will be switched to
> > SYS1_PLL_800M to avoid clock missing, and after
> > arm pll relock done, it will be switched back.
> >=20
> > > Signed-off-by: Anson Huang <anson.huang@nxp.com>
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > =A0drivers/cpufreq/Kconfig.arm=A0=A0=A0=A0=A0=A0|=A0=A0=A08 ++
> > =A0drivers/cpufreq/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0drivers/cpufreq/imx8mq-cpufreq.c | 223 +++++++++++++++++++++++++++++=
++++++++++
> > =A03 files changed, 232 insertions(+)
> > =A0create mode 100644 drivers/cpufreq/imx8mq-cpufreq.c
> >=20
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 179a1d3..9d8001c 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -92,6 +92,14 @@ config ARM_IMX6Q_CPUFREQ
> > =A0
> > > =A0	=A0=A0If in doubt, say N.
> > =A0
> > +config ARM_IMX8MQ_CPUFREQ
> > > +	tristate "NXP i.MX8MQ cpufreq support"
> > > +	select PM_OPP
> > > +	help
> > > +	=A0=A0This adds cpufreq driver support for NXP i.MX8MQ series SoCs.
> > +
> > > +	=A0=A0If in doubt, say N.
> > +
> > =A0config ARM_KIRKWOOD_CPUFREQ
> > > =A0	def_bool MACH_KIRKWOOD
> > > =A0	help
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 689b26c..fe5416c 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > > @@ -56,6 +56,7 @@ obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+=3D cppc_cpufreq.=
o
> > > =A0obj-$(CONFIG_ARCH_DAVINCI)		+=3D davinci-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o
> > > +obj-$(CONFIG_ARM_IMX8MQ_CPUFREQ)	+=3D imx8mq-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+=3D kirkwood-cpufreq.o
> > > =A0obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+=3D mediatek-cpufreq.o
> > > =A0obj-$(CONFIG_MACH_MVEBU_V7)		+=3D mvebu-cpufreq.o
> > diff --git a/drivers/cpufreq/imx8mq-cpufreq.c b/drivers/cpufreq/imx8mq-=
cpufreq.c
> > new file mode 100644
> > index 0000000..ee24fab
> > --- /dev/null
> > +++ b/drivers/cpufreq/imx8mq-cpufreq.c
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 NXP
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/suspend.h>
> > +
> > +static struct device *cpu_dev;
> > +static bool free_opp;
> > +static struct cpufreq_frequency_table *freq_table;
> > +static struct mutex set_cpufreq_lock;
> > +static unsigned int transition_latency;
> > +static unsigned int suspend_freq;
> > +static struct clk *a53_clk;
> > +static struct clk *arm_a53_src_clk;
> > +static struct clk *arm_pll_clk;
> > +static struct clk *arm_pll_out_clk;
> > +static struct clk *sys1_pll_800m_clk;
> > +
> > +static int imx8mq_set_target(struct cpufreq_policy *policy, unsigned i=
nt index)
> > +{
> > > +	struct dev_pm_opp *opp;
> > > +	unsigned long freq_hz;
> > > +	unsigned int old_freq, new_freq;
> > > +	int ret;
> > +
> > > +	mutex_lock(&set_cpufreq_lock);
> > +
> > > +	new_freq =3D freq_table[index].frequency;
> > > +	freq_hz =3D new_freq * 1000;
> > > +	old_freq =3D policy->cur;
> > +
> > > +	rcu_read_lock();
> > > +	opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> > > +	if (IS_ERR(opp)) {
> > > +		rcu_read_unlock();
> > > +		dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
> > > +		mutex_unlock(&set_cpufreq_lock);
> > > +		return PTR_ERR(opp);
> > > +	}
> > > +	rcu_read_unlock();
> > +
> > > +	dev_dbg(cpu_dev, "%u MHz --> %u MHz\n",
> > > +		old_freq / 1000, new_freq / 1000);
> > +
> > > +	clk_set_parent(arm_a53_src_clk, sys1_pll_800m_clk);
> > > +	clk_set_rate(arm_pll_clk, new_freq * 1000);
> > > +	clk_set_parent(arm_a53_src_clk, arm_pll_out_clk);
> > +
> > > +	/* Ensure the arm clock divider is what we expect */
> > > +	ret =3D clk_set_rate(a53_clk, new_freq * 1000);
> > > +	if (ret)
> > > +		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> > +
> > > +	mutex_unlock(&set_cpufreq_lock);
> > > +	return ret;
> > +}
> > +
> > +static int imx8mq_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > > +	int ret;
> > +
> > > +	policy->clk =3D a53_clk;
> > > +	policy->cur =3D clk_get_rate(a53_clk) / 1000;
> > > +	policy->suspend_freq =3D suspend_freq;
> > +
> > > +	ret =3D cpufreq_generic_init(policy, freq_table, transition_latency=
);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "imx8mq cpufreq init failed!\n");
> > > +		return ret;
> > > +	}
> > +
> > > +	return 0;
> > +}
> > +
> > +static struct cpufreq_driver imx8mq_cpufreq_driver =3D {
> > > +	.flags =3D CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> > > +	.verify =3D cpufreq_generic_frequency_table_verify,
> > > +	.target_index =3D imx8mq_set_target,
> > > +	.get =3D cpufreq_generic_get,
> > > +	.init =3D imx8mq_cpufreq_init,
> > > +	.name =3D "imx8mq-cpufreq",
> > > +	.attr =3D cpufreq_generic_attr,
> > +#ifdef CONFIG_PM
> > > +	.suspend =3D cpufreq_generic_suspend,
> > +#endif
> > +};
> > +
> > +static int imx8mq_cpufreq_probe(struct platform_device *pdev)
> > +{
> > > +	struct device_node *np;
> > > +	int num, ret;
> > +
> > > +	cpu_dev =3D get_cpu_device(0);
> > > +	if (!cpu_dev) {
> > > +		pr_err("failed to get cpu0 device\n");
> > > +		return -ENODEV;
> > > +	}
> > +
> > > +	np =3D of_node_get(cpu_dev->of_node);
> > > +	if (!np) {
> > > +		dev_err(cpu_dev, "failed to find cpu0 node\n");
> > > +		return -ENOENT;
> > > +	}
> > +
> > > +	a53_clk =3D clk_get(cpu_dev, "a53");
> > > +	arm_a53_src_clk =3D clk_get(cpu_dev, "arm_a53_src");
> > > +	arm_pll_clk =3D clk_get(cpu_dev, "arm_pll");
> > > +	arm_pll_out_clk =3D clk_get(cpu_dev, "arm_pll_out");
> > > +	sys1_pll_800m_clk =3D clk_get(cpu_dev, "sys1_pll_800m");
> > > +	if (IS_ERR(a53_clk) || IS_ERR(arm_a53_src_clk)
> > > +		|| IS_ERR(arm_pll_out_clk) || IS_ERR(arm_pll_clk)
> > > +		|| IS_ERR(sys1_pll_800m_clk)) {
> > > +		dev_err(cpu_dev, "failed to get clocks\n");
> > > +		ret =3D -ENOENT;
> > > +		goto put_clk;
> > > +	}
> > +
> > > +	/*
> > > +	=A0* We expect an OPP table supplied by platform.
> > > +	=A0* Just, incase the platform did not supply the OPP
> > > +	=A0* table, it will try to get it.
> > > +	=A0*/
> > > +	num =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > +	if (num < 0) {
> > > +		ret =3D dev_pm_opp_of_add_table(cpu_dev);
> > > +		if (ret < 0) {
> > > +			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> > > +			goto put_clk;
> > > +		}
> > +
> > > +		/* Because we have added the OPPs here, we must free them */
> > > +		free_opp =3D true;
> > +
> > > +		num =3D dev_pm_opp_get_opp_count(cpu_dev);
> > > +		if (num < 0) {
> > > +			ret =3D num;
> > > +			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> > > +			goto out_free_opp;
> > > +		}
> > > +	}
> > +
> > > +	ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> > > +		goto out_free_opp;
> > > +	}
> > +
> > > +	/* use MAX freq to suspend */
> > > +	suspend_freq =3D freq_table[num - 1].frequency;
> > +
> > > +	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> > > +		transition_latency =3D CPUFREQ_ETERNAL;
> > +
> > > +	mutex_init(&set_cpufreq_lock);
> > +
> > > +	ret =3D cpufreq_register_driver(&imx8mq_cpufreq_driver);
> > > +	if (ret) {
> > > +		dev_err(cpu_dev, "failed register driver: %d\n", ret);
> > > +		goto free_freq_table;
> > > +	}
> > +
> > > +	of_node_put(np);
> > > +	dev_info(cpu_dev, "registered imx8mq-cpufreq\n");
> > +
> > > +	return 0;
> > +
> > +free_freq_table:
> > > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> > +out_free_opp:
> > > +	if (free_opp)
> > > +		dev_pm_opp_of_remove_table(cpu_dev);
> > +put_clk:
> > > +	if (!IS_ERR(a53_clk))
> > > +		clk_put(a53_clk);
> > > +	if (!IS_ERR(arm_a53_src_clk))
> > > +		clk_put(arm_a53_src_clk);
> > > +	if (!IS_ERR(arm_pll_clk))
> > > +		clk_put(arm_pll_clk);
> > > +	if (!IS_ERR(arm_pll_out_clk))
> > > +		clk_put(arm_pll_out_clk);
> > > +	if (!IS_ERR(sys1_pll_800m_clk))
> > > +		clk_put(sys1_pll_800m_clk);
> > > +	of_node_put(np);
> > > +	return ret;
> > +}
> > +
> > +static int imx8mq_cpufreq_remove(struct platform_device *pdev)
> > +{
> > > +	cpufreq_unregister_driver(&imx8mq_cpufreq_driver);
> > > +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> > > +	if (free_opp)
> > > +		dev_pm_opp_of_remove_table(cpu_dev);
> > > +	clk_put(a53_clk);
> > > +	clk_put(arm_a53_src_clk);
> > > +	clk_put(arm_pll_clk);
> > > +	clk_put(arm_pll_out_clk);
> > > +	clk_put(sys1_pll_800m_clk);
> > +
> > > +	return 0;
> > +}
> > +
> > +static struct platform_driver imx8mq_cpufreq_platdrv =3D {
> > > +	.driver =3D {
> > > > +		.name	=3D "imx8mq-cpufreq",
> > > +	},
> > > > +	.probe		=3D imx8mq_cpufreq_probe,
> > > > +	.remove		=3D imx8mq_cpufreq_remove,
> > +};
> > +module_platform_driver(imx8mq_cpufreq_platdrv);
> > +
> > > +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> > +MODULE_DESCRIPTION("Freescale i.MX8MQ cpufreq driver");
> > +MODULE_LICENSE("GPL");=
