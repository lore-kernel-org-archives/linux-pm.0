Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DE4266B9;
	Wed, 16 Sep 2026 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587101; cv=fail; b=A4nwJL9ks5Z6vSwWCOjRLIec4s+/WpV3xQeVkMOxXil/7W60q6KIS89tjcaNuV/qOHsiqT/pLX3M9WjGJVVZFJkO/JBGhMTA6JseyNbg9p9nOAiLaDTTvAbOR9dxrAzYY3JB9pRizb7udM0qUsaZqpEasltzcCgzzuYwEa+eAQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587101; c=relaxed/simple;
	bh=2ElVV3GUUhV+p5Rz3b7AqEElS6NBwadfm2bWQrgwtpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nWeCZMRXbpAe733M7Uoi/91BSGy00CHzz4olmXUiWLRTddmisPgSuC2INBNQKpDMjbhL5QRM9BwpREYl7kaLlIqA+fHMTMbU1zyhI3EBblD1Tp6D0JGXgk4pURWWEmBlk/Iz6IHpxpxC47+Kg+Zm39dLZ93xNrv0F4MIp5N3Wag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FExQP4rM; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FExQP4rM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIlrgDb0YBL0ju6j7qV+FgDQthlXfXa6wyoJPY50QzWl6LkbiMzBk0mlFijHYYFJ7dGfuR5GI/Woe43xbYbk+Z+/DbBkVis7N17KA8M5EE/k5pDOTVd8jKnCrEVAIRTtU9UnZ3OZ7oejEvqGPo8vOncYILPr7slQZsaDg59fr2El7goJhI2r3qykkcdRV+BYMIYBQ0D+alP8wTBClh4j3QVWPvmwhfQY6QtDsQMVgZOfl9YpWNnYKTPyihRNOgUidtShwNPXxYm+ktRXG5lc4+J6z95YWvHQUraAmW+IWzhMv9f+W2+6Y4NgPe79vQZJeQW8r1g6jujrLT15GlHWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yekm9JCk24u81QBiMdhShrhgNQ/puHnOUXxx+Tx3+JY=;
 b=XOs3j7iT8dkHBYF1fO6TZ0rJW/TnwomqY/weIm9EQtQo5vyq/m+p2p8uyNz84htMWPo4FSV+T/q8xhrHX5iPC45f8CVPOi1QKv3qT6ZqQwcUPCz3LU5ls021cWsXS8xQTLzpoKyH+V7N46oE5SEJF5tl7mmRsaFs1xNz1RZ1ZpVyiZs87lQH95knPvcxHagNr+AAACqWROFfzKIDyuUeC1cnjSweIzJznht+LnwL6kNmM0RabZzLyxP22EXhqpya4lD1pfh5d92pSfHu/W3NLYwOgtH2gGdkyG2UsWP16dyvobpppK0cS/VqqiUP44tsKl8CzVOglrmOHLgH796Uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yekm9JCk24u81QBiMdhShrhgNQ/puHnOUXxx+Tx3+JY=;
 b=FExQP4rMvK7sOMTpCnsMwT5WiVplRF2gCUCv/I3fcKrzk5I/9ysEIpvxheRnSNB5S2hUABPR0C5O+9djKKeH5Yv2DSqTADL0ZSyyv+brs3SHdcTQR3pkdfavhslmd8bpwWxcdqLDG3WSvS48jmK/TyKefEDU5wPgapcEuHH8oCDB7ISHny2AEBIn65EtMCPafqssPCZB0xL1rBZVZuttihcZssmh14REFF47hCtyc1Jv8PcTTxsSta9jMBxl1EPWVU7gqyN1ewyjCZ2ig+3JNS2paPLQhvd0G4ivkqyMYJHEpihwk43smOY2VLshRzrsvzqNgBnWHXMDIXAbn+y0GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 19:31:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:31:20 +0000
Date: Wed, 16 Sep 2026 14:31:08 -0500
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
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
Message-ID: <aqrufOQdAo_C29yL@SMW015318>
References: <20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com>
 <aqlSerHyjCB-03IR@SMW015318>
 <ed3e2377-7a1a-454d-8031-ac1834977584@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3e2377-7a1a-454d-8031-ac1834977584@oss.nxp.com>
X-ClientProxiedBy: PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: fc378bfa-5596-4b2a-715e-08df1429159c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|19092799006|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vPvxFtHJMeTx90WdhHUbevHgs4BcS+Hi9dg0o+mkDSpDUCq+TCZzq4fg/0TBhD/CWCxC4Nx6lqIFZjV1BFLDgNqd6nvSzNirXwVLnT3fzxhu7WaoYK7xQ2D0GJSbgr8ZuHX2kVEQgxN4x4U9kA0gcIPmLFZkuAJ+qQRpmzqhEJSvGcNfiCEIpMGRLX5rD6mM8vPou8OepYFOf/pmIEliEIfPYAt/AWOblBFtomcvXKUluCJl2+MxFdxrGDR7ILnjjvGn2amZX4OG+t3gt96WfsmUWQIbtPMNxEbxit9U6Uh/8uI4qNwy8CakNnm3nrYl1xjcVdVNiEx1RZwSygzveOZ7fNF5Abg/TQNSWzb3O4PomLkHEeu2hxrS5ANvfggHs6fFHcyPVAtLPehwvD87YBqDYDNmzGiDwXCHqVUxp/ZtH2qcInziI8ouZsx+T3xqWYvHkXwL32C0z5gnQXPHOKYlDJWUe27/XOyapeRyQO49oTuDahybnAcODRFdeftefnZROH/psRqLSpKINkOWfs+clS3tZ4ErXvzUOhLstBCaqCLSswRS/GKMdSnpXI3rEMtTIR13qReTPgVX4pw1h392sikkJHopHBVUMFlgo1+qZJ77p8BdPndXHDPQk1C/DxqfaBOnX0obtydXsfbMS3bJrC0l8nTwCWKHawyDPv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DW+sGaJ5Leg44mOH8tDEUwo8KZT/uuN01W3DuEkEUrVQd3XWgdXQ8DzjkeKK?=
 =?us-ascii?Q?n4EQ7tsXicuPNu3H8Ei7kDpYsW+V0Dzk+ERzXinq4jO3MfpzjeMd7cIPHtfC?=
 =?us-ascii?Q?SwRJr1EhbgTWrlMKpQnLALX/En1+B9Tm7ATqR7+ryneSWsRwh2wcpWcPg//Z?=
 =?us-ascii?Q?7v4Z2M1DBfJSG5ZwC7LnMK5DWvvzBbD1AZASzkzXZhPP6kwuNw4oPgZrpSIG?=
 =?us-ascii?Q?KwbcasMIAzeQzB1hJ7wKI9jm1wiUgPWqqDhgnc5oyDkvH5YVOd+CcJ3Nga80?=
 =?us-ascii?Q?pnV0SkJSJTPWVP7peGGEf6XS9kvtMpN1Xa1SBJU4oYIeTbEk6cn/SLy7GbK6?=
 =?us-ascii?Q?oDH3ZZawC/iLqTLY335kwGFkB5NyeK7Jc3aNw1wKiZL5IkczwZGEOLQwBMk+?=
 =?us-ascii?Q?3pyP0nWw2wjgxsM09JYy25/J3PY7RGwzgfUB/Sy444KfwsNotZXwKHMbh9cY?=
 =?us-ascii?Q?iJIBrLQO5O6VRL3Q11pmm6JuF/jJaDr6CgvWgp6VIoU/WzhM2d736oMURw0W?=
 =?us-ascii?Q?zDJXJAzy6E8Z1MwZEvXh0OEpaU/w7VAMiXmXcYqwsQTvMovXiiJ8vcEmUPfb?=
 =?us-ascii?Q?yM0FDVMsa2OHbhvV4ykA22tr2g1zqXbvNDDuMrj+GCG5iJIJM+PpxljSzDwk?=
 =?us-ascii?Q?FGpQC8RScu0AXl+St67YD6zBJeaUJi9B1t56pJThRzoOY8GW0ImerJnLtW5J?=
 =?us-ascii?Q?wK5OlJA89wne4KD/ZUd/zP4D14EZl/hCCmPynZ80P4CrUmAYRsHv7odap29n?=
 =?us-ascii?Q?Vb92rh8V6VCPxtdQndzbmYPpvl8zrSae/pEQIdk6O80fUO8nJLzi7o6CQo0w?=
 =?us-ascii?Q?gmztsNf5pEbRYcnYZIBucxSxAxB/nXW5VhDb0bM65/YCTQSCLJlRUm3124Sq?=
 =?us-ascii?Q?RXeSfh3mXEJG0KKlPfm/DM0NstiBb04Ha5zSsLBOOHf0c7qPmCmewJ/3z1i0?=
 =?us-ascii?Q?DORab2m6rICox5F3+SBqTSv2rmJl4oTZg1ImpOLrNwsiT3F5IE7MjJ06C8Xm?=
 =?us-ascii?Q?Llg3QMaOAJD4WJwCBDAu4W6zd3g9BynpsoiuF433xvWAr4qZgLCzr7PjkKMw?=
 =?us-ascii?Q?AHiYTnx+B86SuoemqVeJIhazS1RfhQh+oVrUlJ7g+xaDi0r9wVwP8pvIHAB9?=
 =?us-ascii?Q?hV+cKAwPfER9f73i1RPLilNZu31kRyy+2Sk2PP4nrI8XTIGuXfkRYmYQ+Dd2?=
 =?us-ascii?Q?7J1eSOYqMYNwEzw7wr9ebQ25CclG3Dkowzh2nQQ2UOsXdULZQmIg1borX9Rn?=
 =?us-ascii?Q?Bm0nUIGTsD9B9sPtWZrTbf86/pFx2fUpd49pTCGzNOciPgnBAWdGnrCSPLdD?=
 =?us-ascii?Q?7FQK5zwOISgON+zFqH9s0swZwm0hE6HKv7rT/w9aJ/+XrK9EJrxXZtPxwXXs?=
 =?us-ascii?Q?959PLb/Ut8o/CoQICllxqCheuZKW868QZIvgzxyH+fWfkvDoN6Mxwklhthg9?=
 =?us-ascii?Q?iMBcSaAFYDDH8cA9A+ZQfNpQojrwsl6V5w5/c6/5TsB8oNf9HTnplyfsK+Zd?=
 =?us-ascii?Q?5mnKMKUOXy3FCqUBnBjNmhLc2Ir84WfjWvwpQaf/iRj3Sgz1LbF/SASYuovh?=
 =?us-ascii?Q?FkttkA7Ur28a/Q5t6+de9N+0Bbm+G2B8x9kBpeqMoxI57C3s4Oh3qDhJ274n?=
 =?us-ascii?Q?bcThDvvIMxvFuB8y7xspikwrVCPZgjA4L4+3ZQvvO5ZXEejYAFlK4s5NC9vE?=
 =?us-ascii?Q?cAZdFv/KVUNvjr9x9DpZkRJW4FgpBYHiygYsTME6wHMrnlS09vVe4GteD3SK?=
 =?us-ascii?Q?45XffJxZAn9U8lgnJNfs3Jn0eoXT/l8EPyKcxzDJP38UZvKqI+ep?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc378bfa-5596-4b2a-715e-08df1429159c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:31:20.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E63DcHvMTJfLQqaVZLaRTByKf2+dztgdHDH1TXgjgkPETSRVgW12NTfsgixj+z6Mg452bI0z+ESNyL+y1K63IpNdhaGk7OPoy+huwWTFG6+EiPcH+GINpXeZpvw+AQKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

On Wed, Sep 16, 2026 at 11:06:02AM +0800, Ming Qian(OSS) wrote:
> Hi Frank,
>
> On 9/15/2026 10:13 PM, Frank Li wrote:
> > On Tue, Sep 15, 2026 at 07:09:43PM +0900, Ming Qian wrote:
> > > On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> > > concurrently rarely and non-deterministically leaves a VPU stuck in
> > > reset: its block registers read back all zeros. A decoder then times out
> > > (G1/G2 reset failed) or the encoder fails its format check reading a
> > > read-only capability register (VC8000E reset failed). Raising the
> > > runtime-PM autosuspend delay hides it, which points at the blk-ctrl
> > > power on/off path.
> > >
> > > The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds
> > > whose power_on/power_off are serialized only by the per-genpd lock, so on
> > > SMP the callbacks of different domains can run concurrently. Each domain
> > > only manipulates its own bit in the shared BLK_SFT_RSTN/BLK_CLK_EN
> > > registers, so this is not a matter of siblings corrupting each other's
> > > register bits.
> > >
> > > However the sibling power transitions still interact through the shared
> > > VPUMIX resources: the VPUMIX bus power domain, the VPU_NOC and the ADB400
> > > handshake. power_on asserts a domain's reset, enables its clock and
> > > releases the reset after a short udelay, relying on the reset propagating
> > > through that shared path. The GPC does not ack-verify the ADB400
> > > handshake on power-up (it only delays), and per ERR050531 the VPU_NOC
> > > handshake is timing sensitive during VC8000E/VPUMIX power up/down
> > > cycling. So when a sibling's power_on/power_off runs while another domain
> > > is inside its reset window, it disturbs the shared VPU_NOC/ADB/AXI clock
> > > timing and the victim's reset fails to take effect, leaving its block in
> > > reset with registers reading zero.
> > >
> > > This is a blk-ctrl defect: the VPU power domains' power up/down sequences
> > > must not interleave, yet the driver deliberately avoids a genpd
> > > parent/child hierarchy (to meet its sequencing requirements) and so gets
> > > no cross-sibling serialization from the genpd core.
> > >
> > > Add a per-blk-ctrl mutex around the blk-ctrl register and reset sequence
> > > and the synchronous power-up path, so a sibling domain cannot run its
> > > sequence while another domain is inside its reset window. The GPC
> > > power-down is queued by pm_runtime_put() and still completes outside the
> > > lock; serializing the reset sequences is what fixes the observed failure.
> > > The bus domain's GENPD_NOTIFY_ON notifier runs in the same call stack
> > > while the lock is held and must not take it.
> >
> > Thanks you for detail descript problem, basically it is power up/down
> > reset, clock have not serialized.
> >
> > Can you help summery to cut message shorter end emphase most important
> > part?
>
> Thanks for the review. Your summary is right: the power up/down reset
> and clock sequences of the sibling VPU domains are not serialized
> against each other.
>
> Below is the shortened commit message. Does it look acceptable to you?
>
> On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> genpds, each serialized only by its own genpd lock, so their power_on
> and power_off callbacks can run concurrently on SMP.
>
> The sequences are not independent: they share the VPUMIX bus domain, the
> VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
> the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
> clk-en bit - so it just waits a fixed delay instead of polling hskack. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset does not take
> effect, and its block registers read back all zeros: the decoder times
> out or the encoder fails its format check.
>
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
> driver deliberately avoids a genpd hierarchy, so the genpd core gives no
> cross-sibling serialization.

good

Frank

>
>
> Thanks,
> Ming
>
> >
> > Frank
> >
> > >
> > > Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > > ---
> > > Reproduced on i.MX8MP with an Android 6.18 kernel: running an H.264
> > > decode and an H.264 encode concurrently hits the failure within one to
> > > two hours. A VPU comes up stuck in reset, its block registers read back
> > > all zeros, and the decoder times out or the encoder fails its format
> > > check.
> > >
> > > With this patch applied the same test ran overnight, over 14 hours,
> > > without a single occurrence.
> > > ---
> > >   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > index 479789009c7f..f8105e87ea3c 100644
> > > --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > > @@ -15,6 +15,7 @@
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/regmap.h>
> > >   #include <linux/clk.h>
> > > +#include <linux/mutex.h>
> > >
> > >   #include <dt-bindings/power/imx8mm-power.h>
> > >   #include <dt-bindings/power/imx8mn-power.h>
> > > @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
> > >   	struct regmap *regmap;
> > >   	struct imx8m_blk_ctrl_domain *domains;
> > >   	struct genpd_onecell_data onecell_data;
> > > +	/*
> > > +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
> > > +	 * their transitions interact through the shared VPUMIX bus domain,
> > > +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> > > +	 */
> > > +	struct mutex power_lock;
> > >   };
> > >
> > >   struct imx8m_blk_ctrl_domain_data {
> > > @@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
> > >   	struct imx8m_blk_ctrl *bc = domain->bc;
> > >   	int ret;
> > >
> > > +	guard(mutex)(&bc->power_lock);
> > > +
> > >   	/* make sure bus domain is awake */
> > >   	ret = pm_runtime_get_sync(bc->bus_power_dev);
> > >   	if (ret < 0) {
> > > @@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
> > >   	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
> > >   	struct imx8m_blk_ctrl *bc = domain->bc;
> > >
> > > +	guard(mutex)(&bc->power_lock);
> > > +
> > >   	/* put devices into reset and disable clocks */
> > >   	if (data->mipi_phy_rst_mask)
> > >   		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> > > @@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
> > >
> > >   	bc->dev = dev;
> > >
> > > +	ret = devm_mutex_init(dev, &bc->power_lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >   	bc_data = of_device_get_match_data(dev);
> > >
> > >   	base = devm_platform_ioremap_resource(pdev, 0);
> > >
> > > ---
> > > base-commit: 6e30287eaf3e41b86dfb86df3b811526693d74b4
> > > change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
> > >
> > >
