From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 17:34:06 +0200
Message-ID: <201008051734.06736.rjw__35044.7426936173$1281027307$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<201008050220.51805.rjw@sisk.pl>
	<AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 05, 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/8/4 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Thursday, August 05, 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Wed, Aug 4, 2010 at 1:56 PM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> >> > On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
> >> >> On Wednesday, August 04, 2010, Matthew Garrett wrote:
> >> >> > No! And that's precisely the issue. Android's existing behaviour =
could
> >> >> > be entirely implemented in the form of binary that manually trigg=
ers
> >> >> > suspend when (a) the screen is off and (b) no userspace applicati=
ons
> >> >> > have indicated that the system shouldn't sleep, except for the wa=
keup
> >> >> > event race. Imagine the following:
> >> >> >
> >> >> > 1) The policy timeout is about to expire. No applications are hol=
ding
> >> >> > wakelocks. The system will suspend providing nothing takes a wake=
lock.
> >> >> > 2) A network packet arrives indicating an incoming SIP call
> >> >> > 3) The VOIP application takes a wakelock and prevents the phone f=
rom
> >> >> > suspending while the call is in progress
> >> >> >
> >> >> > What stops the system going to sleep between (2) and (3)? cgroups=
 don't,
> >> >> > because the voip app is an otherwise untrusted application that y=
ou've
> >> >> > just told the scheduler to ignore.
> >> >>
> >> >> I _think_ you can use the just-merged /sys/power/wakeup_count mecha=
nism to
> >> >> avoid the race (if pm_wakeup_event() is called at 2)).
> >> >
> >> > Yes, I think that solves the problem. The only question then is whet=
her
> >>
> >> How? By passing a timeout to pm_wakeup_event when the network driver
> >> gets the packet or by passing 0. If you pass a timeout it is the same
> >> as using a wakelock with a timeout and should work (assuming the
> >> timeout you picked is long enough). If you don't pass a timeout it
> >> does not work, since the packet may not be visible to user-space yet.
> >
> > Alternatively, pm_stay_awake() / pm_relax() can be used.
> >
> =

> Which makes the driver and/or network stack changes identical to using
> wakelocks, right?

Please refer to the Matthew's response.

> >> > it's preferable to use cgroups or suspend fully, which is pretty muc=
h up
> >> > to the implementation. In other words, is there a reason we're still
> >>
> >> I have seen no proposed way to use cgroups that will work. If you
> >> leave some processes running while other processes are frozen you run
> >> into problems when a frozen process holds a resource that a running
> >> process needs.
> >>
> >>
> >> > having this conversation? :) It'd be good to have some feedback from
> >> > Google as to whether this satisfies their functional requirements.
> >> >
> >>
> >> That is "this"? The merged code? If so, no it does not satisfy our
> >> requirements. The in kernel api, while offering similar functionality
> >> to the wakelock interface, does not use any handles which makes it
> >> impossible to get reasonable stats (You don't know which pm_stay_awake
> >> request pm_relax is reverting).
> >
> > Why is that a problem (out of curiosity)?
> >
> =

> Not having stats or not knowing what pm_relax is undoing? We need
> stats to be able to debug the system.

You have the stats in struct device and they are available via sysfs.
I suppose they are insufficient, but I'd like to know why exactly.

> If the system does not suspend
> at all or is awake for too long, the wakelock stats tells us which
> component is at fault. Since pm_stay_awake and pm_relax does not
> operate on a handle, you cannot determine how long it prevented
> suspend for.

Well, if you need that, you can add a counter of "completed events" into
struct dev_pm_info and a function similar to pm_relax() that
will update that counter.  I don't think anyone will object to that change.

> >> The proposed in user-space interface
> >> of calling into every process that receives wakeup events before every
> >> suspend call
> >
> > Well,  you don't really need to do that.
> >
> =

> Only if the driver blocks suspend until user-space has read the event.
> This means that for android to work we need to block suspend when
> input events are not processed, but a system using your scheme needs a
> pm_wakeup_event call when the input event is queued. How to you switch
> between them? Do we add separate ioctls in the input device to enable
> each scheme? If someone has a single threaded user space power manager
> that also reads input event it will deadlock if you block suspend
> until it reads the input events since you block when reading the wake
> count.

Well, until someone actually tries to implement a power manager in user spa=
ce
it's a bit vague.

Thanks,
Rafael
