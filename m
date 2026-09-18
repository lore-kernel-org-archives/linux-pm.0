Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4E3CE099;
	Fri, 18 Sep 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743165; cv=fail; b=glPjUYwZCbSzF+CoanRyj5nptffDU2kFR683I4ucIsEKkcMsQAxm0CV9BZcZnkOhgkIFyW/lXexweDUqAVclJY+Xm+BixEoviP4TzyuoZAgrKNFCvhoPVTT5ZcvGyiTluxKFV4nuvLsuHFI5dLShTc7cnFPkZWxVhxb52vNL8tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743165; c=relaxed/simple;
	bh=PRByG5sxTaunBRg7B6hqrmK1PTDtfcDSM7xkbkcB1jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyqQMY5BCG64WJ9CNoav73RLXiKIdB0OHtj4GK51D9BZb8wNo7Cl6r77QeU+1UC6uIIXhypR2KIov6GtCdwVCoIRl55/87viYH/K50MtWURvJx9Vm51p6jmm6WqG11WJFLWZ2IWrwrsemVFWJGDjU2GEBfa6GYyHwo3r1inpYx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o7cF4AoZ; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o7cF4AoZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6kBEoXjSnu67q6lYjwIGncvELHByZLPu//wDQphZgPsJmZvgpdzukGph4gJ4cB/LzFAoDr3mD07IpB5wQZBnUm1UZqf5KRRuCBy+zvQR+IfhwrwUT/i9mNEmWzO5N6RRjPuOsbMef1WGXoBCxZ/BZeZAdVb/Rdv/STUYoxZrvZ/xvM+3yg3fNIupXVi71MtEayHgrePTrqVlBRiuz/6zDp26PvOQjEHVAOWOmwT83pr42N3Ad3JBeBpIprPDCMlqUduv9TEmZ4MrmJ8AorVA4HS2ceGmTtUImXOndhR3KuC62dxB2nahQ9nca9cTfUIOip28og7Ub/awwAesnVUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZBdSvEW3nA8W18mYzFaVqXGJb3q3bjw0DazXvHmoi0=;
 b=ctMnCCwvEBarzJDBfyWagXHyicE4Wd3autcGq/lKWKqOfd2PZ1zLtnIt6c64x+zioAQuPmUiTIgJWZXltMGf/v5j1KSOYyBG1l6g9q4arIE1Ly0Wiz3wjQDvN5WRRIvAXQvJLDPuMPbzT8THbB3fU/VuxSiWcVsTNj+UkiMTwpQta4D3CCYK/B+SB/JqQpMQMI0w8AiP5aJhbU8dyqMbLa+qbLaY/7Tr2JaWmYBIBJew2/0dpLoglGnjqR+RL3jqWHx1JzbbcBUFUjFRoVL6yV1TDUotvMmKd3xym+t9uF3SiA/vZi1PIWIS2kIHl87IjjceNkJ4YTuoI8VlIl2t2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZBdSvEW3nA8W18mYzFaVqXGJb3q3bjw0DazXvHmoi0=;
 b=o7cF4AoZYLy5rrhAhUI0nXsI09ZtSbYM+JKkUWCUWR6z0XtPQRkJt3Ij60ehdW0TpYYtmS52BgdENkLwr4uSfD7uomLxvkC9abGFsWY1cep1ehAZLHHwKkUILEPmfxksGlC2FQxE7Fnwmz57QYree19qgFl1ftze+tuIzcuZiK/xw5WLIkeDc9ktQ9g9RKBI6WHuEcRtZ+RXPsjZ1mSiub19NUMmaTcgnJbO5R6rw97uI66Tx7fpKJc8XZK3EwBNGwTU2lf+iJuFqqQ0mX9vZbkn+CXd3y2cvX7Fm7uK5fI8RB7HiNJO3qwjwOBlZHKp8wKcLT9hhO8G8tLqdc2xUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9653.eurprd04.prod.outlook.com (2603:10a6:20b:475::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:52:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:52:32 +0000
Date: Fri, 18 Sep 2026 09:52:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>,
	Ming Zhou <ming.zhou@nxp.com>
Subject: Re: [PATCH v2] pmdomain: imx8m-blk-ctrl: Serialize power on/off
 across sibling domains
Message-ID: <aq1QJmhK9c3wwFZ-@SMW015318>
References: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
 <aqwYbhghBVb1fwdy@SMW015318>
 <aqycJQHcR9bqwXKr@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqycJQHcR9bqwXKr@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
X-ClientProxiedBy: CY5PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:930:2::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b5693e-4323-4b96-ed1a-08df159477e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|23010399003|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fo91ytMOEihwE78uwhRM9iDguepVE6IVIBVQrggRusbef5InmeHh358XyUa9cpFd5iqQrckB2wwbZS2CLpR+bXrmziKQBYx7YiWeOkkWGatmKichkROC4A5Nyw2OLY3Rpqk8DcjF0nes9Km7NcsRsuhwNek/8CxxYGThexjeRE9DqHisCTy4Tv0cX2+MMx9wEqOxNXrmrcuvd0LII5Qdm/bQV7D485FvuUXAoHSrpgxAidenEMYfZERWsthrlRA6448PKBDJMgW6d/H3bCoJLrkY29NqtObpbHzHLa3n/C0AVebomxWoGmE4ETuYA4mOPzsbhQBBVu8fjVPjfLL2XtgfzXap5wUZA0agXG7up9T0xEzwzzDZ+2lTnnsnn/yK9gQVnbRKgYg3cWx9tRCOLCNHrpGIflHgPuZ627zCvo+eaBBGPosFWv4mMSuF98tFtC7AWN4O4HefOUmxg1mOogcc3V0S3yH4M7w40qmDrAG2rwOzE431niLcTC0wMggZJDb4baPV1glAfiGvsQ6dKONPUpmhB1uKHgYvUG7Xoddcg0vMk4t/upnZCt6yZKSmOSpoaoat2EH3ho6N6cbHoEm58Sp2CwTNdDQCe7dQkhBJSSBgyHX2ehsJBLmxViPe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3Hf5UiYLMsBONam6ovXufMjFKMkkib5I5WWBk+EAdIPfDitpEcv3CWoKirI?=
 =?us-ascii?Q?WGNpq+qD5QsTMRElyNtm0E53JQZyiy+uugRtoMIzXqbbe16/qtIeWtKX8Lmb?=
 =?us-ascii?Q?EEAw21oAS6zrCjE3pL6x7M76jx4sdRdIvTXLeoSM/aEHE1TdG5M3BVAxMc8E?=
 =?us-ascii?Q?yNMIePDVP5Z78LHFIFBuwnL92zIjI9PJOZTTyKXcgeJIhK7/jLml5qSz/9KS?=
 =?us-ascii?Q?vMFu7ByCE4Lac2Kv+K9iFljAwOMvzF9f2IDSb8sRam9ot6To9XzDzy8HWmJq?=
 =?us-ascii?Q?LAyF5E4bPI/U0OKh95FdYvHWo++qxBzcZ31CB7n1H6hPrpSFdmY7p0sAa/sG?=
 =?us-ascii?Q?BIkhprHXkUyul0ewIHtfp3+7v3OaKoI+bffMwly7iKQQC1BjSVlvBE2tPq8h?=
 =?us-ascii?Q?l59AgyW3JaSZHnVAX1WEroophnjbC0gbpEAVIgH3F2VZp9uwjfCS7QmLEEwj?=
 =?us-ascii?Q?9pgxyKd1Do9yMriiCkM7UKRjydT1GctiwF5ijsS1orE2SRdz2WdYOrAr6Wb/?=
 =?us-ascii?Q?mmP6eMtgXJ3OBCEixpgGigbt/jntW6SR02h0DIn3K/BtjkqQWFYwLwFUtHG0?=
 =?us-ascii?Q?tcQD7lQERaMmUIU4/i8AnL5tK1kVD49WiEFwZpYYEMqSVmdmYb4MYhal6PsB?=
 =?us-ascii?Q?3i09T1FljqxAPPKtoF/ViLqOH6MLvBOyIAduduQC8qUZIPcl+jpDTbKuM2xP?=
 =?us-ascii?Q?pcI8nbU12QM2nvgo6OIUlJhpX5d2wZegQOp+yAiHtfwuZTREcblUoXfRQQeS?=
 =?us-ascii?Q?73Zvqork2dRK2/bteDC1NjVmjA/1UCZiR7irUj/poF57QJs77d4hs3mKGg+y?=
 =?us-ascii?Q?c8nimHGZUkeMZ+wLIdV51eVbLR322PTknrghc1gjAfjB5Uco04UBWkVU4Jc0?=
 =?us-ascii?Q?B5MyuT2I9AMl+eXCX3BLsVl7X3lgAn3dVKS4plZ5dcf6l8hZYWgJtGBX3M4z?=
 =?us-ascii?Q?A/A46C3btCeJwH0mK13SmrugGXE6fWTwbkTH4rGq10jC2G1lGla1VLijfpxk?=
 =?us-ascii?Q?cdEVoFozGmi0J2EGwU9pAXr0f6qqlAnNchc/fk1rNpXNuunTHrGJ34heg7rd?=
 =?us-ascii?Q?CogyNyNtCV+5yVcmFX/SYVPpGS+2Pba1OxPrIfMhm2BVbZThwa6vIpzVJptv?=
 =?us-ascii?Q?8sBXPhb4WtYppP+6BUA9iwzD3rW0p7f+p2O2Fbkev6tewYUypwjchhGy0z/R?=
 =?us-ascii?Q?r5RefdLBhAeLaW/mJEJv/6ANmhCn9evx8hSeSYauUPA7Gk8WB701iM+Ih86C?=
 =?us-ascii?Q?/PpE63nBQnkagTm8gfCF5nvlJUQx7oprbH/MGgSRS4o2yc3l1si6PTjK8D1i?=
 =?us-ascii?Q?lUvZEZcSPISOhEdxZciEjx+2FWeZUCLPEoKRfr8m7/dZaI5kFEafbb2KAbAt?=
 =?us-ascii?Q?XJwuFN7+7CEAAO5RVsp/SZRPL4o/kN1zm37+N56uq7Kxp4LuL3CYyzzNi5DZ?=
 =?us-ascii?Q?bGoFXAHRYyBumA27ZDWx0IZpaQMTNq4WToxQgOM4h1lnNV3iZKMm2mN5OZMw?=
 =?us-ascii?Q?T9TNtrpwKCpWUH2yj2qG5rg+qqjmJTJeUuE4gsG801B4BRbyewDGfh3O+sQ7?=
 =?us-ascii?Q?vbhTU/UMpmb2NVYJFqlanR1wOJnDQPmBR0EAGxEwIBtnmfcPe9wsFNmWu8nr?=
 =?us-ascii?Q?hzpLpj4IkAhocGCnW/scz6ZhkH+p9zmevTOr6hXakUftO2HrQbb8jNvGJ4rf?=
 =?us-ascii?Q?RLZDis3zIuZwkdRKxZfX4sUHxo0fzIjUvqW0UUy7khtbywaJNBlxzsZfDe72?=
 =?us-ascii?Q?SKIP0aBUMHXluo01cMEXOwRKUzb+P4wdGZtyYfDBCs0gl9n1oWVH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b5693e-4323-4b96-ed1a-08df159477e3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:52:32.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMjE4zu62DZZ4+G397NgQTAH+6Gzp8WbiG5BUFKv271Dx3ZqQBuBMslk+XM+cXbUyh8UdhGil8jb6H0AyKpOFWY4IxvX0onhnYyyahih3QKahI3WRupDD8tson6nOCkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9653

On Fri, Sep 18, 2026 at 11:08:06AM +0900, Ming Qian(OSS) wrote:
> Hi Frank,
>
> On Thu, Sep 17, 2026 at 11:42:22AM -0500, Frank Li wrote:
> > On Thu, Sep 17, 2026 at 04:07:54PM +0900, Ming Qian wrote:
> > > On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> > > genpds, each serialized only by its own genpd lock, so their power_on and
> > > power_off callbacks can run concurrently on SMP.
> > >
> > > The sequences are not independent: they share the VPUMIX bus domain, the
> > > VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> > > the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> > > clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> > > sibling transition landing inside another domain's reset window disturbs
> > > that shared clock and handshake timing, the victim's reset does not take
> > > effect, and its block registers read back all zeros: the decoder times
> > > out or the encoder fails its format check.
> > >
> > > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> > > driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> > > cross-sibling serialization.
> > >
> > > Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > > ---
> > > Problem:
> > > On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> > > concurrently rarely and non-deterministically leaves a VPU stuck in
> > > reset: its block registers read back all zeros. A decoder then times out
> > > or the encoder fails its format check.
> > >
> > > Root cause:
> > > The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> > > serialized only by the per-genpd lock, so on SMP their power_on/power_off
> > > callbacks can run concurrently. The sequences share the VPUMIX bus
> > > domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> > > not ack-verify the ADB400 handshake - the ack only completes once
> > > blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> > > sibling transition landing inside another domain's reset window disturbs
> > > that shared clock and handshake timing, the victim's reset fails to take
> > > effect, and its block is left in reset with registers reading zero.
> > >
> > > Fix:
> > > Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> > > sibling domain cannot run its sequence while another is inside its reset
> > > window. The driver deliberately avoids a genpd hierarchy, so the genpd
> > > core provides no cross-sibling serialization.
> > >
> > > Test:
> > > i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> > > this patch the failure reproduces within one to two hours. With it the
> > > same test ran overnight, over 14 hours, without a single occurrence.
> > > ---
> > > Changes in v2:
> > > - Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
> > >   power_on() already unwinds errors with goto, and cleanup.h asks not to
> > >   mix goto and scope-based cleanup in one function (sashiko-bot).
> > > - Shorten the commit message to the essentials and move the detailed
> > >   hardware analysis into this cover letter (Frank Li).
> > > - Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com
> > >
> > > To: Ulf Hansson <ulfh@kernel.org>
> > > To: Frank Li <Frank.Li@nxp.com>
> > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > To: Fabio Estevam <festevam@gmail.com>
> > > To: Shawn Guo <shawnguo@kernel.org>
> > > To: Peng Fan <peng.fan@nxp.com>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: imx@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > index 479789009c7f..270f43229fe7 100644
> > > --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/clk.h>
> > > +#include <linux/mutex.h>
> > >
> > >  #include <dt-bindings/power/imx8mm-power.h>
> > >  #include <dt-bindings/power/imx8mn-power.h>
> > > @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
> > >  	struct regmap *regmap;
> > >  	struct imx8m_blk_ctrl_domain *domains;
> > >  	struct genpd_onecell_data onecell_data;
> > > +	/*
> > > +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
> > > +	 * their transitions interact through the shared VPUMIX bus domain,
> > > +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> > > +	 */
> > > +	struct mutex power_lock;
> > >  };
> > >
> > >  struct imx8m_blk_ctrl_domain_data {
> > > @@ -98,12 +105,14 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> > >  	struct imx8m_blk_ctrl *bc = domain->bc;
> > >  	int ret;
> > >
> > > +	mutex_lock(&bc->power_lock);
> > > +
> > >  	/* make sure bus domain is awake */
> > >  	ret = pm_runtime_get_sync(bc->bus_power_dev);
> > >  	if (ret < 0) {
> > >  		pm_runtime_put_noidle(bc->bus_power_dev);
> > >  		dev_err(bc->dev, "failed to power up bus domain\n");
> > > -		return ret;
> > > +		goto unlock;
> >
> > can you use auto cleanup guard()
> >
> > Frank
> >
>
> v1 did exactly that, and sashiko-bot flagged it, because
> imx8m_blk_ctrl_power_on() unwinds its errors with goto:
>
>   https://patch.msgid.link/20260915102028.2CFFD1F000FF@smtp.kernel.org
>
> According to the cleanup subsystem guidelines (include/linux/cleanup.h),
> using goto and scope-based cleanup helpers shouldn't be mixed in the same
> function:
>
>    * Lastly, given that the benefit of cleanup helpers is removal of
>    * "goto", and that the "goto" statement can jump between scopes, the
>    * expectation is that usage of "goto" and cleanup helpers is never
>    * mixed in the same function. I.e. for a given routine, convert all
>    * resources that need a "goto" cleanup to scope-based cleanup, or
>    * convert none of them.
>
> So v2 changed imx8m_blk_ctrl_power_on() back from guard() to
> mutex_lock(), and imx8m_blk_ctrl_power_off() follows the same style for
> consistency.

include/linux/cleanup.h, the description is not exactly correct. The major
means is avoid goto back to cleanup scope, which will cause scope's cause.

err:

guard()
goto err

sashiko mark feedback as low. I think it is fine by use guard, if your goto
to do tear down work.

Frank

>
> Regards,
> Ming
>
> > >  	}
> > >
> > >  	/* put devices into reset */
> > > @@ -148,12 +157,16 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> > >  	/* disable upstream clocks */
> > >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> > >
> > > +	mutex_unlock(&bc->power_lock);
> > > +
> > >  	return 0;
> > >
> > >  clk_disable:
> > >  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> > >  bus_put:
> > >  	pm_runtime_put(bc->bus_power_dev);
> > > +unlock:
> > > +	mutex_unlock(&bc->power_lock);
> > >
> > >  	return ret;
> > >  }
> > > @@ -164,6 +177,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> > >  	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> > >  	struct imx8m_blk_ctrl *bc = domain->bc;
> > >
> > > +	mutex_lock(&bc->power_lock);
> > > +
> > >  	/* put devices into reset and disable clocks */
> > >  	if (data->mipi_phy_rst_mask)
> > >  		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> > > @@ -177,6 +192,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> > >  	/* allow bus domain to suspend */
> > >  	pm_runtime_put(bc->bus_power_dev);
> > >
> > > +	mutex_unlock(&bc->power_lock);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -202,6 +219,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
> > >
> > >  	bc->dev = dev;
> > >
> > > +	ret = devm_mutex_init(dev, &bc->power_lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	bc_data = of_device_get_match_data(dev);
> > >
> > >  	base = devm_platform_ioremap_resource(pdev, 0);
> > >
> > > ---
> > > base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> > > change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
> > >
> > >
