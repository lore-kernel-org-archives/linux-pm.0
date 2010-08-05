From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 17:00:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041654100.6545__17444.6594821804$1280966594$gmane$org@asgard.lang.hm>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
	<alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
	<AANLkTiknyohok23S7dob=Tb1+PZp1QqZgwckcVDWMSe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-241120125-1280966445=:6545"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTiknyohok23S7dob=Tb1+PZp1QqZgwckcVDWMSe9@mail.gmail.com>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-241120125-1280966445=:6545
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o7501XAw011542

On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:

> 2010/8/4  <david@lang.hm>:
>> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
>>
>>> 2010/8/4 =A0<david@lang.hm>:
>>>>
>>>> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
>>>>
>>>>> On Wed, Aug 4, 2010 at 3:31 PM, =A0<david@lang.hm> wrote:
>>>>>>
>>>>>> On Wed, 4 Aug 2010, Matthew Garrett wrote:
>>>>>>
>>>>>>> On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote=
:
>>>>>>>>
>>>>>>>> On Wednesday, August 04, 2010, Matthew Garrett wrote:
>>>>>>>>>
>>>>>>>>> No! And that's precisely the issue. Android's existing behaviou=
r
>>>>>>>>> could
>>>>>>>>> be entirely implemented in the form of binary that manually tri=
ggers
>>>>>>>>> suspend when (a) the screen is off and (b) no userspace applica=
tions
>>>>>>>>> have indicated that the system shouldn't sleep, except for the
>>>>>>>>> wakeup
>>>>>>>>> event race. Imagine the following:
>>>>>>>>>
>>>>>>>>> 1) The policy timeout is about to expire. No applications are
>>>>>>>>> holding
>>>>>>>>> wakelocks. The system will suspend providing nothing takes a
>>>>>>>>> wakelock.
>>>>>>>>> 2) A network packet arrives indicating an incoming SIP call
>>>>>>>>> 3) The VOIP application takes a wakelock and prevents the phone=
 from
>>>>>>>>> suspending while the call is in progress
>>>>>>>>>
>>>>>>>>> What stops the system going to sleep between (2) and (3)? cgrou=
ps
>>>>>>>>> don't,
>>>>>>>>> because the voip app is an otherwise untrusted application that
>>>>>>>>> you've
>>>>>>>>> just told the scheduler to ignore.
>>>>>>>>
>>>>>>>> I _think_ you can use the just-merged /sys/power/wakeup_count
>>>>>>>> mechanism
>>>>>>>> to
>>>>>>>> avoid the race (if pm_wakeup_event() is called at 2)).
>>>>>>>
>>>>>>> Yes, I think that solves the problem. The only question then is
>>>>>>> whether
>>>>>>> it's preferable to use cgroups or suspend fully, which is pretty =
much
>>>>>>> up
>>>>>>> to the implementation. In other words, is there a reason we're st=
ill
>>>>>>> having this conversation? :) It'd be good to have some feedback f=
rom
>>>>>>> Google as to whether this satisfies their functional requirements.
>>>>>>
>>>>>> the proposal that I nade was not to use cgroups to freeze some
>>>>>> processes
>>>>>> and
>>>>>> not others, but to use cgroups to decide to ignore some processes =
when
>>>>>> deciding if the system is idle, stop everything or nothing. cgroup=
s are
>>>>>> just
>>>>>> a way of easily grouping processes (and their children) into diffe=
rent
>>>>>> groups.
>>>>>>
>>>>>
>>>>> That does not avoid the dependency problem. A process may be waitin=
g
>>>>> on a resource that a process you ignore owns. I you ignore the proc=
ess
>>>>> that owns the resource and enter idle when it is ready to run (or
>>>>> waiting on a timer), you are still effectively blocking the other
>>>>> process.
>>>>
>>>> and if you don't have a wakelock the same thing will happen. If you
>>>> expect
>>>
>>> Not the same thing. If you don't hold a wakelock the entire system
>>> will suspend and when it wakes up it continues where it left off.
>>> Timeout still have time left before they expire.
>>
>> in what I'm proposing, if the 'privilaged/trusted" processes are idle =
long
>> enough the entire system will suspend, and when it wakes up everything=
 will
>> continue to process normally
>>
>
> If you are triggering a system suspend from idle (I assume all cpus
> idle), you also have to consider when to resume. You cannot abort
> suspend just because a cpu is not idle anymore, since suspend itself
> will wake up threads.

since the premise is that we only consider the activity of some processes=
=20
when we are deciding if the system is idle, it's very possible that not=20
all CPUs will be idle when we decide to suspend.

will suspend wake up the application threads? or will it create it's own=20
processes (and/or use processes that can be tagged ahead of time)?

>>>> the process to take a while you can set a timeout to wake up every 3=
0
>>>> seconds or so and wait again, this would be enough to prevent you fr=
om
>>>> going
>>>
>>> I don't think polling is an acceptable solution to this problem. You
>>> user space code know needs to know what "idle" timeout you have
>>> selected so it can choose a faster poll rate. When is it safe to stop
>>> polling?
>>
>> I think the timeouts are of such an order of magnatude that the pollin=
g can
>> be infrequent enough to not be a significant amount of load, but be fa=
ster
>> than any timeout
>>
>
> How do you ever enter suspend in this system? Currently timers in the
> kernel and trusted user space code causes a significant power draw and
> you want insignificant timers to prevent suspend.

no, I want recent activity from a privilaged/trusted process to prevent=20
suspend. I'm saying that such a process can wake up infrequently enough=20
that the wakeups themselves are not a significant amount of processing if=
=20
it wants to keep the system awake so that other things can keep running.

you say below that the system will never suspend while the backlight is=20
on, well the process that monitors/controlls the backlight would be one o=
f=20
these trusted processes.

>>>> to sleep (or am I misunderstanding how long before you go into suspe=
nd
>>>> without a wakelock set, see my other e-mail for the full question)
>>>>
>>>
>>> We suspend as soon as no wakelocks are held. There is no delay.
>>
>> So, if I have a bookreader app that is not allowed to get the wakelock=
, and
>> nothing else is running, the system will suspend immediatly after I cl=
ick a
>> button to go to the next page? it will not stay awake to give me a cha=
nce to
>> read the page at all?
>>
>> how can any application run without wakelock privilages?
>
> A wakelock is active when the screen is on.

so what controls when the screen is on? what still needs to run (and keep=
=20
the system awake) if the screen is off?

David Lang
--680960-241120125-1280966445=:6545
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-241120125-1280966445=:6545--
