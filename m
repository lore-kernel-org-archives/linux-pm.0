From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 02:10:40 +0200
Message-ID: <201008050210.40995.rjw@sisk.pl>
References: <20100801210548.23f77ff6@infradead.org>
	<201008050126.20812.rjw@sisk.pl>
	<alpine.DEB.2.00.1008041634560.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008041634560.6545@asgard.lang.hm>
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
> On Thu, 5 Aug 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday, August 05, 2010, david@lang.hm wrote:
> >> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
> >>
> >>> Subject: Re: Attempted summary of suspend-blockers LKML thread
> >>>
> >>> On Wednesday, August 04, 2010, david@lang.hm wrote:
> >>>> On Wed, 4 Aug 2010, Rafael J. Wysocki wrote:
> >>>>> In the suspend case, when you have frozen all applications, you can
> >>>>> sequentially disable all interrupts except for a few selected ("wakeup") ones
> >>>>> in a safe way.   By disabling them, you ensure that the CPU will only be
> >>>>> "revived" by a limited set of events and that allows the system to stay
> >>>>> low-power for extended time intervals.
> >>>>
> >>>> the benifit of this will depend on what wakeups you are able to avoid by
> >>>> putting the hardware to sleep. Depending on the hardware, this may be not
> >>>> matter that much.
> >>>
> >>> That's correct, but evidently it does make a difference with the hardware
> >>> Android commonly runs on.
> >>
> >> Ok, but is there a way to put some of this to sleep without involving a
> >> full suspend?
> >
> > Technically, maybe, but we have no generic infrastructure in the kernel for that.
> > There may be SoC-specific implementations, but nothing general enough.
> 
> well, I know that we have specific cases of this (drive spin-down, cpu 
> speed, display backlight for a few examples), is it worth trying to define 
> a generic way to do this sort of thing? or should it be left as a 
> per-device thing (with per-device knobs to control it)

The ability to put specific devices into low-power states in certain
well-defined situations is clearly not sufficient.  For one example, usually
you can easily put an Ethernet adapter into a low-power state when the network
cable is detached from it.  It is not clear, however, what criteria should be
used for deciding to put that adapter into the low-power state when the cable
is attached to it (and open() has been called).

To mimic suspend you'll have to be able to put _all_ devices into low-power
states and shut down the interrupts that allow the monotonic clock to advance.
That's much more than simple runtime power management of selected devices.

> I thought I had seen discussion on how to define such a generic power 
> management interface, and I thought the results had been acceptable.

If you have a pointer to that discussion, I'm interested. :-)

Thanks,
Rafael
