From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 01:26:20 +0200
Message-ID: <201008050126.20812.rjw__11090.1876040318$1280966896$gmane$org@sisk.pl>
References: <20100801210548.23f77ff6@infradead.org>
	<201008042231.51901.rjw@sisk.pl>
	<alpine.DEB.2.00.1008041600060.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008041600060.6545@asgard.lang.hm>
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
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 05, 2010, david@lang.hm wrote:
> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
> 
> > Subject: Re: Attempted summary of suspend-blockers LKML thread
> > 
> > On Wednesday, August 04, 2010, david@lang.hm wrote:
> >> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
> >>> In the suspend case, when you have frozen all applications, you can
> >>> sequentially disable all interrupts except for a few selected ("wakeup") ones
> >>> in a safe way.   By disabling them, you ensure that the CPU will only be
> >>> "revived" by a limited set of events and that allows the system to stay
> >>> low-power for extended time intervals.
> >>
> >> the benifit of this will depend on what wakeups you are able to avoid by
> >> putting the hardware to sleep. Depending on the hardware, this may be not
> >> matter that much.
> >
> > That's correct, but evidently it does make a difference with the hardware
> > Android commonly runs on.
> 
> Ok, but is there a way to put some of this to sleep without involving a 
> full suspend?

Technically, maybe, but we have no generic infrastructure in the kernel for that.
There may be SoC-specific implementations, but nothing general enough.

> >> In addition, there are input devices like a touchscreen that could be
> >> disabled even short of a full suspend, as long as there is some way to get
> >> them reactivated.
> >
> > That's correct again, but it doesn't matter too much as far as the difference
> > between "deep idle" and suspend is concerned.  These devices are generally not
> > the interrupt sources that are difficult to shut down safely in the "idle" case.
> >
> >>> To achieve the same result in the "idle" case, you'll need to have a mechanism
> >>> to disable interrupts (except for the "wakeup" ones) avoiding synchronization
> >>> problems (eg. situations in which task A, blocked on a "suspended" device
> >>> access, holds a mutex waited for by task B that needs to run so that we can
> >>> "suspend" another device).  That, however, is a difficult problem.
> >>
> >> I would say that the difficulty of the problem depends on the hardware and
> >> how much userspace interaction is needed. If the kernel can disable the
> >> hardware in the driver (so that it can wake it up again when accessed by
> >> an application) it would seem that this isn't a problem.
> >
> > Well, I guess it's useful to consider the sequence of events in the "idle"
> > case.
> >
> > We first detect that a CPU is idle, so it can be put into a C-state (or
> > equivalent).  It's easy to put that CPU into such a state, but suppose we
> > want to do more and put all devices into low-power states at that point.
> > We have to ensure that there are no devices in the middle of DMA and that
> > the other CPUs are idle (that's kind of easy, but still).  Next, we have to
> > figure out the right ordering in which to put devices into low-power states
> > (that is not trivial, because the tasks that use those devices may depend on
> > each other in various ways).  If we decide to shut down clock source
> > interrupts, we must ensure that the timekeeping will be correct after that and
> > so on.  Moreover, things get ugly if there are shared interrupts.
> >
> > Suspend kind of works around these difficulties by taking the entire user
> > space out of the picture with one big sledgehammer called the freezer,
> > but these problems would have to be actually _solved_ in the "idle" case.
> 
> I'm not opposed to doing a suspend if the system is idle enough, I'm just 
> questioning if suspend is really that different, or if it can be viewed as 
> yet another low power mode (one that's significantly more expensive to 
> transition in and out of)

Suspend is really different.  First, the way it is entered is different (ie. it
starts from the freezing of user space and sequentially powers down things
going from leaf devices towards the "core" of the system).  Second, it shuts
down interrupt sources that cannot be easily shut down from idle (at least
in general).  Finally, on some platforms (eg. ACPI) it requires extra hardware
black magic that cannot be triggered from the cpuidle context.

The deactivation of more interrupt sources appears to be the most significant
difference from the energy saving point of view, but it is achieved because of
the way suspend is entered.  It may or may not be achieved in a different way,
but (1) no one has implemented anything close to a working alternative
solution yet and (2) it is not certain that's worth doing.

Thanks,
Rafael
