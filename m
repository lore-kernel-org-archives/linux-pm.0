From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 4/7] thermal/drivers/core: Use governor table to initialize
Date: Tue, 23 Apr 2019 16:03:06 +0530
Message-ID: <CAHLCerONOh9prVzn4SJ8WEPdVmh4WwvLHyuWJycVah9kcg7wpg@mail.gmail.com>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190402161256.11044-4-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-4-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 2, 2019 at 9:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Now that the governor table is in place and the macro allows to browse the
> table, declare the governor so the entry is added in the governor table
> in the init section.
>
> The [un]register_thermal_governors function does no longer need to use the
> exported [un]register thermal governor's specific function which in turn
> call the [un]register_thermal_governor. The governors are fully
> self-encapsulated.
>
> The cyclic dependency is no longer needed, remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/fair_share.c      | 12 +-------
>  drivers/thermal/gov_bang_bang.c   | 11 +------
>  drivers/thermal/power_allocator.c | 11 +------
>  drivers/thermal/step_wise.c       | 11 +------
>  drivers/thermal/thermal_core.c    | 51 +++++++++++++++++--------------
>  drivers/thermal/thermal_core.h    | 40 ------------------------
>  drivers/thermal/user_space.c      | 12 +-------
>  7 files changed, 33 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index d3469fbc5207..bda2afc63471 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -129,14 +129,4 @@ static struct thermal_governor thermal_gov_fair_share = {
>         .name           = "fair_share",
>         .throttle       = fair_share_throttle,
>  };
> -
> -int thermal_gov_fair_share_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_fair_share);
> -}
> -
> -void thermal_gov_fair_share_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_fair_share);
> -}
> -
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index fc5e5057f0de..c5e19c7d63da 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -126,13 +126,4 @@ static struct thermal_governor thermal_gov_bang_bang = {
>         .name           = "bang_bang",
>         .throttle       = bang_bang_control,
>  };
> -
> -int thermal_gov_bang_bang_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_bang_bang);
> -}
> -
> -void thermal_gov_bang_bang_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_bang_bang);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> index 3055f9a12a17..44636475b2a3 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -651,13 +651,4 @@ static struct thermal_governor thermal_gov_power_allocator = {
>         .unbind_from_tz = power_allocator_unbind,
>         .throttle       = power_allocator_throttle,
>  };
> -
> -int thermal_gov_power_allocator_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_power_allocator);
> -}
> -
> -void thermal_gov_power_allocator_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_power_allocator);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index ee047ca43084..6cd251ab56fc 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -218,13 +218,4 @@ static struct thermal_governor thermal_gov_step_wise = {
>         .name           = "step_wise",
>         .throttle       = step_wise_throttle,
>  };
> -
> -int thermal_gov_step_wise_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_step_wise);
> -}
> -
> -void thermal_gov_step_wise_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_step_wise);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 28f7ece0e8fe..50c88682a848 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -243,36 +243,41 @@ int thermal_build_list_of_policies(char *buf)
>         return count;
>  }
>
> -static int __init thermal_register_governors(void)
> +static void __init thermal_unregister_governors(void)
>  {
> -       int result;
> +       struct thermal_governor **governor;
>
> -       result = thermal_gov_step_wise_register();
> -       if (result)
> -               return result;
> +       for_each_governor_table(governor)
> +               thermal_unregister_governor(*governor);

As a result of this function moving to __init, can't
thermal_unregister_governor also become __init now?

Nice cleanup.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> +}
>
> -       result = thermal_gov_fair_share_register();
> -       if (result)
> -               return result;
> +static int __init thermal_register_governors(void)
> +{
> +       int ret = 0;
> +       struct thermal_governor **governor;
>
> -       result = thermal_gov_bang_bang_register();
> -       if (result)
> -               return result;
> +       for_each_governor_table(governor) {
> +               ret = thermal_register_governor(*governor);
> +               if (ret) {
> +                       pr_err("Failed to register governor: '%s'",
> +                              (*governor)->name);
> +                       break;
> +               }
>
> -       result = thermal_gov_user_space_register();
> -       if (result)
> -               return result;
> +               pr_info("Registered thermal governor '%s'",
> +                       (*governor)->name);
> +       }
>
> -       return thermal_gov_power_allocator_register();
> -}
> +       if (ret) {
> +               struct thermal_governor **gov;
> +               for_each_governor_table(gov) {
> +                       if (gov == governor)
> +                               break;
> +                       thermal_unregister_governor(*gov);
> +               }
> +       }
>
> -static void __init thermal_unregister_governors(void)
> -{
> -       thermal_gov_step_wise_unregister();
> -       thermal_gov_fair_share_unregister();
> -       thermal_gov_bang_bang_unregister();
> -       thermal_gov_user_space_unregister();
> -       thermal_gov_power_allocator_unregister();
> +       return ret;
>  }
>
>  /*
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 28d18083e969..a3c555b48eb3 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -90,46 +90,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>                                     unsigned long new_state) {}
>  #endif /* CONFIG_THERMAL_STATISTICS */
>
> -#ifdef CONFIG_THERMAL_GOV_STEP_WISE
> -int thermal_gov_step_wise_register(void);
> -void thermal_gov_step_wise_unregister(void);
> -#else
> -static inline int thermal_gov_step_wise_register(void) { return 0; }
> -static inline void thermal_gov_step_wise_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_STEP_WISE */
> -
> -#ifdef CONFIG_THERMAL_GOV_FAIR_SHARE
> -int thermal_gov_fair_share_register(void);
> -void thermal_gov_fair_share_unregister(void);
> -#else
> -static inline int thermal_gov_fair_share_register(void) { return 0; }
> -static inline void thermal_gov_fair_share_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_FAIR_SHARE */
> -
> -#ifdef CONFIG_THERMAL_GOV_BANG_BANG
> -int thermal_gov_bang_bang_register(void);
> -void thermal_gov_bang_bang_unregister(void);
> -#else
> -static inline int thermal_gov_bang_bang_register(void) { return 0; }
> -static inline void thermal_gov_bang_bang_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_BANG_BANG */
> -
> -#ifdef CONFIG_THERMAL_GOV_USER_SPACE
> -int thermal_gov_user_space_register(void);
> -void thermal_gov_user_space_unregister(void);
> -#else
> -static inline int thermal_gov_user_space_register(void) { return 0; }
> -static inline void thermal_gov_user_space_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_USER_SPACE */
> -
> -#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> -int thermal_gov_power_allocator_register(void);
> -void thermal_gov_power_allocator_unregister(void);
> -#else
> -static inline int thermal_gov_power_allocator_register(void) { return 0; }
> -static inline void thermal_gov_power_allocator_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> -
>  /* device tree support */
>  #ifdef CONFIG_THERMAL_OF
>  int of_parse_thermal_zones(void);
> diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
> index 8e92a06ef48a..5fac99e5221d 100644
> --- a/drivers/thermal/user_space.c
> +++ b/drivers/thermal/user_space.c
> @@ -56,14 +56,4 @@ static struct thermal_governor thermal_gov_user_space = {
>         .name           = "user_space",
>         .throttle       = notify_user_space,
>  };
> -
> -int thermal_gov_user_space_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_user_space);
> -}
> -
> -void thermal_gov_user_space_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_user_space);
> -}
> -
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> --
> 2.17.1
>
