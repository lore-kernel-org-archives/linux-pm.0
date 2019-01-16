From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 03/10] cpufreq: Replace open-coded << with BIT()
Date: Wed, 16 Jan 2019 23:55:17 +0100
Message-ID: <2392396.AI7Hxg4e4v@aspire.rjw.lan>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 14, 2019 5:34:55 PM CET Amit Kucheria wrote:
> Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
> comment formatting while we're at it to make it easier to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Can you please do this cleanup as the first patch in the series, so it
doesn't depend on the other patches in it, which isn't necessary IMO?

> ---
>  include/linux/cpufreq.h | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 70ad02088825..ea303dfd5f05 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -351,14 +351,15 @@ struct cpufreq_driver {
>  };
>  
>  /* flags */
> -#define CPUFREQ_STICKY		(1 << 0)	/* driver isn't removed even if
> -						   all ->init() calls failed */
> -#define CPUFREQ_CONST_LOOPS	(1 << 1)	/* loops_per_jiffy or other
> -						   kernel "constants" aren't
> -						   affected by frequency
> -						   transitions */
> -#define CPUFREQ_PM_NO_WARN	(1 << 2)	/* don't warn on suspend/resume
> -						   speed mismatches */
> +
> +/* driver isn't removed even if all ->init() calls failed */
> +#define CPUFREQ_STICKY				BIT(0)
> +
> +/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
> +#define CPUFREQ_CONST_LOOPS			BIT(1)
> +
> +/* don't warn on suspend/resume speed mismatches */
> +#define CPUFREQ_PM_NO_WARN			BIT(2)
>  
>  /*
>   * This should be set by platforms having multiple clock-domains, i.e.
> @@ -366,14 +367,14 @@ struct cpufreq_driver {
>   * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
>   * governor with different tunables for different clusters.
>   */
> -#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY (1 << 3)
> +#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY	BIT(3)
>  
>  /*
>   * Driver will do POSTCHANGE notifications from outside of their ->target()
>   * routine and so must set cpufreq_driver->flags with this flag, so that core
>   * can handle them specially.
>   */
> -#define CPUFREQ_ASYNC_NOTIFICATION  (1 << 4)
> +#define CPUFREQ_ASYNC_NOTIFICATION		BIT(4)
>  
>  /*
>   * Set by drivers which want cpufreq core to check if CPU is running at a
> @@ -382,19 +383,19 @@ struct cpufreq_driver {
>   * from the table. And if that fails, we will stop further boot process by
>   * issuing a BUG_ON().
>   */
> -#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
> +#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	BIT(5)
>  
>  /*
>   * Set by drivers to disallow use of governors with "dynamic_switching" flag
>   * set.
>   */
> -#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
> +#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
>  /*
>   * Set by drivers that want the core to automatically register the cpufreq
>   * driver as a thermal cooling device
>   */
> -#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
>  
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> 
