From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 2/2] Thermal: Exynos : add missing dependency
Date: Thu, 15 Nov 2012 14:11:33 +0530
Message-ID: <CAK44p21Q71JVeTSF5nCwUrxvzftpH=-1_rX1F0T0OUK4VRKh-Q@mail.gmail.com>
References: <1352962947.2080.10.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64337 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423500Ab2KOIle (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 03:41:34 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so1423682obb.19
        for <linux-pm@vger.kernel.org>; Thu, 15 Nov 2012 00:41:34 -0800 (PST)
In-Reply-To: <1352962947.2080.10.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Sachin Kamat <sachin.kamat@linaro.org>, patches@linaro.org

On 15 November 2012 12:32, Zhang Rui <rui.zhang@intel.com> wrote:
> there is still something unclear to me.
>
> Amit, the next step should be remove this "depends on CPU_THERMAL"
> line for EXYNOS driver, right?
Yes I will refactor the sensor code and framework registration code.
Now it is somewhat tied together.
> If we do this, the exynos driver should work w/ or w/o CPU_THERMAL,
> but should we have something like,
> "hey, I like CPU_THERMAL, I work better with it set"?
>
> "Select" does not work here
> because it may block exynos driver when CPU_FREQ cleared.
Good idea but as Select does not enable all dependencies recursively
so we ourself needs to resolve all.  "depends on " is a easy way to do
it with just 1 macro.
BTW current exynos driver needs both CPU_FREQ and CPU_THERMAL so your
patch is fine.

Thanks,
Amit Daniel
>
> any ideas on this?
>
> thanks,
> rui
>
>  CPU_FREQ_TABLE depends on CPU_FREQ. Selecting
>  CPU_FREQ_TABLE without checking for dependencies gives
>  the following compilation warnings: warning:
>  (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC &&
>  UX500_SOC_DB8500 && CPU_THERMAL && EXYNOS_THERMAL)
>  selects CPU_FREQ_TABLE which has unmet direct
>  dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
>
> Patch-based-on: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 937a23d..99b6587 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -96,7 +96,7 @@ config RCAR_THERMAL
>  config EXYNOS_THERMAL
>         tristate "Temperature sensor on Samsung EXYNOS"
>         depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
> -       select CPU_FREQ_TABLE
> +       depends on CPU_THERMAL
>         help
>           If you say yes here you get support for TMU (Thermal Managment
>           Unit) on SAMSUNG EXYNOS series of SoC.
> --
> 1.7.9.5
>
>
>
