From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 07:47:08 -0600
Message-ID: <20190513134708.GB15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "Busch, Keith" <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>, Mario Limonciello <Mario.Limonciello@dell.com>, lkml <linux-kernel@vger.kernel.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Rafael Wysocki <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, May 11, 2019 at 11:06:35PM -0700, Chaitanya Kulkarni wrote:
> On 5/10/19 2:35 PM, Keith Busch wrote:
> >   
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)

> dev->ctrl.npss is u8 can we use same data type here ?
> If this is due to last_ps we use as a result and then call set_power may 
> be we can change the type of last_ps ?
> OR
> can we please use unsigned int to avoid possible warnings ?

Right, the feature uses a 32-bit value even though only the first byte
is defined at the moment. It's just for foward compatibility. Will make
this a u32.

> > +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
> > +{
> > +	struct nvme_command c;
> May be use struct nvme_command c {} so we can get rid of the memset() call.

Good point.

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
>
> May be add a check for result here in above if before deref pointer :-
> 	if (ret >= 0 && result)

I have it checked at the top of the function since it doesn't make much
sense to call this without a way to return the result.
