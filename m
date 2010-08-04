From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 16:23:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041620010.6545__24549.008816439$1280964382$gmane$org@asgard.lang.hm>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041124580.6545@asgard.lang.hm>
	<20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1223617944-1280964223=:6545"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
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

--680960-1223617944-1280964223=:6545
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o74NOigH006579

On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:

> 2010/8/4  <david@lang.hm>:
>> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
>>
>>> On Wed, Aug 4, 2010 at 3:31 PM, =A0<david@lang.hm> wrote:
>>>>
>>>> On Wed, 4 Aug 2010, Matthew Garrett wrote:
>>>>
>>>>> On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
>>>>>>
>>>>>> On Wednesday, August 04, 2010, Matthew Garrett wrote:
>>>>>>>
>>>>>>> No! And that's precisely the issue. Android's existing behaviour =
could
>>>>>>> be entirely implemented in the form of binary that manually trigg=
ers
>>>>>>> suspend when (a) the screen is off and (b) no userspace applicati=
ons
>>>>>>> have indicated that the system shouldn't sleep, except for the wa=
keup
>>>>>>> event race. Imagine the following:
>>>>>>>
>>>>>>> 1) The policy timeout is about to expire. No applications are hol=
ding
>>>>>>> wakelocks. The system will suspend providing nothing takes a wake=
lock.
>>>>>>> 2) A network packet arrives indicating an incoming SIP call
>>>>>>> 3) The VOIP application takes a wakelock and prevents the phone f=
rom
>>>>>>> suspending while the call is in progress
>>>>>>>
>>>>>>> What stops the system going to sleep between (2) and (3)? cgroups
>>>>>>> don't,
>>>>>>> because the voip app is an otherwise untrusted application that y=
ou've
>>>>>>> just told the scheduler to ignore.
>>>>>>
>>>>>> I _think_ you can use the just-merged /sys/power/wakeup_count mech=
anism
>>>>>> to
>>>>>> avoid the race (if pm_wakeup_event() is called at 2)).
>>>>>
>>>>> Yes, I think that solves the problem. The only question then is whe=
ther
>>>>> it's preferable to use cgroups or suspend fully, which is pretty mu=
ch up
>>>>> to the implementation. In other words, is there a reason we're stil=
l
>>>>> having this conversation? :) It'd be good to have some feedback fro=
m
>>>>> Google as to whether this satisfies their functional requirements.
>>>>
>>>> the proposal that I nade was not to use cgroups to freeze some proce=
sses
>>>> and
>>>> not others, but to use cgroups to decide to ignore some processes wh=
en
>>>> deciding if the system is idle, stop everything or nothing. cgroups =
are
>>>> just
>>>> a way of easily grouping processes (and their children) into differe=
nt
>>>> groups.
>>>>
>>>
>>> That does not avoid the dependency problem. A process may be waiting
>>> on a resource that a process you ignore owns. I you ignore the proces=
s
>>> that owns the resource and enter idle when it is ready to run (or
>>> waiting on a timer), you are still effectively blocking the other
>>> process.
>>
>> and if you don't have a wakelock the same thing will happen. If you ex=
pect
>
> Not the same thing. If you don't hold a wakelock the entire system
> will suspend and when it wakes up it continues where it left off.
> Timeout still have time left before they expire.

in what I'm proposing, if the 'privilaged/trusted" processes are idle lon=
g=20
enough the entire system will suspend, and when it wakes up everything=20
will continue to process normally

>> the process to take a while you can set a timeout to wake up every 30
>> seconds or so and wait again, this would be enough to prevent you from=
 going
>
> I don't think polling is an acceptable solution to this problem. You
> user space code know needs to know what "idle" timeout you have
> selected so it can choose a faster poll rate. When is it safe to stop
> polling?

I think the timeouts are of such an order of magnatude that the polling=20
can be infrequent enough to not be a significant amount of load, but be=20
faster than any timeout

>> to sleep (or am I misunderstanding how long before you go into suspend
>> without a wakelock set, see my other e-mail for the full question)
>>
>
> We suspend as soon as no wakelocks are held. There is no delay.

So, if I have a bookreader app that is not allowed to get the wakelock,=20
and nothing else is running, the system will suspend immediatly after I=20
click a button to go to the next page? it will not stay awake to give me =
a=20
chance to read the page at all?

how can any application run without wakelock privilages?

David Lang
--680960-1223617944-1280964223=:6545
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1223617944-1280964223=:6545--
