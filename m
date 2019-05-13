From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 07:36:11 -0600
Message-ID: <20190513133611.GA15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <20190511072258.GB14764@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190511072258.GB14764@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Busch, Keith" <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Rafael Wysocki <rafael@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mario Limonciello <Mario.Limonciello@dell.com>, Kai Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-pm@vger.kernel.org

On Sat, May 11, 2019 at 12:22:58AM -0700, Christoph Hellwig wrote:
> A couple nitpicks, mostly leftover from the previous iteration
> (I didn't see replies to those comments from you, despite seeing
> a reply to my mail, assuming it didn't get lost):

I thought you just meant the freeze/unfreeze sequence. I removed that
part entirely, but yes, I can move all of this from the core. I will
just need to export 'nvme_set_features'
 
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
> > +{
> > +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_power);
> > +
> > +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
> > +{
> > +	struct nvme_command c;
> > +	union nvme_result res;
> > +	int ret;
> > +
> > +	if (!result)
> > +		return -EINVAL;
> > +
> > +	memset(&c, 0, sizeof(c));
> > +	c.features.opcode = nvme_admin_get_features;
> > +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> > +
> > +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> > +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> > +	if (ret >= 0)
> > +		*result = le32_to_cpu(res.u32);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_get_power);
> 
> At this point I'd rather see those in the PCIe driver.  While the
> power state feature is generic in the spec I don't see it actually
> being used anytime anywhere else any time soon.
> 
> But maybe we can add a nvme_get_features helper ala nvme_set_features
> in the core to avoid a little boilerplate code for the future?

Sounds good.
 
> > +	ret = nvme_set_power(&dev->ctrl, dev->ctrl.npss);
> > +	if (ret < 0)
> > +		return ret;
> 
> I can't find any wording in the spec that guarantees the highest
> numerical power state is the deepest.  But maybe I'm just missing
> something as such an ordering would be really helpful?

I actually only noticed APST made this assumption, and I had to search
the spec to see where it calls this out. It is in section 8.4:

  Power states are contiguously numbered starting with zero such that
  each subsequent power state consumes less than or equal to the maximum
  power consumed in the previous state.

> >  static int nvme_suspend(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> >  
> > +	/*
> > +	 * Try to use nvme if the device supports host managed power settings
> > +	 * and platform firmware is not involved.
> > +	 */
> 
> This just comments that what, but I think we need a why here as the
> what is fairly obvious..

Sounds good.
