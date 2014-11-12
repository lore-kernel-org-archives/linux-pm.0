From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Wed, 12 Nov 2014 11:33:53 +0530
Message-ID: <CAHLCerPKv=NsLNZvwo-vhDwkved5+O4a40LvrP_7j30KjeKqUQ@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
	<1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36124 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaKLGDz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 01:03:55 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so8933200lbg.28
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2014 22:03:54 -0800 (PST)
In-Reply-To: <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, heiko@sntech.de, cw00.choi@samsung.com

Hi Thomas,

On Mon, Oct 20, 2014 at 5:11 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> which did not have CPUfreq driver support, enable the use of generic
> CPUfreq driver.
>
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Chander Kashyap <k.chander@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 6b283eb..a1be294 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -282,6 +282,28 @@ static void __init exynos_init_irq(void)
>         exynos_map_pmu();
>  }
>
> +static const struct of_device_id exynos_cpufreq_matches[] = {
> +       { .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },

While you're at it, can you add this to so we don't have to patch
kernels for the Chromebook2 and Odroid-XU3?

      { .compatible = "samsung,exynos5422", .data = "arm-bL-cpufreq-dt" },
      { .compatible = "samsung,exynos5800", .data = "arm-bL-cpufreq-dt" },


> +       { .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> +       { .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> +       { .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
> +       { /* sentinel */ }
