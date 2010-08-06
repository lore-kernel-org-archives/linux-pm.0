From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sat, 7 Aug 2010 00:04:43 +0200
Message-ID: <201008070004.43923.rjw__25609.8878257491$1281133888$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1008061505070.9303-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008061505070.9303-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 06, 2010, Alan Stern wrote:
> On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:
...
> But what sorts of things qualify as wakeup events?  Right now, the code
> handles only events coming by way of the PME# signal (or its platform
> equivalent).  But that signal usually gets activated only when a PCI
> device is in a low-power mode; if the device is at full power then it
> simply generates an IRQ.  It's the same event, but reported to the
> kernel in a different way.  So consider...
> =

> Case 1: The system is suspending and the PCI device has already been
> 	placed in D3hot when an event occurs.  PME# is activated,
> 	the wakeup event is reported, the suspend is aborted, and the =

> 	system won't try to suspend again for at least 100 ms.  Good.
> =

> Case 2: The system is running normally and the PCI device is at full
> 	power when an event occurs.  PME# isn't activated and =

> 	pm_wakeup_event doesn't get called.  Then when the system
> 	tries to suspend 25 ms later, there's nothing to prevent it
> 	even though the event is still being processed.  Bad.
> =

> In case 2 the race has not been resolved.  It seems to me that the =

> only proper solution is to call pm_wakeup_event for _every_ PCI =

> interrupt.  This may be too much to add to a hot path, but what's the =

> alternative?

Arguably not every PCI interrupt should be regarded as a wakeup event, so
I think we can simply say in the cases when that's necessary the driver sho=
uld
be responsible for using pm_wakeup_event() or pm_stay_awake() / pm_relax() =
as
appropriate.

My patch only added it to the bus-level code which covered the PME-based
wakeup events that _cannot_ be handled by device drivers.

Thanks,
Rafael
