From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 22:59:24 -0700
Message-ID: <AANLkTi=O++qfY7zz5rErqWQn0n4Tj7dfxQNcytjwiP4q__29795.8731688142$1280901621$gmane$org@mail.gmail.com>
References: <20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>
	<20100804001015.GJ2407@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008031723530.6545@asgard.lang.hm>
	<AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
	<alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/8/3  <david@lang.hm>:
> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
>
>> On Tue, Aug 3, 2010 at 5:51 PM, =A0<david@lang.hm> wrote:
>>>
>>> On Tue, 3 Aug 2010, Paul E. McKenney wrote:
>>>
>>>> On Tue, Aug 03, 2010 at 04:19:25PM -0700, david@lang.hm wrote:
>>>>>
>>>>> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
>>>>>
>>>>>> 2010/8/2 =E1<david@lang.hm>:
>>>>>>>
>>>>>>> so what is the fundamental difference between deciding to go into
>>>>>>> low-power
>>>>>>> idle modes to wake up back up on a given point in the future and
>>>>>>> deciding
>>>>>>> that you are going to be idle for so long that you may as well
>>>>>>> suspend
>>>>>>> until
>>>>>>> there is user input?
>>>>>>>
>>>>>>
>>>>>> Low power idle modes are supposed to be transparent. Suspend stops t=
he
>>>>>> monotonic clock, ignores ready threads and switches over to a separa=
te
>>>>>> set of wakeup events/interrupts. We don't suspend until there is user
>>>>>> input, we suspend until there is a wakeup event (user-input, incoming
>>>>>> network data/phone-calls, alarms etc..).
>>>>>
>>>>> s/user input/wakeup event/ and my question still stands.
>>>>>
>>>>> low power modes are not transparent to the user in all cases (if the
>>>>> screen backlight dimms/shuts off a user reading something will
>>>>> notice, if the system switches to a lower clock speed it can impact
>>>>> user response time, etc) The system is making it's best guess as to
>>>>> how to best srve the user by sacraficing some capibilities to save
>>>>> power now so that the power can be available later.
>>>>>
>>>>> as I see it, suspending until a wakeup event (button press, incoming
>>>>> call, alarm, etc) is just another datapoint along the same path.
>>>>>
>>>>> If the system could not wake itself up to respond to user input,
>>>>> phone call, alarm, etc and needed the power button pressed to wake
>>>>> up (or shut down to the point where the battery could be removed and
>>>>> reinstalled a long time later), I would see things moving into a
>>>>> different category, but as long as the system has the ability to
>>>>> wake itself up later (and is still consuming power) I see the
>>>>> suspend as being in the same category as the other low-power modes
>>>>> (it's just more expensive to go in and out of)
>>>>>
>>>>>
>>>>> why should the suspend be put into a different category from the
>>>>> other low-power states?
>>>>
>>>> OK, I'll bite...
>>>
>>> thanks, this is not intended to be a trap.
>>>
>>>> From an Android perspective, the differences are as follows:
>>>>
>>>> 1. =E1 =E1 =E1Deep idle states are entered only if there are no runnab=
le
>>>> tasks.
>>>> =E1 =E1 =E1 =E1In contrast, opportunistic suspend can happen even when=
 there
>>>> =E1 =E1 =E1 =E1are tasks that are ready, willing, and able to run.
>>>
>>> Ok, this is a complication to what I'm proposing (and seems a little od=
d,
>>> but I can see how it can work), but not neccessarily a major problem. it
>>> depends on exactly how the decision is made to go into low power states
>>> and/or suspend. If this is done by an application that is able to look =
at
>>> either all activity or ignore one cgroup of processes at different times
>>> in
>>> it's calculations than this would work.
>>>
>>>> 2. =E1 =E1 =E1There can be a set of input events that do not bring the=
 system
>>>> =E1 =E1 =E1 =E1out of suspend, but which would bring the system out of=
 a deep
>>>> =E1 =E1 =E1 =E1idle state. =E1For example, I believe that it was state=
d that one
>>>> =E1 =E1 =E1 =E1of the Android-based smartphones ignores touchscreen in=
put while
>>>> =E1 =E1 =E1 =E1suspended, but pays attention to it while in deep idle =
states.
>>>
>>> I see this as simply being a matter of what devices are still enabled at
>>> the
>>> different power savings levels. At one level the touchscreen is still
>>> powered, while at another level it isn't, and at yet another level you
>>> have
>>> to hit the power soft-button. This isn't fundamentally different from
>>> powering off a USB peripheral that the system decides is idle (and then
>>> not
>>> seeing input from it until something else wakes the system)
>>
>> The touchscreen on android devices is powered down long before we
>> suspend, so that is not a good example. There is still a significant
>> difference between suspend and idle though. In idle all interrupts
>> work, in suspend only interrupts that the driver has called
>> enable_irq_wake on will work (on platforms that support it).
>
> are you talking about Android here or are you talking genricly across all
> platforms?
>

This appears to be the current Linux driver model. Old platform code
hardcoded the wakeup interrupts.

>>>
>>>> 3. =E1 =E1 =E1The system comes out of a deep idle state when a timer
>>>> =E1 =E1 =E1 =E1expires. =E1In contrast, timers cannot expire while the
>>>> =E1 =E1 =E1 =E1system is suspended. =E1(This one is debatable: some pe=
ople
>>>> =E1 =E1 =E1 =E1argue that timers are subject to jitter, and the suspend
>>>> =E1 =E1 =E1 =E1case for timers is the same as that for deep idle state=
s,
>>>> =E1 =E1 =E1 =E1but with unbounded timer jitter. =E1Others disagree. =
=E1The
>>>> =E1 =E1 =E1 =E1resulting discussions have produced much heat, but litt=
le
>>>> =E1 =E1 =E1 =E1light. =E1Such is life.)
>>>
>>> if you have the ability to wake for an alarm, you have the ability to
>>> wake
>>> for a timer (if from no other method than to set the alarm to when the
>>> timer
>>> tick would go off)
>>>
>>
>> If you just program the alarm you will wake up see that the monotonic
>> clock has not advanced and set the alarm another n seconds into the
>> future. Or are proposing that suspend should be changed to keep the
>> monotonic clock running? If you are, why? We can enter the same
>> hardware states from idle, and modifying suspend to wake up more often
>> would increase the average power consumption in suspend, not improve
>> it for idle. In other words, if suspend wakes up as often as idle, why
>> use suspend?
>
> no, I was thinking that you set the alarm to go off, and when it goes off
> and wakes you up, you correct other local clocks before doing anything el=
se.
>
> even if they wake up at the same time, you would use suspend instead of i=
dle
> if it saved more power (allowing for the power to get in and out of suspe=
nd
> vs the power to get in and out of idle)

Suspend and idle use the same power state on the devices we shipped.
The power saving we get from suspend if from ignoring the timers.

>
> in this case, another reason you would consider using suspend over idle is
> that you can suspend until the next timer that your privilaged applicatio=
ns
> have set, and skip timers set by the non-privilaged applications, resulti=
ng
> in more time asleep.

Without wakelock or suspend blockers this can still break since a
privileged application may be waiting on a resource held by a
non-privileged application.

>
>>>> There may well be others.
>>>>
>>>> Whether these distinctions are a good thing or a bad thing is one of
>>>> the topics of this discussion. =E1But the distinctions themselves are
>>>> certainly very real, from what I can see.
>>>>
>>>> Or am I missing your point?
>>>
>>> these big distinction that I see as significant seem to be in the
>>> decision
>>> of when to go into the different states, and the difference between the
>>> states =E1themselves seem to be less significant (and either very close=
 to,
>>> or
>>> within the variation that already exists for power saving modes)
>>>
>>> If I'm right bout this, then it would seem to simplify the concept and
>>> change it from some really foreign android-only thing into a special ca=
se
>>> variation of existing core concepts.
>>
>> Suspend is not an android only concept. The android extensions just
>> allow us to aggressively use suspend without loosing (or delaying)
>> wakeup events. On the hardware that we shipped we can enter the same
>> power mode from idle as we do in suspend, but we still use suspend
>> primarily because it stops the monotonic clock and all the timers that
>> use it. Changing suspend to behave more like an idle mode, which seems
>> to be what you are suggesting, would not buy us anything.
>
> Ok, If I am understanding you correctly I think this is an important poin=
t.
>
> What Android calls suspend is not what other linux distros call suspend,
> it's just a low-power mode with different wakeup rules.
>
> Is this correct?
>

No. Android suspend is Linux suspend. We just enter it more frequently.

> If this is the case it seems even more so that the android suspend should=
 be
> addressed by tieing into the power management/idle stuff rather than the
> suspend/hibernate side of things
>
> is the reason you want to stop the onotonic clock and the timers because =
the
> applications need to be fooled into thinking no time has passed?
>

Yes, but this is not an Android extension, it is part of the normal
Linux suspend sequence.

> or is it to prevent extranious wakeups?
>
That too.

> or is it to save additional power?
>
No (assuming you are asking about the clock), the actual hardware
clock (on msm) stops even in idle but it is resynchronized on wakeup
with a clock that never stops when used from idle.

>>> you have many different power saving modes, the daemon (or kernel code)
>>> that
>>> is determining which mode to go into would need different logic
>>> (including,
>>> but not limited to the ability to be able to ignore one or more cgroups
>>> of
>>> processes). different power saving modes have different trade-offs, and
>>> some
>>> of them power down different peripherals (which is always a platform
>>> specific, if not system specific set of trade-offs)
>>>
>>
>> The hardware specific idle hook can (and does) decide to go into any
>> power state from idle that does not disrupt any active devices.
>
> This I know is an Andoid specific thing. On other platforms power states
> very definantly can make user visible changes.

How is this Android specific?

>
>>> This all depends on the ability for the code that decides to switch pow=
er
>>> modes (including to trigger suspend) to be able to see things in
>>> sufficient
>>> detail to be able to do different things depending on the class of
>>> programs.
>>> I don't know enough about this code to know if this is the case or not,=
 I
>>> really wish that someone familiar with the power saving code could eith=
er
>>> confirm that this is possible, or state that it's not possible (or at
>>> least,
>>> not without major surgery)



-- =

Arve Hj=F8nnev=E5g
