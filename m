From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 06/13] PM: Implement early suspend api
Date: Thu, 5 Feb 2009 16:18:38 -0800
Message-ID: <20090206001838.GD19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-7-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 04, 2009 at 06:50:19PM -0800, Arve Hj=F8nnev=E5g wrote:
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  kernel/power/Kconfig        |   12 +++
>  kernel/power/Makefile       |    1 +
>  kernel/power/earlysuspend.c |  178 +++++++++++++++++++++++++++++++++++++=
++++++
>  kernel/power/power.h        |    6 ++
>  4 files changed, 197 insertions(+), 0 deletions(-)
>  create mode 100644 kernel/power/earlysuspend.c
> =

> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index dd76467..689abfe 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -119,6 +119,9 @@ config SUSPEND_FREEZER
>  config HAS_WAKELOCK
>  	bool
>  =

> +config HAS_EARLYSUSPEND
> +	bool
> +
>  config WAKELOCK
>  	bool "Wake lock"
>  	depends on PM && RTC_CLASS
> @@ -144,6 +147,15 @@ config DISABLE_SYS_POWER_STATE
>  	  want to run user-space code that does not support wakelocks, do not
>  	  enable this option since it removes the interface.
>  =

> +config EARLYSUSPEND
> +	bool "Early suspend"
> +	depends on WAKELOCK
> +	default y
> +	select HAS_EARLYSUSPEND
> +	---help---
> +	  Call early suspend handlers when the user requested sleep state
> +	  changes.
> +
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 8d8672b..2f17e1d 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -7,6 +7,7 @@ obj-y				:=3D main.o
>  obj-$(CONFIG_PM_SLEEP)		+=3D console.o
>  obj-$(CONFIG_FREEZER)		+=3D process.o
>  obj-$(CONFIG_WAKELOCK)		+=3D wakelock.o
> +obj-$(CONFIG_EARLYSUSPEND)	+=3D earlysuspend.o
>  obj-$(CONFIG_HIBERNATION)	+=3D swsusp.o disk.o snapshot.o swap.o user.o
>  =

>  obj-$(CONFIG_MAGIC_SYSRQ)	+=3D poweroff.o
> diff --git a/kernel/power/earlysuspend.c b/kernel/power/earlysuspend.c
> new file mode 100644
> index 0000000..4d70a7e
> --- /dev/null
> +++ b/kernel/power/earlysuspend.c
> @@ -0,0 +1,178 @@
> +/* kernel/power/earlysuspend.c
> + *
> + * Copyright (C) 2005-2008 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/earlysuspend.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rtc.h>
> +#include <linux/syscalls.h> /* sys_sync */
> +#include <linux/wakelock.h>
> +#include <linux/workqueue.h>
> +
> +#include "power.h"
> +
> +enum {
> +	DEBUG_USER_STATE =3D 1U << 0,
> +	DEBUG_SUSPEND =3D 1U << 1,
> +};
> +static int debug_mask =3D DEBUG_USER_STATE;
> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_IW=
GRP);
> +
> +static DEFINE_MUTEX(early_suspend_lock);
> +static LIST_HEAD(early_suspend_handlers);
> +static void early_suspend(struct work_struct *work);
> +static void late_resume(struct work_struct *work);
> +static DECLARE_WORK(early_suspend_work, early_suspend);
> +static DECLARE_WORK(late_resume_work, late_resume);
> +static DEFINE_SPINLOCK(state_lock);
> +enum {
> +	SUSPEND_REQUESTED =3D 0x1,
> +	SUSPENDED =3D 0x2,
> +	SUSPEND_REQUESTED_AND_SUSPENDED =3D SUSPEND_REQUESTED | SUSPENDED,
> +};
> +static int state;
> +
> +void register_early_suspend(struct early_suspend *handler)
> +{
> +	struct list_head *pos;
> +
> +	mutex_lock(&early_suspend_lock);
> +	list_for_each(pos, &early_suspend_handlers) {
> +		struct early_suspend *e;
> +		e =3D list_entry(pos, struct early_suspend, link);
> +		if (e->level > handler->level)
> +			break;
> +	}
> +	list_add_tail(&handler->link, pos);
> +	if ((state & SUSPENDED) && handler->suspend)
> +		handler->suspend(handler);
> +	mutex_unlock(&early_suspend_lock);
> +}
> +EXPORT_SYMBOL(register_early_suspend);
> +
> +void unregister_early_suspend(struct early_suspend *handler)
> +{
> +	mutex_lock(&early_suspend_lock);
> +	list_del(&handler->link);
> +	mutex_unlock(&early_suspend_lock);
> +}
> +EXPORT_SYMBOL(unregister_early_suspend);
> +
> +static void early_suspend(struct work_struct *work)
> +{
> +	struct early_suspend *pos;
> +	unsigned long irqflags;
> +	int abort =3D 0;
> +
> +	mutex_lock(&early_suspend_lock);
> +	spin_lock_irqsave(&state_lock, irqflags);
> +	if (state =3D=3D SUSPEND_REQUESTED)
> +		state |=3D SUSPENDED;
> +	else
> +		abort =3D 1;
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +
> +	if (abort) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("early_suspend: abort, state %d\n", state);
> +		mutex_unlock(&early_suspend_lock);
> +		goto abort;
> +	}
> +
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("early_suspend: call handlers\n");
> +	list_for_each_entry(pos, &early_suspend_handlers, link) {
> +		if (pos->suspend)
> +			pos->suspend(pos);
> +	}
> +	mutex_unlock(&early_suspend_lock);
> +
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("early_suspend: sync\n");
> +
> +	sys_sync();

couldn't this trigger GC if you are running something like JFFS2 and
have an indeterminant execution time?  =


tough call.  predictable suspend times or gard against FS corruption.

> +abort:
> +	spin_lock_irqsave(&state_lock, irqflags);
> +	if (state =3D=3D SUSPEND_REQUESTED_AND_SUSPENDED)
> +		wake_unlock(&main_wake_lock);
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +}
> +
> +static void late_resume(struct work_struct *work)
> +{
> +	struct early_suspend *pos;
> +	unsigned long irqflags;
> +	int abort =3D 0;
> +
> +	mutex_lock(&early_suspend_lock);
> +	spin_lock_irqsave(&state_lock, irqflags);
> +	if (state =3D=3D SUSPENDED)
> +		state =3D 0; /* clear SUSPENDED */
> +	else
> +		abort =3D 1;
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +
> +	if (abort) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("late_resume: abort, state %d\n", state);
> +		goto abort;
> +	}
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("late_resume: call handlers\n");
> +	list_for_each_entry_reverse(pos, &early_suspend_handlers, link)
> +		if (pos->resume)
> +			pos->resume(pos);
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("late_resume: done\n");
> +abort:
> +	mutex_unlock(&early_suspend_lock);
> +}
> +
> +void request_suspend_state(suspend_state_t new_state)
> +{
> +	unsigned long irqflags;
> +	int old_sleep;
> +
> +	spin_lock_irqsave(&state_lock, irqflags);
> +	old_sleep =3D state & SUSPEND_REQUESTED;
> +	if (debug_mask & DEBUG_USER_STATE) {
> +		struct timespec ts;
> +		struct rtc_time tm;
> +		getnstimeofday(&ts);
> +		rtc_time_to_tm(ts.tv_sec, &tm);
> +		pr_info("request_suspend_state: %s (%d->%d) at %lld "
> +			"(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n",
> +			new_state !=3D PM_SUSPEND_ON ? "sleep" : "wakeup",
> +			requested_suspend_state, new_state,
> +			ktime_to_ns(ktime_get()),
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +	}
> +	if (!old_sleep && new_state !=3D PM_SUSPEND_ON) {
> +		state |=3D SUSPEND_REQUESTED;
> +		queue_work(suspend_work_queue, &early_suspend_work);
> +	} else if (old_sleep && new_state =3D=3D PM_SUSPEND_ON) {
> +		state &=3D ~SUSPEND_REQUESTED;
> +		wake_lock(&main_wake_lock);
> +		queue_work(suspend_work_queue, &late_resume_work);
> +	}
> +	requested_suspend_state =3D new_state;
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +}
> +
> +suspend_state_t get_suspend_state(void)
> +{
> +	return requested_suspend_state;
> +}
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index ed1b7f4..acbb13a 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -231,3 +231,9 @@ extern struct wake_lock main_wake_lock;
>  extern suspend_state_t requested_suspend_state;
>  extern bool ignore_suspend_wakelocks;
>  #endif
> +
> +#ifdef CONFIG_EARLYSUSPEND
> +/* kernel/power/earlysuspend.c */
> +void request_suspend_state(suspend_state_t state);
> +suspend_state_t get_suspend_state(void);
> +#endif
> -- =

> 1.6.1
> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
