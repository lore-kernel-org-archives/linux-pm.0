Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2B51B16C;
	Thu, 17 Sep 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663358; cv=fail; b=DkPE5LZQF1KWlf++3lNsD5UYUQ1yM/DNqf0MMWP/UCWaqiNaKCD6H5UYnDIN99/+K4+uu4ARiAy8bh4nsen/uWIala4F7xgmhoFbd3HMQgbdSS+/g2PKy+j+E1YIM6695bKwR9HuOUeAfskUocFXDejmOdb1IkFWpy5Sm5iFQd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663358; c=relaxed/simple;
	bh=lWEVbf2qtFCBisWbspVntlLWoodzWBeuqPUd7+FCgW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nMfarBDYZfESRC4wQGjE4eAfOVSDVXgih8J+nomx2P+ThznuSl24oBEjbUGbRPT7KU05mtkvq9T3gMqfTZeK0HvbJWyeLIgzGa/OVnE7Ms9vA1mm0k1HizxGdClRZzj5MULfvzZnqgsu4hy2dlOeJBTSm6yMJxGN/9HqZ34WtM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mVF0p0K5; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mVF0p0K5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+sCtqbeRlmWaCQKa4e/gwRzBUwi64IJLPukUy9jNxPjlLPvyI/tl/NmuCzqMMvKqvcUr4mHLX/BqVmd8Dlq69/6aRTfdTR6G6a0zoBemOP26n/Fr+5mPmpHj10O7LD0yMBBtO6LGqPaLKhDceZBRiQquOVtbspsaPcfafC/RQHxK6X5DlouUj12x8ezXpdJB6kmTCirnP/Z78+c9lR1LPLxThtwJmZElqdPxzTNfnCbkMGHn2fa3rxU1m03d5BmzxtZ9QuS8woljwgZwrpsbatQm2xmY+TY8Ank13dm706mByusasdkYwgMNWTj/QBSmugJZ4isz9KvQIPjHdQmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHkvfFdQLUhY5sYOx0pKHB0qM1iC6EqLd5EAxFQ9uDI=;
 b=oJAjFBVKGtqBCSMsB0b1BPmyqATY02RBhYvzHgATnkBcQC1fdQCSKsnembyRfwv1Cr3DDoTsc11jwd01doKrsw+clOGhZ3gUxC9Wcu+gRjMn+WZulkQVoqi6pcuWnfHsUPxIG7H3Ng/ZGfKbCXmFMVxgtmWzZzPrYt1LblyUf/eoyBZ+Exee8hnGBh+TNaTEE97Vs4Vo2Ta0MwjMVsiGxXVEHQB95N4TZXK12cuyvVynfWIJoEbLtt6jY1VL+D32lFLkqfFlaC4iQcF6xh7fTm0Rzs+l/xrMcvVncL8bhr6nzpxQc9wPnQZ013O3leg5h5Qq62VN9ogrwJhy48nzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHkvfFdQLUhY5sYOx0pKHB0qM1iC6EqLd5EAxFQ9uDI=;
 b=mVF0p0K5BRLAOJLcFdYm7rjDNpL6hV5NU5HQRiFOi2HykqWHVbLLLwVtSNKn+2mMvf+Nxt0UbLPmVZrwR+7CL+ea+4LhnW7QnJvEPWEmu1QLkkgZWUyUlFy3WTU7v1yf+e6i08GkLTsiXETqDTaHNJQt1DqpPq2C23eml2s/GHIe4ZI0qoWD/R0QBjKrKso2bZuCCr6Mcwe8C2iaqAMq8B/Yk/BKRto/kYRAyXjLqfa9Sn30awsn/HjiyQc06Tppy71OikI7Ak6NHgdAWQ7UX46ppvZDUSLNSDboYIOFB11X25hInYoazMzHf5cuB9i6F5hHo3Bf14JQm/pd+E7hGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:42:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 16:42:32 +0000
Date: Thu, 17 Sep 2026 11:42:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Ming Qian <ming.qian@oss.nxp.com>
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
Message-ID: <aqwYbhghBVb1fwdy@SMW015318>
References: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
X-ClientProxiedBy: PH8P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ed1aa4-d5e1-4f69-91ac-08df14daab7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|19092799006|376014|10067099003|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	h+Y7lGQ+GMxpkJBaGYRV5ub32Qkrx10D+OXhJYnPghD0WiNnaRr3LbTaCdb6dZjI0QDQl+j2+6fJ6gtcs4ipxOSnkXI1LbW2tFQdZ1CY9cC4PxuE3zymps5M2Y/zS0ZZ23AG4m0i4Ac6lq3nSEBe1fBjE0lAUeWShmP90H1WqdhQZBUpOh0SI0XQRS8o7UsIjRhLDgoepQKeQKbG0VaQmLgB5cmVovExosNoAOMkHg/TV2rU0556HHA05e8tOk7rZ6/qH1btlLcTRnMPP9G2U8Nk1PEXQwK+pFcq2xDRZqUM82lhbCruOER25tgcS0LhNr4wuhZEKvsn3A+VXi4+vfsiBEE/105wirIQyXqoUAwhDJGPJ9/OD6DVTlqT9rV/w6Z97s+PpG/mrGzHh3hUwNJmAghYqqsob2GO4qd4kT/JXMYTDcOt10zmU1mk1vQpCN3yPpOq7VaJepJPrC7cpR9cZC2fyiGkqmnr0/GoXvtlYX3s0BsTtS1IST1pEQRU3UNiId/n+1TuMElzUfNdGoiiexndAI4vufHq6SjU6RfkR6hGaoz1xxfyHMx5VsnVvSHgq5ozkCZWojqtVS5+aIbpQtmLjvzvUFboPk/bk3DiYfpCg1ZtsCoATegRPDNR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(19092799006)(376014)(10067099003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEPjE/J9MxsggIqs9Jh91Js30qg9+ONff7N2eSLkBV+GrkJNfJS1kHi5NSnM?=
 =?us-ascii?Q?mCLIdOhhrBjTFdboWCs6qDMpsfQPNLHBb4YWTbp6rN7cF0PhA20ltsHi36st?=
 =?us-ascii?Q?YmevP7AQxqbrrnUVLzrgzdPkbOc5oV/JK0+/2EU0ognu9fzCwzL2avGkfFvd?=
 =?us-ascii?Q?hQBo7b9RjrU5gWltlDU91wVwwWN4l5j4BZX5pkXoybeXdSYB8BCSbYxIF65t?=
 =?us-ascii?Q?on0RBC3arCjryfRp8UHYOqLn4hAoO1AYCBYUkkfRTQZbzof1hVf2v12POECz?=
 =?us-ascii?Q?BZJFlWM74tfoTNaL4RvOQhmJS2RplDKfXJKTTBGpbhvm7441AeHPsxD6I7WB?=
 =?us-ascii?Q?KK1CMwzCGLu2PWlcc10ENqx8iup4B2kPXOiFcl/atL1ZY1ekzXx0wmXgNHfq?=
 =?us-ascii?Q?QvxgFlPe5ndRUMi4UxHSHIi/MnjI6XZIPIboXA4s8M6zsbeKL5OffVNGeZzf?=
 =?us-ascii?Q?CFKQApZJVLuTkTj51gs+u35b7eX9yosQ+tDfmlxmAdffr0cIFoSusuQVGffY?=
 =?us-ascii?Q?/t1ko4+og6Yem+8EEesWwn9pEhcsKj/ZKoZg5KFAjnrgNqRscxH/eChqoUq0?=
 =?us-ascii?Q?PHNX0T9kDY+irqo3FPaT7+odl1jCDNP3ROpLv6R3e0+WMEtGu8bGcsqcxOGU?=
 =?us-ascii?Q?/fheogM63knFEYepinhtkVre+0wI6nBNwuB5znNkLXMcIZVUhc/lLcsbD5KD?=
 =?us-ascii?Q?DR5DI15nGWLnnvxsQ02Pe0wS184FBBhhRRYmSNu5dadl/G5JFiypgraQ+vve?=
 =?us-ascii?Q?1mDKKYpTuInHWCR1pkrH1mkMwrbfVzvK4Cr2sPkv0XWLlQTSsE/JKql7S01G?=
 =?us-ascii?Q?84EAyQwzIm8XjxiXbas5tZ9fEIzZsuLmlksxuemrfQDfLRu9r09DUfd2PXFo?=
 =?us-ascii?Q?FAkm+687WmPiZ6+i71DsbPCfhQqvSN3kk2T6tAHJBTtRDHOHuZxZM8iL/0Xj?=
 =?us-ascii?Q?9wfbTE0+e7LTnVCRRT8bJIdozp45J8/uLUy9+e4cqRIXoPMIo9WHQC7npQio?=
 =?us-ascii?Q?IHVetE0VZH87vaCdf/O1HZgmw88bSK72p2euENkcGTbZocjbs/lSPgpx+QtH?=
 =?us-ascii?Q?dPpbuA5pLEdzygk9Kq5sHdF+vt3W4yWAQnORE00y79aYKQOwxZHCehzo8j4u?=
 =?us-ascii?Q?dzqTRimJoMilgi7QmPcOUg+qwNzgq1EW26J/7CjDlSKERUdHKbcHKhIpE6r3?=
 =?us-ascii?Q?YUh7meqCirSROopafWD8eV8nqxzNoxwsuq9dMIRlHC6lSHvrYsIky9vRceun?=
 =?us-ascii?Q?dr/3VMvjf4oL5zD0HuC6w5TfsOKyKi8ctulleNSjFx8pkcj2LDl1RcuNRvxo?=
 =?us-ascii?Q?kOrXk2KFHYN8AU/0jkqfabEDv0Y07wfaQwgapwFLalJMHS29KTEeAQQzfRTb?=
 =?us-ascii?Q?n19GGXX+v1uW7laeBsaupjFnevqBiAR/z3oifWNBmbsr5zUf9AbEgLWvW8ll?=
 =?us-ascii?Q?kEH7IeC+1lon6r79mNW9GH+NI03onbYzqmi8TInrE3To2msSMA33fq3ZIxIE?=
 =?us-ascii?Q?PSPCwuAMVVxV2fZWk1EkQm1lXlWsMS3+m/MtUr2wZVPDrrC4eikxlBbWMosH?=
 =?us-ascii?Q?1fZMu8NOFjtgVC4wNfcPdzbwqH3eQWHLVeid+encXqhAuzvEvWDmKhJFZYbH?=
 =?us-ascii?Q?G/zSqh8VgKV1Hy0ron0vUbAzd5gAhwRiibVfEd/vV4WYj3l5/MSaZK+btahq?=
 =?us-ascii?Q?2XnZEJi3xb3W4hHUMfo2lWUVPbxJtLRkKiFWhnhNw9QtKdyWMiv41Grguq+l?=
 =?us-ascii?Q?Y2RKvEJzNUHCvARYnu6eqRhFS/JZ+WYl9taM38bEkbG0E3C8J141?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ed1aa4-d5e1-4f69-91ac-08df14daab7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:42:32.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57HG/8T2z7IOg85YWY6+NYJB/Zrr69tMvWuHUpVI2cqBB9iLxnAcKA52xvDUcmMsSC8mZyayaY3kUFo5JDxq4eRNwtQ19YjZjhVjlJT1q87ANUggnNe0JMP4HAclsxSz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

On Thu, Sep 17, 2026 at 04:07:54PM +0900, Ming Qian wrote:
> On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
> genpds, each serialized only by its own genpd lock, so their power_on and
> power_off callbacks can run concurrently on SMP.
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
>
> Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> Problem:
> On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> concurrently rarely and non-deterministically leaves a VPU stuck in
> reset: its block registers read back all zeros. A decoder then times out
> or the encoder fails its format check.
>
> Root cause:
> The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
> serialized only by the per-genpd lock, so on SMP their power_on/power_off
> callbacks can run concurrently. The sequences share the VPUMIX bus
> domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
> not ack-verify the ADB400 handshake - the ack only completes once
> blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
> sibling transition landing inside another domain's reset window disturbs
> that shared clock and handshake timing, the victim's reset fails to take
> effect, and its block is left in reset with registers reading zero.
>
> Fix:
> Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
> sibling domain cannot run its sequence while another is inside its reset
> window. The driver deliberately avoids a genpd hierarchy, so the genpd
> core provides no cross-sibling serialization.
>
> Test:
> i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
> this patch the failure reproduces within one to two hours. With it the
> same test ran overnight, over 14 hours, without a single occurrence.
> ---
> Changes in v2:
> - Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
>   power_on() already unwinds errors with goto, and cleanup.h asks not to
>   mix goto and scope-based cleanup in one function (sashiko-bot).
> - Shorten the commit message to the essentials and move the detailed
>   hardware analysis into this cover letter (Frank Li).
> - Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com
>
> To: Ulf Hansson <ulfh@kernel.org>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Peng Fan <peng.fan@nxp.com>
> Cc: linux-pm@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 479789009c7f..270f43229fe7 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -15,6 +15,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/mutex.h>
>
>  #include <dt-bindings/power/imx8mm-power.h>
>  #include <dt-bindings/power/imx8mn-power.h>
> @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
>  	struct regmap *regmap;
>  	struct imx8m_blk_ctrl_domain *domains;
>  	struct genpd_onecell_data onecell_data;
> +	/*
> +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
> +	 * their transitions interact through the shared VPUMIX bus domain,
> +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
> +	 */
> +	struct mutex power_lock;
>  };
>
>  struct imx8m_blk_ctrl_domain_data {
> @@ -98,12 +105,14 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	struct imx8m_blk_ctrl *bc = domain->bc;
>  	int ret;
>
> +	mutex_lock(&bc->power_lock);
> +
>  	/* make sure bus domain is awake */
>  	ret = pm_runtime_get_sync(bc->bus_power_dev);
>  	if (ret < 0) {
>  		pm_runtime_put_noidle(bc->bus_power_dev);
>  		dev_err(bc->dev, "failed to power up bus domain\n");
> -		return ret;
> +		goto unlock;

can you use auto cleanup guard()

Frank

>  	}
>
>  	/* put devices into reset */
> @@ -148,12 +157,16 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	/* disable upstream clocks */
>  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>
> +	mutex_unlock(&bc->power_lock);
> +
>  	return 0;
>
>  clk_disable:
>  	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>  bus_put:
>  	pm_runtime_put(bc->bus_power_dev);
> +unlock:
> +	mutex_unlock(&bc->power_lock);
>
>  	return ret;
>  }
> @@ -164,6 +177,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
>  	struct imx8m_blk_ctrl *bc = domain->bc;
>
> +	mutex_lock(&bc->power_lock);
> +
>  	/* put devices into reset and disable clocks */
>  	if (data->mipi_phy_rst_mask)
>  		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> @@ -177,6 +192,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	/* allow bus domain to suspend */
>  	pm_runtime_put(bc->bus_power_dev);
>
> +	mutex_unlock(&bc->power_lock);
> +
>  	return 0;
>  }
>
> @@ -202,6 +219,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>
>  	bc->dev = dev;
>
> +	ret = devm_mutex_init(dev, &bc->power_lock);
> +	if (ret)
> +		return ret;
> +
>  	bc_data = of_device_get_match_data(dev);
>
>  	base = devm_platform_ioremap_resource(pdev, 0);
>
> ---
> base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
>
>
