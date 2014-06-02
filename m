From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: EXYNOS: PM: fix register setup on EXYNOS4x12
 for AFTR mode code
Date: Mon, 02 Jun 2014 15:10:05 +0200
Message-ID: <538C77AD.1000801@gmail.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com> <1401712543-14281-7-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1401712543-14281-7-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> Add S5P_CENTRAL_SEQ_OPTION register setup for EXYNOS4x12 to AFTR
> mode code.  Without this setup AFTR mode doesn't show any benefit
> over WFI one.  When this setup is applied AFTR mode reduces power
> consumption by ~12% (as measured on Trats2 board).
> 
> This change is a preparation for adding secure firmware support to
> EXYNOS cpuidle driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index aeff99e..0fb9a5a 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -456,6 +456,10 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>  	case CPU_PM_ENTER:
>  		if (cpu == 0) {
>  			exynos_pm_central_suspend();
> +			if (soc_is_exynos4212() || soc_is_exynos4412())
> +				__raw_writel(S5P_USE_STANDBY_WFI0 |
> +					     S5P_USE_STANDBY_WFE0,
> +					     S5P_CENTRAL_SEQ_OPTION);

I wonder whether this isn't required on any Exynos SoC in general, as
this mask decides which STANDBY_WFI/WFE signals are considered before
entering the lower power state.

Also you should check the behavior with Krzysztof's patch adding support
for delayed reset assertion, which should cause WFI/WFE signals of CPUs
powered down to be kept asserted.

Best regards,
Tomasz
