Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CB371877;
	Tue, 15 Sep 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481615; cv=fail; b=B/he2iGKxZeRPBk1hGJgP+0CMfsuJsMYh2UirAgraamTRwY5w7nRgEBzjOHRgAAElNLJYQuYvc3OIlEqVnRXD6gF5CzmiA17UmupubVD4KF5LFmrTjPLyr+ftEDyhw13ijj+q5C7JXyXmwTNOeB5oJPeioVOhd9rMLiDd6Ffj8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481615; c=relaxed/simple;
	bh=s1BJdHk1dpqgV30inyC7qa9K7HDdhTXGQa7Qy9wGUIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWsXBPC0oetRJnP1gZg2RBWYOa2ucdHzxUC9WYzkmLA1835aH87iCyOeq3hEDPCr3PDwxK21vyalwDHPDpojjKrDLXVUjqMiva9qbwwQnW8KjipyND9L5HKm3nwshtULIjPbv2OPTV9tspT0IX8Ikmq02WvfEqJfoByYxk4RIRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bJiOGE0c; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bJiOGE0c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySx3icLcZ0Qowj9EPaPoMURdVYgT2b9wm4XfwZSmbARMndgGK1d7LcPgEtigIL8gu2h+6wjXt3sofMUTD6y4xYuFFxAIKfVRZdyb45/C39oatiZ0ox5iRgkF05ukEwxlRog7zaldMxY/tsvt01mIJdPiFVHqiernabbtty9GSgw5dGZykGkyF2Y8s7VI/k+WUH8viWRwmmf/5i6TEvvtjyz4eijvGS1gWP/eqa/7haiuo/kVbimQAiHLVaMkUw3NoW6N+wX5XBHDRZXynY8RqT7ZZeW2rb1Z66/fda6dsCA3FgRwPTIM1zyTeDySKUIYY5LxSatKioScw/3gJrD9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QeewuehdhsQAtVvweUxhK1tfcyOiLgRNRgMsU/IQSI=;
 b=sWRv/ZGgVohpLhfAUxo6tdtbxWPxMKy9RhAjtwHy+VsT/k40TG0jAntxLw89w83+b/ZpKM+pggTGShoSFwCTKKLiShGzeKAZy7qjOvpIprYJX0NYwe5aKOpWEwegp0O8dC9jB3habOyNha6QlUP37pLYqWCNmWue28Bk4RhBkwbnqRYB8MYMfEvivNpyyh56HCsGrTle2tcRuTveq6Mb1ee2ABJZcj+RaxE23WTTpDXkfyq6gjdNwE4PTkvzHQENQyrqgxI8ad8XFHGCha8I6DKswTYEV2T+eTFy2sWKyY6+dXZfMrkjUUrIbtH3W+aSpE2kpsRV6p8HXtUQ/HlNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QeewuehdhsQAtVvweUxhK1tfcyOiLgRNRgMsU/IQSI=;
 b=bJiOGE0cd38+JLoO1+i823usT5BAqL6v1+z7tzT4WOhGzMHxVaNm3NytZ4Dv0xbX9VwRqXaOn1vSSHUxLJkZjZyu91uiQnpacFYP/4I2vsIWtR/80u1a9i1Z9l8gPZOCz8nqZo0bWG7BneODsDl3509z3Ej6FvbyTHpeL5GEVcT5TTOMythLrUZLUP8hVTk/E6C4a+WSiT5NxyV5Fndeqqt/QGsV/eO8jwjSIVcYA7zSfIKYHM/7mH5cLJzxOebaGqbza5zzIiOfzjR//8+3/ogq55EUb083hSW/f5XDbvHHUUREoFNAsuF4gkWb1M09NmNQ+AJkF6fqs1lOQuOjOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:13:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 14:13:25 +0000
Date: Tue, 15 Sep 2026 09:13:14 -0500
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
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
Message-ID: <aqlSerHyjCB-03IR@SMW015318>
References: <20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com>
X-ClientProxiedBy: CY5PR15CA0196.namprd15.prod.outlook.com
 (2603:10b6:930:82::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: ada3baab-b51c-4dac-865b-08df13338166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y6cFmpiv5QOOShB3GpudBf6XL9eSFH0dJo+3NSLFrwScAOsr7uCGOFQugIjhljsi4FXXDFBcHETEwWnW+iV2xXkzdcY07Qg50eduhskh+zh7M3BkWAtx5zMgNPEOtjE32Ign6Awd+BViud/4sXsowDs/sNiZIyGn7riiPOAzgaz6a3t07ATfVjcRuEEdaVFaqjuSBT/jqw+MipMFk2yUlrtPYwsoBla/jHOqpIIZ7vDVPs6i1lTld3c/4O2AHmJZQOEJztvGoildlAbTP4YNorYH3WxgMOr0C4pJJuE76/yy+1xOpypMzGtygfvPZytQ8KNw7aCpoVdTBJ8HqB2QrIdu7q7yvx+x0qgkL4YbyKO97YyFgBKEPKeW9hV22rwEPni7e9/tq1NUcmUG/QAmUo/W3Vdu5RzW50AKFj98u1UcsD/lmzIb9u1eLAh4xrKyKh19VlRbYKg9+pSPEWmF4YR+M3i3SFbgkLniM/RuKJ1olhFByKSbb++NSgKZN7XzUYdvkoBQr8I3qXTdVkSWdRbwctUzXIl8QRcrsQRXFAfrTbdcdd1Hne/3lxsCgijmRI6VF9oBJVwO+jQg/vtcA5g2AxsRBAkvZ65KoYHDcce7KT2Yw9dosWxi4TZvPJDqthqKGOEZQsBVP64Z4w0NxiC+3DuEeavZfVIFrlv625k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tf4MWpaQigtj+f5LYN2vLAVA6zzlqItakUjYmzCONVXU6EOxhQQN2YefBiGu?=
 =?us-ascii?Q?SAMnETaBDo5dMEZh0uBCX5M97y/E991LsGT2cercsiun2KEJyEzC7W3e9xV0?=
 =?us-ascii?Q?IfpIcQU5rEDDB3HG1tbmj0YrYSSoOt9ESeHWV6D5hcaN4bF+yT6pIEptddBR?=
 =?us-ascii?Q?2nubSLaMGglzs9aObYCdzO05AOC0MU+7KRgEQhcl31YRroA4buiG7u6ojVYs?=
 =?us-ascii?Q?Hzapwy+OTrlvHl1EpJ2WFc6S/9ZpNWdGtIu7R/k1yeex4Nk+vMOw3NaDr2xq?=
 =?us-ascii?Q?GyrimfTLr7TyOLxwXTxWlMhC+tLhg4fK/OcXnNqrWIJ8OG1Y2AdkesOlj27S?=
 =?us-ascii?Q?4XBexbKXE5VoMwtecjVa5w5xZYDsaECR5PEf/52K48Mu+HLJ5n9PmVDxikbP?=
 =?us-ascii?Q?0XZeRyGsiNM3ytvc2QqHGdktF6/WdxjmchCeiwXZ0xX7iyMyn4UjrFpONuij?=
 =?us-ascii?Q?vtmjALF/+lh3C7QZq6aRXJmg5IufeqtaMJY+zf+jTVXzbhWV/OgGTv942C6s?=
 =?us-ascii?Q?QN3e7gUVWtZIk6E0EJPfARTwC7WnoBIJel/3RKOxg9FZz66vjPN0jFsCKJEp?=
 =?us-ascii?Q?fQVu1psnKhHRT9eyCmUuR1HLHjdd0/ljc5mefISLkuqUMi7Dw2hUi2bGAqhn?=
 =?us-ascii?Q?oIctlmiQpEgcsAg6VO/ihOowYun8iLpVWbZy1ZRRmYwDU32KRYDxgnbBM0Pw?=
 =?us-ascii?Q?RaUMiaruhakVLxkaO3ZUnlbv3oEj36TeJqt5rP/svVxbNU3jXJZeiEe/Vfdc?=
 =?us-ascii?Q?hEfEM2tnwQdDCrWzxT4HqE3/1qG4bT6NkvzsD+03WyZAXOrYLnQGS2awPg3L?=
 =?us-ascii?Q?P8QHzsbmYMlHXzHYHXk0NiGdoWztgSSG3G+CGViKklZ9aGZ0XSklxKuJdyUU?=
 =?us-ascii?Q?mPCm4c6c6mbdzkN5DEkE3s0kjeqoGY/tJFk63Auj2cROaIt9x+MJ4ulVv7PZ?=
 =?us-ascii?Q?0odnYAvY4hGqUw4KLT5fMdMz/S64UW5BG9xFRqdJYc8enSxZlnSIASjIPgGA?=
 =?us-ascii?Q?1jN1wdfn/CnEnte2VLvAvzbKOzxEelXTsnxS8e9/jJg0znLs5/NLf1KjeCrV?=
 =?us-ascii?Q?NEU/I3N2mGfj44bkp5lnDQ3U+DhXaeAk/M+T51LT2XI16snCLG3BE3w65Jr2?=
 =?us-ascii?Q?VuVKXF6jZClP9kg+uoAtNu2NNJevQnMEDsKiJDs7aIlWOTM91vLz3N0XAG47?=
 =?us-ascii?Q?8LGkLabNBG6y5SPZfHcVIZMhg2UYnXCgiDWHVuXsb03CeuxJp2J8vkoSHoih?=
 =?us-ascii?Q?1EEMr3zCf+rWq76dmX3uVfuFuZqK6MV6iQyvcCEMNNvjNL6fr3pxZ38DspmG?=
 =?us-ascii?Q?vcfIwrbIDz7612OUgjaETVX7pKO5PF3KX0y8AhNwn4xBQRTZHTFL+kclkVw2?=
 =?us-ascii?Q?2TslMOza9j0tg2fPEK68K2KkCBIYvbIepF4QrkX5j+ZQR0Ga+HcBjF5JlNn5?=
 =?us-ascii?Q?byOGPs9SjGP4YYVULDOrKCHJTg1CWWtnh6QARSvp27MZHpCuNeXLJxCk+NGg?=
 =?us-ascii?Q?+o4PLBbKSmPU8BYEL0KNplDFqDMktYqktPfFP3D9atH17bZKAX232nE9Za1d?=
 =?us-ascii?Q?58yRMZbJZ23UppTb4dEYoOa7CGLvfgFczBNxAnoc2VV+rUZuC8eYyErvLVKJ?=
 =?us-ascii?Q?MdqffgkTmBUhirH6e/tBaBhA/3n8I+uosJW+nDW/lyuq1KRv8mJo4UGhFlhx?=
 =?us-ascii?Q?veKtOeETZlzVGtZXoSU+ESNl6j7CGB+1pFzRF3s2iuAfYtexMgqrX6Z4Avfw?=
 =?us-ascii?Q?Dx1+hrQxd3FcUyZvn2rj4C2OsS/ApLhBX2YmaHDDFeg8dN1xo9me?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada3baab-b51c-4dac-865b-08df13338166
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:13:25.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbrkmEbNkPw/nRWEOrnkZvN1hEqYcpl663Mg4OqpdDAqVVC9t4kpbQAZc3OcjWKPVNe+lYH+j0FAi5N72B2zE9pEK8FWRUIpDuYPoQjIHT3+WyT3epR7UguJP/35+cLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

On Tue, Sep 15, 2026 at 07:09:43PM +0900, Ming Qian wrote:
> On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
> concurrently rarely and non-deterministically leaves a VPU stuck in
> reset: its block registers read back all zeros. A decoder then times out
> (G1/G2 reset failed) or the encoder fails its format check reading a
> read-only capability register (VC8000E reset failed). Raising the
> runtime-PM autosuspend delay hides it, which points at the blk-ctrl
> power on/off path.
>
> The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds
> whose power_on/power_off are serialized only by the per-genpd lock, so on
> SMP the callbacks of different domains can run concurrently. Each domain
> only manipulates its own bit in the shared BLK_SFT_RSTN/BLK_CLK_EN
> registers, so this is not a matter of siblings corrupting each other's
> register bits.
>
> However the sibling power transitions still interact through the shared
> VPUMIX resources: the VPUMIX bus power domain, the VPU_NOC and the ADB400
> handshake. power_on asserts a domain's reset, enables its clock and
> releases the reset after a short udelay, relying on the reset propagating
> through that shared path. The GPC does not ack-verify the ADB400
> handshake on power-up (it only delays), and per ERR050531 the VPU_NOC
> handshake is timing sensitive during VC8000E/VPUMIX power up/down
> cycling. So when a sibling's power_on/power_off runs while another domain
> is inside its reset window, it disturbs the shared VPU_NOC/ADB/AXI clock
> timing and the victim's reset fails to take effect, leaving its block in
> reset with registers reading zero.
>
> This is a blk-ctrl defect: the VPU power domains' power up/down sequences
> must not interleave, yet the driver deliberately avoids a genpd
> parent/child hierarchy (to meet its sequencing requirements) and so gets
> no cross-sibling serialization from the genpd core.
>
> Add a per-blk-ctrl mutex around the blk-ctrl register and reset sequence
> and the synchronous power-up path, so a sibling domain cannot run its
> sequence while another domain is inside its reset window. The GPC
> power-down is queued by pm_runtime_put() and still completes outside the
> lock; serializing the reset sequences is what fixes the observed failure.
> The bus domain's GENPD_NOTIFY_ON notifier runs in the same call stack
> while the lock is held and must not take it.

Thanks you for detail descript problem, basically it is power up/down
reset, clock have not serialized.

Can you help summery to cut message shorter end emphase most important
part?

Frank

>
> Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> Reproduced on i.MX8MP with an Android 6.18 kernel: running an H.264
> decode and an H.264 encode concurrently hits the failure within one to
> two hours. A VPU comes up stuck in reset, its block registers read back
> all zeros, and the decoder times out or the encoder fails its format
> check.
>
> With this patch applied the same test ran overnight, over 14 hours,
> without a single occurrence.
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 479789009c7f..f8105e87ea3c 100644
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
> @@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  	struct imx8m_blk_ctrl *bc = domain->bc;
>  	int ret;
>
> +	guard(mutex)(&bc->power_lock);
> +
>  	/* make sure bus domain is awake */
>  	ret = pm_runtime_get_sync(bc->bus_power_dev);
>  	if (ret < 0) {
> @@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
>  	struct imx8m_blk_ctrl *bc = domain->bc;
>
> +	guard(mutex)(&bc->power_lock);
> +
>  	/* put devices into reset and disable clocks */
>  	if (data->mipi_phy_rst_mask)
>  		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> @@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
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
> base-commit: 6e30287eaf3e41b86dfb86df3b811526693d74b4
> change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
>
>
