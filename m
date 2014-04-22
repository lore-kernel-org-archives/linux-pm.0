From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] cpuidle: config: Add SOC_EXYNOS5420 entry to select
 cpuidle-big-little driver
Date: Tue, 22 Apr 2014 12:42:04 +0200
Message-ID: <5356477C.1070403@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org> <1398080958-21677-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:52938 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbaDVKlj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 06:41:39 -0400
Received: by mail-wi0-f169.google.com with SMTP id hm4so2867375wib.4
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 03:41:38 -0700 (PDT)
In-Reply-To: <1398080958-21677-2-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <k.chander@samsung.com>

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> Exynos5420 is a big-little SoC from Samsung. It has 4 A15 and 4 A7 co=
res.
> In order to use generic cpuidle-big-little driver, this patch adds Ex=
ynos5420
> specific check to initialize generic cpuidle driver.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> ---
>   drivers/cpuidle/Kconfig.arm |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 97ccc31..5244d87 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,7 +4,7 @@
>
>   config ARM_BIG_LITTLE_CPUIDLE
>   	bool "Support for ARM big.LITTLE processors"
> -	depends on ARCH_VEXPRESS_TC2_PM
> +	depends on ARCH_VEXPRESS_TC2_PM || SOC_EXYNOS5420

=46or the sake of consistency, I would prefer:

depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS

and let the current code (and future platform driver) to handle the=20
loading of the driver.

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

