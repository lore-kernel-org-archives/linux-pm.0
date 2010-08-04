From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 16:30:13 -0700
Message-ID: <20100804233013.GN24163__21346.1238694892$1280964994$gmane$org@linux.vnet.ibm.com>
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
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 04:23:43PM -0700, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
> =

> >2010/8/4  <david@lang.hm>:
> >>On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
> >>
> >>>On Wed, Aug 4, 2010 at 3:31 PM, =A0<david@lang.hm> wrote:
> >>>>
> >>>>On Wed, 4 Aug 2010, Matthew Garrett wrote:
> >>>>
> >>>>>On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
> >>>>>>
> >>>>>>On Wednesday, August 04, 2010, Matthew Garrett wrote:
> >>>>>>>
> >>>>>>>No! And that's precisely the issue. Android's existing behaviour c=
ould
> >>>>>>>be entirely implemented in the form of binary that manually trigge=
rs
> >>>>>>>suspend when (a) the screen is off and (b) no userspace applicatio=
ns
> >>>>>>>have indicated that the system shouldn't sleep, except for the wak=
eup
> >>>>>>>event race. Imagine the following:
> >>>>>>>
> >>>>>>>1) The policy timeout is about to expire. No applications are hold=
ing
> >>>>>>>wakelocks. The system will suspend providing nothing takes a wakel=
ock.
> >>>>>>>2) A network packet arrives indicating an incoming SIP call
> >>>>>>>3) The VOIP application takes a wakelock and prevents the phone fr=
om
> >>>>>>>suspending while the call is in progress
> >>>>>>>
> >>>>>>>What stops the system going to sleep between (2) and (3)? cgroups
> >>>>>>>don't,
> >>>>>>>because the voip app is an otherwise untrusted application that yo=
u've
> >>>>>>>just told the scheduler to ignore.
> >>>>>>
> >>>>>>I _think_ you can use the just-merged /sys/power/wakeup_count mecha=
nism
> >>>>>>to
> >>>>>>avoid the race (if pm_wakeup_event() is called at 2)).
> >>>>>
> >>>>>Yes, I think that solves the problem. The only question then is whet=
her
> >>>>>it's preferable to use cgroups or suspend fully, which is pretty muc=
h up
> >>>>>to the implementation. In other words, is there a reason we're still
> >>>>>having this conversation? :) It'd be good to have some feedback from
> >>>>>Google as to whether this satisfies their functional requirements.
> >>>>
> >>>>the proposal that I nade was not to use cgroups to freeze some proces=
ses
> >>>>and
> >>>>not others, but to use cgroups to decide to ignore some processes when
> >>>>deciding if the system is idle, stop everything or nothing. cgroups a=
re
> >>>>just
> >>>>a way of easily grouping processes (and their children) into different
> >>>>groups.
> >>>>
> >>>
> >>>That does not avoid the dependency problem. A process may be waiting
> >>>on a resource that a process you ignore owns. I you ignore the process
> >>>that owns the resource and enter idle when it is ready to run (or
> >>>waiting on a timer), you are still effectively blocking the other
> >>>process.
> >>
> >>and if you don't have a wakelock the same thing will happen. If you exp=
ect
> >
> >Not the same thing. If you don't hold a wakelock the entire system
> >will suspend and when it wakes up it continues where it left off.
> >Timeout still have time left before they expire.
> =

> in what I'm proposing, if the 'privilaged/trusted" processes are
> idle long enough the entire system will suspend, and when it wakes
> up everything will continue to process normally
> =

> >>the process to take a while you can set a timeout to wake up every 30
> >>seconds or so and wait again, this would be enough to prevent you from =
going
> >
> >I don't think polling is an acceptable solution to this problem. You
> >user space code know needs to know what "idle" timeout you have
> >selected so it can choose a faster poll rate. When is it safe to stop
> >polling?
> =

> I think the timeouts are of such an order of magnatude that the
> polling can be infrequent enough to not be a significant amount of
> load, but be faster than any timeout
> =

> >>to sleep (or am I misunderstanding how long before you go into suspend
> >>without a wakelock set, see my other e-mail for the full question)
> >>
> >
> >We suspend as soon as no wakelocks are held. There is no delay.
> =

> So, if I have a bookreader app that is not allowed to get the
> wakelock, and nothing else is running, the system will suspend
> immediatly after I click a button to go to the next page? it will
> not stay awake to give me a chance to read the page at all?
> =

> how can any application run without wakelock privilages?

Isn't a wakelock held as long as the display is lit, so that the
system would continue running as long as the page was visible?

							Thanx, Paul
