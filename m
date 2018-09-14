From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Fri, 14 Sep 2018 13:26:13 +0200
Message-ID: <4793718.OcKebjM5bH@aspire.rjw.lan>
References: <20180913160851.18169-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913160851.18169-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
> It is possible to observe hung_task complaints when system goes to
> suspend-to-idle state:
> 
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>  sd 0:0:0:0: [sda] Synchronizing SCSI cache
>  INFO: task bash:1569 blocked for more than 120 seconds.
>        Not tainted 4.19.0-rc3_+ #687
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  bash            D    0  1569    604 0x00000000
>  Call Trace:
>   ? __schedule+0x1fe/0x7e0
>   schedule+0x28/0x80
>   suspend_devices_and_enter+0x4ac/0x750
>   pm_suspend+0x2c0/0x310
> 
> Register a PM notifier to disable the detector on suspend and re-enable
> back on wakeup.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since RFC:
> - Add PM_HIBERNATION_PREPARE/PM_POST_HIBERNATION for consistency
>   [Rafael J. Wysocki]
> ---
>  kernel/hung_task.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b9132d1269ef..41955c5d8427 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -15,6 +15,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/export.h>
>  #include <linux/sysctl.h>
> +#include <linux/suspend.h>
>  #include <linux/utsname.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> @@ -242,6 +243,26 @@ void reset_hung_task_detector(void)
>  }
>  EXPORT_SYMBOL_GPL(reset_hung_task_detector);
>  
> +static bool hung_detector_suspended;
> +
> +static int hungtask_pm_notify(struct notifier_block *self,
> +			      unsigned long action, void *hcpu)
> +{
> +	switch (action) {
> +	case PM_SUSPEND_PREPARE:
> +	case PM_HIBERNATION_PREPARE:
> +		hung_detector_suspended = true;
> +		break;
> +	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +		hung_detector_suspended = false;
> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
>  /*
>   * kthread which checks for tasks stuck in D state
>   */
> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
>  		interval = min_t(unsigned long, interval, timeout);
>  		t = hung_timeout_jiffies(hung_last_checked, interval);

Since you are adding the notifier anyway, what about designing it to make
the thread wait on _PREPARE until the notifier kicks it again on exit
fron suspend/hibernation?

>  		if (t <= 0) {
> -			if (!atomic_xchg(&reset_hung_task, 0))
> +			if (!atomic_xchg(&reset_hung_task, 0) &&
> +			    !hung_detector_suspended)
>  				check_hung_uninterruptible_tasks(timeout);
>  			hung_last_checked = jiffies;
>  			continue;
> @@ -275,6 +297,10 @@ static int watchdog(void *dummy)
>  static int __init hung_task_init(void)
>  {
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +
> +	/* Disable hung task detector on suspend */
> +	pm_notifier(hungtask_pm_notify, 0);
> +
>  	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
>  
>  	return 0;
> 
