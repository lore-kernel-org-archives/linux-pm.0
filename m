From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/7] PCI PM: Let the core be more careful
	with respect to drivers using new framework
Date: Thu, 5 Feb 2009 01:47:01 +0100
Message-ID: <200902050147.02632.rjw__24856.4814719886$1233795094$gmane$org@sisk.pl>
References: <200902040154.36018.rjw@sisk.pl> <200902040209.08633.rjw@sisk.pl>
	<1233713153.16867.143.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233713153.16867.143.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 04 February 2009, Benjamin Herrenschmidt wrote:
> 
> > For non-bridge devices without drivers the PCI PM core will disable
> > them and save their state on suspend.  During resume, it will put
> > them into D0, if necessary, restore their state (early) and reenable
> > them.
> 
> This is "without drivers" only or does it include devices that have a
> driver and no PM ops ?

It includes devices with drivers and without PM ops (either "legacy" or "new"),
the idea being that in the simplest cases the driver should not be required to
implement PM ops and the device should be handled nevertheless.

> In the later case, the worry is that the driver will potentially still
> take shared interrupts after you have disabled the device. I know the
> normal disable path only disables bus mastering, which is a GOOD
> thing :-) but the pcibios hook might do more here ...

I don't know about ppc, but on x86 the pcibios hook is only supposed to
disable the device's interrupt link.

> I would recommend only doing that disabling in the "noirq" phase of
> suspend to avoid problems here. Do you see any reason that wouldn't
> work ?

Potentially, calling into the AML interpreter.

When we implement the changes discussed in the "PCI PM: Restore standard
config registers of all devices early" thread, that part will end up in
suspend_noirq.

Thanks,
Rafael
