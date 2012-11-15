From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH-Resend] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 12:31:36 +0530
Message-ID: <CAK44p21smO8rrKoJF=47ywRCeagDudvFzZ7DhJ7TZCT7Mqv7kA@mail.gmail.com>
References: <1352961579-13807-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46008 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145Ab2KOHBh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 02:01:37 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so1364451obb.19
        for <linux-pm@vger.kernel.org>; Wed, 14 Nov 2012 23:01:36 -0800 (PST)
In-Reply-To: <1352961579-13807-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, akpm@linux-foundation.org, linux-samsung-soc@vger.kernel.org

On 15 November 2012 12:09, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
> for dependencies gives the following compilation warnings:
> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
> CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
> direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
>
> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/thermal/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 266c15e..6124c4b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -50,8 +50,7 @@ config RCAR_THERMAL
>
>  config EXYNOS_THERMAL
>         tristate "Temperature sensor on Samsung EXYNOS"
> -       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
> -       select CPU_FREQ_TABLE
Hi Sachin/Rui,

"select CPU_FREQ_TABLE" should be there even if CONFIG_CPU_FREQ is
enabled. Only some governors enable it. See drivers/cpufreq/Kconfig
Also "depends THERMAL" should be there otherwise menuconfig
parent/child relationship is broken.

Thanks,
Amit Daniel

> +       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && CPU_THERMAL
>         help
>           If you say yes here you get support for TMU (Thermal Managment
>           Unit) on SAMSUNG EXYNOS series of SoC.
> --
> 1.7.4.1
>
