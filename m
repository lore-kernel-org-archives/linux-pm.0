From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Thu, 3 Jun 2010 00:30:27 +0200
Message-ID: <201006030030.27234.rjw__32021.4844229215$1275517785$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006021539460.1628-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006021539460.1628-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 June 2010, Alan Stern wrote:
> On Wed, 2 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > > Do PCI bus type callbacks need to be reworked to work correctly with unbound
> > > > devices?
> > > 
> > > They do; I neglected to take care of them when first writing this 
> > > patch.  After everything is working I'll submit it for real.  For now, 
> > > the point was to find out whether this is going in the right direction.
> > 
> > I don't have a fundamental problem with it.  As long as all things can be made
> > work along these lines, it's fine by me.
> 
> Arggh!  I just tried out a revised patch.  It seems to work
> perfectly, except for one thing.  When I unbound ehci-hcd from one of
> the USB controllers, which should have caused the controller to be 
> runtime-suspended, this is what showed up in the log:
> 
> [  295.651545] pci 0000:00:1d.7: PME# enabled
> [  295.664044] pci 0000:00:1d.7: Refused to change power state, currently in D0
> 
> Which seems to mean that the controller didn't want to go into D3hot!  
> Presumably this is because it was unconfigured when the driver was 
> unbound.  That's the only explanation I can think of; the controller 
> had no objection about going into D3hot when it was bound to the 
> driver.

Hmm.  I must say I don't quite understand this behavior.  Oh well.

> Assuming other PCI devices will have similar behavior, I have to agree
> that there's no point trying to put driverless devices into low-power
> states.

I guess so.

> One more thing: When looking at the r8169 and e1000e drivers, I noticed
> that you used the same test (pci_dev_run_wake -- not the greatest name
> in the world, BTW)

It's following the ACPI naming which I admit generally sucks.

> in both the probe and remove routines.  That's not
> the right thing to do if the runtime-wakeup setting could get changed
> inbetween.  (I realize that currently there is no way to change the
> setting, but in the future there might be.)
> 
> Do you want to make an explicit assumption that the runtime wakeup
> settings are fixed, not subject to change?

I'm not sure yet. :-)

> If so, then why not compute the setting just once, when the device is
> registered, and store it in the pci_device structure?  Or even in the struct
> device?

If we decide it will be immutable, then yes, in which case I think struct
pci_dev will be a better place to store it, because that kind of setting may
not be meaningful for other types of devices (some of them will always be
wakeup-capable and some of them will never be).

Rafael
