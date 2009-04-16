From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 15 Apr 2009 18:45:00 -0700
Message-ID: <d6200be20904151845h4d6c27a0t771623ef3330ae8b@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
	<20090415223130.GC3679@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090415223130.GC3679@linux.intel.com>
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

2009/4/15 mark gross <mgross@linux.intel.com>:
> I'm sure you are sick of this question, but couldn't you do this same
> functionality (constraining entry to Suspend) using existing
> infrastructure. =A0You are clearly aggregating a block-count and triggeri=
ng
> on an zero aggregate value to enter Suspend.

The only reason I have a block count, is that the feedback on this
list was that it is too expensive to use a spin-lock every time we
want to block or unblock suspend. The later patches that enable stats
and timeout support uses inactive and active lists instead.

>
> I'm thinking you could do something like CPUIDLE to push the implicit
> suspend call and use a new pmqos parameter to keep the system alive.
> We'd have to look at the API to make sure it would work in interrupt
> mode.
>
> The only thing I got from the earlier threads asking why not PMQOS, was
> some complaint about the strcmp the constraint aggregation does WRT
> performance. =A0I don't think it would be too hard to address the perceiv=
ed
> performance issue (even if its yet to be proven as an issue anywhere)

There was a question about why we did not use pmqos instead othe the
idle wake locks. One reason was that we mainly needed to prevent a
specific state to not loose interrupts, not because the latency was
too high. The other reason was that the pm qos interface uses strings
instead of handles. Using strings to search to a list for the item you
want to update has an impact on performance that is not hard to
measure, but it also require the clients to create unique strings.

> FWIW there is some talk of re-factoring some of pmqos to sit on top of a
> constraint framework (to generalize the code a little and support
> constraining things that are not really measurable in terms of latencies
> or throughputs)
>

That should help with replacing the idle-wake-locks.

> anyway a few comments below.
>
> On Tue, Apr 14, 2009 at 06:41:25PM -0700, Arve Hj=F8nnev=E5g wrote:
>> Adds /sys/power/request_state, a non-blocking interface that specifies
>> which suspend state to enter when no suspend blockers are active. A
>> special state, "on", stops the process by activating the "main" suspend
>> blocker.
>>
>> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>> ---
>> =A0Documentation/power/suspend-blockers.txt | =A0 76 +++++++++
>> =A0include/linux/suspend_block.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 61 +++++++
>> =A0kernel/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10=
 ++
>> =A0kernel/power/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
>> =A0kernel/power/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
62 +++++++
>> =A0kernel/power/power.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A06 +
>> =A0kernel/power/suspend_block.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0257 +++++++=
+++++++++++++++++++++++
>> =A07 files changed, 473 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/power/suspend-blockers.txt
>> =A0create mode 100755 include/linux/suspend_block.h
>> =A0create mode 100644 kernel/power/suspend_block.c
>>
>> diff --git a/Documentation/power/suspend-blockers.txt b/Documentation/po=
wer/suspend-blockers.txt
>> new file mode 100644
>> index 0000000..743b870
>> --- /dev/null
>> +++ b/Documentation/power/suspend-blockers.txt
>> @@ -0,0 +1,76 @@
>> +Suspend blockers
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +A suspend_blocker prevents the system from entering suspend.
>
> And trigger implicit entry into suspend when last blocker is released.
>
>> +
>> +If the suspend operation has already started when calling suspend_block=
 on a
>> +suspend_blocker, it will abort the suspend operation as long it has not=
 already
>> +reached the sysdev suspend stage. This means that calling suspend_block=
 from an
>> +interrupt handler or a freezeable thread always works, but if you call
>> +block_suspend from a sysdev suspend handler you must also return an err=
or from
>> +that handler to abort suspend.
>> +
>> +Suspend blockers can be used to allow user-space to decide which keys s=
hould
>> +wake the full system up and turn the screen on.
>
> Provided the user mode process controlling the screen power is in the cal=
ling
> path of user-space input-event thread.

What you mean by this? Our user-space input event thread does not turn
the screen on, but translates the events and queues the translated
event on another queue. As long as all queues are protected by a
suspend blocker, there is no requirement about which thread turns the
screen on.

>
> Basically it should be made clear that this is not a device PM
> implementation. =A0Its a global system suspend constraint system, where
> the count of blockers is aggregated in a static variable,
> suspend_block_count, within suspend_block.c =A0with implicit suspend
> called when block count gets to zero.
>
> i.e. only useful in platform specific code for platforms that can do
> ~10ms suspends and resumes.

I disagree. If I have a desktop system that takes 5 seconds to wake up
from sleep, I still want the ability to auto suspend after user
inactivity, and to prevent suspend while some tasks are running.

>
>> Use set_irq_wake or a platform
>> +specific api to make sure the keypad interrupt wakes up the cpu. Once t=
he keypad
>> +driver has resumed, the sequence of events can look like this:
>> +- The Keypad driver gets an interrupt. It then calls suspend_block on t=
he
>> + =A0keypad-scan suspend_blocker and starts scanning the keypad matrix.
> count =3D 1
>> +- The keypad-scan code detects a key change and reports it to the input=
-event
>> + =A0driver.
>> +- The input-event driver sees the key change, enqueues an event, and ca=
lls
>> + =A0suspend_block on the input-event-queue suspend_blocker.
> count =3D 2
>> +- The keypad-scan code detects that no keys are held and calls suspend_=
unblock
>> + =A0on the keypad-scan suspend_blocker.
> count =3D 1
>> +- The user-space input-event thread returns from select/poll, calls
>> + =A0suspend_block on the process-input-events suspend_blocker and then =
calls read
>> + =A0on the input-event device.
> count =3D 2
>> +- The input-event driver dequeues the key-event and, since the queue is=
 now
>> + =A0empty, it calls suspend_unblock on the input-event-queue suspend_bl=
ocker.
> count =3D 1
>> +- The user-space input-event thread returns from read. It determines th=
at the
>> + =A0key should not wake up the full system, calls suspend_unblock on the
>> + =A0process-input-events suspend_blocker and calls select or poll.
> count =3D 0 + race between dropping into Suspend state and the execution
> of the select or poll. =A0(should probably be ok)

This is not a race condition, select or poll does not affect the
suspend blocker in the input driver to it does not matter if the poll
is called before or after suspend.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Key pressed =A0 Key released
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 |
>> +keypad-scan =A0 =A0 =A0 =A0 =A0++++++++++++++++++
>> +input-event-queue =A0 =A0 =A0 =A0+++ =A0 =A0 =A0 =A0 =A0+++
>> +process-input-events =A0 =A0 =A0 +++ =A0 =A0 =A0 =A0 =A0+++
>> +
>> +

>> +struct suspend_blocker {
>> +#ifdef CONFIG_SUSPEND_BLOCK
>> + =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0flags;
>> + =A0 =A0 const char =A0 =A0 =A0 =A0 *name;
>> +#endif
>> +};
>> +
...
>> +
>> +#define SB_INITIALIZED =A0 =A0 =A0 =A0 =A0 =A0(1U << 8)
>> +#define SB_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1U << 9)
>> +
>> +static DEFINE_SPINLOCK(state_lock);
>> +static atomic_t suspend_block_count;
>
> So if suspend_block_count is the lynch pin of the design, why have all
> the suspend_blocker structs? =A0Why have all the logic around the
> different suspend blocker instances?

The suspend block structs need to be part of the api to allow stats
and/or debugging. It also ensures that a single suspend_blocker does
not change the global count by more than one. Also,
suspend_block_count is not part of the design, it is an optimization
that becomes useless when you enable stats.

>
> It seems like a lot of extra effort for an atomic "stay awake" counter.
>


-- =

Arve Hj=F8nnev=E5g
