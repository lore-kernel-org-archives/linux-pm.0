From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 02:20:51 +0200
Message-ID: <201008050220.51805.rjw__23427.9258795597$1280967847$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
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
> On Wed, Aug 4, 2010 at 1:56 PM, Matthew Garrett <mjg59@srcf.ucam.org> wro=
te:
> > On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
> >> On Wednesday, August 04, 2010, Matthew Garrett wrote:
> >> > No! And that's precisely the issue. Android's existing behaviour cou=
ld
> >> > be entirely implemented in the form of binary that manually triggers
> >> > suspend when (a) the screen is off and (b) no userspace applications
> >> > have indicated that the system shouldn't sleep, except for the wakeup
> >> > event race. Imagine the following:
> >> >
> >> > 1) The policy timeout is about to expire. No applications are holding
> >> > wakelocks. The system will suspend providing nothing takes a wakeloc=
k.
> >> > 2) A network packet arrives indicating an incoming SIP call
> >> > 3) The VOIP application takes a wakelock and prevents the phone from
> >> > suspending while the call is in progress
> >> >
> >> > What stops the system going to sleep between (2) and (3)? cgroups do=
n't,
> >> > because the voip app is an otherwise untrusted application that you'=
ve
> >> > just told the scheduler to ignore.
> >>
> >> I _think_ you can use the just-merged /sys/power/wakeup_count mechanis=
m to
> >> avoid the race (if pm_wakeup_event() is called at 2)).
> >
> > Yes, I think that solves the problem. The only question then is whether
> =

> How? By passing a timeout to pm_wakeup_event when the network driver
> gets the packet or by passing 0. If you pass a timeout it is the same
> as using a wakelock with a timeout and should work (assuming the
> timeout you picked is long enough). If you don't pass a timeout it
> does not work, since the packet may not be visible to user-space yet.

Alternatively, pm_stay_awake() / pm_relax() can be used.

> > it's preferable to use cgroups or suspend fully, which is pretty much up
> > to the implementation. In other words, is there a reason we're still
> =

> I have seen no proposed way to use cgroups that will work. If you
> leave some processes running while other processes are frozen you run
> into problems when a frozen process holds a resource that a running
> process needs.
> =

> =

> > having this conversation? :) It'd be good to have some feedback from
> > Google as to whether this satisfies their functional requirements.
> >
> =

> That is "this"? The merged code? If so, no it does not satisfy our
> requirements. The in kernel api, while offering similar functionality
> to the wakelock interface, does not use any handles which makes it
> impossible to get reasonable stats (You don't know which pm_stay_awake
> request pm_relax is reverting).

Why is that a problem (out of curiosity)?

> The proposed in user-space interface
> of calling into every process that receives wakeup events before every
> suspend call

Well,  you don't really need to do that.

> is also not compatible with existing apps.

Thanks,
Rafael
