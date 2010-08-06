From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/8] PCI / PCIe: Ask BIOS for control of all
	native services at once (v6)
Date: Fri, 6 Aug 2010 12:47:23 +0200
Message-ID: <201008061247.23581.rjw@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022356.31166.rjw@sisk.pl>
	<4C5B6660.9030507@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5B6660.9030507@jp.fujitsu.com>
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

On Friday, August 06, 2010, Hidetoshi Seto wrote:
> Rafael,
> 
> I found that following 2 hunks break kernel build with O= option. 
> 
> (2010/08/03 6:56), Rafael J. Wysocki wrote:
> > Index: linux-2.6/drivers/pci/pcie/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pcie/Makefile
> > +++ linux-2.6/drivers/pci/pcie/Makefile
> > @@ -6,10 +6,11 @@
> >  obj-$(CONFIG_PCIEASPM)		+= aspm.o
> >  
> >  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
> > +pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
> >  
> >  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
> >  
> >  # Build PCI Express AER if needed
> >  obj-$(CONFIG_PCIEAER)		+= aer/
> >  
> > -obj-$(CONFIG_PCIE_PME) += pme/
> > +obj-$(CONFIG_PCIE_PME) += pme/pcie_pme.o
> 
> and
> 
> > Index: linux-2.6/drivers/pci/pcie/pme/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pcie/pme/Makefile
> > +++ /dev/null
> > @@ -1,8 +0,0 @@
> > -#
> > -# Makefile for PCI-Express Root Port PME signaling driver
> > -#
> > -
> > -obj-$(CONFIG_PCIE_PME) += pmedriver.o
> > -
> > -pmedriver-objs := pcie_pme.o
> > -pmedriver-$(CONFIG_ACPI) += pcie_pme_acpi.o
> 
> $ make -j12 O=../gitbuild/
>   GEN     /home/seto/gitbuild/Makefile
>   CHK     include/linux/version.h
>   Using /home/seto/GIT-linux as source for kernel
>   CHK     include/generated/utsrelease.h
>   CALL    /home/seto/GIT-linux/scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      drivers/pci/pcie/pme/pcie_pme.o
> Assembler messages:
> Fatal error: can't create drivers/pci/pcie/pme/.tmp_pcie_pme.o: No such file or directory
> make[4]: *** [drivers/pci/pcie/pme/pcie_pme.o] Error 2
> make[3]: *** [drivers/pci/pcie] Error 2
> make[2]: *** [drivers/pci] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [sub-make] Error 2
> $
> 
> It seems that the error is because directory pme/ is not created
> in the working tree.

Hmm.  That seems to be correct, but I'm not sure how to resolve it.

If I move pcie_pme.c to pcie/ in the same patch, the changes in that file
will not be clearly visible.

Perhaps I'll add a separate patch that will remove the Makefile from
pme/ and move pcie_pme.c to pcie/.

Thanks,
Rafael
