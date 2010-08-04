From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 21:47:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
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
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1955507232-1280897269=:25170"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1955507232-1280897269=:25170
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o744mFGT027849

On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:

> On Tue, Aug 3, 2010 at 5:51 PM,  <david@lang.hm> wrote:
>> On Tue, 3 Aug 2010, Paul E. McKenney wrote:
>>
>>> On Tue, Aug 03, 2010 at 04:19:25PM -0700, david@lang.hm wrote:
>>>>
>>>> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
>>>>
>>>>> 2010/8/2 =A0<david@lang.hm>:
>>>>>>
>>>>>> so what is the fundamental difference between deciding to go into
>>>>>> low-power
>>>>>> idle modes to wake up back up on a given point in the future and
>>>>>> deciding
>>>>>> that you are going to be idle for so long that you may as well sus=
pend
>>>>>> until
>>>>>> there is user input?
>>>>>>
>>>>>
>>>>> Low power idle modes are supposed to be transparent. Suspend stops =
the
>>>>> monotonic clock, ignores ready threads and switches over to a separ=
ate
>>>>> set of wakeup events/interrupts. We don't suspend until there is us=
er
>>>>> input, we suspend until there is a wakeup event (user-input, incomi=
ng
>>>>> network data/phone-calls, alarms etc..).
>>>>
>>>> s/user input/wakeup event/ and my question still stands.
>>>>
>>>> low power modes are not transparent to the user in all cases (if the
>>>> screen backlight dimms/shuts off a user reading something will
>>>> notice, if the system switches to a lower clock speed it can impact
>>>> user response time, etc) The system is making it's best guess as to
>>>> how to best srve the user by sacraficing some capibilities to save
>>>> power now so that the power can be available later.
>>>>
>>>> as I see it, suspending until a wakeup event (button press, incoming
>>>> call, alarm, etc) is just another datapoint along the same path.
>>>>
>>>> If the system could not wake itself up to respond to user input,
>>>> phone call, alarm, etc and needed the power button pressed to wake
>>>> up (or shut down to the point where the battery could be removed and
>>>> reinstalled a long time later), I would see things moving into a
>>>> different category, but as long as the system has the ability to
>>>> wake itself up later (and is still consuming power) I see the
>>>> suspend as being in the same category as the other low-power modes
>>>> (it's just more expensive to go in and out of)
>>>>
>>>>
>>>> why should the suspend be put into a different category from the
>>>> other low-power states?
>>>
>>> OK, I'll bite...
>>
>> thanks, this is not intended to be a trap.
>>
>>> From an Android perspective, the differences are as follows:
>>>
>>> 1. =A0 =A0 =A0Deep idle states are entered only if there are no runna=
ble tasks.
>>> =A0 =A0 =A0 =A0In contrast, opportunistic suspend can happen even whe=
n there
>>> =A0 =A0 =A0 =A0are tasks that are ready, willing, and able to run.
>>
>> Ok, this is a complication to what I'm proposing (and seems a little o=
dd,
>> but I can see how it can work), but not neccessarily a major problem. =
it
>> depends on exactly how the decision is made to go into low power state=
s
>> and/or suspend. If this is done by an application that is able to look=
 at
>> either all activity or ignore one cgroup of processes at different tim=
es in
>> it's calculations than this would work.
>>
>>> 2. =A0 =A0 =A0There can be a set of input events that do not bring th=
e system
>>> =A0 =A0 =A0 =A0out of suspend, but which would bring the system out o=
f a deep
>>> =A0 =A0 =A0 =A0idle state. =A0For example, I believe that it was stat=
ed that one
>>> =A0 =A0 =A0 =A0of the Android-based smartphones ignores touchscreen i=
nput while
>>> =A0 =A0 =A0 =A0suspended, but pays attention to it while in deep idle=
 states.
>>
>> I see this as simply being a matter of what devices are still enabled =
at the
>> different power savings levels. At one level the touchscreen is still
>> powered, while at another level it isn't, and at yet another level you=
 have
>> to hit the power soft-button. This isn't fundamentally different from
>> powering off a USB peripheral that the system decides is idle (and the=
n not
>> seeing input from it until something else wakes the system)
>
> The touchscreen on android devices is powered down long before we
> suspend, so that is not a good example. There is still a significant
> difference between suspend and idle though. In idle all interrupts
> work, in suspend only interrupts that the driver has called
> enable_irq_wake on will work (on platforms that support it).

are you talking about Android here or are you talking genricly across all=
=20
platforms?

>>
>>> 3. =A0 =A0 =A0The system comes out of a deep idle state when a timer
>>> =A0 =A0 =A0 =A0expires. =A0In contrast, timers cannot expire while th=
e
>>> =A0 =A0 =A0 =A0system is suspended. =A0(This one is debatable: some p=
eople
>>> =A0 =A0 =A0 =A0argue that timers are subject to jitter, and the suspe=
nd
>>> =A0 =A0 =A0 =A0case for timers is the same as that for deep idle stat=
es,
>>> =A0 =A0 =A0 =A0but with unbounded timer jitter. =A0Others disagree. =A0=
The
>>> =A0 =A0 =A0 =A0resulting discussions have produced much heat, but lit=
tle
>>> =A0 =A0 =A0 =A0light. =A0Such is life.)
>>
>> if you have the ability to wake for an alarm, you have the ability to =
wake
>> for a timer (if from no other method than to set the alarm to when the=
 timer
>> tick would go off)
>>
>
> If you just program the alarm you will wake up see that the monotonic
> clock has not advanced and set the alarm another n seconds into the
> future. Or are proposing that suspend should be changed to keep the
> monotonic clock running? If you are, why? We can enter the same
> hardware states from idle, and modifying suspend to wake up more often
> would increase the average power consumption in suspend, not improve
> it for idle. In other words, if suspend wakes up as often as idle, why
> use suspend?

no, I was thinking that you set the alarm to go off, and when it goes off=
=20
and wakes you up, you correct other local clocks before doing anything=20
else.

even if they wake up at the same time, you would use suspend instead of=20
idle if it saved more power (allowing for the power to get in and out of=20
suspend vs the power to get in and out of idle)

in this case, another reason you would consider using suspend over idle i=
s=20
that you can suspend until the next timer that your privilaged=20
applications have set, and skip timers set by the non-privilaged=20
applications, resulting in more time asleep.

>>> There may well be others.
>>>
>>> Whether these distinctions are a good thing or a bad thing is one of
>>> the topics of this discussion. =A0But the distinctions themselves are
>>> certainly very real, from what I can see.
>>>
>>> Or am I missing your point?
>>
>> these big distinction that I see as significant seem to be in the deci=
sion
>> of when to go into the different states, and the difference between th=
e
>> states =A0themselves seem to be less significant (and either very clos=
e to, or
>> within the variation that already exists for power saving modes)
>>
>> If I'm right bout this, then it would seem to simplify the concept and
>> change it from some really foreign android-only thing into a special c=
ase
>> variation of existing core concepts.
>
> Suspend is not an android only concept. The android extensions just
> allow us to aggressively use suspend without loosing (or delaying)
> wakeup events. On the hardware that we shipped we can enter the same
> power mode from idle as we do in suspend, but we still use suspend
> primarily because it stops the monotonic clock and all the timers that
> use it. Changing suspend to behave more like an idle mode, which seems
> to be what you are suggesting, would not buy us anything.

Ok, If I am understanding you correctly I think this is an important=20
point.

What Android calls suspend is not what other linux distros call suspend,=20
it's just a low-power mode with different wakeup rules.

Is this correct?

If this is the case it seems even more so that the android suspend should=
=20
be addressed by tieing into the power management/idle stuff rather than=20
the suspend/hibernate side of things

is the reason you want to stop the onotonic clock and the timers because=20
the applications need to be fooled into thinking no time has passed?

or is it to prevent extranious wakeups?

or is it to save additional power?

>> you have many different power saving modes, the daemon (or kernel code=
) that
>> is determining which mode to go into would need different logic (inclu=
ding,
>> but not limited to the ability to be able to ignore one or more cgroup=
s of
>> processes). different power saving modes have different trade-offs, an=
d some
>> of them power down different peripherals (which is always a platform
>> specific, if not system specific set of trade-offs)
>>
>
> The hardware specific idle hook can (and does) decide to go into any
> power state from idle that does not disrupt any active devices.

This I know is an Andoid specific thing. On other platforms power states=20
very definantly can make user visible changes.

>> This all depends on the ability for the code that decides to switch po=
wer
>> modes (including to trigger suspend) to be able to see things in suffi=
cient
>> detail to be able to do different things depending on the class of pro=
grams.
>> I don't know enough about this code to know if this is the case or not=
, I
>> really wish that someone familiar with the power saving code could eit=
her
>> confirm that this is possible, or state that it's not possible (or at =
least,
>> not without major surgery)
--680960-1955507232-1280897269=:25170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1955507232-1280897269=:25170--
