From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in Kconfig
Date: Wed, 3 Apr 2019 01:51:55 +0700
Message-ID: <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190402161256.11044-5-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-5-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 2, 2019 at 11:14 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The dependency on the THERMAL option to be set is already there implicitly
> by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
> check against the THERMAL option as they are called from a Kconfig block
> which is enabled by the conditionnal option.
>
> Remove the useless "depends on THERMAL" in the Kconfigs.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig       | 2 --
>  drivers/thermal/intel/Kconfig | 1 -
>  drivers/thermal/qcom/Kconfig  | 1 -
>  3 files changed, 4 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ccf5b9408d7a..d8aa7fac8c56 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -24,7 +24,6 @@ config THERMAL_STATISTICS
>
>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>         int "Emergency poweroff delay in milli-seconds"
> -       depends on THERMAL
>         default 0
>         help
>           Thermal subsystem will issue a graceful shutdown when
> @@ -152,7 +151,6 @@ config CPU_THERMAL
>         bool "generic cpu cooling support"
>         depends on CPU_FREQ
>         depends on THERMAL_OF
> -       depends on THERMAL=y

This will break the intention of afa1f2ab43d48d0e1. At the moment, we
need THERMAL=y if we want cpu_cooling.

>         help
>           This implements the generic cpu cooling mechanism through frequency
>           reduction. An ACPI version of this already exists
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index 2e013eeb4a1d..2c727a820759 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -1,6 +1,5 @@
>  config INTEL_POWERCLAMP
>         tristate "Intel PowerClamp idle injection driver"
> -       depends on THERMAL
>         depends on X86
>         depends on CPU_SUP_INTEL
>         help
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index cdb455ffd575..3ce20fec86a2 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,6 +1,5 @@
>  config QCOM_TSENS
>         tristate "Qualcomm TSENS Temperature Alarm"
> -       depends on THERMAL
>         depends on QCOM_QFPROM
>         depends on ARCH_QCOM || COMPILE_TEST
>         help
> --
> 2.17.1
>
