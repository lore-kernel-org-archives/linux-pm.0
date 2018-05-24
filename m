From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC] suspend: Prevent might sleep splats
Date: Thu, 24 May 2018 17:07:16 +0200
Message-ID: <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com>
References: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 24, 2018 at 4:24 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> timekeeping suspend/resume calls read_persistent_clock() which takes
> rtc_lock. That results in might sleep warnings because at that point
> we run with interrupts disabled.
>
> We cannot convert rtc_lock to a raw spinlock as that would trigger
> other might sleep warnings.
>
> As a workaround we disable the might sleep warnings by setting
> system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
> restoring it to SYSTEM_RUNNING afer sysdev_resume().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hmm.  Don't we also need to cover suspend-to-idle?

> ---
>  include/linux/kernel.h   |    1 +
>  kernel/power/hibernate.c |    7 +++++++
>  kernel/power/suspend.c   |    4 ++++
>  3 files changed, 12 insertions(+)
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -532,6 +532,7 @@ extern enum system_states {
>         SYSTEM_HALT,
>         SYSTEM_POWER_OFF,
>         SYSTEM_RESTART,
> +       SYSTEM_SUSPEND,
>  } system_state;
>
>  #define TAINT_PROPRIETARY_MODULE       0
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -287,6 +287,8 @@ static int create_image(int platform_mod
>
>         local_irq_disable();
>
> +       system_state = SYSTEM_SUSPEND;
> +
>         error = syscore_suspend();
>         if (error) {
>                 pr_err("Some system devices failed to power down, aborting hibernation\n");
> @@ -317,6 +319,7 @@ static int create_image(int platform_mod
>         syscore_resume();
>
>   Enable_irqs:
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> @@ -445,6 +448,7 @@ static int resume_target_kernel(bool pla
>                 goto Enable_cpus;
>
>         local_irq_disable();
> +       system_state = SYSTEM_SUSPEND;
>
>         error = syscore_suspend();
>         if (error)
> @@ -478,6 +482,7 @@ static int resume_target_kernel(bool pla
>         syscore_resume();
>
>   Enable_irqs:
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> @@ -563,6 +568,7 @@ int hibernation_platform_enter(void)
>                 goto Enable_cpus;
>
>         local_irq_disable();
> +       system_state = SYSTEM_SUSPEND;
>         syscore_suspend();
>         if (pm_wakeup_pending()) {
>                 error = -EAGAIN;
> @@ -575,6 +581,7 @@ int hibernation_platform_enter(void)
>
>   Power_up:
>         syscore_resume();
> +       system_state = SYSTEM_RUNNING;
>         local_irq_enable();
>
>   Enable_cpus:
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -428,6 +428,8 @@ static int suspend_enter(suspend_state_t
>         arch_suspend_disable_irqs();
>         BUG_ON(!irqs_disabled());
>
> +       system_state = SYSTEM_SUSPEND;
> +
>         error = syscore_suspend();
>         if (!error) {
>                 *wakeup = pm_wakeup_pending();
> @@ -443,6 +445,8 @@ static int suspend_enter(suspend_state_t
>                 syscore_resume();
>         }
>
> +       system_state = SYSTEM_RUNNING;
> +
>         arch_suspend_enable_irqs();
>         BUG_ON(irqs_disabled());
>
