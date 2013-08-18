From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 13/34] cpufreq: exynos5440: set CPUFREQ_NO_NOTIFICATION flag
Date: Sun, 18 Aug 2013 16:24:00 +0530
Message-ID: <CADGdYn6TKURuO8jxL=tjvSLbmpUoUwoa08MZhsBAiEF91FM-cA@mail.gmail.com>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
	<14993d27bdc6a91eced0af5eb96bdb5ca6546cbf.1376619363.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <14993d27bdc6a91eced0af5eb96bdb5ca6546cbf.1376619363.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel@lists.linaro.org, "patches@linaro.org" <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 16, 2013 at 7:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Most of the drivers do following in their ->target_index() routines:
>
>         struct cpufreq_freqs freqs;
>         freqs.old = old freq...
>         freqs.new = new freq...
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>
>         /* Change rate here */
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
>
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, but this drivers needs to do this notification itself and so
> it sets its CPUFREQ_NO_NOTIFICATION flag.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
The code change looks fine,
Acked-By: Amit Daniel Kachhap <amit.daniel@samsung.com>

Thanks
Amit Daniel
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index 91a64d6..8fb6183 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -323,7 +323,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  }
>
>  static struct cpufreq_driver exynos_driver = {
> -       .flags          = CPUFREQ_STICKY,
> +       .flags          = CPUFREQ_STICKY | CPUFREQ_NO_NOTIFICATION,
>         .verify         = cpufreq_generic_frequency_table_verify,
>         .target_index   = exynos_target,
>         .get            = exynos_getspeed,
> --
> 1.7.12.rc2.18.g61b472e
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
