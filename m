From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 7/8] drivers: cpuidle: initialize big.LITTLE driver
 through DT
Date: Wed, 03 Sep 2014 15:29:01 +0200
Message-ID: <5407179D.6040909@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-8-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35220 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbaICN3H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 09:29:07 -0400
Received: by mail-wg0-f47.google.com with SMTP id z12so8519888wgg.30
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 06:29:06 -0700 (PDT)
In-Reply-To: <1409585324-3678-8-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Chander Kashyap <k.chander@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ashwin

On 09/01/2014 05:28 PM, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for AR=
M
> can now initialize idle states data through properties in the device =
tree.
>
> This patch adds code to the big.LITTLE CPUidle driver to dynamically
> initialize idle states data through the updated device tree source fi=
le.
>
> Cc: Chander Kashyap <k.chander@samsung.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 23 +++++++++++++++++++=
++++
>   drivers/cpuidle/Kconfig.arm                |  1 +
>   drivers/cpuidle/cpuidle-big_little.c       | 19 +++++++++++++++++++
>   3 files changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/bo=
ot/dts/vexpress-v2p-ca15_a7.dts
> index a25c262..322fd15 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -38,6 +38,7 @@
>   			compatible =3D "arm,cortex-a15";
>   			reg =3D <0>;
>   			cci-control-port =3D <&cci_control1>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
>   		};
>
>   		cpu1: cpu@1 {
> @@ -45,6 +46,7 @@
>   			compatible =3D "arm,cortex-a15";
>   			reg =3D <1>;
>   			cci-control-port =3D <&cci_control1>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
>   		};
>
>   		cpu2: cpu@2 {
> @@ -52,6 +54,7 @@
>   			compatible =3D "arm,cortex-a7";
>   			reg =3D <0x100>;
>   			cci-control-port =3D <&cci_control2>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
>   		};
>
>   		cpu3: cpu@3 {
> @@ -59,6 +62,7 @@
>   			compatible =3D "arm,cortex-a7";
>   			reg =3D <0x101>;
>   			cci-control-port =3D <&cci_control2>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
>   		};
>
>   		cpu4: cpu@4 {
> @@ -66,6 +70,25 @@
>   			compatible =3D "arm,cortex-a7";
>   			reg =3D <0x102>;
>   			cci-control-port =3D <&cci_control2>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
> +		};
> +
> +		idle-states {
> +			CLUSTER_SLEEP_BIG: cluster-sleep-big {
> +				compatible =3D "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us =3D <1000>;
> +				exit-latency-us =3D <700>;
> +				min-residency-us =3D <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
> +				compatible =3D "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us =3D <1000>;
> +				exit-latency-us =3D <500>;
> +				min-residency-us =3D <2500>;
> +			};
>   		};
>   	};
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 38cff69..e339c7f 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -7,6 +7,7 @@ config ARM_BIG_LITTLE_CPUIDLE
>   	depends on MCPM
>   	select ARM_CPU_SUSPEND
>   	select CPU_IDLE_MULTIPLE_DRIVERS
> +	select DT_IDLE_STATES
>   	help
>   	  Select this option to enable CPU idle driver for big.LITTLE base=
d
>   	  ARM systems. Driver manages CPUs coordination through MCPM and
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> index ef94c3b..85d09bc 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -24,6 +24,8 @@
>   #include <asm/smp_plat.h>
>   #include <asm/suspend.h>
>
> +#include "dt_idle_states.h"
> +
>   static int bl_enter_powerdown(struct cpuidle_device *dev,
>   			      struct cpuidle_driver *drv, int idx);
>
> @@ -73,6 +75,12 @@ static struct cpuidle_driver bl_idle_little_driver=
 =3D {
>   	.state_count =3D 2,
>   };
>
> +static const struct of_device_id bl_idle_state_match[] __initconst =3D=
 {
> +	{ .compatible =3D "arm,idle-state",
> +	  .data =3D bl_enter_powerdown },
> +	{ },
> +};
> +
>   static struct cpuidle_driver bl_idle_big_driver =3D {
>   	.name =3D "big_idle",
>   	.owner =3D THIS_MODULE,
> @@ -190,6 +198,17 @@ static int __init bl_idle_init(void)
>   	if (ret)
>   		goto out_uninit_little;
>
> +	/* Start at index 1, index 0 standard WFI */
> +	ret =3D dt_init_idle_driver(&bl_idle_big_driver, bl_idle_state_matc=
h, 1);
> +	if (ret < 0)
> +		goto out_uninit_big;
> +
> +	/* Start at index 1, index 0 standard WFI */
> +	ret =3D dt_init_idle_driver(&bl_idle_little_driver,
> +				  bl_idle_state_match, 1);
> +	if (ret < 0)
> +		goto out_uninit_big;
> +
>   	ret =3D cpuidle_register(&bl_idle_little_driver, NULL);
>   	if (ret)
>   		goto out_uninit_big;
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

