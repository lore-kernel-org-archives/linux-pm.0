From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 20:59:34 -0700
Message-ID: <20100805035934.GA2491__5808.48649046874$1280980833$gmane$org@linux.vnet.ibm.com>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<201008050220.51805.rjw@sisk.pl>
	<AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 06:02:28PM -0700, Arve Hj=F8nnev=E5g wrote:
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
> =

> Which makes the driver and/or network stack changes identical to using
> wakelocks, right?

Arve, you say that like it is a bad thing.  ;-)

Seriously, the hope is that Rafael's implementation is useful to other
projects in addition to Android.  And, all else being equal, the more
people who need a given facility, the more likely that facility is to
make it to mainline, right?

And yes, I see you call out some additional things that Android needs,
but hopefully this gap can be closed one way or another.

							Thanx, Paul

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
> stats to be able to debug the system. If the system does not suspend
> at all or is awake for too long, the wakelock stats tells us which
> component is at fault. Since pm_stay_awake and pm_relax does not
> operate on a handle, you cannot determine how long it prevented
> suspend for.
> =

> >> The proposed in user-space interface
> >> of calling into every process that receives wakeup events before every
> >> suspend call
> >
> > Well, =A0you don't really need to do that.
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
> =

> >> is also not compatible with existing apps.
> >
> > Thanks,
> > Rafael
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at =A0http://www.tux.org/lkml/
> >
> =

> =

> =

> -- =

> Arve Hj=F8nnev=E5g
