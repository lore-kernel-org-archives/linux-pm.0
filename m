From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 8/8] drivers: cpuidle: initialize Exynos driver
 through DT
Date: Wed, 3 Sep 2014 18:29:34 +0100
Message-ID: <20140903172934.GH1824@e102568-lin.cambridge.arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-9-git-send-email-lorenzo.pieralisi@arm.com>
 <5407185E.6030308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34922 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbaICR3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 13:29:42 -0400
In-Reply-To: <5407185E.6030308@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, b.zolnierkie@samsung.com
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.o>

On Wed, Sep 03, 2014 at 02:32:14PM +0100, Daniel Lezcano wrote:
> On 09/01/2014 05:28 PM, Lorenzo Pieralisi wrote:
> > With the introduction of DT based idle states, CPUidle drivers for
> > ARM can now initialize idle states data through properties in the device
> > tree.
> >
> > This patch adds code to the Exynos CPUidle driver to dynamically
> > initialize idle states data through the updated device tree source
> > files.
> >
> > Cc: Chander Kashyap <k.chander@samsung.com>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel !

This patch has a dependency:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274179.html

Bartolomiej do you plan to merge the patch above ?

This patch needs also testing, I do not have Exynos boards so I only
compile tested it.

Lorenzo

> 
> > ---
> >   arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
> >   arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
> >   drivers/cpuidle/Kconfig.arm       |  1 +
> >   drivers/cpuidle/cpuidle-exynos.c  | 18 +++++++++++++++++-
> >   4 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> > index eab7c7b..69fd1a0 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -48,12 +48,23 @@
> >   			device_type = "cpu";
> >   			compatible = "arm,cortex-a9";
> >   			reg = <0x900>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_0>;
> >   		};
> >
> >   		cpu@901 {
> >   			device_type = "cpu";
> >   			compatible = "arm,cortex-a9";
> >   			reg = <0x901>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_0>;
> > +		};
> > +
> > +		idle-states {
> > +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				entry-latency-us = <1000>;
> > +				exit-latency-us = <300>;
> > +				min-residency-us = <100000>;
> > +			};
> >   		};
> >   	};
> >
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> > index 492e1ef..3a758ff 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -63,12 +63,23 @@
> >   			compatible = "arm,cortex-a15";
> >   			reg = <0>;
> >   			clock-frequency = <1700000000>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_0>;
> >   		};
> >   		cpu@1 {
> >   			device_type = "cpu";
> >   			compatible = "arm,cortex-a15";
> >   			reg = <1>;
> >   			clock-frequency = <1700000000>;
> > +			cpu-idle-states = <&CLUSTER_SLEEP_0>;
> > +		};
> > +
> > +		idle-states {
> > +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				entry-latency-us = <1000>;
> > +				exit-latency-us = <300>;
> > +				min-residency-us = <100000>;
> > +			};
> >   		};
> >   	};
> >
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index e339c7f..04cc229 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
> >   config ARM_EXYNOS_CPUIDLE
> >   	bool "Cpu Idle Driver for the Exynos processors"
> >   	depends on ARCH_EXYNOS
> > +	select DT_IDLE_STATES
> >   	help
> >   	  Select this to enable cpuidle for Exynos processors
> >
> > diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
> > index ba9b34b..e66a426 100644
> > --- a/drivers/cpuidle/cpuidle-exynos.c
> > +++ b/drivers/cpuidle/cpuidle-exynos.c
> > @@ -18,6 +18,8 @@
> >   #include <asm/suspend.h>
> >   #include <asm/cpuidle.h>
> >
> > +#include "dt_idle_states.h"
> > +
> >   static void (*exynos_enter_aftr)(void);
> >
> >   static int exynos_enter_lowpower(struct cpuidle_device *dev,
> > @@ -56,13 +58,27 @@ static struct cpuidle_driver exynos_idle_driver = {
> >   	.safe_state_index = 0,
> >   };
> >
> > +static const struct of_device_id exynos_idle_state_match[] __initconst = {
> > +	{ .compatible = "arm,idle-state",
> > +	  .data = exynos_enter_lowpower },
> > +	{ },
> > +};
> > +
> >   static int exynos_cpuidle_probe(struct platform_device *pdev)
> >   {
> >   	int ret;
> > +	struct cpuidle_driver *drv = &exynos_idle_driver;
> >
> >   	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
> >
> > -	ret = cpuidle_register(&exynos_idle_driver, NULL);
> > +	/* Start at index 1, index 0 standard WFI */
> > +	ret = dt_init_idle_driver(drv, exynos_idle_state_match, 1);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to initialize idle states\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = cpuidle_register(drv, NULL);
> >   	if (ret) {
> >   		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
> >   		return ret;
> >
> 
> 
> -- 
>   <http://www.linaro.org/> Linaro.org | Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 

