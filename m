From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 12:16:18 -0600
Message-ID: <20190513181618.GD15437@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
 <20190513151652.GB15437@localhost.localdomain>
 <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: sagi@grimberg.me, rafael@kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, keith.busch@intel.com, Christoph Hellwig <hch@lst.de>
List-Id: linux-pm@vger.kernel.org

On Tue, May 14, 2019 at 01:16:22AM +0800, Kai-Heng Feng wrote:
> Disabling HMB prior suspend makes my original patch work without memory
> barrier.
> 
> However, using the same trick on this patch still freezes the system during
> S2I.

Could you post your code, please?
