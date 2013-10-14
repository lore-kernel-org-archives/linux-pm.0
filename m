From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 12/14] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Mon, 14 Oct 2013 18:36:13 +0200
Message-ID: <20131014183613.7fd18395@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-13-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34016 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757024Ab3JNQgQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 12:36:16 -0400
In-Reply-To: <1381759106-15004-13-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:24 +0200, Gregory CLEMENT wrote:
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include <linux/smp.h>
> +#include <asm/cpuidle.h>
> +#include <asm/smp_plat.h>
> +#include <linux/armada-370-xp-pmsu.h>
> +#include <linux/platform_device.h>
> +
> +#define ARMADA_370_XP_MAX_STATES	3
> +#define ARMADA_370_XP_FLAG_DEEP_IDLE	0x10000
> +
> +extern void v7_flush_dcache_all(void);

This function is no longer called by the driver, it seems.

> +/* Functions defined in suspend-armada-370-xp.S */
> +int armada_370_xp_cpu_resume(unsigned long);
> +int armada_370_xp_cpu_suspend(unsigned long);

So the PMSU functions have their prototype in a header in <linux/...>,
but not those ones. Why chose one solution for some functions, and
another one for these functions?

> +static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index)
> +{
> +	bool deepidle = false;
> +	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> +
> +	armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume, hw_cpu);
> +
> +	if (drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE)
> +		deepidle = true;

This could also be written as:

	deepidle = drv->states[index].flags & ARMADA_370_XP_FLAG_DEEP_IDLE;

which allows to remove the deepidle = false initialization. But I agree
this is rather a matter of taste, so I don't mind if you chose to keep
your implementation.

> +
> +	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
> +
> +	armada_370_xp_pmsu_idle_restore();
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver armada_370_xp_idle_driver = {
> +	.name			= "armada_370_xp_idle",
> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		= {
> +		.enter			= armada_370_xp_enter_idle,
> +		.exit_latency		= 10,
> +		.power_usage		= 50,
> +		.target_residency	= 100,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "MV CPU IDLE",
> +		.desc			= "CPU power down",
> +	},
> +	.states[2]		= {
> +		.enter			= armada_370_xp_enter_idle,
> +		.exit_latency		= 100,
> +		.power_usage		= 5,
> +		.target_residency	= 1000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID |
> +						ARMADA_370_XP_FLAG_DEEP_IDLE,
> +		.name			= "MV CPU DEEP IDLE",
> +		.desc			= "CPU and L2 Fabric power down",
> +	},
> +	.state_count = ARMADA_370_XP_MAX_STATES,
> +};
> +
> +static int armada_370_xp_cpuidle_probe(struct platform_device *pdev)
> +{
> +	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
> +		return -ENODEV;
> +
> +	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
> +		return -ENODEV;

I am wondering if those checks shouldn't be done by the core mach-mvebu
code before registering the cpuidle platform device, and only register
it if all the prerequisites are available.

> +	pr_info("Initializing Armada-XP CPU power management ");

Not sure this message is really useful, but if it is, it should be
using dev_info(), it should not have a trailing space, and it should
probably not be called "CPU power management", but really "cpuidle" or
something like that. "CPU power management" is a very fuzzy term, which
could be confused with cpufreq, for example.

> +
> +	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
> +
> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +}
> +
> +static int armada_370_xp_cpuidle_remove(struct platform_device *pdev)
> +{
> +	cpuidle_unregister(&armada_370_xp_idle_driver);
> +	return 0;
> +}
> +
> +

One too many empty line here.

> +static struct platform_driver armada_370_xp_cpuidle_plat_driver = {
> +	.driver = {
> +		.name = "cpuidle-armada-370-xp",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = armada_370_xp_cpuidle_probe,
> +	.remove = armada_370_xp_cpuidle_remove,
> +};
> +
> +

One too many empty line here.

> +module_platform_driver(armada_370_xp_cpuidle_plat_driver);
> +
> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> +MODULE_DESCRIPTION("Armada 370/XP cpu idle driver");
> +MODULE_LICENSE("GPL");

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
