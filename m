From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] kernel/hung_task.c: disable on suspend
Date: Thu, 18 Oct 2018 09:32:42 +0200
Message-ID: <CAJZ5v0iJmn4x+zqNhQ4zfYCucnZhYb2hK3o096xPX6Ju2zV2oQ@mail.gmail.com>
References: <20181017112355.12763-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017112355.12763-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 17, 2018 at 1:24 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It is possible to observe hung_task complaints when system goes to
> suspend-to-idle state:
>
>  # echo freeze > /sys/power/state
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

Thanks for your patience with this!

Are there any objections or concerns regarding this patch?

> ---
> Changes since v3:
> - Handle PM_RESTORE_PREPARE/PM_POST_RESTORE for completeness
>   [Rafael J. Wysocki]
> ---
>  kernel/hung_task.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b9132d1269ef..cb8e3e8ac7b9 100644
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
> @@ -242,6 +243,28 @@ void reset_hung_task_detector(void)
>  }
>  EXPORT_SYMBOL_GPL(reset_hung_task_detector);
>
> +static bool hung_detector_suspended;
> +
> +static int hungtask_pm_notify(struct notifier_block *self,
> +                             unsigned long action, void *hcpu)
> +{
> +       switch (action) {
> +       case PM_SUSPEND_PREPARE:
> +       case PM_HIBERNATION_PREPARE:
> +       case PM_RESTORE_PREPARE:
> +               hung_detector_suspended = true;
> +               break;
> +       case PM_POST_SUSPEND:
> +       case PM_POST_HIBERNATION:
> +       case PM_POST_RESTORE:
> +               hung_detector_suspended = false;
> +               break;
> +       default:
> +               break;
> +       }
> +       return NOTIFY_OK;
> +}
> +
>  /*
>   * kthread which checks for tasks stuck in D state
>   */
> @@ -261,7 +284,8 @@ static int watchdog(void *dummy)
>                 interval = min_t(unsigned long, interval, timeout);
>                 t = hung_timeout_jiffies(hung_last_checked, interval);
>                 if (t <= 0) {
> -                       if (!atomic_xchg(&reset_hung_task, 0))
> +                       if (!atomic_xchg(&reset_hung_task, 0) &&
> +                           !hung_detector_suspended)
>                                 check_hung_uninterruptible_tasks(timeout);
>                         hung_last_checked = jiffies;
>                         continue;
> @@ -275,6 +299,10 @@ static int watchdog(void *dummy)
>  static int __init hung_task_init(void)
>  {
>         atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +
> +       /* Disable hung task detector on suspend */
> +       pm_notifier(hungtask_pm_notify, 0);
> +
>         watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
>
>         return 0;
> --
> 2.17.1
>
