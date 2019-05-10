From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Fri, 10 May 2019 07:51:39 -0600
Message-ID: <20190510135139.GE9675@localhost.localdomain>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <20190510053052.GB3654@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510053052.GB3654@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>, "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Busch, Keith" <keith.busch@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 10:30:52PM -0700, Christoph Hellwig wrote:
> Also I don't see any reason why we'd need to do the freeze game on
> resume.  

Right, definitely no reason for resume.

> Even on suspend it looks a little odd to me, as in theory
> the PM core should have already put the system into a quiescent state.
> But maybe we actually need it there, in which case a comment would
> be helpful.

I wasn't sure if suspend prevents a kthread or work queue from
running. For example, if the device sends a namespace notify AEN during
S2I, does the nvme scan_work run?

Since I wasn't sure, I took a paranoid approach to ensure nothing was
in flight, but I'd be happy if this is unnecessary.

> > +     if (!pm_suspend_via_firmware())
> > +             return nvme_set_power(&ndev->ctrl, 0);
> 
> Don't we need to save the previous power state here and restore that?
> For example if someone set a specific state through nvme-cli?

Sure, we can do that. It would have been super if the spec had this
set feature command's CQE DW0 return the previous power state so we
could set the new and save the old in a single command, but two commands
is just a minor inconvenience.
