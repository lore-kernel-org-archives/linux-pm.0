From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCIe native PME support
Date: Wed, 26 Aug 2009 01:43:58 +0200
Message-ID: <200908260143.58580.rjw__39140.1573819623$1251244200$gmane$org@sisk.pl>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
	<200908250013.32462.rjw@sisk.pl>
	<20090825012738.GA27590@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090825012738.GA27590@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 August 2009, Shaohua Li wrote:
> On Tue, Aug 25, 2009 at 06:13:32AM +0800, Rafael J. Wysocki wrote:
> > On Monday 24 August 2009, Shaohua Li wrote:
> > >
> > > PCIe defines a native PME detection mechanism. When a PCIe endpoint
> > > invokes PME, PCIe root port has a set of regisets to detect the
> > > endpoint's bus/device/function number and root port will send out
> > > interrupt when PME is received. After getting interrupt, OS can identify
> > > which device invokes PME according to such information. See PCIe
> > > spec for detail. This patch implements this feature.
> > >
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > ---
> > >  drivers/pci/pcie/Kconfig     |    8 +
> > >  drivers/pci/pcie/Makefile    |    2
> > >  drivers/pci/pcie/pcie_npme.c |  327 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 337 insertions(+)
> > >
> > > Index: linux/drivers/pci/pcie/Kconfig
> > > ===================================================================
> > > --- linux.orig/drivers/pci/pcie/Kconfig       2009-08-24 15:38:46.000000000 +0800
> > > +++ linux/drivers/pci/pcie/Kconfig    2009-08-24 15:47:09.000000000 +0800
> > > @@ -46,3 +46,11 @@ config PCIEASPM_DEBUG
> > >       help
> > >         This enables PCI Express ASPM debug support. It will add per-device
> > >         interface to control ASPM.
> > > +
> > > +config PCIE_NPME
> > > +     bool "PCIe Native PME reporint(Experimental)"
> > > +     depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
> > > +     help
> > > +       This enables PCI Express Native PME Reporting. When device invokes
> > > +       PME, root port or root complex event collector can report the PME
> > > +       events to OS.
> > 
> > Well, I think we can just drop the CONFIG option and make the whole thing
> > depend on PM_RUNTIME && PCIEPORTBUS.  So make it
> This isn't always required, the ACPI approach still works.

For the record, I have a system where it doesn't.

> But fine, I'll do it.
>  
> > +config PCIE_PME
> > +       def_bool y
> > +       depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
> > 
> > Ah, please drop the 'N' as I've just done.  It doesn't carry any substantial
> > information and is confusing IMO.  Please also drop it from the function names
> > below.
> I don't want to drop the 'N'. The spec calls it native pme, so it's natural to
> name the driver npme.

Did you see the NPME acronym _anywhere_ in the spec or just anywhere outside
of your patches?

I know that it's called "native" by the spec, but if you use "pcie" and "pme"
together in the names, that clearly indicates they are related to something
_specific_ to PCIe, so the "native" part is really redundant.

Also, the headers of the files state clearly that they are for the "native"
PCIe PME and I don't think there's any point to put that information in
every function name in these files.

> 
> > > +#define PCI_EXP_RTSTA_PME 0x10000 /* PME status */
> > > +
> > > +static int disabled;
> > > +module_param(disabled, bool, 0);
> > > +static int force = 1;
> > > +module_param(force, bool, 0);
> > 
> > Why would anyone want to force it or disable it at this level?
> In ACPI platform, we need call _OSC to declare the feature before we can use it.
> Some BIOSes simply don't provide _OSC or implement it wrong. Per spec, we can't
> enable the feature in such cases, so I provide an option to force it enabled.
> 
> The 'disabled' option is in case the feature doesn't work.

So perhaps we can add a kernel command line option for that in analogy with
pcie_aspm ?

> > > +
> > > +struct pcie_npme_service_data {
> > > +     spinlock_t lock;
> > > +     struct pcie_device *dev;
> > > +     struct work_struct work;
> > > +     int in_exiting; /* driver is exiting, don't reenable interrupt */
> > > +};
> > > +
> > 
> > Please add kerneldoc comments to all new functions
> > 
> > > +static inline void pcie_npme_enable_interrupt(struct pci_dev *pdev, bool enable)
> > > +{
> > > +     int pos;
> > > +     u16 rtctl;
> > > +
> > > +     pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > > +
> > > +     pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &rtctl);
> > > +     if (enable)
> > > +             rtctl |= PCI_EXP_RTCTL_PMEIE;
> > > +     else
> > > +             rtctl &= ~PCI_EXP_RTCTL_PMEIE;
> > > +     pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, rtctl);
> > > +}
> > > +
> > > +static inline void pcie_npme_clear_status(struct pci_dev *pdev)
> > > +{
> > > +     int pos;
> > > +     u32 rtsta;
> > > +
> > > +     pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > > +
> > > +     pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
> > > +     rtsta |= PCI_EXP_RTSTA_PME;
> > > +     pci_write_config_dword(pdev, pos + PCI_EXP_RTSTA, rtsta);
> > > +}
> > > +
> > > +static bool pcie_npme_handle_request(struct pci_dev *root_port, u16 request_id)
> > 
> > requester_id would be better.
> ok
> 
> > > +{
> > > +     struct pci_dev *target;
> > > +     bool device_found = false;
> > > +     u8 busnr = request_id >> 8, devfn = request_id & 0xff;
> > > +
> > > +     target = pci_get_bus_and_slot(busnr, devfn);
> > > +     /*
> > > +      * PME from PCI devices under a PCIe-to-PCI bridge may be converted to
> > > +      * a PCIe in-band PME message. In such case, bridge will assign the
> > > +      * message a new request id using bridge's secondary bus numer and
> > > +      * device number/function number 0
> > > +      */
> > > +     if (!target && devfn == 0) {
> > 
> > +       if (!target && !devfn) {
> > 
> > Or better
> > 
> > +       if (target) {
> > +               ret = pci_pm_wakeup(target);
> > +               pci_dev_put(target);
> > +               return ret;
> > +       }
> > 
> > BTW, what we do if target is NULL, but devfn is nonzero?
> From my understanding of PCIe bridge spec, the bridge always makes the devfn to zero
> for legacy pci request upstream.

Well, that requires some clarification.

Are we going to always get target == NULL for such bridges?  If not, the whole
thing should be redesigned and it seems to me this is the case.

> > > +             struct pci_bus *bus;
> > > +
> > > +             bus = pci_find_bus(pci_domain_nr(root_port->bus), busnr);
> > > +             if (bus) {
> > > +                     target = bus->self;
> > > +                     if (!target->is_pcie || target->pcie_type !=
> > > +                                     PCI_EXP_TYPE_PCI_BRIDGE)
> > 
> > +                       if (!target->is_pcie
> > +                           || target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)
> > 
> > > +                             target = NULL;
> > > +             }
> > > +             if (target)
> > > +                     pci_dev_get(target);
> > 
> > Now we don't need to do the _get().
> ok
> 
> > > +     }
> > > +
> > > +     if (target)
> > > +             device_found = pci_pm_handle_wakeup_event(target);
> > 
> > Now we call the function that searches over the hierarchy below the bridge.
> > 
> > > +     else
> > > +             printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
> > > +                     busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
> > > +
> > > +     if (target)
> > > +             pci_dev_put(target);
> > 
> > The two lines above aren't necessary any more.
> > > +
> > > +     return device_found;
> > > +}
> > > +
> > > +static void pcie_npme_work_handle(struct work_struct *work)
> > > +{
> > > +     struct pcie_npme_service_data *data =
> > > +                     container_of(work, struct pcie_npme_service_data, work);
> > > +     struct pci_dev *root_port = data->dev->port;
> > > +     unsigned long flags;
> > > +     bool spurious = true;
> > > +     u32 rtsta;
> > > +     int pos;
> > > +
> > > +     pos = pci_find_capability(root_port, PCI_CAP_ID_EXP);
> > > +     while (1) {
> > > +             spin_lock_irqsave(&data->lock, flags);
> > > +             pci_read_config_dword(root_port, pos + PCI_EXP_RTSTA, &rtsta);
> > > +
> > > +             if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> > > +                     spin_unlock_irqrestore(&data->lock, flags);
> > > +                     break;
> > > +             }
> > > +
> > > +             /* clear PME, if there are other pending PME, the status will
> > > +              * get set again
> > > +              */
> > > +             pcie_npme_clear_status(root_port);
> > > +             spin_unlock_irqrestore(&data->lock, flags);
> > > +
> > > +             if (pcie_npme_handle_request(root_port, rtsta & 0xffff))
> > > +                     spurious = false;
> > > +     }
> > 
> > It doesn't work like this if my reading of the spec is correct.  Namely,
> > we should get a separate interrupt for each device that generated a PME,
> > so it's only necessary to clear the status without looping.
> > 
> > Moreover, I think we should do something like this:
> > 
> > * interrrupt arrives
> > * disable interrupt
> > * read the requester ID, schedule the service
> > * clear the status
> > * enable interrupt
> > 
> > which now will allow us to get the interrupt for another device, if any.
> > The spec seems to require devices not to generate PME messages continously,
> > but only if they are not handled within a "reasonable amount of time" (original
> > wording), so we should be safe from interrupt flooding.
> > 
> > Note that we need to create a separate work_struct for each interrupt in this
> > case, though.
> I have different understanding. The root port can buffer several PME requests from
> different devices. If the PME pending bit is set and after the status is clear,
> the status bit will get set soon. We can do one request one time for each interrupt,
> but seems not necessary. And the loop makes OS more quickly handle PME request without
> overflow root port buffer.

OK, but in that case it probably is a good idea to use the PME Pending bit as
well.

Thanks,
Rafael
