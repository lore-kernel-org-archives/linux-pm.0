Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50318FC80;
	Fri, 18 Sep 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697353; cv=fail; b=NXDFmdk0XJ6YoC6CqU76XNI7IZaDu5t4dExUwoDGeElZZNvo/x2aW0MuvgN7hMOhuUMJ9aCV3Mb4BMdIpoC0Lm34rHQhBX/FY+R9OKVFfarIkUH16Wlk0TFLTLm5lgE883wp+n7acKdkcEoqHM+6I6J0Whbbu8++UFNyXNMR80c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697353; c=relaxed/simple;
	bh=PtfS1jTL6txz2aKQKkYoMsD0ReRmSrG0ZPDFktQkoYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSLQtvxMuNDxPbsDea0EpzCXOzD3FY5xJ+EIeRwG3XbyoktiV6EpBbilLGiclHFb9dV+Fw9/Yh9gxqOnPe5/lipWxgzrDBZOy2NVW9r6Mjfrcwr5EYVMWGgPxuI769MsQwrWemL1IonSWL4/SqB3eJd4MmBw4ynAAkEXL0qJsFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kIsLli9v; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kIsLli9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONOuskrGej9UbA3oYBWp2/KKpyZMZjank8GH++0WaWaZywbRShHdMVl445k+9vM6yDBIKow/7wD7M/V2Jjt/wRVkhpmYU0RDbBpcGnop0Pipxv96fKdfR62OMxihwhSQt1/kPu4pX2TebuvU51s0rLZLJS/SoT0U3oOUNOWryhRnr68P8CzK/yRiZxf6+ZjHHGef1sem1DOxzDVI/eamlfWItAuYmw+d7d1LjcQSUJzAUw08YqKV9v1ZWo+OvHrCvkEjUk2icua6nUka3ByzRoUZcoaJ8hShj5X2XOgVT27xnN8IlN3neIpV/laPYL5yGTqNodBEwb7HoG2F3gdLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5rzsvH6fkNaGicDtY0RCP6BfRrFZfrRweM8SrduHT8=;
 b=LGXEe37n5VrGt2neu7D/M4x4cUs6GC9cVieppP1iQOa5UovxLbNRaFdCUhV3wqviSX0sghLqzihL+d37l7Df7XnGRx8Fmz1Zl2dPp1XW8q3+mHXCTQvQSUGrp7q5W0h0rX4UJ1gmOWx7BgheFr2zhWHtZRPQ0VX5uHGsWxmz9bzho3sHzS9Do+yo59aNHX80pg6Q61svEtwofb5Xp0MsPqztEVQrsQ38fJmlfNEXDTMTE00/gRabaqu0kR4SJrkIpPndR1jHTFBQGjFP0tzD3LL3q8pV+rB9XzOPAw6nsqtYCvZhgkiEeNATxvXdKKAtkpL8h5m6mPHYqALcNUsV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5rzsvH6fkNaGicDtY0RCP6BfRrFZfrRweM8SrduHT8=;
 b=kIsLli9vsGT2b+42oRk9nhfOj4abOjzUvM7op3WBIRz91Dic6BJoTloIDfNWPpglAMlN0MNHsQSkT2PWjDcPPZDswnFhhIvVh489p3prv/OYLr/6wnxOEN9QP0xWwxYZF/3tlKgRwVLFXaWts0kbzxPSMG6C+na3S/lDRBacel59BS+JQZ/mrAiz8fkAoOjAVYT+fOm9/bX4CMFsdqGZ57Soe5pwCZvMoBIwnYBkSeHj5JGMZqJRW6+pR3NWZFgGtjmy9fFbAZKcMDKCOocy9qPNI0jo0phzCPaqV8GIWMg1JY4G4jfb6FVtIMFKQl/9nFufJJa4hi1WrGjEqZK55g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB4696.eurprd04.prod.outlook.com (2603:10a6:20b:10::18)
 by PAXPR04MB8848.eurprd04.prod.outlook.com (2603:10a6:102:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:09:06 +0000
Received: from AM6PR04MB4696.eurprd04.prod.outlook.com
 ([fe80::ad53:be37:8f28:b4da]) by AM6PR04MB4696.eurprd04.prod.outlook.com
 ([fe80::ad53:be37:8f28:b4da%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 02:09:06 +0000
Date: Fri, 18 Sep 2026 11:08:06 +0900
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Zhou Peng <eagle.zhou@nxp.com>, 
	Xiahong Bao <xiahong.bao@nxp.com>, Ming Zhou <ming.zhou@nxp.com>
Subject: Re: [PATCH v2] pmdomain: imx8m-blk-ctrl: Serialize power on/off
 across sibling domains
Message-ID: <aqycJQHcR9bqwXKr@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
References: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
 <aqwYbhghBVb1fwdy@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqwYbhghBVb1fwdy@SMW015318>
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To DB7PR04MB4698.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4696:EE_|PAXPR04MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb8a056-418a-4a76-a2c8-08df1529b99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|366016|7416014|376014|10067099003|11063799006|6133799003|5023799004|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	PYnCf1unNYy9ZOSFGz7DaDx2FiNpHvti3x265leaTmJ3jP9cYEfcVBle0KhnQNLd92cH2qf0JnUr0xpSlhsG/7sk+WKd0FQ5Z3yMtOSiawy0iT9z2mpxTxSM40gYdHhDSWdQGdiimIznf3NM/KNMC1qILKLXAT+LKeE4tvR9yoIfcsON215fbAvUGWQrn86Tj13a/wRio7v/WMlYcOo+Y+vF+uqogdgAVydLL3rEnhf5mAXn/hwYS6qfdhLiL3ViiqSYNrD/lAB+Qv1ydYI3Q20GpTReVmwUO82SiytMJJZzb8ZjXf5KEXa07+jRg7AKr6OLGfJOmOmkK2qv3Ez+Za7mw9A8rbFn1L82RepmVzLodsBUu2zgcxNDmMsdU1f2pb6zr8UQutTfRxlLSDrSmF1N8GaWiPo2SRciOnQGi93m4UTjkg9qD4LmHLSfcABzJ/t9PhGZa0tBoGts9O4Umstj6g+4/Y/CvGz/iYhrpN061CcJWMZw+sFPpDRjulNlGCqZpRG9GQ4DzMa0L3+z6TjIdF1uiC/GdgwtSBRBXKw9oqqMwgC0hJ7e3fy9ToVFsMedJuJ51altDfVr7k65KoD9SHETDco7sL51FZB9Oja4spAc+XvgncN6S6Esj6aU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(7416014)(376014)(10067099003)(11063799006)(6133799003)(5023799004)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2XM63h1Thz3DNp5cgsQB8QQ3wpdhmGXGSfPChsLao1Rv1pk9RJzN3YPcPyN?=
 =?us-ascii?Q?nL9lV+K3Migz1P2cKQs65RlmC/qmzAFo97C3iGJsKHtwjCCjva+ONCgWmMZd?=
 =?us-ascii?Q?hj8P8zEQ6iGGCvHN69J7XpFMBRORpcwaW4ldB/exsrNMRzOn9FuYiKTKvEYc?=
 =?us-ascii?Q?t3DaB6W8WqRJh5d0yNMpUQHkt8e2VfDmjpNEcmguIf5NvcGH+CW5LpHdrTzH?=
 =?us-ascii?Q?Lc7VI6xwwl0/E31E37w0MdhTqnFvIi6z4lQdA34zeYlaj61+SqhAdEvAsj9C?=
 =?us-ascii?Q?ZShX+OkMXK7Xvn0Dzzw3EK5m65ceHuKM3B23Cm7MExizSiWBN3wVRwg4DNEE?=
 =?us-ascii?Q?OTA/MmxOXH+hGAOkEiFvoV/Jz55uF2il1qnl7IDuaTEBURHq/wxexaMHFFZ5?=
 =?us-ascii?Q?TCZpUoMT2XxWr9sXJVh7GoafnWTr4qQhmMG5acFutPXBVTf8dzGC4abGdFdk?=
 =?us-ascii?Q?RHj8X/Pg7VJT1lkPnCvqVVX+RucUhhkpcyhg2yKB0i7GeDW2Qxf5HkHMjU3h?=
 =?us-ascii?Q?NWJfSgPG4MLWx5EuhArX0txtWUkOE6loSZjJrEb4HQkfBRZigOF7O3LNe/5A?=
 =?us-ascii?Q?MMicDHb67Bdwvts8zSp/ELK2Gb+0ziGlNpvJEa9aE1qzqDzgeYcozKs1O2OO?=
 =?us-ascii?Q?KfYOR/ULvwQlFDUTG1X9+n3MXcTz11nnVImly/ejO3cCCxl9Z/1676m1AstQ?=
 =?us-ascii?Q?8DYdRbPEDGOO1fjqAZ3mfFWgLVw5eXcIu7FE1/rDm6GM4mXWOdUZzt39IMms?=
 =?us-ascii?Q?GnVeqzMR/fcfEWnVvr2R8tuhCXa/gt9lSwrgZPu45ecSToep+vOe4mbhQ5od?=
 =?us-ascii?Q?z2rF2UTEH30ts5MHD2SVcAyFDwjpo+2maSTyEAhDCVVLisrQo/CKekM5spbL?=
 =?us-ascii?Q?BA66kSmykijbAKj0qjypDUNn+9dMuG/7CGg2JvvOqGFsRAShYbWcnpA8TS03?=
 =?us-ascii?Q?g0ThyWIWP3pYSNX8lpD3g87TZ+nYKdmLd3XjsFeI1sFCNQ0KLaLZbDrpjZOn?=
 =?us-ascii?Q?EAJ2ouP2iyCxs7iUNq3K6u0J5CIw4oQUWDTQG+Jesf3RKQpJsDBU0WEc7gfk?=
 =?us-ascii?Q?FjaKOMgpxfISsGKmLWbPVIl595LNJezEjJGBfOmmRdrPuHiu+IA/isC3uZAd?=
 =?us-ascii?Q?peWC9EGmVRlne5ApqC+2EztPlr8K3En4hMKS8OpdUSMwhWdwBHMLeJ+IzAk8?=
 =?us-ascii?Q?07mv8vtAveM4zMVpWmFhyPxU6vVJOGFVvvdGx5jQ6b1nYmoqUTQCDKaEp3CF?=
 =?us-ascii?Q?S3zlCuF7ZZsCgD0sDxHXwBQ9C5u4g0kRruT0+m6gR1Xrs0X11bMgkEcv4Z9c?=
 =?us-ascii?Q?ouXgDLBKALsIpFHWnOIlsCzfRxTH7zrbknjagWgJtLbXfWAqdZFZheef6sfX?=
 =?us-ascii?Q?+bCY0CzUNEGR6e3k+QWMcf7LlcHWqX2d7MTJdy69bsgQTOTlCWAerndl4Fqg?=
 =?us-ascii?Q?qZywDiCbDPDn3j7b9OhHkCH1Cl9kxjY4AqPAQm1D+/+//oygs/lvuhMA8Xv9?=
 =?us-ascii?Q?Wdzxe7clwcFCRyf3dnSe7MnyO/F9SNJkOH1myIR5LYsRuDDqfoQMmGUp6rZW?=
 =?us-ascii?Q?yEI5G2GMC2grDXkeyJJiT8HhzMN4jY3NcQ7F5DaAgUAKNZ92ve3BrjSX7neF?=
 =?us-ascii?Q?l4XMdAdrrPmVvCN9Gj6j3ueErJl4U8q/nDchrLS5RFXWImIoRNpAFO+fykRB?=
 =?us-ascii?Q?vZ58S7UGLHxMBmwd0ct0J3MEP/uFsIPwgO5LuIfXO9AWilk5cWOODIZ9hrhO?=
 =?us-ascii?Q?BKjeEqkQUiZn+HqfVBO2JRorPXd0dQERGjKghT8GMiRKTBgRbyPc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb8a056-418a-4a76-a2c8-08df1529b99f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:09:05.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aFMIiZLmeYiNg7jy2fEHGtKSn3r7kigyiuLFQ/XDVbQvk2vQl3v/waUKrfxvb7c5zIXRfDY8CZqbZchEMVG246moUcA2OWfvs3NaR7wd2nkw1wPamSQd4DJ82jcZecO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8848

Hi Frank,

On Thu, Sep 17, 2026 at 11:42:22AM -0500, Frank Li wrote:
> On Thu, Sep 17, 2026 at 04:07:54PM +0900, Ming Qian wrote:
> > On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> > genpds, each serialized only by its own genpd lock, so their power_on and
> > power_off callbacks can run concurrently on SMP.
> >
> > The sequences are not independent: they share the VPUMIX bus domain, the
> > VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> > the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> > clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> > sibling transition landing inside another domain's reset window disturbs
> > that shared clock and handshake timing, the victim's reset does not take
> > effect, and its block registers read back all zeros: the decoder times
> > out or the encoder fails its format check.
> >
> > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> > driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> > cross-sibling serialization.
> >
> > Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > ---
> > Problem:
> > On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> > concurrently rarely and non-deterministically leaves a VPU stuck in
> > reset: its block registers read back all zeros. A decoder then times out
> > or the encoder fails its format check.
> >
> > Root cause:
> > The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> > serialized only by the per-genpd lock, so on SMP their power_on/power_off
> > callbacks can run concurrently. The sequences share the VPUMIX bus
> > domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> > not ack-verify the ADB400 handshake - the ack only completes once
> > blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> > sibling transition landing inside another domain's reset window disturbs
> > that shared clock and handshake timing, the victim's reset fails to take
> > effect, and its block is left in reset with registers reading zero.
> >
> > Fix:
> > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> > sibling domain cannot run its sequence while another is inside its reset
> > window. The driver deliberately avoids a genpd hierarchy, so the genpd
> > core provides no cross-sibling serialization.
> >
> > Test:
> > i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> > this patch the failure reproduces within one to two hours. With it the
> > same test ran overnight, over 14 hours, without a single occurrence.
> > ---
> > Changes in v2:
> > - Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
> >   power_on() already unwinds errors with goto, and cleanup.h asks not to
> >   mix goto and scope-based cleanup in one function (sashiko-bot).
> > - Shorten the commit message to the essentials and move the detailed
> >   hardware analysis into this cover letter (Frank Li).
> > - Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com
> >
> > To: Ulf Hansson <ulfh@kernel.org>
> > To: Frank Li <Frank.Li@nxp.com>
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > To: Fabio Estevam <festevam@gmail.com>
> > To: Shawn Guo <shawnguo@kernel.org>
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > index 479789009c7f..270f43229fe7 100644
> > --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/clk.h>
> > +#include <linux/mutex.h>
> >
> >  #include <dt-bindings/power/imx8mm-power.h>
> >  #include <dt-bindings/power/imx8mn-power.h>
> > @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
> >  	struct regmap *regmap;
> >  	struct imx8m_blk_ctrl_domain *domains;
> >  	struct genpd_onecell_data onecell_data;
> > +	/*
> > +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
> > +	 * their transitions interact through the shared VPUMIX bus domain,
> > +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> > +	 */
> > +	struct mutex power_lock;
> >  };
> >
> >  struct imx8m_blk_ctrl_domain_data {
> > @@ -98,12 +105,14 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> >  	struct imx8m_blk_ctrl *bc = domain->bc;
> >  	int ret;
> >
> > +	mutex_lock(&bc->power_lock);
> > +
> >  	/* make sure bus domain is awake */
> >  	ret = pm_runtime_get_sync(bc->bus_power_dev);
> >  	if (ret < 0) {
> >  		pm_runtime_put_noidle(bc->bus_power_dev);
> >  		dev_err(bc->dev, "failed to power up bus domain\n");
> > -		return ret;
> > +		goto unlock;
> 
> can you use auto cleanup guard()
> 
> Frank
> 

v1 did exactly that, and sashiko-bot flagged it, because
imx8m_blk_ctrl_power_on() unwinds its errors with goto:

  https://patch.msgid.link/20260915102028.2CFFD1F000FF@smtp.kernel.org

According to the cleanup subsystem guidelines (include/linux/cleanup.h),
using goto and scope-based cleanup helpers shouldn't be mixed in the same
function:

   * Lastly, given that the benefit of cleanup helpers is removal of
   * "goto", and that the "goto" statement can jump between scopes, the
   * expectation is that usage of "goto" and cleanup helpers is never
   * mixed in the same function. I.e. for a given routine, convert all
   * resources that need a "goto" cleanup to scope-based cleanup, or
   * convert none of them.

So v2 changed imx8m_blk_ctrl_power_on() back from guard() to
mutex_lock(), and imx8m_blk_ctrl_power_off() follows the same style for
consistency.

Regards,
Ming

> >  	}
> >
> >  	/* put devices into reset */
> > @@ -148,12 +157,16 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> >  	/* disable upstream clocks */
> >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> >
> > +	mutex_unlock(&bc->power_lock);
> > +
> >  	return 0;
> >
> >  clk_disable:
> >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> >  bus_put:
> >  	pm_runtime_put(bc->bus_power_dev);
> > +unlock:
> > +	mutex_unlock(&bc->power_lock);
> >
> >  	return ret;
> >  }
> > @@ -164,6 +177,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> >  	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> >  	struct imx8m_blk_ctrl *bc = domain->bc;
> >
> > +	mutex_lock(&bc->power_lock);
> > +
> >  	/* put devices into reset and disable clocks */
> >  	if (data->mipi_phy_rst_mask)
> >  		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> > @@ -177,6 +192,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> >  	/* allow bus domain to suspend */
> >  	pm_runtime_put(bc->bus_power_dev);
> >
> > +	mutex_unlock(&bc->power_lock);
> > +
> >  	return 0;
> >  }
> >
> > @@ -202,6 +219,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
> >
> >  	bc->dev = dev;
> >
> > +	ret = devm_mutex_init(dev, &bc->power_lock);
> > +	if (ret)
> > +		return ret;
> > +
> >  	bc_data = of_device_get_match_data(dev);
> >
> >  	base = devm_platform_ioremap_resource(pdev, 0);
> >
> > ---
> > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
> >
> >
