From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Sun, 12 May 2019 15:20:59 +0000
Message-ID: <SN6PR04MB45276B524D255F667A6BE29E860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190512143056.GA7761@minwooim-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Mario Limonciello <Mario.Limonciello@dell.com>, linux-pm <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <keith.busch@intel.com>, Kai Heng Feng <kai.heng.feng@canonical.com>, "hange-folder>?" <toggle-mailboxes@minwooim-desktop>, Christoph Hellwig <hch@lst.de>
List-Id: linux-pm@vger.kernel.org

Disregard my comment.=0A=
=0A=
On 5/12/19 7:31 AM, Minwoo Im wrote:=0A=
>>> +	union nvme_result res;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	if (!result)=0A=
>>> +		return -EINVAL;=0A=
>>> +=0A=
>>> +	memset(&c, 0, sizeof(c));=0A=
>>> +	c.features.opcode =3D nvme_admin_get_features;=0A=
>>> +	c.features.fid =3D cpu_to_le32(NVME_FEAT_POWER_MGMT);=0A=
>>> +=0A=
>>> +	ret =3D __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,=0A=
>>> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);=0A=
>>> +	if (ret >=3D 0)=0A=
>>> +		*result =3D le32_to_cpu(res.u32);=0A=
>> May be add a check for result here in above if before deref pointer :-=
=0A=
>> 	if (ret >=3D 0 && result)=0A=
>>=0A=
> 'result' already has been checked in a few lines above.=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
