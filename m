From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
Date: Fri, 10 May 2019 17:49:04 +0200
Message-ID: <20190510154904.GA31649@lst.de>
References: <20190509103142.GA19550@lst.de> <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com> <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM> <20190509192807.GB9675@localhost.localdomain> <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM> <20190509215409.GD9675@localhost.localdomain> <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM> <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com> <20190510140209.GG9675@localhost.localdomain> <D2D197AF-0072-42AC-A844-8D6BC9677949@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D2D197AF-0072-42AC-A844-8D6BC9677949@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Keith Busch <kbusch@kernel.org>, "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Busch, Keith" <keith.busch@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 11:18:52PM +0800, Kai Heng Feng wrote:
> > I'm afraid the requirement is still not clear to me. AFAIK, all our
> > barriers routines ensure data is visible either between CPUs, or between
> > CPU and devices. The CPU never accesses HMB memory, so there must be some
> > other reasoning if this barrier is a real requirement for this device.
> 
> Sure, I’ll ask vendor what that MemRd is for.

I'd like to understand this bug, but this thread leaves me a little
confused.  So we have a NVMe driver with HMB.

Something crashes - the kernel or the firmware?
When does it crash?  suspend or resume?

That crash seems to be related to a related to a PCIe TLP that reads
memory from the host, probably due to the HMB.

But a device with a HMB has been told that it can access that memory
at any time.  So if in any given suspend state TLP to access RAM are
not allowed we'll have to tell the device to stop using the HMB.

So: what power states do not allow the device to DMA to / from host
memory?  How do we find out we are about to enter those from the
pm methods?  We'll then need to disable the HMB, which might suck
in terms of latency.
