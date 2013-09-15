From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Sun, 15 Sep 2013 16:34:47 +0200
Message-ID: <5235C587.4030802@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <52333112.2050003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52333112.2050003@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Dan Frazier <dann.frazier@canonical.com>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <leif.lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Chris Van Hoof <van>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

thanks for you review,

On 13/09/2013 17:36, Daniel Lezcano wrote:
> On 09/13/2013 12:06 PM, Gregory CLEMENT wrote:
>> Add the wfi, cpu idle and cpu deep idle power states support for the
>> Armada XP SoCs.
>>
>> All the latencies and the power consumption values used at the
>> "armada_370_xp_idle_driver" structure are preliminary and will be
>> modified in the future after running some measurements and analysis.
>>
>> Based on the work of Nadav Haklai.
>>
>> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/cpuidle/Kconfig.arm             |   5 ++
>>  drivers/cpuidle/Makefile                |   1 +
>>  drivers/cpuidle/cpuidle-armada-370-xp.c | 103 ++++++++++++++++++++++++++++++++
>>  drivers/cpuidle/suspend-armada-370-xp.S |  91 ++++++++++++++++++++++++++++
> 
> Somehow, you will have to move "suspend-armada-370-xp.S" into arch/arm.

Does it mean that you want I move it for the next version?

> 
>>  4 files changed, 200 insertions(+)
>>  create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
>>  create mode 100644 drivers/cpuidle/suspend-armada-370-xp.S
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 8e36603..071d960 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -1,6 +1,11 @@
>>  #
>>  # ARM CPU Idle drivers
>>  #
>> +config ARM_ARMADA_370_XP_CPUIDLE
>> +	bool "CPU Idle Driver for Armada 370/XP family processors"
>> +	depends on ARCH_MVEBU
>> +	help
>> +	  Select this to enable cpuidle on Armada 370/XP processors.
>>  
>>  config ARM_HIGHBANK_CPUIDLE
>>  	bool "CPU Idle Driver for Calxeda processors"
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index cea5ef5..90fc4a6 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>>  
>>  ##################################################################################
>>  # ARM SoC drivers
>> +obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += cpuidle-armada-370-xp.o suspend-armada-370-xp.o
>>  obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
>>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
>> new file mode 100644
>> index 0000000..7c78d92
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
>> @@ -0,0 +1,103 @@
>> +/*
>> + * Marvell Armada 370 and Armada XP SoC cpuidle driver
>> + *
>> + * Copyright (C) 2013 Marvell
>> + *
>> + * Nadav Haklai <nadavh@marvell.com>
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + */
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/suspend.h>
>> +#include <asm/suspend.h>
>> +#include <linux/smp.h>
>> +#include <asm/cpuidle.h>
>> +#include <asm/smp_plat.h>
>> +#include <linux/armada-370-xp-pmsu.h>
>> +
>> +#define ARMADA_370_XP_MAX_STATES	3
>> +
>> +enum mv_pm_states {
>> +	WFI = 0,
>> +	MV_CPU_IDLE,
>> +	MV_CPU_DEEP_IDLE,
>> +};
>> +
>> +extern void v7_flush_dcache_all(void);
>> +
>> +/* Functions defined in suspend-armada-370-xp.S */
>> +int armada_370_xp_cpu_resume(unsigned long);
>> +int armada_370_xp_cpu_suspend(unsigned long);
>> +
>> +static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv,
>> +				int index)
>> +{
>> +	bool deepidle = false;
>> +	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
>> +
>> +	armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume, hw_cpu);
>> +
>> +	if (index == MV_CPU_DEEP_IDLE)
>> +		deepidle = true;
> 
> That looks a bit hackish no ? :)
> 
> Can't you use the CPUIDLE_DRIVER_FLAGS_MASK to store this information ?

I didn't notice this mask until now but indeed we can use it.

> 
>> +	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
>> +
>> +	cpu_init();
>> +
>> +	armada_370_xp_pmsu_idle_restore();
>> +
>> +	return index;
>> +}
>> +
>> +static struct cpuidle_driver armada_370_xp_idle_driver = {
>> +	.name			= "armada_370_xp_idle",
>> +	.states[0]		= ARM_CPUIDLE_WFI_STATE,
>> +	.states[1]		= {
>> +		.enter			= armada_370_xp_enter_idle,
>> +		.exit_latency		= 10,
>> +		.power_usage		= 50,
>> +		.target_residency	= 100,
>> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
>> +		.name			= "MV CPU IDLE",
>> +		.desc			= "CPU power down",
>> +	},
>> +	.states[2]		= {
>> +		.enter			= armada_370_xp_enter_idle,
>> +		.exit_latency		= 100,
>> +		.power_usage		= 5,
>> +		.target_residency	= 1000,
>> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
>> +		.name			= "MV CPU DEEP IDLE",
>> +		.desc			= "CPU and L2 Fabric power down",
>> +	},
>> +	.state_count = ARMADA_370_XP_MAX_STATES,
>> +};
> 
> What about the local timers ? Are they shutdown ?

I need to chekc it.

> 
>> +
>> +static int __init armada_370_xp_cpuidle_init(void)
>> +{
>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
>> +		return -ENODEV;
>> +
>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
>> +		return -ENODEV;
>> +
>> +	pr_info("Initializing Armada-XP CPU power management ");
>> +
>> +	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
>> +
>> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
>> +}
>> +
>> +module_init(armada_370_xp_cpuidle_init);
> 
> Isn't it possible to replace it by module_platform_driver ? like ux500
> or kirkwood ?

It should be possible indeed, I will check it.

> 
> Thanks
>   -- Daniel
> 
>> +MODULE_LICENSE("GPL");
> 
> [ ... ]
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
