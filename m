From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 29 Apr 2009 17:49:10 -0700
Message-ID: <d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904300034.09837.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2009/4/29 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 15 April 2009, Arve Hj=F8nnev=E5g wrote:
>> diff --git a/include/linux/suspend_block.h b/include/linux/suspend_block=
.h
>> new file mode 100755
>> index 0000000..7820c60
>> --- /dev/null
>> +++ b/include/linux/suspend_block.h
>
> suspend_blockers.h perhaps?

suspend_blocker.h?

>
>> @@ -0,0 +1,61 @@
>> +/* include/linux/suspend_block.h
>> + *
>> + * Copyright (C) 2007-2009 Google, Inc.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef _LINUX_SUSPEND_BLOCK_H
>> +#define _LINUX_SUSPEND_BLOCK_H
>
> SUSPEND_BLOCKERS_H ?
>
>> +
>> +/* A suspend_blocker prevents the system from entering suspend when act=
ive.
>> + */
>> +
>> +struct suspend_blocker {
>> +#ifdef CONFIG_SUSPEND_BLOCK
>
> CONFIG_SUSPEND_BLOCKERS ?

OK.

>
>> + =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0flags;
>> + =A0 =A0 const char =A0 =A0 =A0 =A0 *name;
>> +#endif
>> +};
>> +
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> +
>> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *=
name);
>> +void suspend_blocker_destroy(struct suspend_blocker *blocker);
>> +void suspend_block(struct suspend_blocker *blocker);
>> +void suspend_unblock(struct suspend_blocker *blocker);
>> +
>> +/* is_blocking_suspend returns true if the suspend_blocker is currently=
 active.
>> + */
>> +bool is_blocking_suspend(struct suspend_blocker *blocker);
>
> suspend_blocker_is_active() ?
OK.
> suspend_blocker_enabled() ?
>
>> +
>> +/* suspend_is_blocked can be used by generic power management code to a=
bort
>> + * suspend.
>> + *
>> + * To preserve backward compatibility suspend_is_blocked returns 0 unle=
ss it
>> + * is called during suspend initiated from the suspend_block code.
>> + */
>> +bool suspend_is_blocked(void);
>> +
>> +#else
>> +
>> +static inline void suspend_blocker_init(struct suspend_blocker *blocker,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const char *name) {}
>> +static inline void suspend_blocker_destroy(struct suspend_blocker *bloc=
ker) {}
>> +static inline void suspend_block(struct suspend_blocker *blocker) {}
>> +static inline void suspend_unblock(struct suspend_blocker *blocker) {}
>> +static inline bool is_blocking_suspend(struct suspend_blocker *bl) { re=
turn 0; }
>> +static inline bool suspend_is_blocked(void) { return 0; }
>> +
>> +#endif
>> +
>> +#endif
>> +
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index 23bd4da..9d1df13 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -116,6 +116,16 @@ config SUSPEND_FREEZER
>>
>> =A0 =A0 =A0 =A0 Turning OFF this setting is NOT recommended! If in doubt=
, say Y.
>>
>> +config SUSPEND_BLOCK
>> + =A0 =A0 bool "Suspend block"
>> + =A0 =A0 depends on PM
>> + =A0 =A0 select RTC_LIB
>
> depends on RTC_LIB
>
> select doesn't really work and I don't think it ever will.

Nothing depends on RTC_LIB, it is only selected.

>
>> + =A0 =A0 default n
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 Enable suspend_block.
>
> Enable suspend blockers.

OK.

>
>> When user space requests a sleep state through
>> + =A0 =A0 =A0 /sys/power/request_state, the requested sleep state will b=
e entered
>> + =A0 =A0 =A0 when no suspend_blockers are active.
>
> Well, if you don't want suspend blockers to block suspend started via
> /sys/power/state, it's worth making it crystal clear in the documentation=
 too.

I added this to the intro.

>
>> +
>> =A0config HIBERNATION
>> =A0 =A0 =A0 bool "Hibernation (aka 'suspend to disk')"
>> =A0 =A0 =A0 depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
>> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
>> index 720ea4f..29cdc9e 100644
>> --- a/kernel/power/Makefile
>> +++ b/kernel/power/Makefile
>> @@ -6,6 +6,7 @@ endif
>> =A0obj-$(CONFIG_PM) =A0 =A0 =A0 =A0 =A0 =A0 +=3D main.o
>> =A0obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D console.o
>> =A0obj-$(CONFIG_FREEZER) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D process.o
>> +obj-$(CONFIG_SUSPEND_BLOCK) =A0+=3D suspend_block.o
>> =A0obj-$(CONFIG_HIBERNATION) =A0 =A0+=3D swsusp.o disk.o snapshot.o swap=
.o user.o
>>
>> =A0obj-$(CONFIG_MAGIC_SYSRQ) =A0 =A0+=3D poweroff.o
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index c9632f8..e4c6b20 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -22,6 +22,7 @@
>> =A0#include <linux/freezer.h>
>> =A0#include <linux/vmstat.h>
>> =A0#include <linux/syscalls.h>
>> +#include <linux/suspend_block.h>
>>
>> =A0#include "power.h"
>>
>> @@ -392,6 +393,9 @@ static void suspend_finish(void)
>>
>>
>> =A0static const char * const pm_states[PM_SUSPEND_MAX] =3D {
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> + =A0 =A0 [PM_SUSPEND_ON] =A0 =A0 =A0 =A0 =3D "on",
>> +#endif
>
> Why #ifdef?

Removed.

>
>> =A0 =A0 =A0 [PM_SUSPEND_STANDBY] =A0 =A0=3D "standby",
>> =A0 =A0 =A0 [PM_SUSPEND_MEM] =A0 =A0 =A0 =A0=3D "mem",
>> =A0};
>> @@ -540,6 +544,61 @@ static ssize_t state_store(struct kobject *kobj, st=
ruct kobj_attribute *attr,
>>
>> =A0power_attr(state);
>>
>> +/**
>> + * =A0 request_state - control system power state.
>> + *
>> + * =A0 This is similar to state, but it does not block until the system
>> + * =A0 resumes, and it will try to re-enter the state until another sta=
te is
>> + * =A0 requested. Suspend blockers are respected and the requested stat=
e will
>> + * =A0 only be entered when no suspend blockers are active.
>> + * =A0 Write "on" to cancel.
>> + */
>> +
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> +static ssize_t request_state_show(struct kobject *kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct kob=
j_attribute *attr, char *buf)
>> +{
>> + =A0 =A0 char *s =3D buf;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < PM_SUSPEND_MAX; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm_states[i] && (i =3D=3D PM_SUSPEND_ON ||=
 valid_state(i)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprintf(s, "%s ", pm_st=
ates[i]);
>> + =A0 =A0 }
>> + =A0 =A0 if (s !=3D buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* convert the last space to a newline */
>> + =A0 =A0 =A0 =A0 =A0 =A0 *(s-1) =3D '\n';
>> + =A0 =A0 return (s - buf);
>> +}
>> +
>> +static ssize_t request_state_store(struct kobject *kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
kobj_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const c=
har *buf, size_t n)
>> +{
>> + =A0 =A0 suspend_state_t state =3D PM_SUSPEND_ON;
>> + =A0 =A0 const char * const *s;
>> + =A0 =A0 char *p;
>> + =A0 =A0 int len;
>> + =A0 =A0 int error =3D -EINVAL;
>> +
>> + =A0 =A0 p =3D memchr(buf, '\n', n);
>> + =A0 =A0 len =3D p ? p - buf : n;
>> +
>> + =A0 =A0 for (s =3D &pm_states[state]; state < PM_SUSPEND_MAX; s++, sta=
te++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (*s && len =3D=3D strlen(*s) && !strncmp(bu=
f, *s, len))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 if (state < PM_SUSPEND_MAX && *s)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D PM_SUSPEND_ON || valid_state(=
state)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_suspend_state(state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 return error ? error : n;
>> +}
>> +
>> +power_attr(request_state);
>> +#endif /* CONFIG_SUSPEND_BLOCK */
>> +
>> =A0#ifdef CONFIG_PM_TRACE
>> =A0int pm_trace_enabled;
>>
>> @@ -567,6 +626,9 @@ power_attr(pm_trace);
>>
>> =A0static struct attribute * g[] =3D {
>> =A0 =A0 =A0 &state_attr.attr,
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> + =A0 =A0 &request_state_attr.attr,
>> +#endif
>> =A0#ifdef CONFIG_PM_TRACE
>> =A0 =A0 =A0 &pm_trace_attr.attr,
>> =A0#endif
>> diff --git a/kernel/power/power.h b/kernel/power/power.h
>> index 46b5ec7..2414a74 100644
>> --- a/kernel/power/power.h
>> +++ b/kernel/power/power.h
>> @@ -223,3 +223,9 @@ static inline void suspend_thaw_processes(void)
>> =A0{
>> =A0}
>> =A0#endif
>> +
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> +/* kernel/power/suspend_block.c */
>> +void request_suspend_state(suspend_state_t state);
>> +#endif
>
> Is the #ifdef really necessary?
>

No, but it gives a compile error instead of a link error if you call
request_suspend_state when it is not available so it is useful.

>> +
>> diff --git a/kernel/power/suspend_block.c b/kernel/power/suspend_block.c
>> new file mode 100644
>> index 0000000..b4f2191
>> --- /dev/null
>> +++ b/kernel/power/suspend_block.c
>> @@ -0,0 +1,257 @@
>> +/* kernel/power/suspend_block.c
>> + *
>> + * Copyright (C) 2005-2008 Google, Inc.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/rtc.h>
>> +#include <linux/suspend.h>
>> +#include <linux/suspend_block.h>
>> +#include <linux/sysdev.h>
>> +#include "power.h"
>> +
>> +enum {
>> + =A0 =A0 DEBUG_EXIT_SUSPEND =3D 1U << 0,
>> + =A0 =A0 DEBUG_WAKEUP =3D 1U << 1,
>> + =A0 =A0 DEBUG_USER_STATE =3D 1U << 2,
>> + =A0 =A0 DEBUG_SUSPEND =3D 1U << 3,
>> + =A0 =A0 DEBUG_SUSPEND_BLOCKER =3D 1U << 4,
>> +};
>> +static int debug_mask =3D DEBUG_EXIT_SUSPEND | DEBUG_WAKEUP | DEBUG_USE=
R_STATE;
>> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_I=
WGRP);
>> +
>> +#define SB_INITIALIZED =A0 =A0 =A0 =A0 =A0 =A0(1U << 8)
>> +#define SB_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1U << 9)
>> +
>> +static DEFINE_SPINLOCK(state_lock);
>> +static atomic_t suspend_block_count;
>> +static atomic_t current_event_num;
>> +struct workqueue_struct *suspend_work_queue;
>> +struct suspend_blocker main_suspend_blocker;
>> +static suspend_state_t requested_suspend_state =3D PM_SUSPEND_MEM;
>> +static bool enable_suspend_blockers;
>> +
>> +bool suspend_is_blocked(void)
>> +{
>> + =A0 =A0 if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend bloc=
kers\n"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 return !!atomic_read(&suspend_block_count);
>> +}
>> +
>> +static void suspend_worker(struct work_struct *work)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 int entry_event_num;
>> +
>> + =A0 =A0 enable_suspend_blockers =3D 1;
>
> 'true' instead of '1', please.

OK.

>
>> +
>> +retry:
>> + =A0 =A0 if (suspend_is_blocked()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: abort suspen=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto abort;
>
> If that were in a loop you could just use 'break' here.

do you think this is better:
while(1) {
        if (exception1) {
                ...
                break;
        }
        ...
        if (exception2) {
                ...
                continue;
        }
        break;
}
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 entry_event_num =3D atomic_read(&current_event_num);
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: enter suspend\n");
>> + =A0 =A0 ret =3D pm_suspend(requested_suspend_state);
>> + =A0 =A0 if (debug_mask & DEBUG_EXIT_SUSPEND) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct timespec ts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct rtc_time tm;
>> + =A0 =A0 =A0 =A0 =A0 =A0 getnstimeofday(&ts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rtc_time_to_tm(ts.tv_sec, &tm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: exit suspend, ret =3D %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%d-%02d-%02d %02d:%02d:%02d.=
%09lu UTC)\n", ret,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_year + 1900, tm.tm_mon +=
 1, tm.tm_mday,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_hour, tm.tm_min, tm.tm_s=
ec, ts.tv_nsec);
>> + =A0 =A0 }
>> + =A0 =A0 if (atomic_read(&current_event_num) =3D=3D entry_event_num) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: pm_suspend r=
eturned with no event\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
>
> Put that into a loop and use 'continue' here? =A0Or use 'break' to go out=
 of
> the loop?

The retry is a workaround for the lack of suspend_block_timeout.

>
>> + =A0 =A0 }
>> +abort:
>> + =A0 =A0 enable_suspend_blockers =3D 0;
>
> 'false' instead of '0', please.

OK.

>
>> +}
>> +static DECLARE_WORK(suspend_work, suspend_worker);
>> +
>> +static int suspend_block_suspend(struct sys_device *dev, pm_message_t s=
tate)
>> +{
>> + =A0 =A0 int ret =3D suspend_is_blocked() ? -EAGAIN : 0;
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_block_suspend return %d\n", r=
et);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static struct sysdev_class suspend_block_sysclass =3D {
>> + =A0 =A0 .name =3D "suspend_block",
>> + =A0 =A0 .suspend =3D suspend_block_suspend,
>> +};
>> +static struct sys_device suspend_block_sysdev =3D {
>> + =A0 =A0 .cls =3D &suspend_block_sysclass,
>> +};
>> +
>
> Hmm. =A0Perhaps add the suspend_is_blocked() check at the beginning of
> sysdev_suspend() instead of this? =A0Surely you don't want to suspend
> any sysdevs with any suspend blockers active, right?

You could make the same argument for any device. Using a sysdev makes
the patch easier to apply.

>
>> +/**
>> + * suspend_blocker_init() - Initialize a suspend blocker
>> + * @blocker: The suspend blocker to initialize.
>> + * @name: =A0 =A0The name of the suspend blocker to show in
>> + * =A0 =A0 =A0 =A0 =A0 /proc/suspend_blockers
>> + */
>> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *=
name)
>> +{
>> + =A0 =A0 if (name)
>> + =A0 =A0 =A0 =A0 =A0 =A0 blocker->name =3D name;
>> + =A0 =A0 BUG_ON(!blocker->name);
>
> Do you really want to crash the kernel in this case? =A0WARN_ON() might b=
e better IMO.

OK.

>
> Also, this assumes that the caller won't release the memory used to store=
 the
> 'name' string. =A0it might be a good idea to point that out in the kernel=
doc
> comment.
>
>> +
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_blocker_init name=3D%s\n", bl=
ocker->name);
>> +
>> + =A0 =A0 atomic_set(&blocker->flags, SB_INITIALIZED);
>> +}
>> +EXPORT_SYMBOL(suspend_blocker_init);
>> +
>> +/**
>> + * suspend_blocker_destroy() - Destroy a suspend blocker
>> + * @blocker: The suspend blocker to destroy.
>> + */
>> +void suspend_blocker_destroy(struct suspend_blocker *blocker)
>> +{
>> + =A0 =A0 int flags;
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_blocker_destroy name=3D%s\n",=
 blocker->name);
>> + =A0 =A0 flags =3D atomic_xchg(&blocker->flags, 0);
>> + =A0 =A0 WARN(!(flags & SB_INITIALIZED), "suspend_blocker_destroy calle=
d on "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "uninitialized suspend_blocker\n");
>> + =A0 =A0 if (flags =3D=3D (SB_INITIALIZED | SB_ACTIVE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_dec_and_test(&suspend_block_count))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_work(suspend_work_queue,=
 &suspend_work);
>> +}
>> +EXPORT_SYMBOL(suspend_blocker_destroy);
>> +
>> +/**
>> + * suspend_block() - Block suspend
>> + * @blocker: The suspend blocker to use
>> + */
>> +void suspend_block(struct suspend_blocker *blocker)
>> +{
>> + =A0 =A0 BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED));
>
> WARN_ON() and exit instead? =A0BUG_ON() is a bit drastic IMHO.
>
>> +
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_block: %s\n", blocker->name);
>> + =A0 =A0 if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED,
>> + =A0 =A0 =A0 =A0 SB_INITIALIZED | SB_ACTIVE) =3D=3D SB_INITIALIZED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&suspend_block_count);
>> +
>> + =A0 =A0 atomic_inc(&current_event_num);
>> +}
>> +EXPORT_SYMBOL(suspend_block);
>> +
>> +/**
>> + * suspend_unblock() - Unblock suspend
>> + * @blocker: The suspend blocker to unblock.
>> + *
>> + * If no other suspend blockers block suspend, the system will suspend.
>> + */
>> +void suspend_unblock(struct suspend_blocker *blocker)
>> +{
>> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_unblock: %s\n", blocker->name=
);
>> +
>> + =A0 =A0 if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED | SB_ACTIVE,
>> + =A0 =A0 =A0 =A0 SB_INITIALIZED) =3D=3D (SB_INITIALIZED | SB_ACTIVE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_dec_and_test(&suspend_block_count))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_work(suspend_work_queue,=
 &suspend_work);
>> +}
>> +EXPORT_SYMBOL(suspend_unblock);
>> +
>> +/**
>> + * is_blocking_suspend() - Test if a suspend blocker is blocking suspend
>> + * @blocker: The suspend blocker to check.
>> + */
>> +bool is_blocking_suspend(struct suspend_blocker *blocker)
>> +{
>> + =A0 =A0 return !!(atomic_read(&blocker->flags) & SB_ACTIVE);
>
> Check SB_INITIALIZED too, perhaps? =A0WARN_ON(!SB_INITIALIZED)?

Added WARN_ON.

>
>> +}
>> +EXPORT_SYMBOL(is_blocking_suspend);
>> +
>> +void request_suspend_state(suspend_state_t state)
>> +{
>> + =A0 =A0 unsigned long irqflags;
>> + =A0 =A0 spin_lock_irqsave(&state_lock, irqflags);
>> + =A0 =A0 if (debug_mask & DEBUG_USER_STATE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct timespec ts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct rtc_time tm;
>> + =A0 =A0 =A0 =A0 =A0 =A0 getnstimeofday(&ts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rtc_time_to_tm(ts.tv_sec, &tm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("request_suspend_state: %s (%d->%d) at=
 %lld "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%d-%02d-%02d %02d:%02d:%02d.=
%09lu UTC)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state !=3D PM_SUSPEND_ON ? "sl=
eep" : "wakeup",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 requested_suspend_state, state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ktime_to_ns(ktime_get()),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_year + 1900, tm.tm_mon +=
 1, tm.tm_mday,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm.tm_hour, tm.tm_min, tm.tm_s=
ec, ts.tv_nsec);
>> + =A0 =A0 }
>> + =A0 =A0 requested_suspend_state =3D state;
>> + =A0 =A0 if (state =3D=3D PM_SUSPEND_ON)
>> + =A0 =A0 =A0 =A0 =A0 =A0 suspend_block(&main_suspend_blocker);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 suspend_unblock(&main_suspend_blocker);
>> + =A0 =A0 spin_unlock_irqrestore(&state_lock, irqflags);
>> +}
>> +
>> +static int __init suspend_block_init(void)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 suspend_blocker_init(&main_suspend_blocker, "main");
>> + =A0 =A0 suspend_block(&main_suspend_blocker);
>> +
>> + =A0 =A0 ret =3D sysdev_class_register(&suspend_block_sysclass);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("suspend_block_init: sysdev_class_regis=
ter failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysdev_class_register;
>> + =A0 =A0 }
>> + =A0 =A0 ret =3D sysdev_register(&suspend_block_sysdev);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("suspend_block_init: suspend_block_sysd=
ev failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysdev_register;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 suspend_work_queue =3D create_singlethread_workqueue("suspend"=
);
>
> Do we need a separate workqueue for this purpose?
>

Yes. Some drivers wait on work that runs on the main workqueue in
their suspend handler.

>> + =A0 =A0 if (suspend_work_queue =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_suspend_work_queue;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_suspend_work_queue:
>> + =A0 =A0 sysdev_unregister(&suspend_block_sysdev);
>> +err_sysdev_register:
>> + =A0 =A0 sysdev_class_unregister(&suspend_block_sysclass);
>> +err_sysdev_class_register:
>> + =A0 =A0 suspend_blocker_destroy(&main_suspend_blocker);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void =A0__exit suspend_block_exit(void)
>> +{
>> + =A0 =A0 destroy_workqueue(suspend_work_queue);
>> + =A0 =A0 sysdev_unregister(&suspend_block_sysdev);
>> + =A0 =A0 sysdev_class_unregister(&suspend_block_sysclass);
>> + =A0 =A0 suspend_blocker_destroy(&main_suspend_blocker);
>> +}
>> +
>> +core_initcall(suspend_block_init);
>> +module_exit(suspend_block_exit);
>
> Thanks,
> Rafael
>



-- =

Arve Hj=F8nnev=E5g
