From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Thu, 5 Feb 2009 16:10:20 -0800
Message-ID: <20090206001020.GC19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-4-git-send-email-arve@android.com>
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

On Wed, Feb 04, 2009 at 06:50:16PM -0800, Arve Hj=F8nnev=E5g wrote:
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  kernel/power/Kconfig    |   19 ++
>  kernel/power/Makefile   |    1 +
>  kernel/power/power.h    |    7 +
>  kernel/power/wakelock.c |  598 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 625 insertions(+), 0 deletions(-)
>  create mode 100644 kernel/power/wakelock.c
> =

> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 23bd4da..6e3da6e 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,25 @@ config SUSPEND_FREEZER
>  =

>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  =

> +config HAS_WAKELOCK
> +	bool
> +
> +config WAKELOCK
> +	bool "Wake lock"
> +	depends on PM && RTC_CLASS
> +	default n
> +	select HAS_WAKELOCK
> +	---help---
> +	  Enable wakelocks. When user space request a sleep state the
> +	  sleep request will be delayed until no wake locks are held.
> +
> +config WAKELOCK_STAT
> +	bool "Wake lock stats"
> +	depends on WAKELOCK
> +	default y
> +	---help---
> +	  Report wake lock stats in /proc/wakelocks
> +
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index d7a1016..8d8672b 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -6,6 +6,7 @@ endif
>  obj-y				:=3D main.o
>  obj-$(CONFIG_PM_SLEEP)		+=3D console.o
>  obj-$(CONFIG_FREEZER)		+=3D process.o
> +obj-$(CONFIG_WAKELOCK)		+=3D wakelock.o
>  obj-$(CONFIG_HIBERNATION)	+=3D swsusp.o disk.o snapshot.o swap.o user.o
>  =

>  obj-$(CONFIG_MAGIC_SYSRQ)	+=3D poweroff.o
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 46b5ec7..1527174 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -223,3 +223,10 @@ static inline void suspend_thaw_processes(void)
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_WAKELOCK
> +/* kernel/power/wakelock.c */
> +extern struct workqueue_struct *suspend_work_queue;
> +extern struct wake_lock main_wake_lock;
> +extern suspend_state_t requested_suspend_state;
> +#endif
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> new file mode 100644
> index 0000000..c9e22f9
> --- /dev/null
> +++ b/kernel/power/wakelock.c
> @@ -0,0 +1,598 @@
> +/* kernel/power/wakelock.c
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
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/suspend.h>
> +#include <linux/syscalls.h> /* sys_sync */
> +#include <linux/wakelock.h>
> +#ifdef CONFIG_WAKELOCK_STAT
> +#include <linux/proc_fs.h>
> +#endif
> +#include "power.h"
> +
> +enum {
> +	DEBUG_EXIT_SUSPEND =3D 1U << 0,
> +	DEBUG_WAKEUP =3D 1U << 1,
> +	DEBUG_SUSPEND =3D 1U << 2,
> +	DEBUG_EXPIRE =3D 1U << 3,
> +	DEBUG_WAKE_LOCK =3D 1U << 4,
> +};
> +static int debug_mask =3D DEBUG_EXIT_SUSPEND | DEBUG_WAKEUP;
> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_IW=
GRP);
> +
> +#define WAKE_LOCK_TYPE_MASK              (0x0f)
> +#define WAKE_LOCK_INITIALIZED            (1U << 8)
> +#define WAKE_LOCK_ACTIVE                 (1U << 9)
> +#define WAKE_LOCK_AUTO_EXPIRE            (1U << 10)
> +#define WAKE_LOCK_PREVENTING_SUSPEND     (1U << 11)
> +
> +static DEFINE_SPINLOCK(list_lock);
> +static LIST_HEAD(inactive_locks);
> +static struct list_head active_wake_locks[WAKE_LOCK_TYPE_COUNT];
> +static int current_event_num;
> +struct workqueue_struct *suspend_work_queue;
> +struct wake_lock main_wake_lock;
> +suspend_state_t requested_suspend_state =3D PM_SUSPEND_MEM;
> +static struct wake_lock unknown_wakeup;
> +
> +#ifdef CONFIG_WAKELOCK_STAT
> +static struct wake_lock deleted_wake_locks;
> +static ktime_t last_sleep_time_update;
> +static int wait_for_wakeup;
> +
> +int get_expired_time(struct wake_lock *lock, ktime_t *expire_time)
> +{
> +	struct timespec ts;
> +	struct timespec kt;
> +	struct timespec tomono;
> +	struct timespec delta;
> +	unsigned long seq;
> +	long timeout;
> +
> +	if (!(lock->flags & WAKE_LOCK_AUTO_EXPIRE))
> +		return 0;
> +	do {
> +		seq =3D read_seqbegin(&xtime_lock);
> +		timeout =3D lock->expires - jiffies;
> +		if (timeout > 0)
> +			return 0;
> +		kt =3D current_kernel_time();
> +		tomono =3D wall_to_monotonic;
> +	} while (read_seqretry(&xtime_lock, seq));
> +	jiffies_to_timespec(-timeout, &delta);
> +	set_normalized_timespec(&ts, kt.tv_sec + tomono.tv_sec - delta.tv_sec,
> +				kt.tv_nsec + tomono.tv_nsec - delta.tv_nsec);
> +	*expire_time =3D timespec_to_ktime(ts);
> +	return 1;
> +}
> +
> +
> +static int print_lock_stat(char *buf, struct wake_lock *lock)
> +{
> +	int lock_count =3D lock->stat.count;
> +	int expire_count =3D lock->stat.expire_count;
> +	ktime_t active_time =3D ktime_set(0, 0);
> +	ktime_t total_time =3D lock->stat.total_time;
> +	ktime_t max_time =3D lock->stat.max_time;
> +	ktime_t prevent_suspend_time =3D lock->stat.prevent_suspend_time;
> +	if (lock->flags & WAKE_LOCK_ACTIVE) {
> +		ktime_t now, add_time;
> +		int expired =3D get_expired_time(lock, &now);
> +		if (!expired)
> +			now =3D ktime_get();
> +		add_time =3D ktime_sub(now, lock->stat.last_time);
> +		lock_count++;
> +		if (!expired)
> +			active_time =3D add_time;
> +		else
> +			expire_count++;
> +		total_time =3D ktime_add(total_time, add_time);
> +		if (lock->flags & WAKE_LOCK_PREVENTING_SUSPEND)
> +			prevent_suspend_time =3D ktime_add(prevent_suspend_time,
> +					ktime_sub(now, last_sleep_time_update));
> +		if (add_time.tv64 > max_time.tv64)
> +			max_time =3D add_time;
> +	}
> +
> +	return sprintf(buf, "\"%s\"\t%d\t%d\t%d\t%lld\t%lld\t%lld\t%lld\t"
> +		       "%lld\n", lock->name, lock_count, expire_count,
> +		       lock->stat.wakeup_count, ktime_to_ns(active_time),
> +		       ktime_to_ns(total_time),
> +		       ktime_to_ns(prevent_suspend_time), ktime_to_ns(max_time),
> +		       ktime_to_ns(lock->stat.last_time));
> +}
> +
> +
> +static int wakelocks_read_proc(char *page, char **start, off_t off,
> +			       int count, int *eof, void *data)
> +{
> +	unsigned long irqflags;
> +	struct wake_lock *lock;
> +	int len =3D 0;
> +	char *p =3D page;
> +	int type;
> +
> +	spin_lock_irqsave(&list_lock, irqflags);
> +
> +	p +=3D sprintf(p, "name\tcount\texpire_count\twake_count\tactive_since"
> +		     "\ttotal_time\tsleep_time\tmax_time\tlast_change\n");
> +	list_for_each_entry(lock, &inactive_locks, link) {
> +		p +=3D print_lock_stat(p, lock);
> +	}
> +	for (type =3D 0; type < WAKE_LOCK_TYPE_COUNT; type++) {
> +		list_for_each_entry(lock, &active_wake_locks[type], link)
> +			p +=3D print_lock_stat(p, lock);
> +	}
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +
> +	*start =3D page + off;
> +
> +	len =3D p - page;
> +	if (len > off)
> +		len -=3D off;
> +	else
> +		len =3D 0;
> +
> +	return len < count ? len  : count;
> +}
> +
> +static void wake_unlock_stat_locked(struct wake_lock *lock, int expired)
> +{
> +	ktime_t duration;
> +	ktime_t now;
> +	if (!(lock->flags & WAKE_LOCK_ACTIVE))
> +		return;
> +	if (get_expired_time(lock, &now))
> +		expired =3D 1;
> +	else
> +		now =3D ktime_get();
> +	lock->stat.count++;
> +	if (expired)
> +		lock->stat.expire_count++;
> +	duration =3D ktime_sub(now, lock->stat.last_time);
> +	lock->stat.total_time =3D ktime_add(lock->stat.total_time, duration);
> +	if (ktime_to_ns(duration) > ktime_to_ns(lock->stat.max_time))
> +		lock->stat.max_time =3D duration;
> +	lock->stat.last_time =3D ktime_get();
> +	if (lock->flags & WAKE_LOCK_PREVENTING_SUSPEND) {
> +		duration =3D ktime_sub(now, last_sleep_time_update);
> +		lock->stat.prevent_suspend_time =3D ktime_add(
> +			lock->stat.prevent_suspend_time, duration);
> +		lock->flags &=3D ~WAKE_LOCK_PREVENTING_SUSPEND;
> +	}
> +}
> +
> +static void update_sleep_wait_stats_locked(int done)
> +{
> +	struct wake_lock *lock;
> +	ktime_t now, etime, elapsed, add;
> +	int expired;
> +
> +	now =3D ktime_get();
> +	elapsed =3D ktime_sub(now, last_sleep_time_update);
> +	list_for_each_entry(lock, &active_wake_locks[WAKE_LOCK_SUSPEND], link) {

Is this list opperation SMP safe?  what if some on on the other CPU
removes a lock form user mode while walking this guy?  this goes for all
your list walking.

> +		expired =3D get_expired_time(lock, &etime);
> +		if (lock->flags & WAKE_LOCK_PREVENTING_SUSPEND) {
> +			if (expired)
> +				add =3D ktime_sub(etime, last_sleep_time_update);
> +			else
> +				add =3D elapsed;
> +			lock->stat.prevent_suspend_time =3D ktime_add(
> +				lock->stat.prevent_suspend_time, add);
> +		}
> +		if (done || expired)
> +			lock->flags &=3D ~WAKE_LOCK_PREVENTING_SUSPEND;
> +		else
> +			lock->flags |=3D WAKE_LOCK_PREVENTING_SUSPEND;
> +	}
> +	last_sleep_time_update =3D now;
> +}
> +#endif
> +
> +
> +static void expire_wake_lock(struct wake_lock *lock)
> +{
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wake_unlock_stat_locked(lock, 1);
> +#endif
> +	lock->flags &=3D ~(WAKE_LOCK_ACTIVE | WAKE_LOCK_AUTO_EXPIRE);
> +	list_del(&lock->link);
> +	list_add(&lock->link, &inactive_locks);
> +	if (debug_mask & (DEBUG_WAKE_LOCK | DEBUG_EXPIRE))
> +		pr_info("expired wake lock %s\n", lock->name);
> +}

Are we missing locking for this list opperation?

> +
> +static void print_active_locks(int type)
> +{
> +	unsigned long irqflags;
> +	struct wake_lock *lock;
> +
> +	BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	list_for_each_entry(lock, &active_wake_locks[type], link) {
> +		if (lock->flags & WAKE_LOCK_AUTO_EXPIRE) {
> +			long timeout =3D lock->expires - jiffies;
> +			if (timeout <=3D 0)
> +				pr_info("wake lock %s, expired\n", lock->name);
> +			else
> +				pr_info("active wake lock %s, time left %ld\n",
> +					lock->name, timeout);
> +		} else
> +			pr_info("active wake lock %s\n", lock->name);
> +	}
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +
> +static long has_wake_lock_locked(int type)
> +{
> +	struct wake_lock *lock, *n;
> +	long max_timeout =3D 0;
> +
> +	BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
> +	list_for_each_entry_safe(lock, n, &active_wake_locks[type], link) {
> +		if (lock->flags & WAKE_LOCK_AUTO_EXPIRE) {
> +			long timeout =3D lock->expires - jiffies;
> +			if (timeout <=3D 0)
> +				expire_wake_lock(lock);
> +			else if (timeout > max_timeout)
> +				max_timeout =3D timeout;
> +		} else
> +			return -1;
> +	}
> +	return max_timeout;
> +}
> +
> +long has_wake_lock(int type)
> +{
> +	long ret;
> +	unsigned long irqflags;
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	ret =3D has_wake_lock_locked(type);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +	return ret;
> +}
> +
> +static void suspend(struct work_struct *work)

there are a lot of "suspend" functions in the kernel already that have
different calling semantics, can we change this name so my TAG file is
more sane?

> +{
> +	int ret;
> +	int entry_event_num;
> +
> +	if (has_wake_lock(WAKE_LOCK_SUSPEND)) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("suspend: abort suspend\n");
> +		return;
> +	}
> +
> +	entry_event_num =3D current_event_num;
> +	sys_sync();

um, this feel wrong to me.

> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("suspend: enter suspend\n");
> +	ret =3D pm_suspend(requested_suspend_state);

oh, you are adding yet another path to getting the system into a
suspended state.  is this necessary?

> +	if (debug_mask & DEBUG_EXIT_SUSPEND) {
> +		struct timespec ts;
> +		struct rtc_time tm;
> +		getnstimeofday(&ts);
> +		rtc_time_to_tm(ts.tv_sec, &tm);
> +		pr_info("suspend: exit suspend, ret =3D %d "
> +			"(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n", ret,
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +	}
> +	if (current_event_num =3D=3D entry_event_num) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("suspend: pm_suspend returned with no event\n");
> +		wake_lock_timeout(&unknown_wakeup, HZ / 2);
> +	}
> +}
> +static DECLARE_WORK(suspend_work, suspend);
> +
> +static void expire_wake_locks(unsigned long data)
> +{
> +	long has_lock;
> +	unsigned long irqflags;
> +	if (debug_mask & DEBUG_EXPIRE)
> +		pr_info("expire_wake_locks: start\n");
> +	if (debug_mask & DEBUG_SUSPEND)
> +		print_active_locks(WAKE_LOCK_SUSPEND);
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	has_lock =3D has_wake_lock_locked(WAKE_LOCK_SUSPEND);
> +	if (debug_mask & DEBUG_EXPIRE)
> +		pr_info("expire_wake_locks: done, has_lock %ld\n", has_lock);
> +	if (has_lock =3D=3D 0)
> +		queue_work(suspend_work_queue, &suspend_work);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +static DEFINE_TIMER(expire_timer, expire_wake_locks, 0, 0);
> +
> +static int power_suspend_late(struct platform_device *pdev, pm_message_t=
 state)
> +{
> +	int ret =3D has_wake_lock(WAKE_LOCK_SUSPEND) ? -EAGAIN : 0;
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wait_for_wakeup =3D 1;
> +#endif
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("power_suspend_late return %d\n", ret);
> +	return ret;
> +}
> +
> +static struct platform_driver power_driver =3D {
> +	.driver.name =3D "power",
> +	.suspend_late =3D power_suspend_late,
> +};
> +static struct platform_device power_device =3D {
> +	.name =3D "power",
> +};
> +
> +void wake_lock_init(struct wake_lock *lock, int type, const char *name)
> +{
> +	unsigned long irqflags =3D 0;
> +
> +	if (name)
> +		lock->name =3D name;
> +	BUG_ON(!lock->name);
> +
> +	if (debug_mask & DEBUG_WAKE_LOCK)
> +		pr_info("wake_lock_init name=3D%s\n", lock->name);
> +#ifdef CONFIG_WAKELOCK_STAT
> +	lock->stat.count =3D 0;
> +	lock->stat.expire_count =3D 0;
> +	lock->stat.wakeup_count =3D 0;
> +	lock->stat.total_time =3D ktime_set(0, 0);
> +	lock->stat.prevent_suspend_time =3D ktime_set(0, 0);
> +	lock->stat.max_time =3D ktime_set(0, 0);
> +	lock->stat.last_time =3D ktime_set(0, 0);
> +#endif
> +	lock->flags =3D (type & WAKE_LOCK_TYPE_MASK) | WAKE_LOCK_INITIALIZED;
> +
> +	INIT_LIST_HEAD(&lock->link);
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	list_add(&lock->link, &inactive_locks);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_lock_init);
> +
> +void wake_lock_destroy(struct wake_lock *lock)
> +{
> +	unsigned long irqflags;
> +	if (debug_mask & DEBUG_WAKE_LOCK)
> +		pr_info("wake_lock_destroy name=3D%s\n", lock->name);
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	lock->flags &=3D ~WAKE_LOCK_INITIALIZED;
> +#ifdef CONFIG_WAKELOCK_STAT
> +	if (lock->stat.count) {
> +		deleted_wake_locks.stat.count +=3D lock->stat.count;
> +		deleted_wake_locks.stat.expire_count +=3D lock->stat.expire_count;
> +		deleted_wake_locks.stat.total_time =3D
> +			ktime_add(deleted_wake_locks.stat.total_time,
> +				  lock->stat.total_time);
> +		deleted_wake_locks.stat.prevent_suspend_time =3D
> +			ktime_add(deleted_wake_locks.stat.prevent_suspend_time,
> +				  lock->stat.prevent_suspend_time);
> +		deleted_wake_locks.stat.max_time =3D
> +			ktime_add(deleted_wake_locks.stat.max_time,
> +				  lock->stat.max_time);
> +	}
> +#endif
> +	list_del(&lock->link);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_lock_destroy);
> +
> +static void wake_lock_internal(
> +	struct wake_lock *lock, long timeout, int has_timeout)
> +{
> +	int type;
> +	unsigned long irqflags;
> +	long expire_in;
> +
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
> +	BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
> +	BUG_ON(!(lock->flags & WAKE_LOCK_INITIALIZED));
> +#ifdef CONFIG_WAKELOCK_STAT
> +	if (type =3D=3D WAKE_LOCK_SUSPEND && wait_for_wakeup) {
> +		if (debug_mask & DEBUG_WAKEUP)
> +			pr_info("wakeup wake lock: %s\n", lock->name);
> +		wait_for_wakeup =3D 0;
> +		lock->stat.wakeup_count++;
> +	}
> +	if ((lock->flags & WAKE_LOCK_AUTO_EXPIRE) &&
> +	    (long)(lock->expires - jiffies) <=3D 0) {
> +		wake_unlock_stat_locked(lock, 0);
> +		lock->stat.last_time =3D ktime_get();
> +	}
> +#endif
> +	if (!(lock->flags & WAKE_LOCK_ACTIVE)) {
> +		lock->flags |=3D WAKE_LOCK_ACTIVE;
> +#ifdef CONFIG_WAKELOCK_STAT
> +		lock->stat.last_time =3D ktime_get();
> +#endif
> +	}
> +	list_del(&lock->link);
> +	if (has_timeout) {
> +		if (debug_mask & DEBUG_WAKE_LOCK)
> +			pr_info("wake_lock: %s, type %d, timeout %ld.%03lu\n",
> +				lock->name, type, timeout / HZ,
> +				(timeout % HZ) * MSEC_PER_SEC / HZ);
> +		lock->expires =3D jiffies + timeout;
> +		lock->flags |=3D WAKE_LOCK_AUTO_EXPIRE;
> +		list_add_tail(&lock->link, &active_wake_locks[type]);
> +	} else {
> +		if (debug_mask & DEBUG_WAKE_LOCK)
> +			pr_info("wake_lock: %s, type %d\n", lock->name, type);
> +		lock->expires =3D LONG_MAX;
> +		lock->flags &=3D ~WAKE_LOCK_AUTO_EXPIRE;
> +		list_add(&lock->link, &active_wake_locks[type]);
> +	}
> +	if (type =3D=3D WAKE_LOCK_SUSPEND) {
> +		current_event_num++;
> +#ifdef CONFIG_WAKELOCK_STAT
> +		if (lock =3D=3D &main_wake_lock)
> +			update_sleep_wait_stats_locked(1);
> +		else if (!wake_lock_active(&main_wake_lock))
> +			update_sleep_wait_stats_locked(0);
> +#endif
> +		if (has_timeout)
> +			expire_in =3D has_wake_lock_locked(type);
> +		else
> +			expire_in =3D -1;
> +		if (expire_in > 0) {
> +			if (debug_mask & DEBUG_EXPIRE)
> +				pr_info("wake_lock: %s, start expire timer, "
> +					"%ld\n", lock->name, expire_in);
> +			mod_timer(&expire_timer, jiffies + expire_in);
> +		} else {
> +			if (del_timer(&expire_timer))
> +				if (debug_mask & DEBUG_EXPIRE)
> +					pr_info("wake_lock: %s, stop expire "
> +						"timer\n", lock->name);
> +			if (expire_in =3D=3D 0)
> +				queue_work(suspend_work_queue, &suspend_work);
> +		}
> +	}
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +
> +void wake_lock(struct wake_lock *lock)
> +{
> +	wake_lock_internal(lock, 0, 0);
> +}
> +EXPORT_SYMBOL(wake_lock);
> +
> +void wake_lock_timeout(struct wake_lock *lock, long timeout)
> +{
> +	wake_lock_internal(lock, timeout, 1);
> +}
> +EXPORT_SYMBOL(wake_lock_timeout);
> +
> +void wake_unlock(struct wake_lock *lock)
> +{
> +	int type;
> +	unsigned long irqflags;
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wake_unlock_stat_locked(lock, 0);
> +#endif
> +	if (debug_mask & DEBUG_WAKE_LOCK)
> +		pr_info("wake_unlock: %s\n", lock->name);
> +	lock->flags &=3D ~(WAKE_LOCK_ACTIVE | WAKE_LOCK_AUTO_EXPIRE);
> +	list_del(&lock->link);
> +	list_add(&lock->link, &inactive_locks);
> +	if (type =3D=3D WAKE_LOCK_SUSPEND) {
> +		long has_lock =3D has_wake_lock_locked(type);
> +		if (has_lock > 0) {
> +			if (debug_mask & DEBUG_EXPIRE)
> +				pr_info("wake_unlock: %s, start expire timer, "
> +					"%ld\n", lock->name, has_lock);
> +			mod_timer(&expire_timer, jiffies + has_lock);
> +		} else {
> +			if (del_timer(&expire_timer))
> +				if (debug_mask & DEBUG_EXPIRE)
> +					pr_info("wake_unlock: %s, stop expire "
> +						"timer\n", lock->name);
> +			if (has_lock =3D=3D 0)
> +				queue_work(suspend_work_queue, &suspend_work);
> +		}
> +		if (lock =3D=3D &main_wake_lock) {
> +			if (debug_mask & DEBUG_SUSPEND)
> +				print_active_locks(WAKE_LOCK_SUSPEND);
> +#ifdef CONFIG_WAKELOCK_STAT
> +			update_sleep_wait_stats_locked(0);
> +#endif
> +		}
> +	}
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_unlock);
> +
> +int wake_lock_active(struct wake_lock *lock)
> +{
> +	return !!(lock->flags & WAKE_LOCK_ACTIVE);
> +}
> +EXPORT_SYMBOL(wake_lock_active);
> +
> +static int __init wakelocks_init(void)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(active_wake_locks); i++)
> +		INIT_LIST_HEAD(&active_wake_locks[i]);
> +
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wake_lock_init(&deleted_wake_locks, WAKE_LOCK_SUSPEND,
> +			"deleted_wake_locks");
> +#endif
> +	wake_lock_init(&main_wake_lock, WAKE_LOCK_SUSPEND, "main");
> +	wake_lock(&main_wake_lock);
> +	wake_lock_init(&unknown_wakeup, WAKE_LOCK_SUSPEND, "unknown_wakeups");
> +
> +	ret =3D platform_device_register(&power_device);
> +	if (ret) {
> +		pr_err("wakelocks_init: platform_device_register failed\n");
> +		goto err_platform_device_register;
> +	}
> +	ret =3D platform_driver_register(&power_driver);
> +	if (ret) {
> +		pr_err("wakelocks_init: platform_driver_register failed\n");
> +		goto err_platform_driver_register;
> +	}
> +
> +	suspend_work_queue =3D create_singlethread_workqueue("suspend");
> +	if (suspend_work_queue =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_suspend_work_queue;
> +	}
> +
> +#ifdef CONFIG_WAKELOCK_STAT
> +	create_proc_read_entry("wakelocks", S_IRUGO, NULL,
> +				wakelocks_read_proc, NULL);

Shouldn't we *not* be using /proc?  I think this should be under sysfs.

> +#endif
> +
> +	return 0;
> +
> +err_suspend_work_queue:
> +	platform_driver_unregister(&power_driver);
> +err_platform_driver_register:
> +	platform_device_unregister(&power_device);
> +err_platform_device_register:
> +	wake_lock_destroy(&unknown_wakeup);
> +	wake_lock_destroy(&main_wake_lock);
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wake_lock_destroy(&deleted_wake_locks);
> +#endif
> +	return ret;
> +}
> +
> +static void  __exit wakelocks_exit(void)
> +{
> +#ifdef CONFIG_WAKELOCK_STAT
> +	remove_proc_entry("wakelocks", NULL);
> +#endif
> +	destroy_workqueue(suspend_work_queue);
> +	platform_driver_unregister(&power_driver);
> +	platform_device_unregister(&power_device);
> +	wake_lock_destroy(&unknown_wakeup);
> +	wake_lock_destroy(&main_wake_lock);
> +#ifdef CONFIG_WAKELOCK_STAT
> +	wake_lock_destroy(&deleted_wake_locks);
> +#endif
> +}
> +
> +core_initcall(wakelocks_init);
> +module_exit(wakelocks_exit);
> -- =

> 1.6.1
> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
