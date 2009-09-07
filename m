From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1 update] PCI PM: PCIe PME root port
	service	driver
Date: Mon, 7 Sep 2009 15:53:34 +0800
Message-ID: <20090907075334.GB19224__7578.02711236781$1252310144$gmane$org@sli10-desk.sh.intel.com>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
	<20090901023549.GB3695@sli10-desk.sh.intel.com>
	<200909061434.24870.rjw@sisk.pl> <200909061901.14979.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909061901.14979.rjw@sisk.pl>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Sep 07, 2009 at 01:01:14AM +0800, Rafael J. Wysocki wrote:
> On Sunday 06 September 2009, Rafael J. Wysocki wrote:
> > On Tuesday 01 September 2009, Shaohua Li wrote:
> > ...
> > > Updated patch.
> >
> > I looked at it and thought I would do it differently in many places, so
> > below is my version.
> +/*
> + * Apparently, many BIOSes don't implement ACPI _OSC correctly, so let's not use
> + * it by default.
> + */
> +static bool use_acpi_osc;
I'd prefer _OSC is called by default, because without it PCIe PME might not work,
chipset might have internal registers to change in the _OSC. Instead, if _OSC fails,
we just ignore it by default.

> +/**
> + * pcie_pme_handle_request - Find device that generated PME and handle it.
> + * @port: Root port or event collector that generated the PME interrupt.
> + * @req_id: PCIe Requester ID of the device that generated the PME.
> + */
> +static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
> +{
> +       u8 busnr = req_id >> 8, devfn = req_id & 0xff;
> +       struct pci_bus *bus;
> +       struct pci_dev *dev;
> +       bool found = false;
> +
> +       bus = pci_find_bus(pci_domain_nr(port->bus), busnr);
> +       if (!bus)
> +               goto out;
> +
> +       down_read(&pci_bus_sem);
> +       list_for_each_entry(dev, &bus->devices, bus_list) {
> +               pci_dev_get(dev);
> +               if (dev->devfn == devfn) {
> +                       found = true;
> +                       break;
> +               }
> +               pci_dev_put(dev);
> +       }
> +       up_read(&pci_bus_sem);
> +
> +       if (found) {
> +               pm_request_resume(&dev->dev);
Sounds we missed the case dev is PCIe-PCI bridge's (secondary bus, devfn 0). In such
case we still need scan the legacy devices under PCIe-PCI bridge

Thanks,
Shaohua
