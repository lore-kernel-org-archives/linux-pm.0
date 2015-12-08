From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 4/8] ARM: Exynos: use generic cpufreq driver for
 Exynos5420
Date: Tue, 08 Dec 2015 16:36:12 +0900
Message-ID: <5666886C.10203@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:50241 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbLHHgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 02:36:24 -0500
In-reply-to: <1449512300-17230-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The new CPU clock type allows the use of cpufreq-dt driver
> for Exynos5420.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> - disable cpufreq if big.LITTLE switcher support is enabled
> - switch to using cpufreq-dt driver
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 3 +++
>  1 file changed, 3 insertions(+)

I think this is actually now your patch, not Thomas any more. :)

> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 1c47aee..7a89c9d 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -230,6 +230,9 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> +#ifndef CONFIG_BL_SWITCHER
> +	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
> +#endif

Why not on BL_SWITCHER? Shouldn't be enough to disable ARM_DT_BL_CPUFREQ?

Best regards,
Krzysztof

