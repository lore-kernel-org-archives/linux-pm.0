From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCHv4] drivers: power: Detect device suspend/resume lockup
 and log event in pstore.
Date: Wed, 9 Oct 2013 11:51:51 -0700
Message-ID: <CAME+o4=jpqyoVyRM6bz9xF5rzOHse0n95pG_cW9J=b=kYNicEg@mail.gmail.com>
References: <1380148313-763-1-git-send-email-zoran.markovic@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44163 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab3JISvw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2013 14:51:52 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so957450obc.11
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2013 11:51:51 -0700 (PDT)
In-Reply-To: <1380148313-763-1-git-send-email-zoran.markovic@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Benoit Goby <benoit@android.com>, Android Kernel Team <kernel-team@android.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zoran Markovic <zoran.markovic@linaro.org>

Hi Rafael,
Just wondering if you would like anything changed in this patch in
order to get it into 3.13. I'd prefer not missing yet another merge
window...
Thanks,
Zoran

On 25 September 2013 15:31, Zoran Markovic <zoran.markovic@linaro.org> wrote:
> From: Benoit Goby <benoit@android.com>
>
> Rather than hard-lock the kernel, dump the suspend/resume thread stack and
> panic() to capture a message in pstore when a driver takes too long to
> suspend/resume. Default suspend/resume watchdog timeout is set to 12
> seconds to be longer than the usbhid 10 second timeout, but could be
> changed at compile time.
>
> Exclude from the watchdog the time spent waiting for children that
> are resumed asynchronously and time every device, whether or not they
> resumed synchronously.
>
> This patch is targeted for mobile devices where a suspend/resume lockup
> could cause a system reboot. Information about failing device can be
> retrieved in subsequent boot session by mounting pstore and inspecting
> the log. Laptops with EFI-enabled pstore could also benefit from
> this feature.
>
> The hardware watchdog timer is likely suspended during this time and
> couldn't be relied upon. The soft-lockup detector would eventually tell
> that tasks are not scheduled, but would provide little context as to why.
> The patch hence uses system timer and assumes it is still active while the
> devices are suspended/resumed.
>
> This feature can be enabled/disabled during kernel configuration.
>
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Todd Poynor <toddpoynor@google.com>
> Cc: San Mehat <san@google.com>
> Cc: Benoit Goby <benoit@android.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Original-author: San Mehat <san@google.com>
> Signed-off-by: Benoit Goby <benoit@android.com>
> [zoran.markovic@linaro.org: Changed printk(KERN_EMERG,...) to pr_emerg(...),
> tweaked commit message. Moved call to dpm_wd_set() before device_lock() in
> device_resume(). Minor changes to add compile-time inclusion of the feature.]
> Signed-off-by: Zoran Markovic <zoran.markovic@linaro.org>
> ---
>  drivers/base/power/main.c |   68 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/Kconfig      |   16 +++++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 9f098a8..9b7e6b6 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -30,6 +30,8 @@
>  #include <linux/suspend.h>
>  #include <trace/events/power.h>
>  #include <linux/cpuidle.h>
> +#include <linux/timer.h>
> +
>  #include "../base.h"
>  #include "power.h"
>
> @@ -55,6 +57,12 @@ struct suspend_stats suspend_stats;
>  static DEFINE_MUTEX(dpm_list_mtx);
>  static pm_message_t pm_transition;
>
> +struct dpm_watchdog {
> +       struct device           *dev;
> +       struct task_struct      *tsk;
> +       struct timer_list       timer;
> +};
> +
>  static int async_error;
>
>  static char *pm_verb(int event)
> @@ -390,6 +398,60 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>         return error;
>  }
>
> +#ifdef CONFIG_DPM_WD
> +/**
> + * dpm_wd_handler - Driver suspend / resume watchdog handler.
> + *
> + * Called when a driver has timed out suspending or resuming.
> + * There's not much we can do here to recover so panic() to
> + * capture a crash-dump in pstore.
> + */
> +static void dpm_wd_handler(unsigned long data)
> +{
> +       struct dpm_watchdog *wd = (void *)data;
> +
> +       dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> +       show_stack(wd->tsk, NULL);
> +       panic("%s %s: unrecoverable failure\n",
> +               dev_driver_string(wd->dev), dev_name(wd->dev));
> +}
> +
> +/**
> + * dpm_wd_set - Enable pm watchdog for given device.
> + * @wd: Watchdog. Must be allocated on the stack.
> + * @dev: Device to handle.
> + */
> +static void dpm_wd_set(struct dpm_watchdog *wd, struct device *dev)
> +{
> +       struct timer_list *timer = &wd->timer;
> +
> +       wd->dev = dev;
> +       wd->tsk = get_current();
> +
> +       init_timer_on_stack(timer);
> +       /* use same timeout value for both suspend and resume */
> +       timer->expires = jiffies + HZ * CONFIG_DPM_WD_TIMEOUT;
> +       timer->function = dpm_wd_handler;
> +       timer->data = (unsigned long)wd;
> +       add_timer(timer);
> +}
> +
> +/**
> + * dpm_wd_clear - Disable suspend/resume watchdog.
> + * @wd: Watchdog to disable.
> + */
> +static void dpm_wd_clear(struct dpm_watchdog *wd)
> +{
> +       struct timer_list *timer = &wd->timer;
> +
> +       del_timer_sync(timer);
> +       destroy_timer_on_stack(timer);
> +}
> +#else
> +#define dpm_wd_set(x, y)
> +#define dpm_wd_clear(x)
> +#endif
> +
>  /*------------------------- Resume routines -------------------------*/
>
>  /**
> @@ -576,6 +638,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>         pm_callback_t callback = NULL;
>         char *info = NULL;
>         int error = 0;
> +       struct dpm_watchdog wd;
>
>         TRACE_DEVICE(dev);
>         TRACE_RESUME(0);
> @@ -584,6 +647,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>                 goto Complete;
>
>         dpm_wait(dev->parent, async);
> +       dpm_wd_set(&wd, dev);
>         device_lock(dev);
>
>         /*
> @@ -642,6 +706,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
>
>   Unlock:
>         device_unlock(dev);
> +       dpm_wd_clear(&wd);
>
>   Complete:
>         complete_all(&dev->power.completion);
> @@ -1060,6 +1125,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>         pm_callback_t callback = NULL;
>         char *info = NULL;
>         int error = 0;
> +       struct dpm_watchdog wd;
>
>         dpm_wait_for_children(dev, async);
>
> @@ -1083,6 +1149,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>         if (dev->power.syscore)
>                 goto Complete;
>
> +       dpm_wd_set(&wd, dev);
>         device_lock(dev);
>
>         if (dev->pm_domain) {
> @@ -1139,6 +1206,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>         }
>
>         device_unlock(dev);
> +       dpm_wd_clear(&wd);
>
>   Complete:
>         complete_all(&dev->power.completion);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index d444c4e..6a6b763 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -178,6 +178,22 @@ config PM_SLEEP_DEBUG
>         def_bool y
>         depends on PM_DEBUG && PM_SLEEP
>
> +config DPM_WD
> +       bool "Device suspend/resume watchdog"
> +       depends on PM_DEBUG && PSTORE
> +       ---help---
> +         Sets up a watchdog timer to capture drivers that are
> +         locked up attempting to suspend/resume a device.
> +         A detected lockup causes system panic with message
> +         captured in pstore device for inspection in subsequent
> +         boot session.
> +
> +config DPM_WD_TIMEOUT
> +       int "Watchdog timeout in seconds"
> +       range 1 120
> +       default 12
> +       depends on DPM_WD
> +
>  config PM_TRACE
>         bool
>         help
> --
> 1.7.9.5
>
