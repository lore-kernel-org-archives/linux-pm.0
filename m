From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PCI PM: PCIe PME root port service
	driver (rev. 5)
Date: Thu, 18 Feb 2010 20:57:52 +0100
Message-ID: <201002182057.53002.rjw__2181.02357252992$1266523106$gmane$org@sisk.pl>
References: <201002172335.47703.rjw@sisk.pl> <201002172339.08865.rjw@sisk.pl>
	<4B7CBD37.9000706@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B7CBD37.9000706@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Matthew Garrett <mjg@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 18 February 2010, Kenji Kaneshige wrote:
> Hi,
> 
> I'm sorry for the delayed comments.
> 
> > +
> > +/**
> > + * pcie_pme_interrupt_enable - Enable/disable PCIe PME interrupt generation.
> > + * @dev: PCIe root port or event collector.
> > + * @enable: Enable or disable the interrupt.
> > + */
> > +static void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
> > +{
> > +	int rtctl_pos;
> > +	u16 rtctl;
> > +
> > +	rtctl_pos = pci_find_capability(dev, PCI_CAP_ID_EXP) + PCI_EXP_RTCTL;
> 
> How about
> 
> 	rtctl_pos = pci_pcie_cap(dev) + PCI_EXP_RTCTL;
> 
> ?
> 
> The pci_pcie_cap() returns PCIe capability offset saved in struct pci_dev.
> By using this, we can avoid redundant search in PCI configuration space.

While I agree with the comment, I'd prefer to change this with a separate
patch, unless the entire patchset misses the merge window.

Rafael
