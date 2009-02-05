From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 5 Feb 2009 14:51:58 -0800
Message-ID: <20090205225158.GA19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-2-git-send-email-arve@android.com>
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

On Wed, Feb 04, 2009 at 06:50:14PM -0800, Arve Hj=F8nnev=E5g wrote:
> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  Documentation/power/wakelocks.txt |   91 +++++++++++++++++++++++++++++++=
+++++
>  include/linux/wakelock.h          |   92 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 183 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/wakelocks.txt
>  create mode 100755 include/linux/wakelock.h
> =

> diff --git a/Documentation/power/wakelocks.txt b/Documentation/power/wake=
locks.txt
> new file mode 100644
> index 0000000..219bb11
> --- /dev/null
> +++ b/Documentation/power/wakelocks.txt
> @@ -0,0 +1,91 @@
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

How much of this can be implemented using a pm-qos approach?

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

This feels a lot like operating points implemented as a collection of
product specific binary locks.  How could this be generalized to be less
application specific?

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

um, if a driver grabs the wakelock for another device that is sleeping
how will it know when that sleeping device is ready to be used?  Is
wake_lock going to block until the dives its locking is in a good power
state?  (I'm guessing yes) Is doing this in the context of and IRQ a
good idea?

> +
> +When it no longer needs to run it calls wake_unlock:
> +	wake_unlock(&state->wakelock);
> +
> +It can also call wake_lock_timeout to release the wakelock after a delay:
> +	wake_lock_timeout(&state->wakelock, HZ);

Timer?

> +
> +This works whether the wakelock is already held or not. It is useful if =
the
> +driver woke up other parts of the system that do not use wakelocks but
> +still need to run. Avoid this when possible, since it will waste power
> +if the timeout is long or may fail to finish needed work if the timeout =
is
> +short.
> +
> +
> +User-space API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Write "lockname" or "lockname timeout" to /sys/power/wake_lock lock and =
if
> +needed create a wakelock. The timeout here is specified nanoseconds.
> +Write "lockname" to /sys/power/wake_unlock to unlock a user wakelock.
> +
> +Do not use randomly generated wakelock names as there is no api to free
> +a user-space wakelock.
> +
> diff --git a/include/linux/wakelock.h b/include/linux/wakelock.h
> new file mode 100755
> index 0000000..b17e993
> --- /dev/null
> +++ b/include/linux/wakelock.h
> @@ -0,0 +1,92 @@
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
> +#ifdef CONFIG_HAS_WAKELOCK

Shouldn't this #ifdef be in the files using wake_lock.h?  If
!CONFIG_HAS_WAKELOCK then should all the definitions here not be parsed
at compile time?

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
> +#ifdef CONFIG_HAS_WAKELOCK
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
> +/* has_wake_lock returns 0 if no wake locks of the specified type are ac=
tive,
> + * and non-zero if one or more wake locks are held. Specifically it retu=
rns
> + * -1 if one or more wake locks with no timeout are active or the
> + * number of jiffies until all active wake locks time out.
> + */
> +long has_wake_lock(int type);

Type? or class?  What is this type concept?  Should we have some strong
typing to the enum list above or at least a comment on what are the
types that are valid to call this API with?

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

I don't like these type of use of ifdef to no-op out API's do we really
need to do it this way?  =


> +
> +#endif
> +
> -- =

> 1.6.1
> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
