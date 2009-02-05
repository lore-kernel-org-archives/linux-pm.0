From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] PCI PM: Let the core be more careful
 with respect to drivers using new framework
Date: Thu, 05 Feb 2009 12:18:03 +1100
Message-ID: <1233796683.4612.37.camel__1448.93924375555$1233797076$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl>
	<200902040209.08633.rjw@sisk.pl> <1233713153.16867.143.camel@pasglop>
	<200902050147.02632.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902050147.02632.rjw@sisk.pl>
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


> I don't know about ppc, but on x86 the pcibios hook is only supposed to
> disable the device's interrupt link.

Right now on ppc, I may disable the clocks too, but then:

 - As soon as you have implemented the new scheme, I'll replace all that
with using the same hooks as ACPI so that won't be an issue anymore

 - Today, it's probably a non issue too because none of the devices for
which I have that sort of manual clock control also shares interrupts.

> Potentially, calling into the AML interpreter.

Right, but we are fixing that anyway with the noirq phase being AML safe
by no ? :-)
 
> When we implement the changes discussed in the "PCI PM: Restore standard
> config registers of all devices early" thread, that part will end up in
> suspend_noirq.

Yup.

Cheers,
Ben.
