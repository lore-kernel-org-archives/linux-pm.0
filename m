From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM / Sleep: Print last wakeup source on failed wakeup_count write
Date: Mon, 24 Jun 2013 14:06:29 +0200
Message-ID: <1734767.0ymWMYxKqb@vostro.rjw.lan>
References: <1371066922-23577-1-git-send-email-jwerner@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49007 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3FXL5C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Jun 2013 07:57:02 -0400
In-Reply-To: <1371066922-23577-1-git-send-email-jwerner@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julius Werner <jwerner@chromium.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Todd Poynor <toddpoynor@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>

On Wednesday, June 12, 2013 12:55:22 PM Julius Werner wrote:
> Commit a938da06 introduced a useful little log message to tell
> users/debuggers which wakeup source aborted a suspend. However, this
> message is only printed if the abort happens during the in-kernel
> suspend path (after writing /sys/power/state).
> 
> The full specification of the /sys/power/wakeup_count facility allows
> user-space power managers to double-check if wakeups have already
> happened before it actually tries to suspend (e.g. while it was running
> user-space pre-suspend hooks), by writing the last known wakeup_count
> value to /sys/power/wakeup_count. This patch changes the sysfs handler
> for that node to also print said log message if that write fails, so
> that we can figure out the offending wakeup source for both kinds of
> suspend aborts.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>

Queued up for 3.11.

Thanks,
Rafael


> ---
>  drivers/base/power/wakeup.c | 5 +++--
>  include/linux/suspend.h     | 1 +
>  kernel/power/main.c         | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 79715e7..90f83ca5 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -659,7 +659,7 @@ void pm_wakeup_event(struct device *dev, unsigned int msec)
>  }
>  EXPORT_SYMBOL_GPL(pm_wakeup_event);
>  
> -static void print_active_wakeup_sources(void)
> +void pm_print_active_wakeup_sources(void)
>  {
>  	struct wakeup_source *ws;
>  	int active = 0;
> @@ -683,6 +683,7 @@ static void print_active_wakeup_sources(void)
>  			last_activity_ws->name);
>  	rcu_read_unlock();
>  }
> +EXPORT_SYMBOL_GPL(pm_print_active_wakeup_sources);
>  
>  /**
>   * pm_wakeup_pending - Check if power transition in progress should be aborted.
> @@ -708,7 +709,7 @@ bool pm_wakeup_pending(void)
>  	spin_unlock_irqrestore(&events_lock, flags);
>  
>  	if (ret)
> -		print_active_wakeup_sources();
> +		pm_print_active_wakeup_sources();
>  
>  	return ret;
>  }
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index d4e3f16..f73cabf 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -363,6 +363,7 @@ extern bool pm_wakeup_pending(void);
>  extern bool pm_get_wakeup_count(unsigned int *count, bool block);
>  extern bool pm_save_wakeup_count(unsigned int count);
>  extern void pm_wakep_autosleep_enabled(bool set);
> +extern void pm_print_active_wakeup_sources(void);
>  
>  static inline void lock_system_sleep(void)
>  {
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index d77663b..0828070 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -424,6 +424,8 @@ static ssize_t wakeup_count_store(struct kobject *kobj,
>  	if (sscanf(buf, "%u", &val) == 1) {
>  		if (pm_save_wakeup_count(val))
>  			error = n;
> +		else
> +			pm_print_active_wakeup_sources();
>  	}
>  
>   out:
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
