From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 15:31:30 -0700
Message-ID: <20090415223130.GC3679@linux.intel.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1239759692-28617-2-git-send-email-arve@android.com>
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

I'm sure you are sick of this question, but couldn't you do this same
functionality (constraining entry to Suspend) using existing
infrastructure.  You are clearly aggregating a block-count and triggering
on an zero aggregate value to enter Suspend.

I'm thinking you could do something like CPUIDLE to push the implicit
suspend call and use a new pmqos parameter to keep the system alive.
We'd have to look at the API to make sure it would work in interrupt
mode.

The only thing I got from the earlier threads asking why not PMQOS, was
some complaint about the strcmp the constraint aggregation does WRT
performance.  I don't think it would be too hard to address the perceived
performance issue (even if its yet to be proven as an issue anywhere)

FWIW there is some talk of re-factoring some of pmqos to sit on top of a
constraint framework (to generalize the code a little and support
constraining things that are not really measurable in terms of latencies
or throughputs)

anyway a few comments below.

On Tue, Apr 14, 2009 at 06:41:25PM -0700, Arve Hj=F8nnev=E5g wrote:
> Adds /sys/power/request_state, a non-blocking interface that specifies
> which suspend state to enter when no suspend blockers are active. A
> special state, "on", stops the process by activating the "main" suspend
> blocker.
> =

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/suspend-blockers.txt |   76 +++++++++
>  include/linux/suspend_block.h            |   61 +++++++
>  kernel/power/Kconfig                     |   10 ++
>  kernel/power/Makefile                    |    1 +
>  kernel/power/main.c                      |   62 +++++++
>  kernel/power/power.h                     |    6 +
>  kernel/power/suspend_block.c             |  257 ++++++++++++++++++++++++=
++++++
>  7 files changed, 473 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/suspend-blockers.txt
>  create mode 100755 include/linux/suspend_block.h
>  create mode 100644 kernel/power/suspend_block.c
> =

> diff --git a/Documentation/power/suspend-blockers.txt b/Documentation/pow=
er/suspend-blockers.txt
> new file mode 100644
> index 0000000..743b870
> --- /dev/null
> +++ b/Documentation/power/suspend-blockers.txt
> @@ -0,0 +1,76 @@
> +Suspend blockers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A suspend_blocker prevents the system from entering suspend.

And trigger implicit entry into suspend when last blocker is released.

> +
> +If the suspend operation has already started when calling suspend_block =
on a
> +suspend_blocker, it will abort the suspend operation as long it has not =
already
> +reached the sysdev suspend stage. This means that calling suspend_block =
from an
> +interrupt handler or a freezeable thread always works, but if you call
> +block_suspend from a sysdev suspend handler you must also return an erro=
r from
> +that handler to abort suspend.
> +
> +Suspend blockers can be used to allow user-space to decide which keys sh=
ould
> +wake the full system up and turn the screen on. =


Provided the user mode process controlling the screen power is in the calli=
ng
path of user-space input-event thread.

Basically it should be made clear that this is not a device PM
implementation.  Its a global system suspend constraint system, where
the count of blockers is aggregated in a static variable,
suspend_block_count, within suspend_block.c  with implicit suspend
called when block count gets to zero.

i.e. only useful in platform specific code for platforms that can do
~10ms suspends and resumes.
 =

> Use set_irq_wake or a platform
> +specific api to make sure the keypad interrupt wakes up the cpu. Once th=
e keypad
> +driver has resumed, the sequence of events can look like this:
> +- The Keypad driver gets an interrupt. It then calls suspend_block on the
> +  keypad-scan suspend_blocker and starts scanning the keypad matrix.
count =3D 1
> +- The keypad-scan code detects a key change and reports it to the input-=
event
> +  driver.
> +- The input-event driver sees the key change, enqueues an event, and cal=
ls
> +  suspend_block on the input-event-queue suspend_blocker.
count =3D 2
> +- The keypad-scan code detects that no keys are held and calls suspend_u=
nblock
> +  on the keypad-scan suspend_blocker.
count =3D 1
> +- The user-space input-event thread returns from select/poll, calls
> +  suspend_block on the process-input-events suspend_blocker and then cal=
ls read
> +  on the input-event device.
count =3D 2
> +- The input-event driver dequeues the key-event and, since the queue is =
now
> +  empty, it calls suspend_unblock on the input-event-queue suspend_block=
er.
count =3D 1
> +- The user-space input-event thread returns from read. It determines tha=
t the
> +  key should not wake up the full system, calls suspend_unblock on the
> +  process-input-events suspend_blocker and calls select or poll.
count =3D 0 + race between dropping into Suspend state and the execution
of the select or poll.  (should probably be ok)

> +
> +                 Key pressed   Key released
> +                     |             |
> +keypad-scan          ++++++++++++++++++
> +input-event-queue        +++          +++
> +process-input-events       +++          +++
> +
> +
> +Driver API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A driver can use the suspend block api by adding a suspend_blocker varia=
ble to
> +its state and calling suspend_blocker_init. For instance:
> +struct state {
> +	struct suspend_blocker suspend_blocker;
> +}
> +
> +init() {
> +	suspend_blocker_init(&state->suspend_blocker, "suspend-blocker-name");
> +}
> +
> +Before freeing the memory, suspend_blocker_destroy must be called:
> +
> +uninit() {
> +	suspend_blocker_destroy(&state->suspend_blocker);
> +}
> +
> +When the driver determines that it needs to run (usually in an interrupt
> +handler) it calls suspend_block:
> +	suspend_block(&state->suspend_blocker);
> +
> +When it no longer needs to run it calls suspend_unblock:
> +	suspend_unblock(&state->suspend_blocker);
> +
> +Calling suspend_block when the suspend blocker is active or suspend_unbl=
ock when
> +it is not active has no effect. This allows drivers to update their stat=
e and
> +call suspend suspend_block or suspend_unblock based on the result.
> +For instance:
> +
> +if (list_empty(&state->pending_work))
> +	suspend_unblock(&state->suspend_blocker);
> +else
> +	suspend_block(&state->suspend_blocker);
> +
> diff --git a/include/linux/suspend_block.h b/include/linux/suspend_block.h
> new file mode 100755
> index 0000000..7820c60
> --- /dev/null
> +++ b/include/linux/suspend_block.h
> @@ -0,0 +1,61 @@
> +/* include/linux/suspend_block.h
> + *
> + * Copyright (C) 2007-2009 Google, Inc.
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
> +#ifndef _LINUX_SUSPEND_BLOCK_H
> +#define _LINUX_SUSPEND_BLOCK_H
> +
> +/* A suspend_blocker prevents the system from entering suspend when acti=
ve.
> + */
> +
> +struct suspend_blocker {
> +#ifdef CONFIG_SUSPEND_BLOCK
> +	atomic_t            flags;
> +	const char         *name;
> +#endif
> +};
> +
> +#ifdef CONFIG_SUSPEND_BLOCK
> +
> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *n=
ame);
> +void suspend_blocker_destroy(struct suspend_blocker *blocker);
> +void suspend_block(struct suspend_blocker *blocker);
> +void suspend_unblock(struct suspend_blocker *blocker);
> +
> +/* is_blocking_suspend returns true if the suspend_blocker is currently =
active.
> + */
> +bool is_blocking_suspend(struct suspend_blocker *blocker);
> +
> +/* suspend_is_blocked can be used by generic power management code to ab=
ort
> + * suspend.
> + *
> + * To preserve backward compatibility suspend_is_blocked returns 0 unles=
s it
> + * is called during suspend initiated from the suspend_block code.
> + */
> +bool suspend_is_blocked(void);
> +
> +#else
> +
> +static inline void suspend_blocker_init(struct suspend_blocker *blocker,
> +					const char *name) {}
> +static inline void suspend_blocker_destroy(struct suspend_blocker *block=
er) {}
> +static inline void suspend_block(struct suspend_blocker *blocker) {}
> +static inline void suspend_unblock(struct suspend_blocker *blocker) {}
> +static inline bool is_blocking_suspend(struct suspend_blocker *bl) { ret=
urn 0; }
> +static inline bool suspend_is_blocked(void) { return 0; }
> +
> +#endif
> +
> +#endif
> +
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 23bd4da..9d1df13 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,16 @@ config SUSPEND_FREEZER
>  =

>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  =

> +config SUSPEND_BLOCK
> +	bool "Suspend block"
> +	depends on PM
> +	select RTC_LIB
> +	default n
> +	---help---
> +	  Enable suspend_block. When user space requests a sleep state through
> +	  /sys/power/request_state, the requested sleep state will be entered
> +	  when no suspend_blockers are active.
> +
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 720ea4f..29cdc9e 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -6,6 +6,7 @@ endif
>  obj-$(CONFIG_PM)		+=3D main.o
>  obj-$(CONFIG_PM_SLEEP)		+=3D console.o
>  obj-$(CONFIG_FREEZER)		+=3D process.o
> +obj-$(CONFIG_SUSPEND_BLOCK)	+=3D suspend_block.o
>  obj-$(CONFIG_HIBERNATION)	+=3D swsusp.o disk.o snapshot.o swap.o user.o
>  =

>  obj-$(CONFIG_MAGIC_SYSRQ)	+=3D poweroff.o
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index c9632f8..e4c6b20 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -22,6 +22,7 @@
>  #include <linux/freezer.h>
>  #include <linux/vmstat.h>
>  #include <linux/syscalls.h>
> +#include <linux/suspend_block.h>
>  =

>  #include "power.h"
>  =

> @@ -392,6 +393,9 @@ static void suspend_finish(void)
>  =

>  =

>  static const char * const pm_states[PM_SUSPEND_MAX] =3D {
> +#ifdef CONFIG_SUSPEND_BLOCK
> +	[PM_SUSPEND_ON]		=3D "on",
> +#endif
>  	[PM_SUSPEND_STANDBY]	=3D "standby",
>  	[PM_SUSPEND_MEM]	=3D "mem",
>  };
> @@ -540,6 +544,61 @@ static ssize_t state_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
>  =

>  power_attr(state);
>  =

> +/**
> + *	request_state - control system power state.
> + *
> + *	This is similar to state, but it does not block until the system
> + *	resumes, and it will try to re-enter the state until another state is
> + *	requested. Suspend blockers are respected and the requested state will
> + *	only be entered when no suspend blockers are active.
> + *	Write "on" to cancel.
> + */
> +
> +#ifdef CONFIG_SUSPEND_BLOCK
> +static ssize_t request_state_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr, char *buf)
> +{
> +	char *s =3D buf;
> +	int i;
> +
> +	for (i =3D 0; i < PM_SUSPEND_MAX; i++) {
> +		if (pm_states[i] && (i =3D=3D PM_SUSPEND_ON || valid_state(i)))
> +			s +=3D sprintf(s, "%s ", pm_states[i]);
> +	}
> +	if (s !=3D buf)
> +		/* convert the last space to a newline */
> +		*(s-1) =3D '\n';
> +	return (s - buf);
> +}
> +
> +static ssize_t request_state_store(struct kobject *kobj,
> +				   struct kobj_attribute *attr,
> +				   const char *buf, size_t n)
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
> +#endif /* CONFIG_SUSPEND_BLOCK */
> +
>  #ifdef CONFIG_PM_TRACE
>  int pm_trace_enabled;
>  =

> @@ -567,6 +626,9 @@ power_attr(pm_trace);
>  =

>  static struct attribute * g[] =3D {
>  	&state_attr.attr,
> +#ifdef CONFIG_SUSPEND_BLOCK
> +	&request_state_attr.attr,
> +#endif
>  #ifdef CONFIG_PM_TRACE
>  	&pm_trace_attr.attr,
>  #endif
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 46b5ec7..2414a74 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -223,3 +223,9 @@ static inline void suspend_thaw_processes(void)
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_SUSPEND_BLOCK
> +/* kernel/power/suspend_block.c */
> +void request_suspend_state(suspend_state_t state);
> +#endif
> +
> diff --git a/kernel/power/suspend_block.c b/kernel/power/suspend_block.c
> new file mode 100644
> index 0000000..b4f2191
> --- /dev/null
> +++ b/kernel/power/suspend_block.c
> @@ -0,0 +1,257 @@
> +/* kernel/power/suspend_block.c
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
> +#include <linux/rtc.h>
> +#include <linux/suspend.h>
> +#include <linux/suspend_block.h>
> +#include <linux/sysdev.h>
> +#include "power.h"
> +
> +enum {
> +	DEBUG_EXIT_SUSPEND =3D 1U << 0,
> +	DEBUG_WAKEUP =3D 1U << 1,
> +	DEBUG_USER_STATE =3D 1U << 2,
> +	DEBUG_SUSPEND =3D 1U << 3,
> +	DEBUG_SUSPEND_BLOCKER =3D 1U << 4,
> +};
> +static int debug_mask =3D DEBUG_EXIT_SUSPEND | DEBUG_WAKEUP | DEBUG_USER=
_STATE;
> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_IW=
GRP);
> +
> +#define SB_INITIALIZED            (1U << 8)
> +#define SB_ACTIVE                 (1U << 9)
> +
> +static DEFINE_SPINLOCK(state_lock);
> +static atomic_t suspend_block_count;

So if suspend_block_count is the lynch pin of the design, why have all
the suspend_blocker structs?  Why have all the logic around the
different suspend blocker instances?

It seems like a lot of extra effort for an atomic "stay awake" counter.


--mgross


> +static atomic_t current_event_num;
> +struct workqueue_struct *suspend_work_queue;
> +struct suspend_blocker main_suspend_blocker;
> +static suspend_state_t requested_suspend_state =3D PM_SUSPEND_MEM;
> +static bool enable_suspend_blockers;
> +
> +bool suspend_is_blocked(void)
> +{
> +	if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend blockers\n"))
> +		return 0;
> +	return !!atomic_read(&suspend_block_count);
> +}
> +
> +static void suspend_worker(struct work_struct *work)
> +{
> +	int ret;
> +	int entry_event_num;
> +
> +	enable_suspend_blockers =3D 1;
> +
> +retry:
> +	if (suspend_is_blocked()) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("suspend: abort suspend\n");
> +		goto abort;
> +	}
> +
> +	entry_event_num =3D atomic_read(&current_event_num);
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
> +	if (atomic_read(&current_event_num) =3D=3D entry_event_num) {
> +		if (debug_mask & DEBUG_SUSPEND)
> +			pr_info("suspend: pm_suspend returned with no event\n");
> +		goto retry;
> +	}
> +abort:
> +	enable_suspend_blockers =3D 0;
> +}
> +static DECLARE_WORK(suspend_work, suspend_worker);
> +
> +static int suspend_block_suspend(struct sys_device *dev, pm_message_t st=
ate)
> +{
> +	int ret =3D suspend_is_blocked() ? -EAGAIN : 0;
> +	if (debug_mask & DEBUG_SUSPEND)
> +		pr_info("suspend_block_suspend return %d\n", ret);
> +	return ret;
> +}
> +
> +static struct sysdev_class suspend_block_sysclass =3D {
> +	.name =3D "suspend_block",
> +	.suspend =3D suspend_block_suspend,
> +};
> +static struct sys_device suspend_block_sysdev =3D {
> +	.cls =3D &suspend_block_sysclass,
> +};
> +
> +/**
> + * suspend_blocker_init() - Initialize a suspend blocker
> + * @blocker:	The suspend blocker to initialize.
> + * @name:	The name of the suspend blocker to show in
> + *		/proc/suspend_blockers
> + */
> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *n=
ame)
> +{
> +	if (name)
> +		blocker->name =3D name;
> +	BUG_ON(!blocker->name);
> +
> +	if (debug_mask & DEBUG_SUSPEND_BLOCKER)
> +		pr_info("suspend_blocker_init name=3D%s\n", blocker->name);
> +
> +	atomic_set(&blocker->flags, SB_INITIALIZED);
> +}
> +EXPORT_SYMBOL(suspend_blocker_init);
> +
> +/**
> + * suspend_blocker_destroy() - Destroy a suspend blocker
> + * @blocker:	The suspend blocker to destroy.
> + */
> +void suspend_blocker_destroy(struct suspend_blocker *blocker)
> +{
> +	int flags;
> +	if (debug_mask & DEBUG_SUSPEND_BLOCKER)
> +		pr_info("suspend_blocker_destroy name=3D%s\n", blocker->name);
> +	flags =3D atomic_xchg(&blocker->flags, 0);
> +	WARN(!(flags & SB_INITIALIZED), "suspend_blocker_destroy called on "
> +					"uninitialized suspend_blocker\n");
> +	if (flags =3D=3D (SB_INITIALIZED | SB_ACTIVE))
> +		if (atomic_dec_and_test(&suspend_block_count))
> +			queue_work(suspend_work_queue, &suspend_work);
> +}
> +EXPORT_SYMBOL(suspend_blocker_destroy);
> +
> +/**
> + * suspend_block() - Block suspend
> + * @blocker:	The suspend blocker to use
> + */
> +void suspend_block(struct suspend_blocker *blocker)
> +{
> +	BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED));
> +
> +	if (debug_mask & DEBUG_SUSPEND_BLOCKER)
> +		pr_info("suspend_block: %s\n", blocker->name);
> +	if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED,
> +	    SB_INITIALIZED | SB_ACTIVE) =3D=3D SB_INITIALIZED)
> +		atomic_inc(&suspend_block_count);
> +
> +	atomic_inc(&current_event_num);
> +}
> +EXPORT_SYMBOL(suspend_block);
> +
> +/**
> + * suspend_unblock() - Unblock suspend
> + * @blocker:	The suspend blocker to unblock.
> + *
> + * If no other suspend blockers block suspend, the system will suspend.
> + */
> +void suspend_unblock(struct suspend_blocker *blocker)
> +{
> +	if (debug_mask & DEBUG_SUSPEND_BLOCKER)
> +		pr_info("suspend_unblock: %s\n", blocker->name);
> +
> +	if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED | SB_ACTIVE,
> +	    SB_INITIALIZED) =3D=3D (SB_INITIALIZED | SB_ACTIVE))
> +		if (atomic_dec_and_test(&suspend_block_count))
> +			queue_work(suspend_work_queue, &suspend_work);
> +}
> +EXPORT_SYMBOL(suspend_unblock);
> +
> +/**
> + * is_blocking_suspend() - Test if a suspend blocker is blocking suspend
> + * @blocker:	The suspend blocker to check.
> + */
> +bool is_blocking_suspend(struct suspend_blocker *blocker)
> +{
> +	return !!(atomic_read(&blocker->flags) & SB_ACTIVE);
> +}
> +EXPORT_SYMBOL(is_blocking_suspend);
> +
> +void request_suspend_state(suspend_state_t state)
> +{
> +	unsigned long irqflags;
> +	spin_lock_irqsave(&state_lock, irqflags);
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
> +		suspend_block(&main_suspend_blocker);
> +	else
> +		suspend_unblock(&main_suspend_blocker);
> +	spin_unlock_irqrestore(&state_lock, irqflags);
> +}
> +
> +static int __init suspend_block_init(void)
> +{
> +	int ret;
> +
> +	suspend_blocker_init(&main_suspend_blocker, "main");
> +	suspend_block(&main_suspend_blocker);
> +
> +	ret =3D sysdev_class_register(&suspend_block_sysclass);
> +	if (ret) {
> +		pr_err("suspend_block_init: sysdev_class_register failed\n");
> +		goto err_sysdev_class_register;
> +	}
> +	ret =3D sysdev_register(&suspend_block_sysdev);
> +	if (ret) {
> +		pr_err("suspend_block_init: suspend_block_sysdev failed\n");
> +		goto err_sysdev_register;
> +	}
> +
> +	suspend_work_queue =3D create_singlethread_workqueue("suspend");
> +	if (suspend_work_queue =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_suspend_work_queue;
> +	}
> +
> +	return 0;
> +
> +err_suspend_work_queue:
> +	sysdev_unregister(&suspend_block_sysdev);
> +err_sysdev_register:
> +	sysdev_class_unregister(&suspend_block_sysclass);
> +err_sysdev_class_register:
> +	suspend_blocker_destroy(&main_suspend_blocker);
> +	return ret;
> +}
> +
> +static void  __exit suspend_block_exit(void)
> +{
> +	destroy_workqueue(suspend_work_queue);
> +	sysdev_unregister(&suspend_block_sysdev);
> +	sysdev_class_unregister(&suspend_block_sysclass);
> +	suspend_blocker_destroy(&main_suspend_blocker);
> +}
> +
> +core_initcall(suspend_block_init);
> +module_exit(suspend_block_exit);
> -- =

> 1.6.1
