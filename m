From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / sleep: enable suspend-to-idle even without
 registered suspend_ops
Date: Fri, 19 Aug 2016 00:20:01 +0200
Message-ID: <CAJZ5v0i2uZBkeLYs4PB8ZKnRHYfFPv2fEDJRQr+aVix6QHzjHA@mail.gmail.com>
References: <1471511964-6341-1-git-send-email-sudeep.holla@arm.com> <1471538554-28315-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471538554-28315-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Gross <andy.gross@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 18, 2016 at 6:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Suspend-to-idle (aka the "freeze" sleep state) is a system sleep state
> in which all of the processors enter deepest possible idle state and
> wait for interrupts right after suspending all the devices.
>
> There is no hard requirement for a platform to support and register
> platform specific suspend_ops to enter suspend-to-idle/freeze state.
> Only deeper system sleep states like PM_SUSPEND_STANDBY and
> PM_SUSPEND_MEM rely on such low level support/implementation.
>
> Suspend-to-idle can be entered as along as all the devices can be
> suspended. This patch enables the support for suspend-to-idle even on
> systems that don't have any low level support for deeper system sleep
> states and/or don't register any platform specific suspend_ops.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/suspend.h |  2 ++
>  kernel/power/main.c     |  1 +
>  kernel/power/suspend.c  | 14 +++++++++++---
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> v1->v2:
>         - Introduced pm_freeze_init instead of (mis/re)using suspend_set_ops
>           to setup freeze state in absense of registered platform suspend_ops
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 7693e39b14fe..0528ee32be7c 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -245,6 +245,7 @@ static inline bool idle_should_freeze(void)
>         return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
>  }
>
> +extern void __init pm_freeze_init(void);
>  extern void freeze_set_ops(const struct platform_freeze_ops *ops);
>  extern void freeze_wake(void);
>
> @@ -279,6 +280,7 @@ static inline bool pm_resume_via_firmware(void) { return false; }
>  static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
>  static inline bool idle_should_freeze(void) { return false; }
> +static inline void __init pm_freeze_init(void) {}

Why don't you call it pm_states_init()?

>  static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
>  static inline void freeze_wake(void) {}
>  #endif /* !CONFIG_SUSPEND */
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5ea50b1b7595..f27c2f2d0f22 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -651,6 +651,7 @@ static int __init pm_init(void)
>         if (error)
>                 return error;
>         pm_print_times_init();
> +       pm_freeze_init();

And please move this up (before the registration of power_kobj).

>         return pm_autosleep_init();
>  }
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0acab9d7f96f..1c962a366678 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -118,10 +118,18 @@ static bool valid_state(suspend_state_t state)
>   */
>  static bool relative_states;
>
> +void __init pm_freeze_init(void)
> +{
> +       /*
> +        * freeze state should be supported even without any suspend_ops,
> +        * initialize pm_states accordingly here
> +        */
> +       pm_states[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? 0 : 2];
> +}
> +
>  static int __init sleep_states_setup(char *str)
>  {
>         relative_states = !strncmp(str, "1", 1);
> -       pm_states[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? 0 : 2];
>         return 1;
>  }
>
> @@ -211,7 +219,7 @@ static int platform_suspend_begin(suspend_state_t state)
>  {
>         if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->begin)
>                 return freeze_ops->begin();
> -       else if (suspend_ops->begin)
> +       else if (suspend_ops && suspend_ops->begin)
>                 return suspend_ops->begin(state);
>         else
>                 return 0;
> @@ -221,7 +229,7 @@ static void platform_resume_end(suspend_state_t state)
>  {
>         if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->end)
>                 freeze_ops->end();
> -       else if (suspend_ops->end)
> +       else if (suspend_ops && suspend_ops->end)
>                 suspend_ops->end();
>  }
>
> --

Thanks,
Rafael
