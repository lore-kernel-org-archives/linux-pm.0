From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: enable suspend-to-idle even without registered suspend_ops
Date: Thu, 18 Aug 2016 13:06:49 +0200
Message-ID: <1549989.BLB0oyvVbJ@vostro.rjw.lan>
References: <1471511964-6341-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471511964-6341-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 18, 2016 10:19:24 AM Sudeep Holla wrote:
> Suspend-to-idle (aka the "freeze" sleep state) is a system sleep state
> in which all of the processors enter deepest possible idle state and
> wait for interrupts right after suspending all the devices.
> 
> There is no hard requirement for a platform to support and register
> platform specific suspend_ops to enter suspend-to-idle/freeze state.
> Only deeper system sleep states like PM_SUSPEND_STANDBY and
> PM_SUSPEND_MEM rely on such low level support/implementation.
> 
> suspend-to-idle can be entered as along as all the devices can be
> suspended. This patch enables the support for suspend-to-idle even on
> systems that don't have any low level support for deeper system sleep
> states and/or don't register any platform specific suspend_ops.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  kernel/power/main.c    | 5 +++++
>  kernel/power/suspend.c | 8 +++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> Hi Rafael,
> 
> I am not sure if you like this approach. I found this to be the simplest
> but I may have missed to consider all possible corner cases especially
> for x86 and other platforms. I don't see any such issues/cases with ARM
> systems.
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5ea50b1b7595..0f0fd9184f39 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -651,6 +651,11 @@ static int __init pm_init(void)
>  	if (error)
>  		return error;
>  	pm_print_times_init();
> +	/*
> +	 * freeze state should be supported even without any suspend_ops,
> +	 * calling suspend_set_ops without any ops will setup freeze state
> +	 */
> +	suspend_set_ops(NULL);

Well, this is a core initcall, so suspend_set_ops() invocations from platforms
really should happen after that, so something like this should be sufficient here:

	pm_state[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? PM_SUSPEND_MEM : PM_SUSPEND_FREEZE];

if I'm not mistaken.

>  	return pm_autosleep_init();
>  }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0acab9d7f96f..37d64f811ecd 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -138,7 +138,9 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
> 
>  	lock_system_sleep();
> 
> -	suspend_ops = ops;
> +	WARN_ONCE(ops && suspend_ops, "overriding suspend_ops");
> +	if (ops)
> +		suspend_ops = ops;

And this should not be necessary then.

>  	for (i = PM_SUSPEND_MEM; i >= PM_SUSPEND_STANDBY; i--)
>  		if (valid_state(i)) {
>  			pm_states[i] = pm_labels[j++];
> @@ -211,7 +213,7 @@ static int platform_suspend_begin(suspend_state_t state)
>  {
>  	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->begin)
>  		return freeze_ops->begin();
> -	else if (suspend_ops->begin)
> +	else if (suspend_ops && suspend_ops->begin)
>  		return suspend_ops->begin(state);
>  	else
>  		return 0;
> @@ -221,7 +223,7 @@ static void platform_resume_end(suspend_state_t state)
>  {
>  	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->end)
>  		freeze_ops->end();
> -	else if (suspend_ops->end)
> +	else if (suspend_ops && suspend_ops->end)
>  		suspend_ops->end();
>  }

And this is still needed, of course.

Thanks,
Rafael
