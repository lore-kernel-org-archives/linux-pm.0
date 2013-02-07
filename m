From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 5/5] Thermal: Get cooling state via cpu cooling table
Date: Wed, 6 Feb 2013 17:38:30 -0800
Message-ID: <CADGdYn5iPOhK51FXE4O-fU=nrXxufx_qqyPBpaMXA2wOSMcNTA@mail.gmail.com>
References: <CADGdYn4fjoWXmGJ-xTZ48Fo9LE7GK37n_W41GFrBv+VNMPA23w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:48579 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab3BGBib (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Feb 2013 20:38:31 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so2383154iag.17
        for <linux-pm@vger.kernel.org>; Wed, 06 Feb 2013 17:38:30 -0800 (PST)
In-Reply-To: <CADGdYn4fjoWXmGJ-xTZ48Fo9LE7GK37n_W41GFrBv+VNMPA23w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>, amit.kachhap@gmail.com

Hi Rui,

I tested these patches. Below are the comments.

On Wed, Feb 6, 2013 at 5:30 PM, amit kachhap <amit.kachhap@gmail.com> wrote:
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/cpu_cooling.c    |   22 ++++++++++++++++++++++
>  drivers/thermal/exynos_thermal.c |   24 ++----------------------
>  include/linux/cpu_cooling.h      |    6 ++++++
>  include/linux/thermal.h          |    4 +++-
>  4 files changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 784be30..9dbcbc1 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -178,6 +178,28 @@ get_cpu_cooling_table(unsigned int cpu)
>         return new;
>  }
>
> +unsigned long cpufreq_cooling_get_level(unsigned int cpu,
> +                       unsigned int freq)
> +{
> +       struct cpufreq_frequency_table *table;
> +       int i;
> +       unsigned long level = THERMAL_COOLING_STATE_INVALID;
> +
> +       table = get_cpu_cooling_table(cpu);
> +       if (IS_ERR(table))
> +               return -EINVAL;
Here return should be THERMAL_COOLING_STATE_INVALID as the same value
is checked below.

Thanks,
Amit Daniel
> +
> +       for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++)
> +               if (freq == table[i].frequency) {
> +                       level = (unsigned long)i;
> +                       break;
> +               }
> +
> +       kfree(table);
> +       return level;
> +}
> +EXPORT_SYMBOL(cpufreq_cooling_get_level);
> +
>  /**
>   * get_cpu_frequency - get the absolute value of frequency from level.
>   * @cpu: cpu for which frequency is fetched.
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index cd71e24..2fea7a9 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -239,26 +239,6 @@ static int exynos_get_crit_temp(struct
> thermal_zone_device *thermal,
>         return ret;
>  }
>
> -static int exynos_get_frequency_level(unsigned int cpu, unsigned int freq)
> -{
> -       int i = 0, ret = -EINVAL;
> -       struct cpufreq_frequency_table *table = NULL;
> -#ifdef CONFIG_CPU_FREQ
> -       table = cpufreq_frequency_get_table(cpu);
> -#endif
> -       if (!table)
> -               return ret;
> -
> -       while (table[i].frequency != CPUFREQ_TABLE_END) {
> -               if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
> -                       continue;
> -               if (table[i].frequency == freq)
> -                       return i;
> -               i++;
> -       }
> -       return ret;
> -}
> -
>  /* Bind callback functions for thermal zone */
>  static int exynos_bind(struct thermal_zone_device *thermal,
>                         struct thermal_cooling_device *cdev)
> @@ -285,8 +265,8 @@ static int exynos_bind(struct thermal_zone_device *thermal,
>         /* Bind the thermal zone to the cpufreq cooling device */
>         for (i = 0; i < tab_size; i++) {
>                 clip_data = (struct freq_clip_table *)&(tab_ptr[i]);
> -               level = exynos_get_frequency_level(0, clip_data->freq_clip_max);
> -               if (level < 0)
> +               level = cpufreq_cooling_get_level(0, clip_data->freq_clip_max);
> +               if (level == THERMAL_COOLING_STATE_INVALID)
>                         return 0;
>                 switch (GET_ZONE(i)) {
>                 case MONITOR_ZONE:
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 40b4ef5..0a4a05d 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -42,6 +42,7 @@ struct thermal_cooling_device *cpufreq_cooling_register(
>   * @cdev: thermal cooling device pointer.
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
> +unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int);
>  #else /* !CONFIG_CPU_THERMAL */
>  static inline struct thermal_cooling_device *cpufreq_cooling_register(
>         const struct cpumask *clip_cpus)
> @@ -53,6 +54,11 @@ static inline void cpufreq_cooling_unregister(
>  {
>         return;
>  }
> +static inline unsigned long cpufreq_cooling_get_level(
> +               unsigned int cpu, unsigned int freq)
> +{
> +       return THERMAL_COOLING_STATE_INVALID;
> +}
>  #endif /* CONFIG_CPU_THERMAL */
>
>  #endif /* __CPU_COOLING_H__ */
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f0bd7f9..03bdaa4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -33,8 +33,10 @@
>  #define THERMAL_MAX_TRIPS      12
>  #define THERMAL_NAME_LENGTH    20
>
> +#define THERMAL_COOLING_STATE_INVALID -1UL
> +
>  /* No upper/lower limit requirement */
> -#define THERMAL_NO_LIMIT       -1UL
> +#define THERMAL_NO_LIMIT THERMAL_COOLING_STATE_INVALID
>
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)   (long)(((long)t-2732 >= 0) ?    \
> --
> 1.7.9.5
