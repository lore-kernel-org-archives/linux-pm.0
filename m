From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 15:12:58 -0700
Message-ID: <20100811221258.GI2516__30106.1720973395$1281564881$gmane$org@linux.vnet.ibm.com>
References: <20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100811004223.GH2379@linux.vnet.ibm.com>
	<AANLkTik7Po9OuKC-QBZ=E83J70sU_ewNi+nNWgcjjLXd@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik7Po9OuKC-QBZ=E83J70sU_ewNi+nNWgcjjLXd@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 11, 2010 at 11:00:42PM +0300, Felipe Contreras wrote:
> On Wed, Aug 11, 2010 at 3:42 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, Aug 10, 2010 at 09:38:49AM +0100, Alan Cox wrote:
> >> You may also wish to review the earlier parts of the discussion where =
it
> >> was explicitly stated by several developers that they were using
> >> "suspend" type modes as power states already and not using suspend
> >> blockers. So it's being done, today on ARM and your statement is direc=
tly
> >> contradicting the code. Modern ARM processors and x86 MID devices can
> >> suspend and resume extremely fast (fast enough that the fact Linux x86
> >> rewriting all the SMP alternatives on suspend/resume is a measurable
> >> problem). If this same property doesn't end up on big PC boxes in time
> >> then I'd be very surprised. At that point the openoffice with suspend
> >> blockers or oracle with suspend blockers question becomes rather relev=
ant.
> >
> > Here is the list of properties distinguishing idle from suspend:
> >
> > 1. =A0 =A0 =A0Idle states are entered by a given CPU only there are no =
runnable
> > =A0 =A0 =A0 =A0tasks for that CPU. =A0In contrast, opportunistic suspen=
d can
> > =A0 =A0 =A0 =A0halt the entire system even when there are tasks that ar=
e ready,
> > =A0 =A0 =A0 =A0willing, and able to run. =A0(But please note that this =
might not
> > =A0 =A0 =A0 =A0apply to real-time tasks.)
> =

> But if there are no runnable tasks (which is the target), they behave the=
 same.

And if there are runnable tasks, then then don't behave the same.
Apparently different people in this debate have different targets.

> > 2. =A0 =A0 =A0There can be a set of input events that do not bring the =
system
> > =A0 =A0 =A0 =A0out of suspend, but which would bring the system out of =
idle.
> > =A0 =A0 =A0 =A0Exactly which events are in this set depends both on har=
dware
> > =A0 =A0 =A0 =A0capabilities and on the platform/application policy. =A0=
For example,
> > =A0 =A0 =A0 =A0on one of the Android-based smartphones, touchscreen inp=
ut is
> > =A0 =A0 =A0 =A0ignored when the system is suspended, but is handled whe=
n idle.
> =

> And in N900 touching the screen doesn't bring the device out of idle,
> I guess because it's off.

As long as touching the N900 screen doesn't bring the device out of
suspend, its behavior is not a counterexample to #2 above.

> What devices do what on which circumstances on what platform is
> completely irrelevant.

Do you -really- want me to start listing counterexamples to that
brave statement?  ;-)

> > 3. =A0 =A0 =A0The system comes out of idle when a timer expires. =A0In =
contrast,
> > =A0 =A0 =A0 =A0timers might or might not bring the system out of suspen=
d,
> > =A0 =A0 =A0 =A0depending on both hardware capabilities and platform/app=
lication
> > =A0 =A0 =A0 =A0policy.
> =

> Isn't this solved by range timers?

Ahem.  This is a list of differences between idle and suspend, not
a list of problems to be solved.  But to answer your question, if a
timer does not bring a given device out of suspend, then a range timer
is not likely to, either.  Don't get me wrong, I do believe that range
timers have an important part to play in the energy-efficiency arena,
but I have not been convinced that they are any kind of silver bullet.

> > 4. =A0 =A0 =A0Suspend generally forces devices to go into their low-pow=
er
> > =A0 =A0 =A0 =A0states immediately. =A0In contrast, idle generally leave=
s unused
> > =A0 =A0 =A0 =A0devices at full power, relying on timers to shut down th=
ese
> > =A0 =A0 =A0 =A0devices. =A0Idle thus has shorter average wakeup latenci=
es, but
> > =A0 =A0 =A0 =A0worse energy efficiency.
> =

> Only if you make these assumptions
>  1) All the applications use suspend-blockers only when they absolutely m=
ust
>  2) The user has given the right applications the right access

You believe that these assumptions are unreasonable?  Compared to the
assumption that all applications are carefully written to conserve power?
If so, on what grounds?

It seems to me that the same social-engineering approaches work in
both cases.

> If not, you'll see much worst energy efficiency. So in theory maybe,
> but in practice you can't say that.

Really?  What makes you say that?

							Thanx, Paul
