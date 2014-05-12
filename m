From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Mon, 12 May 2014 09:46:01 +0530
Message-ID: <CAKohpo=4c=eDOMxxFi37mLA7LViJ-P_Rb42Yt5ARa_qgiGU8eg@mail.gmail.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
	<1399653631-4938-3-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:53417 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbaELEQB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 00:16:01 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so7673210oag.32
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2014 21:16:01 -0700 (PDT)
In-Reply-To: <1399653631-4938-3-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>

On 9 May 2014 22:10, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> There are arm64 big.LITTLE systems so enable the big.LITTLE cpufreq driver.
> While IKS is not available for these systems the driver is still useful
> since it manages clusters with shared frequencies which is the common case
> for these systems.
>
> Long term combining the cpufreq-cpu0 and big.LITTLE drivers may be a
> more sensible option but that is substantially more complex especially
> in the case of IKS.

Yeah, it was left separately for IKS specially :(

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 6e05a1e18e52..6a7dd3e958d5 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -5,7 +5,8 @@
>  # big LITTLE core layer and glue drivers
>  config ARM_BIG_LITTLE_CPUFREQ
>         tristate "Generic ARM big LITTLE CPUfreq driver"
> -       depends on ARM && BIG_LITTLE && ARM_CPU_TOPOLOGY && HAVE_CLK
> +       depends on (BIG_LITTLE && ARM_CPU_TOPOLOGY) || (ARM64 && SMP)
> +       depends on HAVE_CLK
>         select PM_OPP
>         help
>           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
