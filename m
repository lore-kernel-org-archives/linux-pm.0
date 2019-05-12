From: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Sun, 12 May 2019 23:30:58 +0900
Message-ID: <20190512143056.GA7761@minwooim-desktop>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Mario Limonciello <Mario.Limonciello@dell.com>, lkml <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, "hange-folder>?" <toggle-mailboxes@minwooim-desktop>
List-Id: linux-pm@vger.kernel.org

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
> May be add a check for result here in above if before deref pointer :-
> 	if (ret >= 0 && result)
> 

'result' already has been checked in a few lines above.
