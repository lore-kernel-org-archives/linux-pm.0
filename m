From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Fri, 10 May 2019 23:18:52 +0800
Message-ID: <D2D197AF-0072-42AC-A844-8D6BC9677949@canonical.com>
References: <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <20190510140209.GG9675@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510140209.GG9675@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <kbusch@kernel.org>
Cc: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Busch, Keith" <keith.busch@intel.com>
List-Id: linux-pm@vger.kernel.org



> On May 10, 2019, at 10:02 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> On Thu, May 09, 2019 at 11:05:42PM -0700, Kai-Heng Feng wrote:
>> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a  
>> memory barrier.
>> If mb() shouldn’t be used here, what’s the correct variant to use in this  
>> context?
> 
> I'm afraid the requirement is still not clear to me. AFAIK, all our
> barriers routines ensure data is visible either between CPUs, or between
> CPU and devices. The CPU never accesses HMB memory, so there must be some
> other reasoning if this barrier is a real requirement for this device.

Sure, I’ll ask vendor what that MemRd is for.

Kai-Heng
