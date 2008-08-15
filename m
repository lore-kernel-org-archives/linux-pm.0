From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] Adapt the sky2 driver to the reworked
	PCI PM
Date: Fri, 15 Aug 2008 15:32:13 +0200
Message-ID: <200808151532.14327.rjw__2722.3251331181$1218807160$gmane$org@sisk.pl>
References: <200808142335.56644.rjw@sisk.pl> <20080814152318.625f8609@extreme>
	<200808151501.58315.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808151501.58315.rjw@sisk.pl>
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
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, Stephen Hemminger <stephen.hemminger@vyatta.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 15 of August 2008, Rafael J. Wysocki wrote:
> On Friday, 15 of August 2008, Stephen Hemminger wrote:
> > On Thu, 14 Aug 2008 23:38:17 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Adapt the sky2 driver to the reworked PCI PM
> > > 
> > > * Use device_set_wakeup_enable() and friends as needed
> > > * Remove an open-coded reference to the standard PCI PM registers
> > > * Use pci_prepare_to_sleep() and pci_back_from_sleep() in the
> > >   ->suspend() and ->resume() callbacks
> > > * Use the observation that it is sufficient to call pci_enable_wake()
> > >   once, unless it fails
> > > 
> > > Tested on Asus M3A32-MVP (Yukon-2 EC Ultra rev 3).
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/net/sky2.c |   34 ++++++++++------------------------
> > >  1 file changed, 10 insertions(+), 24 deletions(-)
> > > 
> > > Index: linux-2.6/drivers/net/sky2.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/net/sky2.c
> > > +++ linux-2.6/drivers/net/sky2.c
> > > @@ -3035,7 +3035,8 @@ static int sky2_set_wol(struct net_devic
> > >  	struct sky2_port *sky2 = netdev_priv(dev);
> > >  	struct sky2_hw *hw = sky2->hw;
> > >  
> > > -	if (wol->wolopts & ~sky2_wol_supported(sky2->hw))
> > > +	if ((wol->wolopts & ~sky2_wol_supported(sky2->hw))
> > > +	    || !device_can_wakeup(&hw->pdev->dev))
> > >  		return -EOPNOTSUPP;
> > >  
> > 
> > There was a regression in earlier releases caused because some BIOS's
> > are wrong, and device can wakeup.
> 
> device_can_wakeup() returns 'true' if the device is capable of generating PME#
> from at least one low power state (this is determined on the basis of the
> contents of the device's PCI PM registers - please have a look at
> drivers/pci/pci_pm_init() for details) or if ACPI tells us it can wake up.
> IOW, the BIOSes opinion doesn't matter if we find that the device is capable of
> generating PME#, so the regression must have been related to something else.
> I'm very interested in the details, if available.
> 
> Of course, since we rely on the ability of the device to generate PME# and
> device_can_wakeup() returning 'false' means that the device cannot generate
> PME# from any state, it's reasonable to check it IMO.

BTW, if device_can_wakeup(&pdev->dev) returns 'false',
pci_enable_wake(pdev, state, true) will fail for any 'state', so the wake-up
won't work regardless of the change above.

Thanks,
Rafael
