From: Adrian Bunk <bunk@kernel.org>
Subject: Re: 2.6.23-rc3-git3 make warnings
Date: Tue, 21 Aug 2007 18:57:46 +0200
Message-ID: <20070821165746.GA30705__6045.86580670929$1187715574$gmane$org@stusta.de>
References: <20070821132038.GA22254@ff.dom.local>
	<20070821161723.GA8323@hacking> <20070821164429.GA18324@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070821164429.GA18324@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 21, 2007 at 09:44:29AM -0700, Greg KH wrote:
> On Wed, Aug 22, 2007 at 12:17:23AM +0800, WANG Cong wrote:
> > On Tue, Aug 21, 2007 at 03:20:38PM +0200, Jarek Poplawski wrote:
> > >Here are some more of, probably well-known, warnings with attached
> > >testing-only .config.
> > >
> > >Regards,
> > >Jarek P.
> > >
> > >
> > >sed: -e expression #1, char 154: Unknown option to 's'
> > >drivers/acpi/ec.c: In function `acpi_ec_ecdt_probe':
> > >drivers/acpi/ec.c:873: warning: passing arg 1 of `acpi_get_devices' discards qualifiers from pointer target type
> > >drivers/pci/search.c: In function `pci_find_slot':
> > >drivers/pci/search.c:99: warning: `pci_find_device' is deprecated (declared at include/linux/pci.h:480)
> > >drivers/pci/search.c: At top level:
> > >drivers/pci/search.c:437: warning: `pci_find_device' is deprecated (declared at drivers/pci/search.c:244)
> > >drivers/pci/search.c:437: warning: `pci_find_device' is deprecated (declared at drivers/pci/search.c:244)
> > >drivers/pci/search.c:438: warning: `pci_find_slot' is deprecated (declared at drivers/pci/search.c:96)
> > >drivers/pci/search.c:438: warning: `pci_find_slot' is deprecated (declared at drivers/pci/search.c:96)
> > >drivers/pci/msi.c:686: warning: weak declaration of `arch_msi_check_device' after first use results in unspecified behavior
> > >drivers/pci/msi.c:698: warning: weak declaration of `arch_setup_msi_irqs' after first use results in unspecified behavior
> > >drivers/pci/msi.c:718: warning: weak declaration of `arch_teardown_msi_irqs' after first use results in unspecified behavior
> > >In file included from drivers/usb/host/ohci-hcd.c:859:
> > >drivers/usb/host/ohci-pci.c: In function `ohci_pci_start':
> > >drivers/usb/host/ohci-pci.c:202: warning: unused variable `pdev'
> > 				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > This warning is suspicious. In fact, 'pdev' is used when CONFIG_PM is defined.
> > See the following:
> > 
> > <snip>
> >                 if (device_may_wakeup(&pdev->dev))
> >                         ohci->hc_control |= OHCI_CTRL_RWC;
> > <snip>
> > 
> > Or a bug of gcc?
> 
> gcc bug, I have a patch for this queued up.

No, gcc is all right.

The problem is that with CONFIG_PM=y, CONFIG_PM_SLEEP=n 
device_may_wakeup() is an empty macro, and the pdev usage is in this 
case removed by the preprocessor and therefore invisible to the 
compiler.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
