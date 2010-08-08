From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 15:07:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008081502150.6810-100000__28871.2141373709$1281294509$gmane$org@netrider.rowland.org>
References: <201008081925.42664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008081925.42664.rjw@sisk.pl>
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

On Sun, 8 Aug 2010, Rafael J. Wysocki wrote:

> > > Also please note that it depends a good deal on the definition of a "wakeup
> > > event".  Under the definition used when my patch was being developed, ie. that
> > > wakeup events are the events that would wake up the system from a sleep state,
> > > PCI interrupts cannot be wakeup events, unless the given device remains in the
> > > full power state although the system has been suspended (standard PCI devices
> > > are not allowed to generate signals except for PME from low-power states).
> > 
> > Um, what do you mean by "event"?  Let's take a concrete example.  
> > Suppose you have a system where you want USB plug or unplug events to
> > cause a wakeup.  This is relevant to the discussion at hand if your USB
> > host controller is a PCI device.
> > 
> > By your reckoning, a plug or unplug event that occurs while the system
> > is asleep would be a wakeup event by definition.  And yet you say that
> > the same plug or unplug event occurring while the controller was at
> > full power would not count as a wakeup event?  And in particular, it 
> > should not prevent the system from suspending before the event can be
> > fully processed?  That doesn't make sense.  The same event is the same 
> > event, regardless of the context in which it occurs.  If it is treated 
> > as a wakeup event in context then it should be treated as a wakeup 
> > event in other contexts too.
> 
> In this example the event is not a PCI interrupt itself, which is a consqeuence
> of the event, but the USB plug-unplug.  So, whoever detects the plug-unplug
> should use pm_stay_awake() or pm_wakeup_event().  That may be an
> interrupt handler of a PCI USB controller, so if that is the case, the
> controller driver probably should use one of these functions in its interrupt
> handler.  Still, that by no measn implies that _every_ PCI interrupt should in
> principle be regarded as a wakeup event.

Okay, agreed.  I just wanted you to grant that some PCI interrupts
should be treated like wakeup events even if they don't actually wake
the system up from a sleep state.  The "PCI interrupts cannot be wakeup 
events" statement is a little strong.

Alan Stern
