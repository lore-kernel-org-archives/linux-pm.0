From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sun, 16 Aug 2009 12:09:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908161158210.6522-100000__25891.5556980812$1250439007$gmane$org@netrider.rowland.org>
References: <200908152344.46898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908152344.46898.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 15 Aug 2009, Rafael J. Wysocki wrote:

> On Saturday 15 August 2009, Matthew Garrett wrote:
> > On Sat, Aug 15, 2009 at 11:21:53PM +0200, Rafael J. Wysocki wrote:
> > 
> > > I can even imagine a scenario where this setting might be useful, like when
> > > we don't want a network adapter to be woken up from the outside.
> > 
> > I think in that case we'd probably just want the interface to be downed? 
> > Some of this is going to require device-specific policy, I think - for 
> > the network case we probably want something in between IF_RUNNING and 
> > IF_DOWN (IF_CARRIER, perhaps) that indicates that we want the PHY to be 
> > powered. Pushing this out to sysfs would mean we'd have a consistent 
> > interface but varying semantics, and I'm not convinced that's an 
> > especially helpful interface.
> 
> I'm not disagreeing with that.
> 
> At this point I'd like to know the Alan's opinion.  I would gladly use the
> 'runtime_forbidden' flag only, but if we overlook something now, it's going
> to be difficult to fix later.

The notion of "remote wakeup" is more or less the same for all devices,
and it can effectively be abstracted into the core.  Other notions,
like IF_CARRIER, are more device-dependent.  They must be handled at
the bus or driver level, not in the core.

The real question is whether we should export a "may_runtime_wakeup"  
flag.  If we don't then we prevent the use of a degraded
power-management mode in devices with broken wakeup support.  Perhaps 
that's okay, I don't know.

Which reminds me...  In addition to these flags controlling what
settings should be enabled, maybe we should add a flag to record
whether or not remote wakeup was turned on when the device was last
suspended.  Although the core wouldn't use it, such a flag might be
very convenient for drivers.

Alan Stern
