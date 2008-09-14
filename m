From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] e100: Use pci_pme_active to clear PME_Status
	and disable PME#
Date: Mon, 15 Sep 2008 01:44:35 +0200
Message-ID: <200809150144.36142.rjw__19034.7038246275$1221435816$gmane$org@sisk.pl>
References: <200808051730.27599.alessandro.guido@gmail.com>
	<200808080018.05887.rjw@sisk.pl> <48CC1F7C.7050908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48CC1F7C.7050908@garzik.org>
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
To: Jeff Garzik <jeff@garzik.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 13 of September 2008, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > e100: Use pci_pme_active to clear PME_Status and disable PME#
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > ---
> >  drivers/net/e100.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > Index: linux-2.6/drivers/net/e100.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/net/e100.c
> > +++ linux-2.6/drivers/net/e100.c
> > @@ -2738,9 +2738,7 @@ static int __devinit e100_probe(struct p
> >  		nic->flags |= wol_magic;
> >  
> >  	/* ack any pending wake events, disable PME */
> > -	err = pci_enable_wake(pdev, 0, 0);
> > -	if (err)
> > -		DPRINTK(PROBE, ERR, "Error clearing wake event\n");
> > +	pci_pme_active(pdev, false);
> 
> Since I am rusty on my PCI...  why is this needed?

Because we just want to clear PME_Status and disable PME#, but
pci_enable_wake() involves an ACPI call and generally depends on the
dev->power.can_wakeup and dev->power.should_wakeup flags being set.

The patch I sent here http://marc.info/?l=linux-kernel&m=122096638020191&w=4
has a better changelog.

Thanks,
Rafael
