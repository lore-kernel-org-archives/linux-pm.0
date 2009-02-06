From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 5 Feb 2009 16:13:27 -0800
Message-ID: <d6200be20902051613k77ef5878v7734653749ead8a@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205225158.GA19577@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090205225158.GA19577@linux.intel.com>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 5, 2009 at 2:51 PM, mark gross <mgross@linux.intel.com> wrote:
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
> How much of this can be implemented using a pm-qos approach?

WAKE_LOCK_IDLE overlaps with pm-qos, if you use it to prevent latency.

>
>> +
>> +If the suspend operation has already started when locking a wakelock, i=
t will
>> +abort the suspend operation as long it has not already reached the susp=
end_late
>> +stage. This means that locking a wakelock from an interrupt handler or a
>> +freezeable thread always works, but if you lock a wakelock from a suspe=
nd_late
>> +handler you must also return an error from that handler to abort suspen=
d.
>> +
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
> This feels a lot like operating points implemented as a collection of
> product specific binary locks.  How could this be generalized to be less
> application specific?

Are you complaining about the example being product specific, or the
api? I don't think the api is product specific.

>> +When the driver determines that it needs to run (usually in an interrupt
>> +handler) it calls wake_lock:
>> +     wake_lock(&state->wakelock);
>
> um, if a driver grabs the wakelock for another device that is sleeping
> how will it know when that sleeping device is ready to be used?  Is

A driver does not grab another driver's wakelock. If your driver
depends on another device it should wait for resume to be called
before accessing it.

> wake_lock going to block until the dives its locking is in a good power
> state?  (I'm guessing yes) Is doing this in the context of and IRQ a
> good idea?

wake_lock never blocks.

>> +It can also call wake_lock_timeout to release the wakelock after a dela=
y:
>> +     wake_lock_timeout(&state->wakelock, HZ);
>
> Timer?

What is your question?


>> +struct wake_lock {
>> +#ifdef CONFIG_HAS_WAKELOCK
>
> Shouldn't this #ifdef be in the files using wake_lock.h?  If
> !CONFIG_HAS_WAKELOCK then should all the definitions here not be parsed
> at compile time?

I think the general policy is to avoid #ifdefs in the .c files.

>
>> +     struct list_head    link;
>> +     int                 flags;
>> +     const char         *name;
>> +     unsigned long       expires;
>> +#ifdef CONFIG_WAKELOCK_STAT
>> +     struct {
>> +             int             count;
>> +             int             expire_count;
>> +             int             wakeup_count;
>> +             ktime_t         total_time;
>> +             ktime_t         prevent_suspend_time;
>> +             ktime_t         max_time;
>> +             ktime_t         last_time;
>> +     } stat;
>> +#endif
>> +#endif
>> +};
>> +
>> +#ifdef CONFIG_HAS_WAKELOCK
>> +
>> +void wake_lock_init(struct wake_lock *lock, int type, const char *name);
>> +void wake_lock_destroy(struct wake_lock *lock);
>> +void wake_lock(struct wake_lock *lock);
>> +void wake_lock_timeout(struct wake_lock *lock, long timeout);
>> +void wake_unlock(struct wake_lock *lock);
>> +
>> +/* wake_lock_active returns a non-zero value if the wake_lock is curren=
tly
>> + * locked. If the wake_lock has a timeout, it does not check the timeou=
t,
>> + * but if the timeout had already expired when it was checked elsewhere
>> + * this function will return 0.
>> + */
>> +int wake_lock_active(struct wake_lock *lock);
>> +
>> +/* has_wake_lock returns 0 if no wake locks of the specified type are a=
ctive,
>> + * and non-zero if one or more wake locks are held. Specifically it ret=
urns
>> + * -1 if one or more wake locks with no timeout are active or the
>> + * number of jiffies until all active wake locks time out.
>> + */
>> +long has_wake_lock(int type);
>
> Type? or class?  What is this type concept?  Should we have some strong
> typing to the enum list above or at least a comment on what are the
> types that are valid to call this API with?

+       WAKE_LOCK_SUSPEND, /* Prevent suspend */
+       WAKE_LOCK_IDLE,    /* Prevent low power idle */

-- =

Arve Hj=F8nnev=E5g
