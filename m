Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81E475337;
	Mon, 21 Sep 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007543; cv=fail; b=KBbBEVnQQwIL7niJs2Fyo4O9X//BXvp6s8R1m+HlIeCeYn+6kYVItM72gugniFGNyaqPkU9BpjL9obawg7d9YIGoAKOhJ4hZh8Iy6XCiN7WCRegw8iWq4XB2Tgke0guHBdiY7rozEvVVFE2zqmtwSuzrMR6bCuTiTV4TOvIBc6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007543; c=relaxed/simple;
	bh=5waK7qSRD08hwWiY9Pv8DO8H7KJu+0gxlpBAn0XhCRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZtUHDhfrHLq7UH3djAhKsUYj70as+5FT15q79T1NGUFUMs2DOU2bE+KysWv4rlM5H8Dajtly0OxplrDeVaPQgWWk0l6kKrH88iHooleYIip0JWX5zRf0472Dzlmn0Va8KTTsiVW8TMGkOGxXOcRqbD1B5IY3ZGID4uRWWk7NGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pFM7VojI; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pFM7VojI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fim3goXUbJiRQVMxfj5JXwRLiEnKhqfBuqbgEYRePAPqEG+ANNBTNF1unSGw4SIgBSlRSzlHp+TTuUVesXh4uAqO4nILEXe9EE2uip5YsamWbBGha2Y4V3XsEIffcXLsBSLefNOQB3YbrM2ggIQn5492TYk3o45zz8RSIt3XeWGz37ZM2Wo7SNOVP/YTynLlDoWyIAHjeXKI4Ynm3XKz6PJbUsmOXPcgcWWUiNSqjDVoeQYKW9hHSu7hBZisPWl6e38khmXJPuhlJhV8JYp/Em3xXijMQ5dPumE/y6kHZOlMBLIV8h8Si/PZu0pulcAeXaNRWcghfiHq3MCjfGK9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BapzQDsiaVRZVLZflMmU6iUU7X/vG4htoS8xoXXSvK8=;
 b=mYJPhFSQD5okWD2lQWZBLe0M4593v2/mKWKo8C8PrNAIY9D5DM2RT+zro8iGt6ZkORllbGj+w7Pl7Zlr3CmfYD7D206RM7ExcZkY3FomDqUSbe3bx2mY+R0YEwF9HQvPq7YsInZ0Vu7ivFNTdhEEKyFfRrvgAYTFbxRfeL8MnaNqQBwb2qxvhZW/eZmrFi37lE9ZUMRTf8wD5uEuMoHCbDT+cXD9Ki9ibozloYxEmaGqvuuSA1TAT3snMVPPx+EBHAqqwRgHTMMV/NVvCrzejf5BPVNNohqTy1+KuFPmQxuFYdKsZmv8ve8anlFgcxhosB3FadjI10ab/TUXkYd7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BapzQDsiaVRZVLZflMmU6iUU7X/vG4htoS8xoXXSvK8=;
 b=pFM7VojIdwsc3QjfOtYBvuSUxWRIn5jVuFo4baybiRCZWPnFoM+tp6BKKF0HsI0xw2x+DSGos8WvGFJCv55xs5j4qAe7T3AN4/vadDdcjsUKasEY7har2By7EEIqJ7O24LvmM5Ch+4MRHfHa5lsdoE08ZhT4Rsot8CO9/DpPxY1vvWYAZWbU/cUimogeH82TcMopDvgXu5MYBdjUW3yDVYAFi9D5K3u4KwLmfQQPU+Mfeo0AVoFF/3a9gaCelgzpMcrX18SnE8CYw3tqNPGz5Hx2OPGWeDc7jVU5sxPCYULxFw9v4LGM4CB/uQhWN0kao7wiP1XcY9g/KtuKvjbygQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8647.eurprd04.prod.outlook.com (2603:10a6:10:2de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:18:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:18:54 +0000
Date: Mon, 21 Sep 2026 11:18:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>, u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pmdomain: imx93-blk-ctrl: Use
 pm_runtime_resume_and_get()
Message-ID: <arFY5OxlEL2QnAH0@SMW015318>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
 <20260921033708.14433-4-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921033708.14433-4-phucduc.bui@gmail.com>
X-ClientProxiedBy: CY8PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:930:4f::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: cabd1405-794d-40bc-546d-08df17fc0816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|19092799006|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hTAItxnQEQbgwyn+s0ib6oNZvBCexqXglztFBwarM8QGduo0sgCIU9g/DTA6ZtxPB6+xmMrLdX7jKAKmNRhKjHaIVBLYmO8TlXCaV2tPGcn/u/20QBYkQupUSDPbGZDrFsDuGGl9VBGsCgiuyIiClopvErA0LxyIlPi/1+h4wUV2p7xRDQs1Hv+1sni844LoTuAi72i9vDH3MQ9kJ0Dsxbz/mdnUa8GtxmIdB3ikmWNROdSUJgmeUjypypLKp0twRFa1qjD8hfIqzNC7BtpT2CK7efOvpV4m2pFLw+oo4frQTEnIASd0UeWQIakxtiJPGb9CwfEIzGCq6Usq/rZuyifC6fbxbX1zmnu3GR38qAZq0izFfVOeyCZnSWQmSt1BBZrXiHgIgZflnq4MWG6ZFSoh90kGUyIeR5vrc8a1QSGfqDlc0O2fkm5g9kWIkq/ScUQRbyiOupekdWmoPiwLfVSKMvqRbuoVGfE147Or/V3M9+TgUXbiJXZcarf6ifPGnLDds3UUchmrsfMH+0Wujn1VUrbh7xGkbwll09uvzATaJpUWxKjmgLrZPLpKuddCJ5W0t3bkWiKp26d1anMC2jRRjinoZzKNY/Zgp8vsI6e4fFuQBgApMwzl1YpC27/xB05oTIW8Ut8xhQ0TbthMZT+vTYJ5+gT8dYyDaj/cuOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqYj3fVBXkzUjNGvvi8cTkH43QhvQb2lcbYZYyT0Fn13IO4PSc2rRg0qolUO?=
 =?us-ascii?Q?jbKJsQ1l4ZRoQszF+IPjPcU74EmYUa//N9A7vvVXGkuO4nEj18DdF9Nd+Hzz?=
 =?us-ascii?Q?1Y6lWqvdUJBsBbganKym0J3j4P2nrc0b12xeWNjIUvBUjFMAOfNRGaSSQgnm?=
 =?us-ascii?Q?u92VeTwrl37Wy6kRTTI6XdXMsHVIkrDkgMJ3DCXRdDlMGjO4daebaxNQVH1o?=
 =?us-ascii?Q?mE5o2RszA8R2X/Zr//dygBi72xh1UZ/c7l7CxaTraxuzBcwCLRmLHeK5gK/A?=
 =?us-ascii?Q?5zV/Gd9ouok4Ar+xXq+piBHp7jNP6npz5vaieyhIxT9yEvhHL4P2pOs8FWdR?=
 =?us-ascii?Q?0FvB/vC8kixnmd2mUlnEer8/TUiqw14gkDTnSldeO07Crgm5emZtolnbPsgM?=
 =?us-ascii?Q?rOujSa0cxmv42RJZb9STGCCVQf4NlDHVuPcE0sdsb0GedYcMuF7sYgnPocxn?=
 =?us-ascii?Q?1MwkxUTdLeOkdZBeXDMNtIYyteIiJJY3iCqzz6lZ1hcp/QUpuJbj1xebFhWf?=
 =?us-ascii?Q?TrUAmZgQrlDF/s5SYl5NpQz6VnPiNeabFKxa7uQBLO1EzEZiVmIoVrSayGiz?=
 =?us-ascii?Q?WR1+Qtlqort63LJnpNeLlHIy9LSIajht0AUG8fveMBvwHu6qw4YLtMpsJnww?=
 =?us-ascii?Q?08I4xjeelg2QyjcPWWYkE7JS73pdyNw/DamDlEzgDJOy6CLSs8id2zL7Heaa?=
 =?us-ascii?Q?l/0Cjs7k0EmMEAN3aVj7+y8V7lvudQhwZiTEZfx6R7zCcausoKAdQCxKsRR1?=
 =?us-ascii?Q?vxqM+BAIYGeGy8r8BiZw30ywO7rTMnGBMPuTs9l3mZcFYLep5apwvZb9U0Ih?=
 =?us-ascii?Q?jjoGoGKdqKm/jAgFASuenlpn4Y+ATW0uwVzdI0quf3V6AZXjF+iz6s7uJbeB?=
 =?us-ascii?Q?RWEFBL2QwgXwxifGJ4xK0+LAubFM1501Z/exFXL5fwY4m/nRGk9BYkBpUboY?=
 =?us-ascii?Q?sA6yA4m68YhWOKUWPsdzchl0iZP/DdMi3eNBpzZgsA7yNuVJImEkOZnj/JqH?=
 =?us-ascii?Q?LkpVAeJ6e7oChMQNTL3XOuaY6YJUDY7qcX8tdI1ln7q0C4O+bLsDGrKWV50B?=
 =?us-ascii?Q?heLQkb+zaqYYANYehIGeTWhTkCuLQYBfKmwrxFAWqwDExLLsFUf0eA4lWux2?=
 =?us-ascii?Q?Nqk2JV33da963HLl2JvjtVTm+q6cRUSZrkgfJgvL8i5cTQwFwGGrA90S9Y9u?=
 =?us-ascii?Q?4sucvavti3I4TjetMPkEsIA+zQ2U/uoWOxcAaFnVp2y8P6WbxAT/jZ11zR3e?=
 =?us-ascii?Q?qC5LqfXWoIo5u3hdzE/cADbKRApIRhwRyIJoaSCC0HdQGdQwnTzAagYmi846?=
 =?us-ascii?Q?p5NerPFWLYbHxmMiR3AStEv4/+8W4sg6qaVc/mCiFj3f+zabgKarzxoj1sMr?=
 =?us-ascii?Q?UbLlq2nXUFIXSE/+KoDk019oLOQKqf7dEyeQNtjQo6sbZDTHEmgvqk30utS5?=
 =?us-ascii?Q?NQzdjWUL6s12q+1QNEdCx3YIy1LCJVLbXVA/66xV3ibmyeqit5de7x9A5U+6?=
 =?us-ascii?Q?E/PPG+Kteet2fkyfhe1eRKVxWEq8OdI8Bw3N1NQ7sj5D1GJ0jVoYFOvTbFsz?=
 =?us-ascii?Q?57DPjxg6HYNvtZyMBnVheqJs6+wQBGbs2xMBzWdqrh5IgbYFcsxANxtksZX4?=
 =?us-ascii?Q?hscG3ua335rDCLqot310hhqUE+82Hpfd9XsXKMFwoaF1v+0s6xPibS/qFJHK?=
 =?us-ascii?Q?DGMDmDwi1rtVhdm1bbMhP9jod5+7Rw2DAeR/6fR/Sv70AIzibuJqKlFCaAWQ?=
 =?us-ascii?Q?brfXasiuYmzX0bgGNT+rhgol7hqfp/hQ5AdRHOkONMNEjfJqZdJJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabd1405-794d-40bc-546d-08df17fc0816
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:18:54.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEpKYaTPZtVjq5QrXD+OwgARSD6VA+scluRmnHcmU6mYozyhQ/ZWQpWCqXN7hyWFGLIMsllDp12hps8bSPqVT+favT91JQ2exK1PbGj1h+Ex3hZbszjAITtXQErmpejP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8647

On Mon, Sep 21, 2026 at 10:37:08AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Replace the open-coded pm_runtime_get_sync() + pm_runtime_put_noidle()
> error handling pattern with pm_runtime_resume_and_get(), which already
> does this internally.
>
> No functional change.
>
> Found by manual code inspection.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 243ce939ba68..6d4c55a85c64 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -152,9 +152,8 @@ static int imx93_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		return ret;
>  	}
>
> -	ret = pm_runtime_get_sync(bc->dev);
> +	ret = pm_runtime_resume_and_get(bc->dev);
>  	if (ret < 0) {
> -		pm_runtime_put_noidle(bc->dev);
>  		dev_err(bc->dev, "failed to power up domain\n");
>  		goto disable_clk;
>  	}
> --
> 2.43.0
>
>
