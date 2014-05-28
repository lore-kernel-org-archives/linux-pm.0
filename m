From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 3/6] cpuidle: config: Add ARCH_EXYNOS entry to select
 cpuidle-big-little driver
Date: Wed, 28 May 2014 11:00:26 +0200
Message-ID: <5385A5AA.8070402@linaro.org>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com> <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org> <1400227438-27155-4-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400227438-27155-4-git-send-email-chander.kashyap@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, tomasz.figa@gmail.com, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 05/16/2014 10:03 AM, Chander Kashyap wrote:
> Add support to select generic big-little cpuidle driver for Samsung E=
xynos
> series SoC's. This is required for Exynos big-llittle SoC's eg, Exyno=
s5420.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Changes in v4:
> 	1. Typo fixed from SOC_EXYNOS5420 to ARCH_EXYNOS
> 	2. Commit message updated
> Changes in v3: None
> Changes in v2:
> 	1. Changed config macro from SOC_EXYNOS5420 to ARCH_EXYNOS
>   drivers/cpuidle/Kconfig.arm |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 97ccc31..d9596e7 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,7 +4,7 @@
>
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
> -	depends on ARCH_VEXPRESS_TC2_PM
> +	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
>   	select ARM_CPU_SUSPEND
>   	select CPU_IDLE_MULTIPLE_DRIVERS
>   	help
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
