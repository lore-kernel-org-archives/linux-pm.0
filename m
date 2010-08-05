From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 18:02:28 -0700
Message-ID: <AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0__36891.4712490097$1280970202$gmane$org@mail.gmail.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<201008050220.51805.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008050220.51805.rjw@sisk.pl>
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
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/8/4 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, August 05, 2010, Arve Hj=F8nnev=E5g wrote:
>> On Wed, Aug 4, 2010 at 1:56 PM, Matthew Garrett <mjg59@srcf.ucam.org> wr=
ote:
>> > On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
>> >> On Wednesday, August 04, 2010, Matthew Garrett wrote:
>> >> > No! And that's precisely the issue. Android's existing behaviour co=
uld
>> >> > be entirely implemented in the form of binary that manually triggers
>> >> > suspend when (a) the screen is off and (b) no userspace applications
>> >> > have indicated that the system shouldn't sleep, except for the wake=
up
>> >> > event race. Imagine the following:
>> >> >
>> >> > 1) The policy timeout is about to expire. No applications are holdi=
ng
>> >> > wakelocks. The system will suspend providing nothing takes a wakelo=
ck.
>> >> > 2) A network packet arrives indicating an incoming SIP call
>> >> > 3) The VOIP application takes a wakelock and prevents the phone from
>> >> > suspending while the call is in progress
>> >> >
>> >> > What stops the system going to sleep between (2) and (3)? cgroups d=
on't,
>> >> > because the voip app is an otherwise untrusted application that you=
've
>> >> > just told the scheduler to ignore.
>> >>
>> >> I _think_ you can use the just-merged /sys/power/wakeup_count mechani=
sm to
>> >> avoid the race (if pm_wakeup_event() is called at 2)).
>> >
>> > Yes, I think that solves the problem. The only question then is whether
>>
>> How? By passing a timeout to pm_wakeup_event when the network driver
>> gets the packet or by passing 0. If you pass a timeout it is the same
>> as using a wakelock with a timeout and should work (assuming the
>> timeout you picked is long enough). If you don't pass a timeout it
>> does not work, since the packet may not be visible to user-space yet.
>
> Alternatively, pm_stay_awake() / pm_relax() can be used.
>

Which makes the driver and/or network stack changes identical to using
wakelocks, right?

>> > it's preferable to use cgroups or suspend fully, which is pretty much =
up
>> > to the implementation. In other words, is there a reason we're still
>>
>> I have seen no proposed way to use cgroups that will work. If you
>> leave some processes running while other processes are frozen you run
>> into problems when a frozen process holds a resource that a running
>> process needs.
>>
>>
>> > having this conversation? :) It'd be good to have some feedback from
>> > Google as to whether this satisfies their functional requirements.
>> >
>>
>> That is "this"? The merged code? If so, no it does not satisfy our
>> requirements. The in kernel api, while offering similar functionality
>> to the wakelock interface, does not use any handles which makes it
>> impossible to get reasonable stats (You don't know which pm_stay_awake
>> request pm_relax is reverting).
>
> Why is that a problem (out of curiosity)?
>

Not having stats or not knowing what pm_relax is undoing? We need
stats to be able to debug the system. If the system does not suspend
at all or is awake for too long, the wakelock stats tells us which
component is at fault. Since pm_stay_awake and pm_relax does not
operate on a handle, you cannot determine how long it prevented
suspend for.

>> The proposed in user-space interface
>> of calling into every process that receives wakeup events before every
>> suspend call
>
> Well, =A0you don't really need to do that.
>

Only if the driver blocks suspend until user-space has read the event.
This means that for android to work we need to block suspend when
input events are not processed, but a system using your scheme needs a
pm_wakeup_event call when the input event is queued. How to you switch
between them? Do we add separate ioctls in the input device to enable
each scheme? If someone has a single threaded user space power manager
that also reads input event it will deadlock if you block suspend
until it reads the input events since you block when reading the wake
count.

>> is also not compatible with existing apps.
>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
