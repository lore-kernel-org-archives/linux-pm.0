From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: PCIe: PME: Fix pcie_pme_remove()
Date: Thu, 28 Feb 2019 14:42:13 -0600
Message-ID: <CAErSpo6WEgqQ2Loub4QKzCvmh5V6nU8X8sui3WLdJbgVZ0BnJw@mail.gmail.com>
References: <1943648.NMEmlssb0J@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1943648.NMEmlssb0J@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dongdong Liu <liudongdong3@huawei.com>, Lukas Wunner <lukas@wunner.de>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 27, 2019 at 5:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for
> two reasons.
>
> First, pcie_pme_suspend() calls synchronize_irq() that will wait for
> the native hotplug interrupt handler as well as for the PME one,
> because they share one IRQ (as per the spec).  That may deadlock if
> hotplug is signaled while pcie_pme_remove() is running and the latter
> calls pci_lock_rescan_remove() before the former.
>
> Second, if pcie_pme_suspend() figures out that wakeup needs to be
> enabled for the port, it will return without disabling the interrupt
> as expected by pcie_pme_remove() which was overlooked by commit
> c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system
> suspend/resume").
>
> To fix that, rework pcie_pme_remove() to disable the PME interrupt,
> clear its status and prevent the PME worker function from re-enabling it
> before calling free_irq() on it which should be sufficient.
>
> Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
> Reported-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I added the deadlock details from Dongdong and applied this to pci/pm
for v5.1, thanks!

Bjorn
