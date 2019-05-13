From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 08:37:54 -0600
Message-ID: <20190513143754.GE15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: keith.busch@intel.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 02:24:41PM +0000, Mario.Limonciello@dell.com wrote:
> This was not a disk with HMB, but with regard to the HMB I believe it needs to be
> removed during s0ix so that there isn't any mistake that SSD thinks it can access HMB
> memory in s0ix.

Is that really the case, though? Where may I find that DMA is not
allowed in this state? I just want an authoritative reference to attach
to the behavior.
