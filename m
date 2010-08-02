From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/7] PCI / PCIe: Remove the port driver
	module exit routine
Date: Mon, 2 Aug 2010 16:18:37 +0200
Message-ID: <201008021618.37552.rjw__19522.5991811187$1280759323$gmane$org@sisk.pl>
References: <201007310020.56546.rjw@sisk.pl> <201007310035.14232.rjw@sisk.pl>
	<4C568E34.5080206@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C568E34.5080206@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 02, 2010, Hidetoshi Seto wrote:
> (2010/07/31 7:35), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PCI / PCIe: Remove the port driver module exit routine
> > 
> > The PCIe port driver's module exit routine is never used, so drop it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pcie/portdrv_pci.c |    7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
> > +++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
> > @@ -345,11 +345,4 @@ static int __init pcie_portdrv_init(void
> >  	return retval;
> >  }
> >  
> > -static void __exit pcie_portdrv_exit(void)
> > -{
> > -	pci_unregister_driver(&pcie_portdriver);
> > -	pcie_port_bus_unregister();
> > -}
> > -
> >  module_init(pcie_portdrv_init);
> > -module_exit(pcie_portdrv_exit);
> 
> This is exactly Kaneshige-san's [6/6].

You're right, sorry for not getting the sign-offs right.

> And it seems that this patch can be applied alone.
> 
> Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Thanks,
Rafael
