From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Wed, 19 Nov 2014 19:28:33 +0000
Message-ID: <546CEF61.4050105@arm.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com> <1413805281-6269-2-git-send-email-thomas.ab@samsung.com> <1413805281-6269-3-git-send-email-thomas.ab@samsung.com> <1413805281-6269-4-git-send-email-thomas.ab@samsung.com> <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 20/10/14 12:41, Thomas Abraham wrote:
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
>   arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>   1 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 6b283eb..a1be294 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -282,6 +282,28 @@ static void __init exynos_init_irq(void)
>   	exynos_map_pmu();
>   }
>
> +static const struct of_device_id exynos_cpufreq_matches[] = {
> +	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },

Sorry for raising this issue always with Exynos cpufreq drivers. IMO the
bindings for "arm-bL-cpufreq-dt" is broken. Currently no one is using it
and it's better to fix it before we have a real user of it.

If you look at the binding document for it[1], it has a fixme which
shouldn't have been there at first place. It assumes the ordering of
CPU's specified in the DT and the logical index allocation to them.

It even breaks for hotplug especially if you hotplug-in back in
different order. We can work around that probably, but it's better to
fix the binding. I failed to grab much attention in my previous attempts
to address this[2]. Viresh also started a discussion more recently[3].

Regards,
Sudeep

[1] Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
[2] http://www.spinics.net/lists/arm-kernel/msg303977.html
[3] https://lkml.org/lkml/2014/6/25/152
