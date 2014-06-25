From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 6/8] drivers: cpuidle: initialize big.LITTLE driver
 through DT
Date: Wed, 25 Jun 2014 17:44:04 +0100
Message-ID: <20140625164403.GA15050@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625150623.GD15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140625150623.GD15240@leverpostej>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chander Kashyap <chander.kashyap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Tomasz Figa <t>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 25, 2014 at 04:06:23PM +0100, Mark Rutland wrote:
> On Wed, Jun 25, 2014 at 03:10:19PM +0100, Lorenzo Pieralisi wrote:
> > With the introduction of DT based idle states, CPUidle drivers for ARM
> > can now initialize idle states data through properties in the device tree.
> > 
> > This patch adds code to the big.LITTLE CPUidle driver to dynamically
> > initialize idle states data through the updated device tree source file.
> > 
> > Cc: Chander Kashyap <chander.kashyap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/arm/vexpress.txt | 25 +++++++++++++
> >  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         | 25 +++++++++++++
> >  drivers/cpuidle/Kconfig.arm                        |  1 +
> >  drivers/cpuidle/cpuidle-big_little.c               | 43 +++++++++++-----------
> >  4 files changed, 73 insertions(+), 21 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
> > index 39844cd..7f52ac8 100644
> > --- a/Documentation/devicetree/bindings/arm/vexpress.txt
> > +++ b/Documentation/devicetree/bindings/arm/vexpress.txt
> > @@ -67,6 +67,28 @@ with device_type = "cpu" property for every available core, eg.:
> >  		};
> >  	};
> >  
> > +idle-states node
> > +----------------
> > +
> > +On Versatile Express platforms with power management capabilities, the device
> > +tree source file must contain the idle-states node[1]. As defined in [1] the
> > +idle-states node must contain an entry-method property that for Versatile
> > +Express platforms can be one of:
> > +
> > +	- "arm,vexpress-v2p-ca15_a7"
> 
> ... and what does this mean? It's the name we've assigned the platform
> in the Linux DT bindings, but this binding document tells me nothing
> about how this method works.

Ok, I should have omitted it, I added it to make it compliant with
current DT bindings where entry-method for idle-states is required and I
have just added TC2 compatible string to get code out for review.

I should have made the entry-method optional for arm32 and get rid of
this useless binding and entry-method string.

Thanks,
Lorenzo

> This feels like leaking Linux internals rather than a reusable
> interface.
> 
> Mark.
> 
> > +
> > +Versatile Express idle-states nodes example:
> > +
> > +	idle-states {
> > +		entry-method = "arm,vexpress-v2p-ca15_a7";
> > +
> > +		cluster-sleep-0 {
> > +			compatible = "arm,idle-state";
> > +			entry-latency-us = <1000>;
> > +			exit-latency-us = <700>;
> > +			min-residency-us = <3500>;
> > +		};
> > +	};
> >  
> >  Configuration infrastructure
> >  ----------------------------
> > @@ -227,3 +249,6 @@ Example of a VE tile description (simplified)
> >  	};
> >  };
> >  
> > +
> > +[1] ARM Linux Kernel documentation - Idle states bindings
> > +    Documentation/devicetree/bindings/arm/idle-states.txt
> > diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> > index a25c262..ad28242 100644
> > --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> > +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> > @@ -33,11 +33,32 @@
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> >  
> > +		idle-states {
> > +			entry-method = "arm,vexpress-v2p-ca15_a7";
> > +
> > +			CLUSTER_SLEEP_BIG: cluster-sleep-big {
> > +				compatible = "arm,idle-state";
> > +				power-rank = <0>;
> > +				entry-latency-us = <1000>;
> > +				exit-latency-us = <700>;
> > +				min-residency-us = <3500>;
> > +			};
> > +
> > +			CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
> > +				compatible = "arm,idle-state";
> > +				power-rank = <0>;
> > +				entry-latency-us = <1000>;
> > +				exit-latency-us = <500>;
> > +				min-residency-us = <3000>;
> > +			};
> > +		};
> > +
> >  		cpu0: cpu@0 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a15";
> >  			reg = <0>;
> >  			cci-control-port = <&cci_control1>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
> >  		};
> >  
> >  		cpu1: cpu@1 {
> > @@ -45,6 +66,7 @@
> >  			compatible = "arm,cortex-a15";
> >  			reg = <1>;
> >  			cci-control-port = <&cci_control1>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
> >  		};
> >  
> >  		cpu2: cpu@2 {
> > @@ -52,6 +74,7 @@
> >  			compatible = "arm,cortex-a7";
> >  			reg = <0x100>;
> >  			cci-control-port = <&cci_control2>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
> >  		};
> >  
> >  		cpu3: cpu@3 {
> > @@ -59,6 +82,7 @@
> >  			compatible = "arm,cortex-a7";
> >  			reg = <0x101>;
> >  			cci-control-port = <&cci_control2>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
> >  		};
> >  
> >  		cpu4: cpu@4 {
> > @@ -66,6 +90,7 @@
> >  			compatible = "arm,cortex-a7";
> >  			reg = <0x102>;
> >  			cci-control-port = <&cci_control2>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
> >  		};
> >  	};
> >  
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index b6d69e8..a9b089c 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -12,6 +12,7 @@ config ARM_BIG_LITTLE_CPUIDLE
> >  	depends on ARCH_VEXPRESS_TC2_PM
> >  	select ARM_CPU_SUSPEND
> >  	select CPU_IDLE_MULTIPLE_DRIVERS
> > +	select DT_IDLE_STATES
> >  	help
> >  	  Select this option to enable CPU idle driver for big.LITTLE based
> >  	  ARM systems. Driver manages CPUs coordination through MCPM and
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index b45fc62..6712441 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -24,6 +24,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >  
> > +#include "dt_idle_states.h"
> > +
> >  static int bl_enter_powerdown(struct cpuidle_device *dev,
> >  			      struct cpuidle_driver *drv, int idx);
> >  
> > @@ -61,32 +63,12 @@ static struct cpuidle_driver bl_idle_little_driver = {
> >  	.name = "little_idle",
> >  	.owner = THIS_MODULE,
> >  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> > -	.states[1] = {
> > -		.enter			= bl_enter_powerdown,
> > -		.exit_latency		= 700,
> > -		.target_residency	= 2500,
> > -		.flags			= CPUIDLE_FLAG_TIME_VALID |
> > -					  CPUIDLE_FLAG_TIMER_STOP,
> > -		.name			= "C1",
> > -		.desc			= "ARM little-cluster power down",
> > -	},
> > -	.state_count = 2,
> >  };
> >  
> >  static struct cpuidle_driver bl_idle_big_driver = {
> >  	.name = "big_idle",
> >  	.owner = THIS_MODULE,
> >  	.states[0] = ARM_CPUIDLE_WFI_STATE,
> > -	.states[1] = {
> > -		.enter			= bl_enter_powerdown,
> > -		.exit_latency		= 500,
> > -		.target_residency	= 2000,
> > -		.flags			= CPUIDLE_FLAG_TIME_VALID |
> > -					  CPUIDLE_FLAG_TIMER_STOP,
> > -		.name			= "C1",
> > -		.desc			= "ARM big-cluster power down",
> > -	},
> > -	.state_count = 2,
> >  };
> >  
> >  /*
> > @@ -165,7 +147,8 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
> >  
> >  static int __init bl_idle_init(void)
> >  {
> > -	int ret;
> > +	int ret, i;
> > +	struct cpuidle_driver *drv;
> >  
> >  	/*
> >  	 * Initialize the driver just for a compliant set of machines
> > @@ -187,6 +170,24 @@ static int __init bl_idle_init(void)
> >  	if (ret)
> >  		goto out_uninit_little;
> >  
> > +	 /* Start at index 1, index 0 standard WFI */
> > +	ret = dt_init_idle_driver(&bl_idle_big_driver, NULL, 1, false);
> > +	if (ret)
> > +		goto out_uninit_big;
> > +
> > +	 /* Start at index 1, index 0 standard WFI */
> > +	ret = dt_init_idle_driver(&bl_idle_little_driver, NULL, 1, false);
> > +	if (ret)
> > +		goto out_uninit_big;
> > +
> > +	drv = &bl_idle_big_driver;
> > +	for (i = 1; i < drv->state_count; i++)
> > +		drv->states[i].enter = bl_enter_powerdown;
> > +
> > +	drv = &bl_idle_little_driver;
> > +	for (i = 1; i < drv->state_count; i++)
> > +		drv->states[i].enter = bl_enter_powerdown;
> > +
> >  	ret = cpuidle_register(&bl_idle_little_driver, NULL);
> >  	if (ret)
> >  		goto out_uninit_big;
> > -- 
> > 1.9.1
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
