From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 01:33:00 +0200
Message-ID: <201008050133.01169.rjw__25119.6098085076$1280966980$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804231003.GL24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041616160.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008041616160.6545@asgard.lang.hm>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 05, 2010, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Paul E. McKenney wrote:
> 
> > On Wed, Aug 04, 2010 at 03:56:42PM -0700, david@lang.hm wrote:
> >> On Wed, 4 Aug 2010, Arve Hj?nnev?g wrote:
> >>
> >>> On Wed, Aug 4, 2010 at 3:31 PM,  <david@lang.hm> wrote:
> >>>> On Wed, 4 Aug 2010, Matthew Garrett wrote:
> >>>>
> >>>>> On Wed, Aug 04, 2010 at 10:51:07PM +0200, Rafael J. Wysocki wrote:
> >>>>>>
> >>>>>> On Wednesday, August 04, 2010, Matthew Garrett wrote:
> >>>>>>>
> >>>>>>> No! And that's precisely the issue. Android's existing behaviour could
> >>>>>>> be entirely implemented in the form of binary that manually triggers
> >>>>>>> suspend when (a) the screen is off and (b) no userspace applications
> >>>>>>> have indicated that the system shouldn't sleep, except for the wakeup
> >>>>>>> event race. Imagine the following:
> >>>>>>>
> >>>>>>> 1) The policy timeout is about to expire. No applications are holding
> >>>>>>> wakelocks. The system will suspend providing nothing takes a wakelock.
> >>>>>>> 2) A network packet arrives indicating an incoming SIP call
> >>>>>>> 3) The VOIP application takes a wakelock and prevents the phone from
> >>>>>>> suspending while the call is in progress
> >>>>>>>
> >>>>>>> What stops the system going to sleep between (2) and (3)? cgroups don't,
> >>>>>>> because the voip app is an otherwise untrusted application that you've
> >>>>>>> just told the scheduler to ignore.
> >>>>>>
> >>>>>> I _think_ you can use the just-merged /sys/power/wakeup_count mechanism
> >>>>>> to
> >>>>>> avoid the race (if pm_wakeup_event() is called at 2)).
> >>>>>
> >>>>> Yes, I think that solves the problem. The only question then is whether
> >>>>> it's preferable to use cgroups or suspend fully, which is pretty much up
> >>>>> to the implementation. In other words, is there a reason we're still
> >>>>> having this conversation? :) It'd be good to have some feedback from
> >>>>> Google as to whether this satisfies their functional requirements.
> >>>>
> >>>> the proposal that I nade was not to use cgroups to freeze some processes and
> >>>> not others, but to use cgroups to decide to ignore some processes when
> >>>> deciding if the system is idle, stop everything or nothing. cgroups are just
> >>>> a way of easily grouping processes (and their children) into different
> >>>> groups.
> >>>
> >>> That does not avoid the dependency problem. A process may be waiting
> >>> on a resource that a process you ignore owns. I you ignore the process
> >>> that owns the resource and enter idle when it is ready to run (or
> >>> waiting on a timer), you are still effectively blocking the other
> >>> process.
> >>
> >> and if you don't have a wakelock the same thing will happen. If you
> >> expect the process to take a while you can set a timeout to wake up
> >> every 30 seconds or so and wait again, this would be enough to
> >> prevent you from going to sleep (or am I misunderstanding how long
> >> before you go into suspend without a wakelock set, see my other
> >> e-mail for the full question)
> >
> > The difference between the Android scheme and your proposal is that the
> > Android scheme freezes -all- the processes, not just a subset of them.
> > Therefore, in the Android scheme, the case of one process attempting to
> > acquire a resource held by a frozen process.  In contrast, any scheme
> > that attempts to freeze only a subset of the processes must somehow
> > either avoid or properly handle the situation where a frozen process is
> > holding a resource that a running process is trying to acquire.
> 
> My proposal would never freeze a subset of processes.
> 
> what my proposal:
> 
> only consider the activity of a subset of processes when deciding if we 
> should suspend or not. If the decision is to suspend, freeze everything.

That alone doesn't allow you to handle the race Matthew was referring to
(ie. wakeup event happening right after you've decided to suspend).

A mechanism of making a decision alone is not sufficient, you also need a
mechanism to avoid races between wakeup events and suspend process.

Thanks,
Rafael
