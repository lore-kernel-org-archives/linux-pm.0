From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 8/8] drivers: cpuidle: initialize Exynos driver through
 DT
Date: Wed, 03 Sep 2014 15:32:14 +0200
Message-ID: <5407185E.6030308@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-9-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50551 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbaICNcU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 09:32:20 -0400
Received: by mail-wg0-f43.google.com with SMTP id a1so8501426wgh.14
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 06:32:18 -0700 (PDT)
In-Reply-To: <1409585324-3678-9-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Bartlomiej Zolnierkiewicz <b.zol>

On 09/01/2014 05:28 PM, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for
> ARM can now initialize idle states data through properties in the dev=
ice
> tree.
>
> This patch adds code to the Exynos CPUidle driver to dynamically
> initialize idle states data through the updated device tree source
> files.
>
> Cc: Chander Kashyap <k.chander@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
>   arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
>   drivers/cpuidle/Kconfig.arm       |  1 +
>   drivers/cpuidle/cpuidle-exynos.c  | 18 +++++++++++++++++-
>   4 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/ex=
ynos4210.dtsi
> index eab7c7b..69fd1a0 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -48,12 +48,23 @@
>   			device_type =3D "cpu";
>   			compatible =3D "arm,cortex-a9";
>   			reg =3D <0x900>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
>   		};
>
>   		cpu@901 {
>   			device_type =3D "cpu";
>   			compatible =3D "arm,cortex-a9";
>   			reg =3D <0x901>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		idle-states {
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible =3D "arm,idle-state";
> +				entry-latency-us =3D <1000>;
> +				exit-latency-us =3D <300>;
> +				min-residency-us =3D <100000>;
> +			};
>   		};
>   	};
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/ex=
ynos5250.dtsi
> index 492e1ef..3a758ff 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -63,12 +63,23 @@
>   			compatible =3D "arm,cortex-a15";
>   			reg =3D <0>;
>   			clock-frequency =3D <1700000000>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
>   		};
>   		cpu@1 {
>   			device_type =3D "cpu";
>   			compatible =3D "arm,cortex-a15";
>   			reg =3D <1>;
>   			clock-frequency =3D <1700000000>;
> +			cpu-idle-states =3D <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		idle-states {
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible =3D "arm,idle-state";
> +				entry-latency-us =3D <1000>;
> +				exit-latency-us =3D <300>;
> +				min-residency-us =3D <100000>;
> +			};
>   		};
>   	};
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index e339c7f..04cc229 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
>   config ARM_EXYNOS_CPUIDLE
>   	bool "Cpu Idle Driver for the Exynos processors"
>   	depends on ARCH_EXYNOS
> +	select DT_IDLE_STATES
>   	help
>   	  Select this to enable cpuidle for Exynos processors
>
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuid=
le-exynos.c
> index ba9b34b..e66a426 100644
> --- a/drivers/cpuidle/cpuidle-exynos.c
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -18,6 +18,8 @@
>   #include <asm/suspend.h>
>   #include <asm/cpuidle.h>
>
> +#include "dt_idle_states.h"
> +
>   static void (*exynos_enter_aftr)(void);
>
>   static int exynos_enter_lowpower(struct cpuidle_device *dev,
> @@ -56,13 +58,27 @@ static struct cpuidle_driver exynos_idle_driver =3D=
 {
>   	.safe_state_index =3D 0,
>   };
>
> +static const struct of_device_id exynos_idle_state_match[] __initcon=
st =3D {
> +	{ .compatible =3D "arm,idle-state",
> +	  .data =3D exynos_enter_lowpower },
> +	{ },
> +};
> +
>   static int exynos_cpuidle_probe(struct platform_device *pdev)
>   {
>   	int ret;
> +	struct cpuidle_driver *drv =3D &exynos_idle_driver;
>
>   	exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
>
> -	ret =3D cpuidle_register(&exynos_idle_driver, NULL);
> +	/* Start at index 1, index 0 standard WFI */
> +	ret =3D dt_init_idle_driver(drv, exynos_idle_state_match, 1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to initialize idle states\n");
> +		return ret;
> +	}
> +
> +	ret =3D cpuidle_register(drv, NULL);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
>   		return ret;
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

