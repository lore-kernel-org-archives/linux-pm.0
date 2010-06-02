From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Wed, 2 Jun 2010 15:53:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006021539460.1628-100000__25057.5763675899$1275508511$gmane$org@iolanthe.rowland.org>
References: <201006022136.02785.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006022136.02785.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Jun 2010, Rafael J. Wysocki wrote:

> > > Do PCI bus type callbacks need to be reworked to work correctly with unbound
> > > devices?
> > 
> > They do; I neglected to take care of them when first writing this 
> > patch.  After everything is working I'll submit it for real.  For now, 
> > the point was to find out whether this is going in the right direction.
> 
> I don't have a fundamental problem with it.  As long as all things can be made
> work along these lines, it's fine by me.

Arggh!  I just tried out a revised patch.  It seems to work
perfectly, except for one thing.  When I unbound ehci-hcd from one of
the USB controllers, which should have caused the controller to be 
runtime-suspended, this is what showed up in the log:

[  295.651545] pci 0000:00:1d.7: PME# enabled
[  295.664044] pci 0000:00:1d.7: Refused to change power state, currently in D0

Which seems to mean that the controller didn't want to go into D3hot!  
Presumably this is because it was unconfigured when the driver was 
unbound.  That's the only explanation I can think of; the controller 
had no objection about going into D3hot when it was bound to the 
driver.

Assuming other PCI devices will have similar behavior, I have to agree
that there's no point trying to put driverless devices into low-power
states.


One more thing: When looking at the r8169 and e1000e drivers, I noticed
that you used the same test (pci_dev_run_wake -- not the greatest name
in the world, BTW) in both the probe and remove routines.  That's not
the right thing to do if the runtime-wakeup setting could get changed
inbetween.  (I realize that currently there is no way to change the
setting, but in the future there might be.)

Do you want to make an explicit assumption that the runtime wakeup
settings are fixed, not subject to change?  If so, then why not compute
the setting just once, when the device is registered, and store it in
the pci_device structure?  Or even in the struct device?

Alan Stern
