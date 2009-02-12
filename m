From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 01/10] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 14:00:49 -0800
Message-ID: <20090212220049.GB5290@linux.intel.com>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-2-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1234316955-31304-2-git-send-email-arve@android.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

i'm sorry if I re-hash some discussions feel free to slap me.

On Tue, Feb 10, 2009 at 05:49:06PM -0800, Arve Hj=F8nnev=E5g wrote:
> Adds /sys/power/request_state, a non-blocking interface that specifies
> which suspend state to enter when no wakelocks are locked. A special
> state, "on", stops the process by locking the "main" wakelock.
> =

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/wakelocks.txt |   80 +++++
>  include/linux/wakelock.h          |   93 +++++
>  kernel/power/Kconfig              |   17 +
>  kernel/power/Makefile             |    1 +
>  kernel/power/main.c               |   63 ++++
>  kernel/power/power.h              |    7 +
>  kernel/power/wakelock.c           |  664 +++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 925 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/wakelocks.txt
>  create mode 100755 include/linux/wakelock.h
>  create mode 100644 kernel/power/wakelock.c
> =

> diff --git a/Documentation/power/wakelocks.txt b/Documentation/power/wake=
locks.txt
> new file mode 100644
> index 0000000..893a438
> --- /dev/null
> +++ b/Documentation/power/wakelocks.txt
> @@ -0,0 +1,80 @@
> +Wakelocks
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A locked wakelock, depending on its type, prevents the system from enter=
ing
> +suspend or other low-power states. When creating a wakelock, you can sel=
ect
> +if it prevents suspend or low-power idle states.  If the type is set to
> +WAKE_LOCK_SUSPEND, the wakelock prevents a full system suspend. If the t=
ype
> +is WAKE_LOCK_IDLE, low-power states that cause large interrupt latencies=
, or
> +that disable a set of interrupts, will not be entered from idle until the
> +wakelocks are released. Unless the type is specified, this document refe=
rs
> +to wakelocks with the type set to WAKE_LOCK_SUSPEND.

If there are no wakelocks held, what code path pushes the system to a
lower state?  (wake_unlock?)

Would it make more sense to remove the suspend types of locks?  Those
seem to be pretty contentious.

Do the ARM devices really go into a suspend state or just a low power
state?  =


> +
> +If the suspend operation has already started when locking a wakelock, it=
 will
> +abort the suspend operation as long it has not already reached the suspe=
nd_late
> +stage. This means that locking a wakelock from an interrupt handler or a
> +freezeable thread always works, but if you lock a wakelock from a suspen=
d_late
> +handler you must also return an error from that handler to abort suspend.
> +
> +Wakelocks can be used to allow user-space to decide which keys should wa=
ke the
> +full system up and turn the screen on. Use set_irq_wake or a platform sp=
ecific
> +api to make sure the keypad interrupt wakes up the cpu. Once the keypad =
driver
> +has resumed, the sequence of events can look like this:
> +- The Keypad driver gets an interrupt. It then locks the keypad-scan wak=
elock
> +  and starts scanning the keypad matrix.
> +- The keypad-scan code detects a key change and reports it to the input-=
event
> +  driver.
> +- The input-event driver sees the key change, enqueues an event, and loc=
ks
> +  the input-event-queue wakelock.
> +- The keypad-scan code detects that no keys are held and unlocks the
> +  keypad-scan wakelock.

Lets assume the system drops to suspend after 0ms of no-locks held.
Don't we have a race between the keypad driver unlocking the only lock
and inpu-event-queue lock getting taken?

> +- The user-space input-event thread returns from select/poll, locks the
> +  process-input-events wakelock and then calls read in the input-event d=
evice.
> +- The input-event driver dequeues the key-event and, since the queue is =
now
> +  empty, it unlocks the input-event-queue wakelock.
> +- The user-space input-event thread returns from read. It determines tha=
t the
> +  key should not wake up the full system, releases the process-input-eve=
nts
> +  wakelock and calls select or poll.
> +
> +                 Key pressed   Key released
> +                     |             |
> +keypad-scan          ++++++++++++++++++
> +input-event-queue        +++          +++
> +process-input-events       +++          +++
> +

it feels like there needs to be interlocking wakelocks to keep the
system from unexpectedly falling asleep.  Or, some hysteresis slop time
baked in to hide the races.

Are wakelocks too fine grained?

> +
> +Driver API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A driver can use the wakelock api by adding a wakelock variable to its s=
tate
> +and calling wake_lock_init. For instance:
> +struct state {
> +	struct wakelock wakelock;
> +}
> +
> +init() {
> +	wake_lock_init(&state->wakelock, WAKE_LOCK_SUSPEND, "wakelockname");
> +}
> +
> +Before freeing the memory, wake_lock_destroy must be called:
> +
> +uninit() {
> +	wake_lock_destroy(&state->wakelock);
> +}
> +
> +When the driver determines that it needs to run (usually in an interrupt
> +handler) it calls wake_lock:
> +	wake_lock(&state->wakelock);
> +
> +When it no longer needs to run it calls wake_unlock:
> +	wake_unlock(&state->wakelock);
> +
> +It can also call wake_lock_timeout to release the wakelock after a delay:
> +	wake_lock_timeout(&state->wakelock, HZ);
> +
> +This works whether the wakelock is already held or not. It is useful if =
the
> +driver woke up other parts of the system that do not use wakelocks but
> +still need to run. Avoid this when possible, since it will waste power
> +if the timeout is long or may fail to finish needed work if the timeout =
is
> +short.
> +
> diff --git a/include/linux/wakelock.h b/include/linux/wakelock.h
> new file mode 100755
> index 0000000..ec878d2
> --- /dev/null
> +++ b/include/linux/wakelock.h
> @@ -0,0 +1,93 @@
> +/* include/linux/wakelock.h
> + *
> + * Copyright (C) 2007-2008 Google, Inc.
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
> +#ifndef _LINUX_WAKELOCK_H
> +#define _LINUX_WAKELOCK_H
> +
> +#include <linux/list.h>
> +#include <linux/ktime.h>
> +
> +/* A wake_lock prevents the system from entering suspend or other low po=
wer
> + * states when active. If the type is set to WAKE_LOCK_SUSPEND, the wake=
_lock
> + * prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low po=
wer
> + * states that cause large interrupt latencies or that disable a set of
> + * interrupts will not entered from idle until the wake_locks are releas=
ed.
> + */
> +
> +enum {
> +	WAKE_LOCK_SUSPEND, /* Prevent suspend */
> +	WAKE_LOCK_IDLE,    /* Prevent low power idle */
> +	WAKE_LOCK_TYPE_COUNT
> +};
> +
> +struct wake_lock {
> +#ifdef CONFIG_WAKELOCK
> +	struct list_head    link;
> +	int                 flags;
> +	const char         *name;
> +	unsigned long       expires;
> +#ifdef CONFIG_WAKELOCK_STAT
> +	struct {
> +		int             count;
> +		int             expire_count;
> +		int             wakeup_count;
> +		ktime_t         total_time;
> +		ktime_t         prevent_suspend_time;
> +		ktime_t         max_time;
> +		ktime_t         last_time;
> +	} stat;
> +#endif
> +#endif
> +};
> +
> +#ifdef CONFIG_WAKELOCK
> +
> +void wake_lock_init(struct wake_lock *lock, int type, const char *name);
> +void wake_lock_destroy(struct wake_lock *lock);
> +void wake_lock(struct wake_lock *lock);
> +void wake_lock_timeout(struct wake_lock *lock, long timeout);
> +void wake_unlock(struct wake_lock *lock);
> +
> +/* wake_lock_active returns a non-zero value if the wake_lock is current=
ly
> + * locked. If the wake_lock has a timeout, it does not check the timeout,
> + * but if the timeout had already expired when it was checked elsewhere
> + * this function will return 0.
> + */
> +int wake_lock_active(struct wake_lock *lock);
> +
> +/* has_wake_lock can be used by generic power management code to abort s=
uspend.
> + * has_wake_lock returns 0 if no wake locks of the specified type are ac=
tive,
> + * and non-zero if one or more wake locks are held. Specifically it retu=
rns
> + * -1 if one or more wake locks with no timeout are active or the
> + * number of jiffies until all active wake locks time out.
> + */
> +long has_wake_lock(int type);
> +
> +#else
> +
> +static inline void wake_lock_init(struct wake_lock *lock, int type,
> +					const char *name) {}
> +static inline void wake_lock_destroy(struct wake_lock *lock) {}
> +static inline void wake_lock(struct wake_lock *lock) {}
> +static inline void wake_lock_timeout(struct wake_lock *lock, long timeou=
t) {}
> +static inline void wake_unlock(struct wake_lock *lock) {}
> +
> +static inline int wake_lock_active(struct wake_lock *lock) { return 0; }
> +static inline long has_wake_lock(int type) { return 0; }
> +
> +#endif
> +
> +#endif
> +
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 23bd4da..9abd97e 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,23 @@ config SUSPEND_FREEZER
>  =

>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  =

> +config WAKELOCK
> +	bool "Wake lock"
> +	depends on PM
> +	select RTC_LIB
> +	default n
> +	---help---
> +	  Enable wakelocks. When user space requests a sleep state through
> +	  /sys/power/request_state, the requested sleep state will be entered
> +	  when no wake locks are held.
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
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 2399888..8bdd15a 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -22,6 +22,7 @@
>  #include <linux/freezer.h>
>  #include <linux/vmstat.h>
>  #include <linux/syscalls.h>
> +#include <linux/wakelock.h>
>  =

>  #include "power.h"
>  =

> @@ -388,6 +389,9 @@ static void suspend_finish(void)
>  =

>  =

>  static const char * const pm_states[PM_SUSPEND_MAX] =3D {
> +#ifdef CONFIG_WAKELOCK
> +	[PM_SUSPEND_ON]		=3D "on",
> +#endif
>  	[PM_SUSPEND_STANDBY]	=3D "standby",
>  	[PM_SUSPEND_MEM]	=3D "mem",
>  };
> @@ -536,6 +540,62 @@ static ssize_t state_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
>  =

>  power_attr(state);
>  =

> +/**
> + *	request_state - control system power state.
> + *
> + *	This is similar to state, but it does not block until the system
> + *	resumes, and it will try to re-enter the state until another state is
> + *	requsted. Wakelocks are respected and the requested state will only
> + *	be entered when no wakelocks are held. Write "on" to cancel.
> + *
> + *	If CONFIG_EARLYSUSPEND is set, early_suspend hooks are called when
> + *	the requested state changes to or from "on"
> + */
> +
> +#ifdef CONFIG_WAKELOCK
> +static ssize_t request_state_show(struct kobject *kobj, struct kobj_attr=
ibute *attr,
> +			  char *buf)
> +{
> +	char *s =3D buf;
> +	int i;
> +
> +	for (i =3D 0; i < PM_SUSPEND_MAX; i++) {
> +		if (pm_states[i] && (i =3D=3D PM_SUSPEND_ON || valid_state(i)))
> +			s +=3D sprintf(s,"%s ", pm_states[i]);
> +	}
> +	if (s !=3D buf)
> +		/* convert the last space to a newline */
> +		*(s-1) =3D '\n';
> +	return (s - buf);
> +}
> +
> +static ssize_t request_state_store(struct kobject *kobj, struct kobj_att=
ribute *attr,
> +			   const char *buf, size_t n)
> +{
> +	suspend_state_t state =3D PM_SUSPEND_ON;
> +	const char * const *s;
> +	char *p;
> +	int len;
> +	int error =3D -EINVAL;
> +
> +	p =3D memchr(buf, '\n', n);
> +	len =3D p ? p - buf : n;
> +
> +	for (s =3D &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
> +		if (*s && len =3D=3D strlen(*s) && !strncmp(buf, *s, len))
> +			break;
> +	}
> +	if (state < PM_SUSPEND_MAX && *s)
> +		if (state =3D=3D PM_SUSPEND_ON || valid_state(state)) {
> +			error =3D 0;
> +			request_suspend_state(state);
> +		}
> +	return error ? error : n;
> +}
> +
> +power_attr(request_state);
> +#endif /* CONFIG_WAKELOCK */
> +
>  #ifdef CONFIG_PM_TRACE
>  int pm_trace_enabled;
>  =

> @@ -563,6 +623,9 @@ power_attr(pm_trace);
>  =

>  static struct attribute * g[] =3D {
>  	&state_attr.attr,
> +#ifdef CONFIG_WAKELOCK
> +	&request_state_attr.attr,
> +#endif
>  #ifdef CONFIG_PM_TRACE
>  	&pm_trace_attr.attr,
>  #endif
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 46b5ec7..9468679 100644
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
> +void request_suspend_state(suspend_state_t state);
> +#endif
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> new file mode 100644
> index 0000000..13f5d03
> --- /dev/null
> +++ b/kernel/power/wakelock.c
> @@ -0,0 +1,664 @@
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
> +	DEBUG_USER_STATE =3D 1U << 2,
> +	DEBUG_SUSPEND =3D 1U << 3,
> +	DEBUG_EXPIRE =3D 1U << 4,
> +	DEBUG_WAKE_LOCK =3D 1U << 5,
> +};
> +static int debug_mask =3D DEBUG_EXIT_SUSPEND | DEBUG_WAKEUP | DEBUG_USER=
_STATE;
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
> +static DEFINE_SPINLOCK(state_lock);
> +static LIST_HEAD(inactive_locks);
> +static struct list_head active_wake_locks[WAKE_LOCK_TYPE_COUNT];
> +static int current_event_num;
> +struct workqueue_struct *suspend_work_queue;
> +struct wake_lock main_wake_lock;
> +static suspend_state_t requested_suspend_state =3D PM_SUSPEND_MEM;
> +static struct wake_lock unknown_wakeup;
> +
> +#ifdef CONFIG_WAKELOCK_STAT
> +static struct wake_lock deleted_wake_locks;
> +static ktime_t last_sleep_time_update;
> +static bool wait_for_wakeup;
> +
> +bool stats_get_expired_time(struct wake_lock *lock, ktime_t *expire_time)
> +{
> +	struct timespec ts;
> +	struct timespec kt;
> +	struct timespec tomono;
> +	struct timespec delta;
> +	unsigned long seq;
> +	long timeout;
> +
> +	if (!(lock->flags & WAKE_LOCK_AUTO_EXPIRE))
> +		return false;
> +	do {
> +		seq =3D read_seqbegin(&xtime_lock);
> +		timeout =3D lock->expires - jiffies;
> +		if (timeout > 0)
> +			return false;
> +		kt =3D current_kernel_time();
> +		tomono =3D wall_to_monotonic;
> +	} while (read_seqretry(&xtime_lock, seq));
> +	jiffies_to_timespec(-timeout, &delta);
> +	set_normalized_timespec(&ts, kt.tv_sec + tomono.tv_sec - delta.tv_sec,
> +				kt.tv_nsec + tomono.tv_nsec - delta.tv_nsec);
> +	*expire_time =3D timespec_to_ktime(ts);
> +	return true;
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
> +		bool expired =3D stats_get_expired_time(lock, &now);
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
> +static int wakelock_stats_read_proc(char *page, char **start, off_t off,
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
> +static void wake_lock_stat_init_locked(struct wake_lock *lock)
> +{
> +	lock->stat.count =3D 0;
> +	lock->stat.expire_count =3D 0;
> +	lock->stat.wakeup_count =3D 0;
> +	lock->stat.total_time =3D ktime_set(0, 0);
> +	lock->stat.prevent_suspend_time =3D ktime_set(0, 0);
> +	lock->stat.max_time =3D ktime_set(0, 0);
> +	lock->stat.last_time =3D ktime_set(0, 0);
> +}
> +
> +static void wake_lock_stat_destroy_locked(struct wake_lock *lock)
> +{
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
> +}
> +
> +static void wake_unlock_stat_locked(struct wake_lock *lock, bool expired)
> +{
> +	ktime_t duration;
> +	ktime_t now;
> +	if (!(lock->flags & WAKE_LOCK_ACTIVE))
> +		return;
> +	if (stats_get_expired_time(lock, &now))
> +		expired =3D true;
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
> +static void wake_lock_stat_locked(struct wake_lock *lock)
> +{
> +	int type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
> +	if (type =3D=3D WAKE_LOCK_SUSPEND && wait_for_wakeup) {
> +		if (debug_mask & DEBUG_WAKEUP)
> +			pr_info("wakeup wake lock: %s\n", lock->name);
> +		wait_for_wakeup =3D false;
> +		lock->stat.wakeup_count++;
> +	}
> +	if ((lock->flags & WAKE_LOCK_AUTO_EXPIRE) &&
> +	    time_is_before_eq_jiffies(lock->expires)) {
> +		wake_unlock_stat_locked(lock, false);
> +		lock->stat.last_time =3D ktime_get();
> +	}
> +
> +	if (!(lock->flags & WAKE_LOCK_ACTIVE))
> +		lock->stat.last_time =3D ktime_get();
> +}
> +
> +static void update_sleep_wait_stats_locked(bool done)
> +{
> +	struct wake_lock *lock;
> +	ktime_t now, etime, elapsed, add;
> +	bool expired;
> +
> +	now =3D ktime_get();
> +	elapsed =3D ktime_sub(now, last_sleep_time_update);
> +	list_for_each_entry(lock, &active_wake_locks[WAKE_LOCK_SUSPEND], link) {
> +		expired =3D stats_get_expired_time(lock, &etime);
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
> +
> +#else
> +
> +static inline void wake_lock_stat_init_locked(struct wake_lock *lock) {}
> +static inline void wake_lock_stat_destroy_locked(struct wake_lock *lock)=
 {}
> +static inline void wake_lock_stat_locked(struct wake_lock *lock) {}
> +static inline void wake_unlock_stat_locked(struct wake_lock *lock,
> +					   bool expired) {}
> +static inline void update_sleep_wait_stats_locked(bool done) {}
> +
> +#endif
> +
> +
> +static void expire_wake_lock(struct wake_lock *lock)
> +{
> +	wake_unlock_stat_locked(lock, true);
> +	lock->flags &=3D ~(WAKE_LOCK_ACTIVE | WAKE_LOCK_AUTO_EXPIRE);
> +	list_del(&lock->link);
> +	list_add(&lock->link, &inactive_locks);
> +	if (debug_mask & (DEBUG_WAKE_LOCK | DEBUG_EXPIRE))
> +		pr_info("expired wake lock %s\n", lock->name);
> +}
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
> +static void suspend_worker(struct work_struct *work)
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
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("suspend: enter suspend\n");
> +	ret =3D pm_suspend(requested_suspend_state);
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
> +static DECLARE_WORK(suspend_work, suspend_worker);
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
> +	wait_for_wakeup =3D true;
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
> +/**
> + * wake_lock_init() - Initialize a wakelock
> + * @lock:	The wakelock to initialize.
> + * @type:	Type of wakelock, e.g. WAKE_LOCK_SUSPEND
> + * @name:	The name of the wakelock to show in /proc/wakelocks
> + */
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
> +
> +	lock->flags =3D (type & WAKE_LOCK_TYPE_MASK) | WAKE_LOCK_INITIALIZED;
> +	INIT_LIST_HEAD(&lock->link);
> +
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	wake_lock_stat_init_locked(lock);
> +	list_add(&lock->link, &inactive_locks);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_lock_init);
> +
> +/**
> + * wake_lock_destroy() - Destroy a wakelock
> + * @lock:       The wakelock to destroy.
> + */
> +void wake_lock_destroy(struct wake_lock *lock)
> +{
> +	unsigned long irqflags;
> +	if (debug_mask & DEBUG_WAKE_LOCK)
> +		pr_info("wake_lock_destroy name=3D%s\n", lock->name);
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	wake_lock_stat_destroy_locked(lock);
> +	lock->flags &=3D ~WAKE_LOCK_INITIALIZED;
> +	list_del(&lock->link);
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_lock_destroy);
> +
> +static void __wake_lock(struct wake_lock *lock, long timeout, bool has_t=
imeout)

If the timeout =3D=3D 0 or < 0 can you assume has_timeout?

> +{
> +	int type;
> +	unsigned long irqflags;
> +	long expire_in;
> +
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
> +	BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
> +	BUG_ON(!(lock->flags & WAKE_LOCK_INITIALIZED));
> +
> +	wake_lock_stat_locked(lock);
> +	lock->flags |=3D WAKE_LOCK_ACTIVE;
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
> +		/* Add to head so has_wake_lock only has to examine one entry */
> +		list_add(&lock->link, &active_wake_locks[type]);
> +	}
> +	if (type =3D=3D WAKE_LOCK_SUSPEND) {
> +		current_event_num++;
> +		if (lock =3D=3D &main_wake_lock)
> +			update_sleep_wait_stats_locked(true);
> +		else if (!wake_lock_active(&main_wake_lock))
> +			update_sleep_wait_stats_locked(false);
> +		expire_in =3D has_timeout ? has_wake_lock_locked(type) : -1;
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
> +/**
> + * wake_lock() - Lock a wakelock
> + * @lock:       The wakelock to lock.
> + */
> +void wake_lock(struct wake_lock *lock)

Naming is a little confusing to me.  wake_lock(...) reads as an
initialization / constructor type of function, but its really a locking
operation.  Perhaps lock_wake_lock would be more clear.

> +{
> +	__wake_lock(lock, 0, false);
> +}
> +EXPORT_SYMBOL(wake_lock);
> +
> +/**
> + * wake_lock_timeout() - Lock a wakelock with auto-unlock timeout
> + * @lock:       The wakelock to lock.
> + * @timeout:    Timeout in jiffies before the lock auto-unlock
> + */
> +void wake_lock_timeout(struct wake_lock *lock, long timeout)
> +{
> +	__wake_lock(lock, timeout, true);
> +}
> +EXPORT_SYMBOL(wake_lock_timeout);
> +
> +/**
> + * wake_lock() - Unlock a wakelock
> + * @lock:       The wakelock to unlock.
> + */
> +void wake_unlock(struct wake_lock *lock)

unlock_wake_lock?

> +{
> +	int type;
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&list_lock, irqflags);
> +
> +	wake_unlock_stat_locked(lock, false);
> +
> +	if (debug_mask & DEBUG_WAKE_LOCK)
> +		pr_info("wake_unlock: %s\n", lock->name);
> +	lock->flags &=3D ~(WAKE_LOCK_ACTIVE | WAKE_LOCK_AUTO_EXPIRE);
> +	list_del(&lock->link);
> +	list_add(&lock->link, &inactive_locks);
> +
> +	type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
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
> +			update_sleep_wait_stats_locked(false);
> +		}
> +	}
> +	spin_unlock_irqrestore(&list_lock, irqflags);
> +}
> +EXPORT_SYMBOL(wake_unlock);
> +
> +/**
> + * wake_lock_active() - Test if a wakelock is locked
> + * @lock:       The wakelock to check.
> + */
> +int wake_lock_active(struct wake_lock *lock)
> +{
> +	return !!(lock->flags & WAKE_LOCK_ACTIVE);

A double bang? '!!'  shouldn't this be syntax error?  looks odd.

> +}
> +EXPORT_SYMBOL(wake_lock_active);
> +
> +void request_suspend_state(suspend_state_t state)
> +{
> +	unsigned long irqflags;
> +	spin_lock_irqsave(&state_lock, irqflags);
why not grab this lock after the debug_mask if block?


--mgross

> +	if (debug_mask & DEBUG_USER_STATE) {
> +		struct timespec ts;
> +		struct rtc_time tm;
> +		getnstimeofday(&ts);
> +		rtc_time_to_tm(ts.tv_sec, &tm);
> +		pr_info("request_suspend_state: %s (%d->%d) at %lld "
> +			"(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n",
> +			state !=3D PM_SUSPEND_ON ? "sleep" : "wakeup",
> +			requested_suspend_state, state,
> +			ktime_to_ns(ktime_get()),
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +	}
> +	requested_suspend_state =3D state;
> +	if (state =3D=3D PM_SUSPEND_ON)
> +		wake_lock(&main_wake_lock);
> +	else
> +		wake_unlock(&main_wake_lock);
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +}
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
> +				wakelock_stats_read_proc, NULL);
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
