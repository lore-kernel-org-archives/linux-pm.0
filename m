From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 19 Aug 2010 21:58:15 -0700
Message-ID: <20100820045815.GD2429__7770.92021094194$1282280372$gmane$org@linux.vnet.ibm.com>
References: <20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100811004223.GH2379@linux.vnet.ibm.com>
	<AANLkTik7Po9OuKC-QBZ=E83J70sU_ewNi+nNWgcjjLXd@mail.gmail.com>
	<20100811221258.GI2516@linux.vnet.ibm.com>
	<AANLkTi=fJjM=uWeV+L66ajM9rhrL0t1OO-C7ThNRdbae@mail.gmail.com>
	<20100812161935.GC2524@linux.vnet.ibm.com>
	<AANLkTi=51cFa0t5ZYj2CMiauuW80ZWTrm1tQkn63Et0F@mail.gmail.com>
	<20100813151451.GC2511@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008191600310.8334@asgard.lang.hm>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008191600310.8334@asgard.lang.hm>
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
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 19, 2010 at 04:10:10PM -0700, david@lang.hm wrote:
> On Fri, 13 Aug 2010, Paul E. McKenney wrote:
> =

> >On Thu, Aug 12, 2010 at 08:52:22PM +0300, Felipe Contreras wrote:
> >>On Thu, Aug 12, 2010 at 7:19 PM, Paul E. McKenney
> >><paulmck@linux.vnet.ibm.com> wrote:
> >>>On Thu, Aug 12, 2010 at 03:17:29AM +0300, Felipe Contreras wrote:
> >>>>>It seems to me that the same social-engineering approaches work in
> >>>>>both cases.
> >>>>
> >>>>Yes, but if dynamic PM works as advertised, you don't need
> >>>>opportunistic suspend.
> >>>
> >>>For dynamic power management to totally eliminate the need for somethi=
ng
> >>>like suspend blockers, you are having to make some brave assumptions.
> >>>Yes, dynamic power management is quite useful, but there is a big
> >>>difference between something being useful and something doing everythi=
ng
> >>>for everyone. =A0You have not yet convinced me that dynamic power mana=
gement
> >>>will make it to the "doing everything for everyone" stage.
> >>
> >>As it has been explained before, there's a sweet-spot of idleness:
> >>http://article.gmane.org/gmane.linux.kernel/995525
> >>http://article.gmane.org/gmane.linux.ports.arm.omap/37982
> >>
> >>Do you agree that there's such a thing, and if so, do you agree that
> >>the benefits of opportunistic suspend are much less once that point is
> >>reached?
> >
> >I agree that there will be a sweet spot of idleness (though I would call
> >it a "point of diminishing returns"), but only if all the applications
> >are power-optimized.  The advantage of opportunistic suspend is instead
> >its tolerance of power-oblivious applications with minimal degradation
> >of battery life.
> =

> sorry for the late response, the last week has been very hectic.
> =

> I just wanted to note that there is already a tool in the kernel to
> deal with this, the timer jitter/fuzz control. This can be set by an
> application for itself, or it can be set by some other process for
> an application (I don't remember the details of all the ways this
> can be set)
> =

> This could be used in a way similar to how userspace wakelocks are
> set today, if the power management process (that holds the wakelock
> and keep sthe screen lit today) thinks the system should be awake,
> let the jitter/fuzz be small, if that process thinks the system
> should probably be asleep, set the jitter/fuzz to a larger value. If
> other things are running anyway, the timers can fire and be serviced
> normally, otherwise the kernel is free to delay the timer going off
> even for badly written processes.

Indeed, Rafael and Alan Stern are working to make pm_qos do what the
Android guys need, which could (very roughly) be thought of as extending
the jitter/fuzz such that it meets Android's requirements.

							Thanx, Paul
