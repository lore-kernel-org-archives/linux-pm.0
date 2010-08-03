From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 16:19:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008031611100.6545__16959.1554128148$1280877823$gmane$org@asgard.lang.hm>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<20100802030304.GU2470@linux.vnet.ibm.com>
	<20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1445541686-1280877566=:6545"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
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
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1445541686-1280877566=:6545
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o73NM1Gh027999

On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:

> 2010/8/2  <david@lang.hm>:
>> On Mon, 2 Aug 2010, Arve Hj?nnev?g wrote:
>>
>>> 2010/8/2 =A0<david@lang.hm>:
>>>>
>>>> On Mon, 2 Aug 2010, Arve Hj?nnev?g wrote:
>>>>
>>>>> On Mon, Aug 2, 2010 at 5:08 PM, =A0<david@lang.hm> wrote:
>>>>>>
>>>>>> On Mon, 2 Aug 2010, Paul E. McKenney wrote:
>>>>>>
>>>>>>
>>>>>> you are close, but I think what I'm proposing is actually simpler
>>>>>> (assuming
>>>>>> that the scheduler can be configured to generate the appropriate s=
tats)
>>>>>>
>>>>>> my thought was not to move applications between cgroups as they
>>>>>> aquire/release the suspend-block lock, bur rather to say that any
>>>>>> application that you would trust to get the suspend-block lock sho=
uld
>>>>>> be
>>>>>> in
>>>>>> cgroup A while all other applications are in cgroup B
>>>>>>
>>>>>> when you are deciding if the system shoudl go to sleep because it =
is
>>>>>> idle,
>>>>>> ignore the activity of all applications in cgroup B
>>>>>>
>>>>>> if cgroup A applications are busy, the system is not idle and shou=
ld
>>>>>> not
>>>>>> suspend.
>>>>>>
>>>>>
>>>>> Triggering suspend from idle has been suggested before. However, id=
le
>>>>> is not a signal that it is safe to suspend since timers stop in
>>>>> suspend (or the code could temporarily be waiting on a non-wakeup
>>>>> interrupt). If you add suspend blockers or wakelocks to prevent
>>>>> suspend while events you care about are pending, then it does not m=
ake
>>>>> a lot of sense to prevent suspend just because the cpu is not idle.
>>>>
>>>> isn't this a matter of making the suspend decision look at what time=
rs
>>>> have
>>>> been set to expire in the near future and/or tweaking how long the s=
ystem
>>>> needs to be idle before going to sleep?
>>>>
>>>
>>> You are describing low power idle modes, not suspend. Most timers sto=
p
>>> in suspend, so a timer set 10 seconds from now when entering suspend
>>> will go off 10 seconds after resume so it should have no impact on ho=
w
>>> long you decide to stay in suspend.
>>
>> so what is the fundamental difference between deciding to go into low-=
power
>> idle modes to wake up back up on a given point in the future and decid=
ing
>> that you are going to be idle for so long that you may as well suspend=
 until
>> there is user input?
>>
>
> Low power idle modes are supposed to be transparent. Suspend stops the
> monotonic clock, ignores ready threads and switches over to a separate
> set of wakeup events/interrupts. We don't suspend until there is user
> input, we suspend until there is a wakeup event (user-input, incoming
> network data/phone-calls, alarms etc..).

s/user input/wakeup event/ and my question still stands.

low power modes are not transparent to the user in all cases (if the=20
screen backlight dimms/shuts off a user reading something will notice, if=
=20
the system switches to a lower clock speed it can impact user response=20
time, etc) The system is making it's best guess as to how to best srve th=
e=20
user by sacraficing some capibilities to save power now so that the power=
=20
can be available later.

as I see it, suspending until a wakeup event (button press, incoming call=
,=20
alarm, etc) is just another datapoint along the same path.

If the system could not wake itself up to respond to user input, phone=20
call, alarm, etc and needed the power button pressed to wake up (or shut=20
down to the point where the battery could be removed and reinstalled a=20
long time later), I would see things moving into a different category, bu=
t=20
as long as the system has the ability to wake itself up later (and is=20
still consuming power) I see the suspend as being in the same category as=
=20
the other low-power modes (it's just more expensive to go in and out of)


why should the suspend be put into a different category from the other=20
low-power states?

David Lang
--680960-1445541686-1280877566=:6545
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1445541686-1280877566=:6545--
