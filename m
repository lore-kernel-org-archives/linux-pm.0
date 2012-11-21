From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] EXYNOS: Use static for functions used in only this file
Date: Thu, 22 Nov 2012 00:42:13 +0100
Message-ID: <3447567.TrmCKhveOD@vostro.rjw.lan>
References: <1353391154-32524-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1353391154-32524-1-git-send-email-tushar.behera@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 20, 2012 11:29:14 AM Tushar Behera wrote:
> Fixes following sparse error.
> drivers/cpufreq/exynos-cpufreq.c:34:5: warning: symbol
> 'exynos_verify_speed' was not declared. Should it be static?
> drivers/cpufreq/exynos-cpufreq.c:40:14: warning: symbol
> 'exynos_getspeed' was not declared. Should it be static?

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index af2d81e..eb057bf 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -31,13 +31,13 @@ static unsigned int locking_frequency;
>  static bool frequency_locked;
>  static DEFINE_MUTEX(cpufreq_lock);
>  
> -int exynos_verify_speed(struct cpufreq_policy *policy)
> +static int exynos_verify_speed(struct cpufreq_policy *policy)
>  {
>  	return cpufreq_frequency_table_verify(policy,
>  					      exynos_info->freq_table);
>  }
>  
> -unsigned int exynos_getspeed(unsigned int cpu)
> +static unsigned int exynos_getspeed(unsigned int cpu)
>  {
>  	return clk_get_rate(exynos_info->cpu_clk) / 1000;
>  }
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
