From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] PCI/PM: D3cold support for system suspend
Date: Thu, 04 Apr 2013 22:18:04 +0200
Message-ID: <40154903.vXKcu58qDG@vostro.rjw.lan>
References: <1359434058-15918-1-git-send-email-ying.huang@intel.com> <CAErSpo6m=3txSUH5Bwm7Y7K=25UWA4-kgPs_fs-Pa8jkP5WRDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6m=3txSUH5Bwm7Y7K=25UWA4-kgPs_fs-Pa8jkP5WRDA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Huang Ying <ying.huang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 04, 2013 12:26:52 PM Bjorn Helgaas wrote:
> On Mon, Jan 28, 2013 at 9:34 PM, Huang Ying <ying.huang@intel.com> wrote:
> > [PATCH 1/4] PCI/ACPI: Add target state as parameter to pci_platform_pm_ops->run_wake
> > [PATCH 2/4] PCI: Rename pci_dev->runtime_d3cold to pci_dev->set_d3cold
> > [PATCH 3/4] PCI/PM: Set pci_dev->set_d3cold in pci_set_power_state
> > [PATCH 4/4] PCI/PM: Enable D3cold support for system suspend
> 
> Do we still need these?
> 
> What problem do they solve?  Or what new functionality do they add?

They were supposed to allow PCI devices to be put into D3cold (via ACPI)
during system suspend, but I think it's better not to do that at this
point.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
