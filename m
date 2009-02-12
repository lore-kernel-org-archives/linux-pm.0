From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/10] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 15:06:54 -0800
Message-ID: <d6200be20902121506v11761704y1803ad4f6b3acfd9@mail.gmail.com>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-2-git-send-email-arve@android.com>
	<20090212220049.GB5290@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090212220049.GB5290@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 12, 2009 at 2:00 PM, mark gross <mgross@linux.intel.com> wrote:
>> +A locked wakelock, depending on its type, prevents the system from ente=
ring
>> +suspend or other low-power states. When creating a wakelock, you can se=
lect
>> +if it prevents suspend or low-power idle states.  If the type is set to
>> +WAKE_LOCK_SUSPEND, the wakelock prevents a full system suspend. If the =
type
>> +is WAKE_LOCK_IDLE, low-power states that cause large interrupt latencie=
s, or
>> +that disable a set of interrupts, will not be entered from idle until t=
he
>> +wakelocks are released. Unless the type is specified, this document ref=
ers
>> +to wakelocks with the type set to WAKE_LOCK_SUSPEND.
>
> If there are no wakelocks held, what code path pushes the system to a
> lower state?  (wake_unlock?)

wake_unlock, wake_lock_timeout or the expire timer may wake up the
suspend worker which calls pm_suspend.

> Would it make more sense to remove the suspend types of locks?  Those
> seem to be pretty contentious.

I can remove the idle wake lock type from the patch, but I prefer to
keep the type so we can easily add types. We need the idle lock on the
g1 for now, and anyone adds emergency or high priority sleep support
to linux, we may want a separate wakelock type for that.

> Do the ARM devices really go into a suspend state or just a low power
> state?

If by suspend state you mean something more than halt or
wait-for-interrupt, then yes. The on the G1 the cpu core is powered
down, and when its wakes up it starts at the reset vector. But, it is
fast enough to also be usable from idle.

>> +Wakelocks can be used to allow user-space to decide which keys should w=
ake the
>> +full system up and turn the screen on. Use set_irq_wake or a platform s=
pecific
>> +api to make sure the keypad interrupt wakes up the cpu. Once the keypad=
 driver
>> +has resumed, the sequence of events can look like this:
>> +- The Keypad driver gets an interrupt. It then locks the keypad-scan wa=
kelock
>> +  and starts scanning the keypad matrix.
>> +- The keypad-scan code detects a key change and reports it to the input=
-event
>> +  driver.
>> +- The input-event driver sees the key change, enqueues an event, and lo=
cks
>> +  the input-event-queue wakelock.
>> +- The keypad-scan code detects that no keys are held and unlocks the
>> +  keypad-scan wakelock.
>
> Lets assume the system drops to suspend after 0ms of no-locks held.
> Don't we have a race between the keypad driver unlocking the only lock
> and inpu-event-queue lock getting taken?

The input-event-queue lock is locked before the keypad driver lock is unloc=
ked.

>> +- The user-space input-event thread returns from select/poll, locks the
>> +  process-input-events wakelock and then calls read in the input-event =
device.
>> +- The input-event driver dequeues the key-event and, since the queue is=
 now
>> +  empty, it unlocks the input-event-queue wakelock.
>> +- The user-space input-event thread returns from read. It determines th=
at the
>> +  key should not wake up the full system, releases the process-input-ev=
ents
>> +  wakelock and calls select or poll.
>> +
>> +                 Key pressed   Key released
>> +                     |             |
>> +keypad-scan          ++++++++++++++++++
>> +input-event-queue        +++          +++
>> +process-input-events       +++          +++
>> +
>
> it feels like there needs to be interlocking wakelocks to keep the
> system from unexpectedly falling asleep.  Or, some hysteresis slop time
> baked in to hide the races.

These locks overlap. There is no need for any slop time.

>> +static void __wake_lock(struct wake_lock *lock, long timeout, bool has_=
timeout)
>
> If the timeout =3D=3D 0 or < 0 can you assume has_timeout?

No, wake_lock(lock) is different from wake_lock_timeout(lock, 0) or
wake_lock_timeout(lock, -1).


>> +/**
>> + * wake_lock() - Lock a wakelock
>> + * @lock:       The wakelock to lock.
>> + */
>> +void wake_lock(struct wake_lock *lock)
>
> Naming is a little confusing to me.  wake_lock(...) reads as an
> initialization / constructor type of function, but its really a locking
> operation.  Perhaps lock_wake_lock would be more clear.

So is spin_lock. Most init functions in the kernel have init in their name.

>> +/**
>> + * wake_lock() - Unlock a wakelock
>> + * @lock:       The wakelock to unlock.
>> + */
>> +void wake_unlock(struct wake_lock *lock)
>
> unlock_wake_lock?

That does not seem consistent with other kernel apis.


>> +int wake_lock_active(struct wake_lock *lock)
>> +{
>> +     return !!(lock->flags & WAKE_LOCK_ACTIVE);
>
> A double bang? '!!'  shouldn't this be syntax error?  looks odd.

No.

>
>> +}
>> +EXPORT_SYMBOL(wake_lock_active);
>> +
>> +void request_suspend_state(suspend_state_t state)
>> +{
>> +     unsigned long irqflags;
>> +     spin_lock_irqsave(&state_lock, irqflags);
> why not grab this lock after the debug_mask if block?

To make sure the debug output is correct. It prints state protected by
the spinlock.


-- =

Arve Hj=F8nnev=E5g
