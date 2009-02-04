From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] PCI PM: Let the core be more careful
 with respect to drivers using new framework
Date: Wed, 04 Feb 2009 13:05:53 +1100
Message-ID: <1233713153.16867.143.camel__24493.5004543096$1233713416$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl> <200902040209.08633.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902040209.08633.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org


> For non-bridge devices without drivers the PCI PM core will disable
> them and save their state on suspend.  During resume, it will put
> them into D0, if necessary, restore their state (early) and reenable
> them.

This is "without drivers" only or does it include devices that have a
driver and no PM ops ?

In the later case, the worry is that the driver will potentially still
take shared interrupts after you have disabled the device. I know the
normal disable path only disables bus mastering, which is a GOOD
thing :-) but the pcibios hook might do more here ...

I would recommend only doing that disabling in the "noirq" phase of
suspend to avoid problems here. Do you see any reason that wouldn't
work ?

Cheers,
Ben.
