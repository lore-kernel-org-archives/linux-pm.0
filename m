From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCH 3/4] kernel, power: disable printk_kthread in unsafe
 places
Date: Wed, 22 Mar 2017 16:38:43 +0100
Message-ID: <20170322153843.GC4008@pathway.suse.cz>
References: <20170306124554.828-1-sergey.senozhatsky@gmail.com>
 <20170306124554.828-4-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935025AbdCVPis (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20170306124554.828-4-sergey.senozhatsky@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

(added Eric, kexec mailing likst, and linux-pm mailing list
into CC because we touch their code)

On Mon 2017-03-06 21:45:53, Sergey Senozhatsky wrote:
> It's not always possible/safe to wake_up() printk kernel
> thread. For example, late suspend/early resume may printk()
> while timekeeping is not initialized yet, so calling into the
> scheduler may result in recursive warnings. Thus we need
> printk() to operate in old mode there and attempt to immediately
> flush pending kernel message to the console. This patch adds
> console_printing_thread_off/on sections.

This patch helps to avoid the warning. But IMHO, even more
important effect is that it helps to actually see the
massages when things go wrong, the kthread is never
called later, and we even do not end up in panic()
that would flush them to the console.

I am afraid that there are more locations where
the old mode need to be forced. It might take
a while until they are found and fixed.

I would really like to have an option that would
force the old mode all the time. It might help
a lot when you debug a system freeze and the messages
are not printed because of the deferred console handling.

Otherwise, the location of console_printing_thread_off()/on()
calls looks reasonable to me. But it would be great to get
some confirmation from kexec and pm people.

Best Regards,
Petr


> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/kexec_core.c      | 4 ++++
>  kernel/power/hibernate.c | 8 ++++++++
>  kernel/power/suspend.c   | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index bfe62d5b3872..b40fba31150c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1496,6 +1496,8 @@ int kernel_kexec(void)
>  		goto Unlock;
>  	}
>  
> +	console_printing_thread_off();
> +
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (kexec_image->preserve_context) {
>  		lock_system_sleep();
> @@ -1565,6 +1567,8 @@ int kernel_kexec(void)
>  	}
>  #endif
>  
> +	console_printing_thread_on();
> +
>   Unlock:
>  	mutex_unlock(&kexec_mutex);
>  	return error;
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a8b978c35a6a..15634841ccc6 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -502,6 +502,7 @@ int hibernation_restore(int platform_mode)
>  {
>  	int error;
>  
> +	console_printing_thread_off();
>  	pm_prepare_console();
>  	suspend_console();
>  	pm_restrict_gfp_mask();
> @@ -519,6 +520,7 @@ int hibernation_restore(int platform_mode)
>  	pm_restore_gfp_mask();
>  	resume_console();
>  	pm_restore_console();
> +	console_printing_thread_on();
>  	return error;
>  }
>  
> @@ -542,6 +544,7 @@ int hibernation_platform_enter(void)
>  		goto Close;
>  
>  	entering_platform_hibernation = true;
> +	console_printing_thread_off();
>  	suspend_console();
>  	error = dpm_suspend_start(PMSG_HIBERNATE);
>  	if (error) {
> @@ -589,6 +592,7 @@ int hibernation_platform_enter(void)
>  	entering_platform_hibernation = false;
>  	dpm_resume_end(PMSG_RESTORE);
>  	resume_console();
> +	console_printing_thread_on();
>  
>   Close:
>  	hibernation_ops->end();
> @@ -692,6 +696,7 @@ int hibernate(void)
>  		goto Unlock;
>  	}
>  
> +	console_printing_thread_off();
>  	pm_prepare_console();
>  	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
>  	if (error) {
> @@ -759,6 +764,7 @@ int hibernate(void)
>   Exit:
>  	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
>  	pm_restore_console();
> +	console_printing_thread_on();
>  	atomic_inc(&snapshot_device_available);
>   Unlock:
>  	unlock_system_sleep();
> @@ -868,6 +874,7 @@ static int software_resume(void)
>  		goto Unlock;
>  	}
>  
> +	console_printing_thread_off();
>  	pm_prepare_console();
>  	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
>  	if (error) {
> @@ -884,6 +891,7 @@ static int software_resume(void)
>   Finish:
>  	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
>  	pm_restore_console();
> +	console_printing_thread_on();
>  	atomic_inc(&snapshot_device_available);
>  	/* For success case, the suspend path will release the lock */
>   Unlock:
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 15e6baef5c73..7c6e228b7de4 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -433,6 +433,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  	if (!sleep_state_supported(state))
>  		return -ENOSYS;
>  
> +	console_printing_thread_off();
>  	error = platform_suspend_begin(state);
>  	if (error)
>  		goto Close;
> @@ -462,6 +463,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  
>   Close:
>  	platform_resume_end(state);
> +	console_printing_thread_on();
>  	return error;
>  
>   Recover_platform:
> @@ -520,6 +522,7 @@ static int enter_state(suspend_state_t state)
>  #endif
>  
>  	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
> +	console_printing_thread_off();
>  	pm_suspend_clear_flags();
>  	error = suspend_prepare(state);
>  	if (error)
> @@ -537,6 +540,7 @@ static int enter_state(suspend_state_t state)
>   Finish:
>  	pr_debug("PM: Finishing wakeup.\n");
>  	suspend_finish();
> +	console_printing_thread_on();
>   Unlock:
>  	mutex_unlock(&pm_mutex);
>  	return error;
> -- 
> 2.12.0
> 
