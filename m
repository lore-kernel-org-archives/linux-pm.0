From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv2 4/8] ARM: mvebu: extend PMSU code to support dynamic
 frequency scaling
Date: Tue, 8 Jul 2014 10:05:49 -0300
Message-ID: <20140708130549.GA19751@arch.cereza>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404744702-32010-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37997 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754812AbaGHNGl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jul 2014 09:06:41 -0400
Content-Disposition: inline
In-Reply-To: <1404744702-32010-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

On 07 Jul 04:51 PM, Thomas Petazzoni wrote:
> This commit adds the necessary code in the Marvell EBU PMSU driver to
> support dynamic frequency scaling. In essence, what this new code doe=
s
> is that it:
>=20
>  * registers the frequency operating points supported by the CPU;
>=20
>  * registers a clock notifier of the CPU clocks. The notifier functio=
n
>    listens to the newly introduced APPLY_RATE_CHANGE event, and uses
>    that to finalize the frequency transition by doing the part of the
>    procedure that involves the PMSU;
>=20
>  * registers a platform device for the cpufreq-generic driver, which
>    will take care of the CPU frequency transitions.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 184 +++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 184 insertions(+)
>=20
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 53a55c8..9257b16 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -18,20 +18,26 @@
> =20
>  #define pr_fmt(fmt) "mvebu-pmsu: " fmt
> =20
> +#include <linux/clk.h>
>  #include <linux/cpu_pm.h>
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/smp.h>
>  #include <linux/resource.h>
> +#include <linux/slab.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  #include <asm/tlbflush.h>
>  #include "common.h"
> +#include "armada-370-xp.h"
> =20
>  static void __iomem *pmsu_mp_base;
> =20
> @@ -57,6 +63,10 @@ static void __iomem *pmsu_mp_base;
>  #define PMSU_STATUS_AND_MASK_IRQ_MASK		BIT(24)
>  #define PMSU_STATUS_AND_MASK_FIQ_MASK		BIT(25)
> =20
> +#define PMSU_EVENT_STATUS_AND_MASK(cpu)     ((cpu * 0x100) + 0x120)
> +#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE        BIT(1)
> +#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK   BIT(17)
> +
>  #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x124)
> =20
>  /* PMSU fabric registers */
> @@ -296,3 +306,177 @@ int __init armada_370_xp_cpu_pm_init(void)
> =20
>  arch_initcall(armada_370_xp_cpu_pm_init);
>  early_initcall(armada_370_xp_pmsu_init);
> +
> +static void armada_xp_cpufreq_clk_set_local(void *data)
> +{
> +	u32 reg;
> +	u32 cpu =3D smp_processor_id();
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	/* Prepare to enter idle */
> +	reg =3D readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
> +	reg |=3D PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT |
> +	       PMSU_STATUS_AND_MASK_IRQ_MASK     |
> +	       PMSU_STATUS_AND_MASK_FIQ_MASK;
> +	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
> +
> +	/* Request the DFS transition */
> +	reg =3D readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
> +	reg |=3D PMSU_CONTROL_AND_CONFIG_DFS_REQ;
> +	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
> +
> +	/* The fact of entering idle will trigger the DFS transition */
> +	wfi();
> +
> +	/*
> +	 * We're back from idle, the DFS transition has completed,
> +	 * clear the idle wait indication.
> +	 */
> +	reg =3D readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
> +	reg &=3D ~PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT;
> +	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
> +
> +	local_irq_restore(flags);
> +}
> +
> +struct armada_xp_cpufreq_notifier_block {
> +	struct notifier_block nb;
> +	int cpu;
> +};
> +
> +static int armada_xp_cpufreq_clk_notify(struct notifier_block *self,
> +					unsigned long action, void *data)
> +{
> +	struct armada_xp_cpufreq_notifier_block *nb =3D
> +		container_of(self, struct armada_xp_cpufreq_notifier_block, nb);
> +	unsigned long timeout;
> +	int cpu =3D cpu_logical_map(nb->cpu);
> +	u32 reg;
> +
> +	if (action !=3D APPLY_RATE_CHANGE)
> +		return 0;

Maybe NOTIFY_DONE should be used here?

> +
> +	/* Clear any previous DFS DONE event */
> +	reg =3D readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +	reg &=3D ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE;
> +	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +
> +	/* Mask the DFS done interrupt, since we are going to poll */
> +	reg =3D readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +	reg |=3D PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
> +	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +
> +	/* Trigger the DFS on the appropriate CPU */
> +	smp_call_function_single(get_logical_index(cpu),
> +				 armada_xp_cpufreq_clk_set_local, NULL, false);
> +
> +	/* Poll until the DFS done event is generated */
> +	timeout =3D jiffies + HZ;
> +	while (time_before(jiffies, timeout)) {
> +		reg =3D readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +		if (reg & PMSU_EVENT_STATUS_AND_MASK_DFS_DONE)
> +			break;
> +		udelay(10);
> +	}
> +
> +	/* Restore the DFS mask to its original state */
> +	reg =3D readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +	reg &=3D ~BIT(17);
> +	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
> +
> +	return NOTIFY_DONE;

I think NOTIFY_OK should be used here, not sure.

> +}
> +
> +static int __init armada_xp_pmsu_cpufreq_init(void)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +	int ret, cpu;
> +
> +	if (!of_machine_is_compatible("marvell,armadaxp"))
> +		return 0;
> +
> +	/*
> +	 * In order to have proper cpufreq handling, we need to ensure
> +	 * that the Device Tree description of the CPU clock includes
> +	 * the definition of the PMU DFS registers. If not, we do not
> +	 * register the clock notifier and the cpufreq driver. This
> +	 * piece of code is only for compatibility with old Device
> +	 * Trees.
> +	 */
> +	np =3D of_find_compatible_node(NULL, NULL, "marvell,armada-xp-cpu-c=
lock");
> +	if (!np)
> +		return 0;
> +
> +	ret =3D of_address_to_resource(np, 1, &res);
> +	if (ret) {
> +		pr_warn(FW_WARN "not enabling cpufreq, deprecated armada-xp-cpu-cl=
ock binding\n");
> +		of_node_put(np);
> +		return 0;
> +	}
> +
> +	of_node_put(np);
> +
> +	/*
> +	 * For each CPU, this loop registers the operating points
> +	 * supported (which are the nominal CPU frequency and half of
> +	 * it), and registers the clock notifier that will take care
> +	 * of doing the PMSU part of a frequency transition.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct clk *clk;
> +		struct device *cpu_dev;
> +		struct armada_xp_cpufreq_notifier_block *nbs;
> +		int ret;
> +
> +		cpu_dev =3D get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			pr_err("Cannot get CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		clk =3D clk_get(cpu_dev, 0);
> +		if (!clk) {
> +			pr_err("Cannot get clock for CPU %d\n", cpu);
> +			return -ENODEV;

You are leaking the notifier block here.

> +		}
> +
> +		ret =3D dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
> +		if (ret) {
> +			clk_put(clk);
> +			return ret;

Ditto.

> +		}
> +
> +		ret =3D dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
> +		if (ret) {
> +			clk_put(clk);
> +			return ret;

Ditto.

> +		}
> +
> +		nbs =3D kzalloc(sizeof(struct armada_xp_cpufreq_notifier_block),
> +			      GFP_KERNEL);
> +		if (!nbs) {
> +			pr_err("Cannot allocate memory for cpufreq notifier\n");

You don't need out of memory messages, to error will be really verbose =
by
itself.

> +			clk_put(clk);
> +			return -ENOMEM;

And here you leak as well.

> +		}
> +
> +		nbs->nb.notifier_call =3D armada_xp_cpufreq_clk_notify;

I'd say this is the notifier and use "armada_xp_cpufreq_clk_notifier",
but it's just a nitpick.

> +		nbs->cpu =3D cpu;
> +
> +		ret =3D clk_notifier_register(clk, &nbs->nb);
> +		if (ret) {
> +			pr_err("Cannot register clock notifier\n");
> +			kfree(nbs);
> +			clk_put(clk);
> +			return ret;

Ditto.

> +		}
> +	}
> +
> +	platform_device_register_simple("cpufreq-generic", -1, NULL, 0);
> +	return 0;
> +}
> +
> +device_initcall(armada_xp_pmsu_cpufreq_init);
> --=20
> 2.0.0
>=20

Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
