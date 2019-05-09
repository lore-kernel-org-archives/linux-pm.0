From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Thu, 9 May 2019 22:48:00 +0200
Message-ID: <CAJZ5v0iezuuXeHAuEPbJ2fAcbmaySCAofU+yZ-j-WuN6O+yq0A@mail.gmail.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <20190509065223.GA15984@lst.de> <CAJZ5v0h51nMCte4yL76nMWaYrrXDPrOK=CeUpc50=r2Pp_icPw@mail.gmail.com>
 <20190509092514.GA18598@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509092514.GA18598@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 11:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 09, 2019 at 11:19:37AM +0200, Rafael J. Wysocki wrote:
> > Right, the choice of the target system state has already been made
> > when their callbacks get invoked (and it has been made by user space,
> > not by the platform).
>
> From a previous discussion I remember the main problem here is that
> a lot of consumer NVMe use more power when put into D3hot than just
> letting the device itself manage the power state transitions themselves.
> Based on this patch there also might be some other device that want
> an explicit power state transition from the host, but still not be
> put into D3hot.
>
> The avoid D3hot at all cost thing seems to be based on the Windows
> broken^H^H^H^H^H^Hmodern standby principles.  So for platforms that
> follow the modern standby model we need to avoid putting NVMe devices
> that support power management into D3hot somehow.  This patch doesa a
> few more things, but at least for the device where I was involved in
> the earlier discussion those are not needed, and from the Linux
> point of view many of them seem wrong too.
>
> How do you think we best make that distinction?  Are the pm_ops
> enough if we don't use the simple version?

First, I think that it is instructive to look at what happens without
the patch: nvme_suspend() gets called by pci_pm_suspend() (which
basically causes the device to be "stopped" IIUC) and then
pci_pm_suspend_noirq() is expected to put the device into the right
power state through pci_prepare_to_sleep().  In theory, this should
work for both S2R and S2I as long as the standard PCIe PM plus
possibly ACPI PM is sufficient for the device.  [Of course, the
platform firmware invoked at the last stage of S2R can "fix up" things
to reduce power further, but that should not be necessary if all is
handled properly up to this point.]

The claim in the patch changelog is that one design choice in Windows
related to "Modern Standby" has caused our default PCI PM to not apply
to NVMe devices in general (or to apply to them, but without much
effect, which is practically equivalent IMO).  This is not about a
"different paradigm" (as Mario put it) or a different type of system
suspend, but about the default PCI PM being basically useless for
those devices at least in some configurations.

And BTW, the same problem would have affected PM-runtime, had it been
supported by the nvme driver, because Linux uses the combination of
the standard PCIe PM and ACPI PM for PM-runtime too, and the
"paradigm" in there is pretty much the same as for S2I, so let's not
confuse things, pretty please.

All of this means that the driver needs to override the default PCI PM
like in the patch that Keith has just posted.  Unfortunately, it looks
like the "suspend via firmware" check needs to be there, because the
platform firmware doing S3 on some platforms may get confused by the
custom PM in the driver.
