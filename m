From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Fri, 10 May 2019 07:52:34 -0600
Message-ID: <20190510135234.GF9675@localhost.localdomain>
References: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvme <linux-nvme@lists.infradead.org>, "Busch, Keith" <keith.busch@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 01:23:11AM -0700, Rafael J. Wysocki wrote:
> On Fri, May 10, 2019 at 8:08 AM Kai-Heng Feng
> > I tested the patch from Keith and it has two issues just as simply skipping
> > nvme_dev_disable():
> > 1) It consumes more power in S2I
> > 2) System freeze after resume
> 
> Well, the Keith's patch doesn't prevent pci_pm_suspend_noirq() from
> asking for D3 and both of the symptoms above may be consequences of
> that in principle.

Right, I'll fix up the kernel's PCI D3 control and resend for
consideration.
