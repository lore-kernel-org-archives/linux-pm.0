From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 6/8] drivers: cpuidle: initialize big.LITTLE driver
 through DT
Date: Wed, 25 Jun 2014 16:06:23 +0100
Message-ID: <20140625150623.GD15240@leverpostej>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-7-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40957 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756559AbaFYPG2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 11:06:28 -0400
Content-Disposition: inline
In-Reply-To: <1403705421-17597-7-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chander Kashyap <chander.kashyap@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>Tomasz Figa <t>

On Wed, Jun 25, 2014 at 03:10:19PM +0100, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for ARM
> can now initialize idle states data through properties in the device tree.
> 
> This patch adds code to the big.LITTLE CPUidle driver to dynamically
> initialize idle states data through the updated device tree source file.
> 
> Cc: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/vexpress.txt | 25 +++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         | 25 +++++++++++++
>  drivers/cpuidle/Kconfig.arm                        |  1 +
>  drivers/cpuidle/cpuidle-big_little.c               | 43 +++++++++++-----------
>  4 files changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
> index 39844cd..7f52ac8 100644
> --- a/Documentation/devicetree/bindings/arm/vexpress.txt
> +++ b/Documentation/devicetree/bindings/arm/vexpress.txt
> @@ -67,6 +67,28 @@ with device_type = "cpu" property for every available core, eg.:
>  		};
>  	};
>  
> +idle-states node
> +----------------
> +
> +On Versatile Express platforms with power management capabilities, the device
> +tree source file must contain the idle-states node[1]. As defined in [1] the
> +idle-states node must contain an entry-method property that for Versatile
> +Express platforms can be one of:
> +
> +	- "arm,vexpress-v2p-ca15_a7"

... and what does this mean? It's the name we've assigned the platform
in the Linux DT bindings, but this binding document tells me nothing
about how this method works.

This feels like leaking Linux internals rather than a reusable
interface.

Mark.

> +
> +Versatile Express idle-states nodes example:
> +
> +	idle-states {
> +		entry-method = "arm,vexpress-v2p-ca15_a7";
> +
> +		cluster-sleep-0 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <700>;
> +			min-residency-us = <3500>;
> +		};
> +	};
>  
>  Configuration infrastructure
>  ----------------------------
> @@ -227,3 +249,6 @@ Example of a VE tile description (simplified)
>  	};
>  };
>  
> +
> +[1] ARM Linux Kernel documentation - Idle states bindings
> +    Documentation/devicetree/bindings/arm/idle-states.txt
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index a25c262..ad28242 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -33,11 +33,32 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		idle-states {
> +			entry-method = "arm,vexpress-v2p-ca15_a7";
> +
> +			CLUSTER_SLEEP_BIG: cluster-sleep-big {
> +				compatible = "arm,idle-state";
> +				power-rank = <0>;
> +				entry-latency-us = <1000>;
> +				exit-latency-us = <700>;
> +				min-residency-us = <3500>;
> +			};
> +
> +			CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
> +				compatible = "arm,idle-state";
> +				power-rank = <0>;
> +				entry-latency-us = <1000>;
> +				exit-latency-us = <500>;
> +				min-residency-us = <3000>;
> +			};
> +		};
> +
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			cci-control-port = <&cci_control1>;
> +			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -45,6 +66,7 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <1>;
>  			cci-control-port = <&cci_control1>;
> +			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -52,6 +74,7 @@
>  			compatible = "arm,cortex-a7";
>  			reg = <0x100>;
>  			cci-control-port = <&cci_control2>;
> +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -59,6 +82,7 @@
>  			compatible = "arm,cortex-a7";
>  			reg = <0x101>;
>  			cci-control-port = <&cci_control2>;
> +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
>  		};
>  
>  		cpu4: cpu@4 {
> @@ -66,6 +90,7 @@
>  			compatible = "arm,cortex-a7";
>  			reg = <0x102>;
>  			cci-control-port = <&cci_control2>;
> +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
>  		};
>  	};
>  
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index b6d69e8..a9b089c 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -12,6 +12,7 @@ config ARM_BIG_LITTLE_CPUIDLE
>  	depends on ARCH_VEXPRESS_TC2_PM
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
> +	select DT_IDLE_STATES
>  	help
>  	  Select this option to enable CPU idle driver for big.LITTLE based
>  	  ARM systems. Driver manages CPUs coordination through MCPM and
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index b45fc62..6712441 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -24,6 +24,8 @@
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  
> +#include "dt_idle_states.h"
> +
>  static int bl_enter_powerdown(struct cpuidle_device *dev,
>  			      struct cpuidle_driver *drv, int idx);
>  
> @@ -61,32 +63,12 @@ static struct cpuidle_driver bl_idle_little_driver = {
>  	.name = "little_idle",
>  	.owner = THIS_MODULE,
>  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> -	.states[1] = {
> -		.enter			= bl_enter_powerdown,
> -		.exit_latency		= 700,
> -		.target_residency	= 2500,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID |
> -					  CPUIDLE_FLAG_TIMER_STOP,
> -		.name			= "C1",
> -		.desc			= "ARM little-cluster power down",
> -	},
> -	.state_count = 2,
>  };
>  
>  static struct cpuidle_driver bl_idle_big_driver = {
>  	.name = "big_idle",
>  	.owner = THIS_MODULE,
>  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> -	.states[1] = {
> -		.enter			= bl_enter_powerdown,
> -		.exit_latency		= 500,
> -		.target_residency	= 2000,
> -		.flags			= CPUIDLE_FLAG_TIME_VALID |
> -					  CPUIDLE_FLAG_TIMER_STOP,
> -		.name			= "C1",
> -		.desc			= "ARM big-cluster power down",
> -	},
> -	.state_count = 2,
>  };
>  
>  /*
> @@ -165,7 +147,8 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
>  
>  static int __init bl_idle_init(void)
>  {
> -	int ret;
> +	int ret, i;
> +	struct cpuidle_driver *drv;
>  
>  	/*
>  	 * Initialize the driver just for a compliant set of machines
> @@ -187,6 +170,24 @@ static int __init bl_idle_init(void)
>  	if (ret)
>  		goto out_uninit_little;
>  
> +	 /* Start at index 1, index 0 standard WFI */
> +	ret = dt_init_idle_driver(&bl_idle_big_driver, NULL, 1, false);
> +	if (ret)
> +		goto out_uninit_big;
> +
> +	 /* Start at index 1, index 0 standard WFI */
> +	ret = dt_init_idle_driver(&bl_idle_little_driver, NULL, 1, false);
> +	if (ret)
> +		goto out_uninit_big;
> +
> +	drv = &bl_idle_big_driver;
> +	for (i = 1; i < drv->state_count; i++)
> +		drv->states[i].enter = bl_enter_powerdown;
> +
> +	drv = &bl_idle_little_driver;
> +	for (i = 1; i < drv->state_count; i++)
> +		drv->states[i].enter = bl_enter_powerdown;
> +
>  	ret = cpuidle_register(&bl_idle_little_driver, NULL);
>  	if (ret)
>  		goto out_uninit_big;
> -- 
> 1.9.1
> 
