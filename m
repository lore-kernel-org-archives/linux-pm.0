From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Date: Thu, 9 May 2019 11:25:14 +0200
Message-ID: <20190509092514.GA18598@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com> <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com> <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM> <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM> <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com> <20190509065223.GA15984@lst.de> <CAJZ5v0h51nMCte4yL76nMWaYrrXDPrOK=CeUpc50=r2Pp_icPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h51nMCte4yL76nMWaYrrXDPrOK=CeUpc50=r2Pp_icPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 11:19:37AM +0200, Rafael J. Wysocki wrote:
> Right, the choice of the target system state has already been made
> when their callbacks get invoked (and it has been made by user space,
> not by the platform).

>From a previous discussion I remember the main problem here is that
a lot of consumer NVMe use more power when put into D3hot than just
letting the device itself manage the power state transitions themselves.
Based on this patch there also might be some other device that want
an explicit power state transition from the host, but still not be
put into D3hot.

The avoid D3hot at all cost thing seems to be based on the Windows
broken^H^H^H^H^H^Hmodern standby principles.  So for platforms that
follow the modern standby model we need to avoid putting NVMe devices
that support power management into D3hot somehow.  This patch doesa a
few more things, but at least for the device where I was involved in
the earlier discussion those are not needed, and from the Linux
point of view many of them seem wrong too.

How do you think we best make that distinction?  Are the pm_ops
enough if we don't use the simple version?
