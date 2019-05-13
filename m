From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Tue, 14 May 2019 01:16:22 +0800
Message-ID: <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
 <20190513151652.GB15437@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513151652.GB15437@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mario.Limonciello@dell.com, keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

at 23:16, Keith Busch <kbusch@kernel.org> wrote:

> On Mon, May 13, 2019 at 04:57:08PM +0200, Christoph Hellwig wrote:
>> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com  
>> wrote:
>>> And NVME spec made it sound to me that while in a low power state it  
>>> shouldn't
>>> be available if the memory isn't available.
>>>
>>> NVME spec in 8.9:
>>>
>>> "Host software should request that the controller release the
>>> assigned ranges prior to a shutdown event, a Runtime D3 event, or any  
>>> other event
>>> that requires host software to reclaim the assigned ranges."
>>
>> The last part of the quoted text is the key - if the assigned range
>> is reclaimed, that is the memory is going to be used for something else,
>> we need to release the ranges.  But we do not release the ranges,
>> as we want to keep the memory in use so that we can quickly use it
>> again.
>
> Yes, this. As far as I know, the host memory range is still accessible in
> the idle suspend state. If there are states in which host memory is not
> accessible, a reference explaining the requirement will be most helpful.

Disabling HMB prior suspend makes my original patch work without memory  
barrier.

However, using the same trick on this patch still freezes the system during  
S2I.

Kai-Heng
