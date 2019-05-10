From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Fri, 10 May 2019 10:23:11 +0200
Message-ID: <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com> <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com> <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com> <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain> <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain> <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch <keith.busch@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 8:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 06:19, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:
>
> >> -----Original Message-----
> >> From: Keith Busch <kbusch@kernel.org>
> >> Sent: Thursday, May 9, 2019 4:54 PM
> >> To: Limonciello, Mario
> >> Cc: kai.heng.feng@canonical.com; hch@lst.de; axboe@fb.com;
> >> sagi@grimberg.me; rafael@kernel.org; linux-pm@vger.kernel.org;
> >> rafael.j.wysocki@intel.com; linux-kernel@vger.kernel.org; linux-
> >> nvme@lists.infradead.org; keith.busch@intel.com
> >> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead
> >> of D3 on
> >> Suspend-to-Idle
> >>
> >>
> >> [EXTERNAL EMAIL]
> >>
> >> On Thu, May 09, 2019 at 09:37:58PM +0000, Mario.Limonciello@dell.com
> >> wrote:
> >>>> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> >>>> +{
> >>>> +  int ret;
> >>>> +
> >>>> +  mutex_lock(&ctrl->scan_lock);
> >>>> +  nvme_start_freeze(ctrl);
> >>>> +  nvme_wait_freeze(ctrl);
> >>>> +  ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> >>>> +                          NULL);
> >>>> +  nvme_unfreeze(ctrl);
> >>>> +  mutex_unlock(&ctrl->scan_lock);
> >>>> +
> >>>> +  return ret;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(nvme_set_power);
> >>>
> >>> I believe without memory barriers at the end disks with HMB this will
> >>> still kernel panic (Such as Toshiba BG3).
> >>
> >> Well, the mutex has an implied memory barrier, but your HMB explanation
> >> doesn't make much sense to me anyway. The "mb()" in this thread's original
> >> patch is a CPU memory barrier, and the CPU had better not be accessing
> >> HMB memory. Is there something else going on here?
> >
> > Kai Heng will need to speak up a bit in his time zone as he has this disk
> > on hand,
> > but what I recall from our discussion was that DMA operation MemRd after
> > resume was the source of the hang.
>
> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a
> memory barrier.
> If mb() shouldn’t be used here, what’s the correct variant to use in this
> context?
>
> >
> >>> This still allows D3 which we found at least failed to go into deepest
> >>> state and
> >> blocked
> >>> platform s0ix for the following SSDs (maybe others):
> >>> Hynix PC601
> >>> LiteOn CL1
> >>
> >> We usually write features to spec first, then quirk non-compliant
> >> devices after.
> >
> > NVME spec doesn't talk about a relationship between SetFeatures w/
> > NVME_FEAT_POWER_MGMGT and D3 support, nor order of events.
> >
> > This is why we opened a dialog with storage vendors, including
> > contrasting the behavior
> > of Microsoft Windows inbox NVME driver and Intel's Windows RST driver.
> >
> > Those two I mention that come to mind immediately because they were most
> > recently
> > tested to fail.  Our discussion with storage vendors overwhelmingly
> > requested
> > that we don't use D3 under S2I because their current firmware
> > architecture won't
> > support it.
> >
> > For example one vendor told us with current implementation that receiving
> > D3hot
> > after NVME shutdown will prevent being able to enter L1.2.  D3hot entry
> > was supported
> > by an IRQ handler that isn't serviced in NVME shutdown state.
> >
> > Another vendor told us that with current implementation it's impossible
> > to transition
> > to PS4 (at least via APST) while L1.2 D3hot is active.
>
> I tested the patch from Keith and it has two issues just as simply skipping
> nvme_dev_disable():
> 1) It consumes more power in S2I
> 2) System freeze after resume

Well, the Keith's patch doesn't prevent pci_pm_suspend_noirq() from
asking for D3 and both of the symptoms above may be consequences of
that in principle.
