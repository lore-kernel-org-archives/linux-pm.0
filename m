From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Bug 112121] New: Some PCIe options cause devices to be removed
 after syspend
Date: Mon, 8 Feb 2016 07:51:13 -0600
Message-ID: <CAErSpo4beDk_ajsgqMUNJ3TGxDv=ysyPzhXHcx2AhUEUE9ROKA@mail.gmail.com>
References: <bug-112121-41252@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35003 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcBHN51 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:57:27 -0500
Received: by mail-yw0-f179.google.com with SMTP id g127so101894261ywf.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 05:57:26 -0800 (PST)
In-Reply-To: <bug-112121-41252@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mike@fireburn.co.uk
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, linux-nvme <linux-nvme@lists.infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>

[+cc linux-pci, NVMe folks,  power management folks]

On Sun, Feb 7, 2016 at 11:04 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=112121
>
>             Bug ID: 112121
>            Summary: Some PCIe options cause devices to be removed after
>                     syspend
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.5-rc2
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: mike@fireburn.co.uk
>         Regression: No
>
> Created attachment 203091
>   --> https://bugzilla.kernel.org/attachment.cgi?id=203091&action=edit
> Dmesg showing PCIe device removals
>
> I was having issues with suspend, when the machine was being resumed iommu
> started removing devices - including my PCIe NVMe drive which contained my root
> partition
>
> The problem showed up with:
>
> [*] PCI support
> [*]   Support mmconfig PCI config space access
> [*]   PCI Express Port Bus support
> [*]     PCI Express Hotplug driver
> [*]     Root Port Advanced Error Reporting support
> [*]       PCI Express ECRC settings control
> < >       PCIe AER error injector support
> -*-     PCI Express ASPM control
> [ ]       Debug PCI Express ASPM
>           Default ASPM policy (BIOS default)  --->
> [*]   Message Signaled Interrupts (MSI and MSI-X)
> [ ]   PCI Debugging
> [*]   Enable PCI resource re-allocation detection
> < >   PCI Stub driver
> [*]   Interrupts on hypertransport devices
> [ ] PCI IOV support
> [*] PCI PRI support
> -*- PCI PASID support
>     PCI host controller drivers  ----
> < > PCCard (PCMCIA/CardBus) support  ----
> [*] Support for PCI Hotplug  --->
> < > RapidIO support
>
>
> This is what I have now:
>
> [*] PCI support
> [*]   Support mmconfig PCI config space access
> [*]   PCI Express Port Bus support
> [ ]     Root Port Advanced Error Reporting support
> -*-     PCI Express ASPM control
> [ ]       Debug PCI Express ASPM
>           Default ASPM policy (BIOS default)  --->
> [*]   Message Signaled Interrupts (MSI and MSI-X)
> [*]   PCI Debugging
> [ ]   Enable PCI resource re-allocation detection
> < >   PCI Stub driver
> [*]   Interrupts on hypertransport devices
> [ ] PCI IOV support
> [ ] PCI PRI support
> [ ] PCI PASID support
>     PCI host controller drivers  ----
> < > PCCard (PCMCIA/CardBus) support  ----
> [ ] Support for PCI Hotplug  ----
> < > RapidIO support
>
> I tried disabling the iommu driver first but it had no effect
>
> If people are interested I could play with the above options to see which one
> causes the issue

My guess is that PCI hotplug is the important one.  It would be nice
if dmesg contained enough information to connect nvme0n1 to a PCI
device.  It'd be even nicer if the PCI core noted device removals or
whatever happened here.

You don't get any more details if you boot with "ignore_loglevel", do you?

Mike, you didn't mark this as a regression, so I assume it's always
been this way, and we just haven't noticed it because most people
enable PCI hotplug (or whatever the relevant config option is).

Bjorn
