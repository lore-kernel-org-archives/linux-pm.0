From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFCv5 PATCH 37/46] cpufreq: introduce cpufreq_driver_might_sleep
Date: Wed, 08 Jul 2015 08:09:14 -0700
Message-ID: <20150708150914.9112.89358@quantum>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-38-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436293469-25707-38-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Quoting Morten Rasmussen (2015-07-07 11:24:20)
> From: Michael Turquette <mturquette@baylibre.com>
> 
> Some architectures and platforms perform CPU frequency transitions
> through a non-blocking method, while some might block or sleep. This
> distinction is important when trying to change frequency from interrupt
> context or in any other non-interruptable context, such as from the
> Linux scheduler.
> 
> Describe this distinction with a cpufreq driver flag,
> CPUFREQ_DRIVER_WILL_NOT_SLEEP. The default is to not have this flag set,
> thus erring on the side of caution.
> 
> cpufreq_driver_might_sleep() is also introduced in this patch. Setting
> the above flag will allow this function to return false.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>

Hi Morten,

I believe your sign-off is needed here as well.

Regards,
Mike

> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8ae655c..5753cb6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -112,6 +112,12 @@ bool have_governor_per_policy(void)
>  }
>  EXPORT_SYMBOL_GPL(have_governor_per_policy);
>  
> +bool cpufreq_driver_might_sleep(void)
> +{
> +       return !(cpufreq_driver->flags & CPUFREQ_DRIVER_WILL_NOT_SLEEP);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_might_sleep);
> +
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
>  {
>         if (have_governor_per_policy())
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ee4888..1f2c9a1 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -157,6 +157,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
>  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>  int cpufreq_update_policy(unsigned int cpu);
>  bool have_governor_per_policy(void);
> +bool cpufreq_driver_might_sleep(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
> @@ -314,6 +315,14 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK        (1 << 5)
>  
> +/*
> + * Set by drivers that will never block or sleep during their frequency
> + * transition. Used to indicate when it is safe to call cpufreq_driver_target
> + * from non-interruptable context. Drivers must opt-in to this flag, as the
> + * safe default is that they might sleep.
> + */
> +#define CPUFREQ_DRIVER_WILL_NOT_SLEEP  (1 << 6)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
