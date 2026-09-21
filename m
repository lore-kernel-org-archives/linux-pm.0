Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F72D7DFE;
	Mon, 21 Sep 2026 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954984; cv=fail; b=iXnmnbrjqMR1QjQ3PdRh9F53V+WcszbMKzA8VbGGyMijTqO30/+D58OYuSGKh6E3RPYo033SzXCwbSO4x0nTK4kx3fIproVKa/U9Dx67Gw0GXFZe3QNxqxe3TQUEJTwxuvDfqnMRrp1zgD8jWiKVDylG0yTXtlHbshkw7WdJhbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954984; c=relaxed/simple;
	bh=wmEFo9qmnU9Y7HnWALpE3FuD09pStlAD4SINyeNoyMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGkNZMHCXRQR84tH2bSP/2Sg97G5kUo/vXz001QEtggwabhmSio6Zh6UIEUwYrTs7XogCTB+bcBjuLD0cELFzNz17Z5rIryei+nBh6nE1seq7zhCTNIpzIlBhM9qxlu7kCRcmjyMWIyRwuZCn2YrnENFhOIXkgDjM0tLX60BFPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nCr31b8z; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nCr31b8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2cAOLhDfXNp+QtNWXDupjzdl6UusIqnCvgcl25kavaldnXkcYq8rKHEs5i/Pfcb6dq7HEdZcFilRPj/8JDrHPloI6zZxRsOS5EXE/7xm4WdMdhKimMSvAdxA4R1imCZxmeJ8ux5zHeSdGUd5EhijQIKFA1Xt83DMipZbLVuN9kD8p7YVXIcApKFLGW1c5jUsPRXNIq13j0o8zUS1yCV0LNCGrO3jYKouN8ZNAC7wvatG6Qe/Wsym14WqRtW9WiELPROWlheQiD5yDe5MzT7U/znIUimqRmLJ8Wi++WQ3nR8K3t0tp56wClxZQPSkAYMTjdBQ0sLUL4kYFOAX4G41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHEm4V2y6cD9eCzDqXu3C1dwstJKZwJaldfY0ywWnzs=;
 b=BkfFpVq4XT13Yj9kWwgygtoTSx9nWNbH5pvo3diNOKZwWHiu0tLlStKuquHqtaylj8YWCzhZkVX2NXheT+2sjDAXEwzo/OXtvp6VgoAVq8GNBb/YzRCGk0+AZ6FWudQbBIMiFKEs13geNlnBc4Y4sVsIK76/78oRYoHIBWAQtIdzyNRWxacNESgXXphce/rjqPrUJu5hQH5IG5HSOeguRozjhafq5tPE8kmoU1W7Xl1eAnFevuCUbK7DtY0IG/LTT4s29gzikqBjHex5gsAE0WrpuN0NWMsN5xbJ4Od4aJFmrVv3/JcX5QekgepI9rELjVbAWUGuIEd05OKerx6E0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHEm4V2y6cD9eCzDqXu3C1dwstJKZwJaldfY0ywWnzs=;
 b=nCr31b8z8fjkTC88/2ylxejofW+/12UzWfN/OD9D8QBQ3q36TjYhKgvHkWDTkRjgD3vL+9vvB1Ne+96astH0GSoPFxc5fl7xXICM95bw8obvcjnYG6c4fBv2llilrm+SDp0L43rMmKn/XHuQPo4Hvplf66lqAiWBFtpZ1dtoh3qRIB9eu9zxvzRiyIPS4CzGyk1kPoiv+9euUuK72XH6iZ6rg8Z8CY9hmQ99ehQiEeX8Gb0qrSwgrV8UBOTo/AWCPaNjX8W+V+m2oslJJ9oLpTiQNZ3szVlDIilA14Sz89iClNPC8K5vifEfV/tEppCBX1Gytanm/9sNkQPzrnmcng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Mon, 21 Sep
 2026 01:42:58 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 01:42:57 +0000
Date: Mon, 21 Sep 2026 10:42:45 +0900
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
Message-ID: <arCLBHdYJqUwk9UW@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
References: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
 <aqwYbhghBVb1fwdy@SMW015318>
 <aqycJQHcR9bqwXKr@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
 <aq1QJmhK9c3wwFZ-@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1QJmhK9c3wwFZ-@SMW015318>
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: 67155d12-e3f8-435f-a17f-08df1781a98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|1800799024|376014|23010399003|11063799006|5023799004|10067099003|6133799003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	GV2oCjlK2eq2TuH8+bAxqOTGQtt+L8UTJXseXyi7Yh9KX7adFad/HlJzYZtqhmmKV2cPep+TfmVKPTtZDfJFK++askE/a30IV+5DOsOal/MrIq1LERD1XYDb6yneBEJiGULyJuBwssuSi5tSBlLTqwfeAxyV+jTGXu0C2k3JmcVCD5Pr2+QIyrwNpx/5Jjpe8DcA/crP5eouXTZk3O45WP/DJNKeYzIPkIApWsr6sE0e18s90GQA/GfkY1pDn6vRtPBXo5q1Zyu1JKyPFTQYwg+KLeA6pHx63MCBQBuZVLhLSbKRsJXeUzMp3lQfeM77bi5kdmnPaab9R2MUz7TNzCW2AuAWk1lOSitq6ZR0Nng63PeoEGra7/vvzJfS5KAV9U9mTI29jM60R/03mUzjX+EVeh+MTgEOr7iDYzks9QZV/8yg0Jc6pFkvyEy0vJcY8a4JiFz8jbT+vIb4h8qoJWS+qp4WnrFYZBjcRJZWOEsQe4VUhbAbAiDvtSstOnCFktIBlNG3lDgKHpuz82T5yqmTQZLvy7UEKeerP1hdd99UQu3C/G5wkcZN10/CvleQymBYvuZ/UPOfMbmhEEVXSqdVKMPXnxpdCt1QcJNgispF2bmFk4hgTegsAsthYOVF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iv7hHbQJ9ayv7KJpKNVTtdJwokuMs5oUfvWFH34cMgc/ck7F2HQDURI0/921?=
 =?us-ascii?Q?mV6Xh8vxPsUzQQIpHUodBb58ms2sMqzKhDSmWUdvDkPiNvBPYfXDLrmciPty?=
 =?us-ascii?Q?Gyqcmfmxrge50QWRjsXU9Rug8RUhOTUkHV//+swynuI7UR7ZI4wM4MS2Npzd?=
 =?us-ascii?Q?SyRYU7TCtdQsEOiW9cS6z4wPxAsN/Hr7Cr8WHJPpJ4XUyT0C9F29eAIk4RsD?=
 =?us-ascii?Q?7MO5stxXFIMLQVYwnKRarW9diZ7wAAL0PPgteaRgqsj/FOB+jZ847wtbSbsi?=
 =?us-ascii?Q?LOKN52RwKl7yBUeGzlZSjALtArfbrvu40PWkkeiKhJIinxuK1nF+nz0OVICS?=
 =?us-ascii?Q?B4gWwDRE0QtpVrgDCmdTQNnn3XBt3uCz2blKM5fOxrFr/3Rk5//dGTyQ6qLt?=
 =?us-ascii?Q?y37Ng4J2JSyaoh71KQFLVqHVLMBBeqDARw1YV+CKGgLfsNS7Tu3SNPp8ESUA?=
 =?us-ascii?Q?KJjOwfaojbq2fSuOaWsF4XxNoHOAJlc9GG5c+6XIPB2JKc4C+KL4ijnkDf/B?=
 =?us-ascii?Q?7A5XWmXQ7g29TY6wHddyYRkBX3LWXg5/8XFXxe7Q0CAXE1GSYib1dLXOfzvr?=
 =?us-ascii?Q?TpZTtfOcB8QLiD/4OiJB8YA/g+Zza8XlDy1Ko7bKeGx4L8zitlPItcI/f5EN?=
 =?us-ascii?Q?LpjOfpH3w9PbrlzeUD3UqevCQdaUEix1HR0ak8jRWTDrU7iikAvu+K9dJlnt?=
 =?us-ascii?Q?MEypqv4NIE9/ok+jAQoFFfawLMn0t/4S2kygDcz1AUEYWjSEidIdQGydZOlK?=
 =?us-ascii?Q?7O9Yai5T38CEqsNBio6h4ZqoZI5xXKdIRfUk4HrfEahQvEOsyokuCKM1rH38?=
 =?us-ascii?Q?HIrX3eP0XIOllDqCZ0qBEevm8we/Gd1wBUian/2WD2KSYH1NtypJtoxIH6gm?=
 =?us-ascii?Q?rI0gh47EEhSggc281zu8flVAlCO7ZRxKe5/LBl+HMHBqfcHvGNHFxaywf4lK?=
 =?us-ascii?Q?SCwx3GPgKX+0PInv7KbTeo5fR7Ku1WWFMZQAdky6o/5Kv+6CZBRcPBIr70gI?=
 =?us-ascii?Q?P2hLESEzSc74SUMxYEdDtj6jK3+5mkbQCqBKe9B5OWYY4Ru6JRrH8OqDHztG?=
 =?us-ascii?Q?C17VXYkGP8ilvLX5toW45bCwTwaIeyUZr6noGqxp5XSbgqLZ9VJ7FSbhZ1OE?=
 =?us-ascii?Q?F9RV6vR9w9h86dxaRH7EmKmWK9V3L7dBRPLL+1uK1uhVrDfsnMo2jeP9x11X?=
 =?us-ascii?Q?mTO0x4WyRIzj79b5DDzR/soswFpTTMpBcmfRsppOq2jVVlYmZC0z0LAiSlDZ?=
 =?us-ascii?Q?tb0p3fbiQLHj8xQieVV5sbgxcam5IHgLJ/YdZE+GrRY9SZj+s7b01CSztzgz?=
 =?us-ascii?Q?4Q0UUl+XwQlNj4rs54m+yAK2ybvsOMLDcZ1J9Is76Nd/Ma1o3OqdIRNeyzu7?=
 =?us-ascii?Q?QHFllLp6DwNuJ0slYAzN+/FgmqN4yhRvGZuKu1WaerAgI1TnzJgb8ScfwP9O?=
 =?us-ascii?Q?ia3RsDR1UijjCh6wzkxsmdd+iOLsC3M8MVv2/4DmW4peL927yvXZ+A1nf0jM?=
 =?us-ascii?Q?JpnGjM3z10PjV+soPa28WEXBxFVOHoHlsKKGqdemQAhghwleCSsJfePWZd+/?=
 =?us-ascii?Q?foY6m8AXeuqXlg+YzwP53k0Kp8INV2jN45sOLEXRANjOXpLDkwJt897yyTIa?=
 =?us-ascii?Q?iZk1tc2zblYtH/S0U0NDcacxYzngWgD+IVTlrb+TjLdbeiDpNZnhmXrl7pBB?=
 =?us-ascii?Q?FwLINVNTIYoe6V+Uc+w6cEpn0KzfBbB3NOeFEXrmXXAJlLOsNMj+DrMNAR3C?=
 =?us-ascii?Q?hgGaQWJTYFZ3XsnGuTLB8Oalq7AC+du4NXJvMWBv/DxVrWACUEhv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67155d12-e3f8-435f-a17f-08df1781a98b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 01:42:57.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJIOSfJBUKMH/oTunjQjf2Upx1LB0IEsm5Iksdc6hafDak+5bQ4pEhXkfNYRdkz5rv6LA+DBuoLxZcdujdkG91KvxMdbe8AKXuTWo52JFzQG20YH3vDfQT6gWQTy6uap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234

On Fri, Sep 18, 2026 at 09:52:22AM -0500, Frank Li wrote:
> On Fri, Sep 18, 2026 at 11:08:06AM +0900, Ming Qian(OSS) wrote:
> > Hi Frank,
> >
> > On Thu, Sep 17, 2026 at 11:42:22AM -0500, Frank Li wrote:
> > > On Thu, Sep 17, 2026 at 04:07:54PM +0900, Ming Qian wrote:
> > > > On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> > > > genpds, each serialized only by its own genpd lock, so their power_on and
> > > > power_off callbacks can run concurrently on SMP.
> > > >
> > > > The sequences are not independent: they share the VPUMIX bus domain, the
> > > > VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> > > > the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> > > > clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> > > > sibling transition landing inside another domain's reset window disturbs
> > > > that shared clock and handshake timing, the victim's reset does not take
> > > > effect, and its block registers read back all zeros: the decoder times
> > > > out or the encoder fails its format check.
> > > >
> > > > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> > > > driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> > > > cross-sibling serialization.
> > > >
> > > > Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> > > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > > > ---
> > > > Problem:
> > > > On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> > > > concurrently rarely and non-deterministically leaves a VPU stuck in
> > > > reset: its block registers read back all zeros. A decoder then times out
> > > > or the encoder fails its format check.
> > > >
> > > > Root cause:
> > > > The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> > > > serialized only by the per-genpd lock, so on SMP their power_on/power_off
> > > > callbacks can run concurrently. The sequences share the VPUMIX bus
> > > > domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> > > > not ack-verify the ADB400 handshake - the ack only completes once
> > > > blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> > > > sibling transition landing inside another domain's reset window disturbs
> > > > that shared clock and handshake timing, the victim's reset fails to take
> > > > effect, and its block is left in reset with registers reading zero.
> > > >
> > > > Fix:
> > > > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> > > > sibling domain cannot run its sequence while another is inside its reset
> > > > window. The driver deliberately avoids a genpd hierarchy, so the genpd
> > > > core provides no cross-sibling serialization.
> > > >
> > > > Test:
> > > > i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> > > > this patch the failure reproduces within one to two hours. With it the
> > > > same test ran overnight, over 14 hours, without a single occurrence.
> > > > ---
> > > > Changes in v2:
> > > > - Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
> > > >   power_on() already unwinds errors with goto, and cleanup.h asks not to
> > > >   mix goto and scope-based cleanup in one function (sashiko-bot).
> > > > - Shorten the commit message to the essentials and move the detailed
> > > >   hardware analysis into this cover letter (Frank Li).
> > > > - Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com
> > > >
> > > > To: Ulf Hansson <ulfh@kernel.org>
> > > > To: Frank Li <Frank.Li@nxp.com>
> > > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > > To: Fabio Estevam <festevam@gmail.com>
> > > > To: Shawn Guo <shawnguo@kernel.org>
> > > > To: Peng Fan <peng.fan@nxp.com>
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: imx@lists.linux.dev
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 23 ++++++++++++++++++++++-
> > > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > > index 479789009c7f..270f43229fe7 100644
> > > > --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > > +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/clk.h>
> > > > +#include <linux/mutex.h>
> > > >
> > > >  #include <dt-bindings/power/imx8mm-power.h>
> > > >  #include <dt-bindings/power/imx8mn-power.h>
> > > > @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
> > > >  	struct regmap *regmap;
> > > >  	struct imx8m_blk_ctrl_domain *domains;
> > > >  	struct genpd_onecell_data onecell_data;
> > > > +	/*
> > > > +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
> > > > +	 * their transitions interact through the shared VPUMIX bus domain,
> > > > +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> > > > +	 */
> > > > +	struct mutex power_lock;
> > > >  };
> > > >
> > > >  struct imx8m_blk_ctrl_domain_data {
> > > > @@ -98,12 +105,14 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> > > >  	struct imx8m_blk_ctrl *bc = domain->bc;
> > > >  	int ret;
> > > >
> > > > +	mutex_lock(&bc->power_lock);
> > > > +
> > > >  	/* make sure bus domain is awake */
> > > >  	ret = pm_runtime_get_sync(bc->bus_power_dev);
> > > >  	if (ret < 0) {
> > > >  		pm_runtime_put_noidle(bc->bus_power_dev);
> > > >  		dev_err(bc->dev, "failed to power up bus domain\n");
> > > > -		return ret;
> > > > +		goto unlock;
> > >
> > > can you use auto cleanup guard()
> > >
> > > Frank
> > >
> >
> > v1 did exactly that, and sashiko-bot flagged it, because
> > imx8m_blk_ctrl_power_on() unwinds its errors with goto:
> >
> >   https://patch.msgid.link/20260915102028.2CFFD1F000FF@smtp.kernel.org
> >
> > According to the cleanup subsystem guidelines (include/linux/cleanup.h),
> > using goto and scope-based cleanup helpers shouldn't be mixed in the same
> > function:
> >
> >    * Lastly, given that the benefit of cleanup helpers is removal of
> >    * "goto", and that the "goto" statement can jump between scopes, the
> >    * expectation is that usage of "goto" and cleanup helpers is never
> >    * mixed in the same function. I.e. for a given routine, convert all
> >    * resources that need a "goto" cleanup to scope-based cleanup, or
> >    * convert none of them.
> >
> > So v2 changed imx8m_blk_ctrl_power_on() back from guard() to
> > mutex_lock(), and imx8m_blk_ctrl_power_off() follows the same style for
> > consistency.
> 
> include/linux/cleanup.h, the description is not exactly correct. The major
> means is avoid goto back to cleanup scope, which will cause scope's cause.
> 
> err:
> 
> guard()
> goto err
> 
> sashiko mark feedback as low. I think it is fine by use guard, if your goto
> to do tear down work.
> 
> Frank
> 

Makes sense, I will change back to guard() in v3.

Regards,
Ming

> >
> > Regards,
> > Ming
> >
> > > >  	}
> > > >
> > > >  	/* put devices into reset */
> > > > @@ -148,12 +157,16 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> > > >  	/* disable upstream clocks */
> > > >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> > > >
> > > > +	mutex_unlock(&bc->power_lock);
> > > > +
> > > >  	return 0;
> > > >
> > > >  clk_disable:
> > > >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> > > >  bus_put:
> > > >  	pm_runtime_put(bc->bus_power_dev);
> > > > +unlock:
> > > > +	mutex_unlock(&bc->power_lock);
> > > >
> > > >  	return ret;
> > > >  }
> > > > @@ -164,6 +177,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> > > >  	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> > > >  	struct imx8m_blk_ctrl *bc = domain->bc;
> > > >
> > > > +	mutex_lock(&bc->power_lock);
> > > > +
> > > >  	/* put devices into reset and disable clocks */
> > > >  	if (data->mipi_phy_rst_mask)
> > > >  		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> > > > @@ -177,6 +192,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> > > >  	/* allow bus domain to suspend */
> > > >  	pm_runtime_put(bc->bus_power_dev);
> > > >
> > > > +	mutex_unlock(&bc->power_lock);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -202,6 +219,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
> > > >
> > > >  	bc->dev = dev;
> > > >
> > > > +	ret = devm_mutex_init(dev, &bc->power_lock);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >  	bc_data = of_device_get_match_data(dev);
> > > >
> > > >  	base = devm_platform_ioremap_resource(pdev, 0);
> > > >
> > > > ---
> > > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > > change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
> > > >
> > > >
