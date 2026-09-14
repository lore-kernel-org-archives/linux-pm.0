Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2803C07A;
	Mon, 14 Sep 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419778; cv=fail; b=tPr7EV1F58UfXl+/fKKtnj6k4piTIh++yYcwMTS0x4UtTTven4Ya7SQQgb+tIlobHHFXZoYoCLb7erH8te9fjl/wUptMAElgzXAo7/n6vSFS8SwD3LYfkFszQjoG4Dv+YyYC7qykVvzs3fPEqbHTxHlZTHqOlAmLsCAUhdLJ1cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419778; c=relaxed/simple;
	bh=tjkSk9QUd45yaX2NN2RmMENM1rSawlP10qawu/wFtA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E6176it3iN6qnVSOECcXpcdYhN5ByUJou4UNUvKKv8Sk7bkF6lDLhbvrMcpvJ+pLLS/4tHHCSR0IgYgMxoiztLINxoBADYhqPlaUXwkVGCZT0nHpD/wyTZTgPURm6W9boT9SIR24t2qeQ1PB3tpAkaSnf65TTnOAD8eUilTEOcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u6+XCfWK; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u6+XCfWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ9BhjBhWcueYc15VeoIC6UVODl8sWc8IcJfBHtBMWcueZ1Y4D+Bnz/CnDvutYiJqS4u3mQu407a4vQNNbU26i8Gn+iGM83DTXMnVen9WzXuo0Mn/VHatQBpo0S1/e898sHaa918Llvv7VFlhTw3m0iC8Sh/vrsvyWC0C9iEVZniTr3Kwg4KosOuCR8oWromzg/HAhIIx9GbRCWauGBWhXOeTUFhhkdab9qXyCYP6ZrrDZdzS4RPZMmOMgyaIIj33btoUCWQBWJG6KAPlJRh+2SpZf343kxT/ue1VTn+LDY4WJl7tfag336iYPNO4cgxbv/Oym8JpaSMhvwe92UOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF5vJ9+QKycAXvJ8dQOcJaitM/JO5tBOrJw+qdtsRbU=;
 b=PUITthib+WF40BfGPpqd8AAcJeXrJ6Css8azdpXxk0H2KvcN/E5oQ5Mh4rAKQONRlqGNencx8gSuWNQIpQTZ49SSkekPL+sQcvVo8UJBxp9PN5o2oCVA0D7eYabyFZHFAVpBTIjLL30/TgcyN8VlXt66t1rMhENY9mqkPDyyp9PuD9Vp24s6Ra5a2+UJvniGj2ilIqws4N9aVHF4w3VJ0Fh7Dmxr7aWeBDyA/WiZXqAiee712k/nrQmG9b8EQDdtJ2Ye8ai4lIGmOJg43dIj2EFXbE1pSWh6HF3UUuCDhg7OIGEqhujfCfbtdocHQNYRtnJHtkonM0MVsJIuQXStjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF5vJ9+QKycAXvJ8dQOcJaitM/JO5tBOrJw+qdtsRbU=;
 b=u6+XCfWKT20su1NuKwkpqShOC4p5Yx6Z/sOJJBT7Pcb0FlU2B+nWRX4//ZnXUsuRU3BmCir+8I+T66MisEV2Tqc/j362CvK6GIUGkb31x+E8M/Ihwt1ir0m5u2ZL5SAKL2hRTVEIHb/4/BC/nOkmX7kX1WZumGeYHNLiIlL/0VY0EoXUZXXRDAnKHTbWkMwKdH3tciDoq3rZRq6mW7Np80wLy8G2Ssy/GU0V1QAIqENrhPQlkDRaMJHcJN8gnu/6YY4FY68cUTSIKEog34nRh2c82LVqW5B4MbjaePWpPfQJh+dNQcXAoIv8cMW252/iLCE1VAs30Jc/M8hkE4wICQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MRWPR04MB12046.eurprd04.prod.outlook.com (2603:10a6:501:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 21:02:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 21:02:51 +0000
Date: Mon, 14 Sep 2026 17:02:41 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 17/20] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Message-ID: <aqhg8fCuVBqDvRrh@lizhi-Precision-Tower-5810>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-17-9d0c17e1f816@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-17-9d0c17e1f816@kernel.org>
X-ClientProxiedBy: PH8PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MRWPR04MB12046:EE_
X-MS-Office365-Filtering-Correlation-Id: 9907364c-0473-427f-6116-08df12a3899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|7416014|1800799024|10067099003|6133799003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wCROq+n84vJlfeOVzxSJ+Oonz8MqVKnQGeEdGdlwx38gy5OKbjjRUO+9ZkeRRT9abjmLoTHiYdMzG5JswotXy/i5EY1m4fduik75Aks848WaVv8yRC9nykvYXVs9XSDIx+NeuRMgKz6OGBKKeq8JWTtd5x/g8DNMYyVXb9yWezS6VnUNJ+u0aYD5j87u5CAgLwLDmAOWEvcuSzXrNyBWhwgA7COJrSP5wKS5JMnyzzGKz5Ogc4qtZ7Olgq0nwDoFNsRnLyJ9jwn7pkncsk+pism7cgbuinlL8bZybsJwslwnnYvFa9l0FJWOJz5dxvqyF3ACQRCG8LemliykALPT3GVA+hedYItg8TidFIfn6oVlLGM2ejpXYpLpFCeMNZVt/rZa7XWT0yf+nzq3K9mYyPjUG3W5I3UqmAbtIMtFkcb557Mr8HPatp3Y9tzU7RQu9GNpKS65HPSh9lqRXl+D9BrWUn8z+3II0piLCLhkNeSsuxt9z1n58bWXbN+bWZLUdawuAQHQ1sKicSQLAuRTxys8tWgF0tRYnEgMeSvl3eqTsqsEDGyhwel+EpI1r6gxbc0nJtOAGnkZx5PxvR7fzxnxwajbRAb0p/ps6f0rc5Pp8ih1kgWKlA+iuPYLc/WcisTD+dAskzdDvtLpdfsuPlP6c4L2D4HMQRK1OYoTLLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(7416014)(1800799024)(10067099003)(6133799003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AqcKb+93McpODweTz6zJ7HukT1tjjOndohRe1hpOH8B+0o4H/u+5ynJkW8t0?=
 =?us-ascii?Q?EZgo0ZuhatbRuFmar8rcs9YlgQokIGv3ntiYrBrui+Mbzj7nQ/2pLMqVGm3S?=
 =?us-ascii?Q?OKk+g/ZdH53CHRFkSqN+hHuCqs1Re/ZsKLJ/WpxxCO9SCBo5WL09AbT7aXuw?=
 =?us-ascii?Q?YdpGdIkGB2DBptDcOSJ2+Js99ho/CVPuuQH+FLrQx7L8Vvssa6TBPDRAwLdv?=
 =?us-ascii?Q?hPUp7AaPml7vzDTrDILldfWid2JBmo10bTDEFBfOB2W5z64XuuSQOQ9x+3z4?=
 =?us-ascii?Q?2IjbO3KW6XcFE7StizJ/76YUdkO6sKVj5jddyceLsEj/jE5+0ocxlWv3VoRz?=
 =?us-ascii?Q?auuRK3zMQje3ooCO1e9rcXeFdwOllU9OuiFxbVa2jzeldnU4BkjqEcTgQbrK?=
 =?us-ascii?Q?v58oHs1mY3JujbuHHO+hbA9K8tRttJ+Gyt5LO7/8ti8zVJ4o8uXR8w3WXlpM?=
 =?us-ascii?Q?n5fy5ep+8VauSfX3LrxA10Y5voo8Jhv8PxfgzASEa6NMsZRh5LNSOwROSfpr?=
 =?us-ascii?Q?dPKq2b4d5erjsGTkluIJnG4Xqc/6POSvZWzuJVbsdMpBeDLbyjw/wv6l6+1c?=
 =?us-ascii?Q?eLYdzgZOWYJwblu+VfkWQvkiT01NpeG1BagjfFjPExbKxPFgNhhGtofrTkFl?=
 =?us-ascii?Q?p63yExAMz6cuJTG6XgRKn2I4HU6HfAda7aaPR72mUqEnkcI9PkRFDFt2OdQ3?=
 =?us-ascii?Q?PPht/LOQPfkGjcMRFS7FU99GHmM1praFgV21gSx3chbbdELa4KMdYBaznRDu?=
 =?us-ascii?Q?mMdmVSbclJf4whlxL4e6UL0XYBWuGyI2MVmB+TLG1yLTmJoRUjYTqIV3DfTe?=
 =?us-ascii?Q?EH7YNQcL50jlKiOcXxWViDL7qzcj9L/mErDABWwzjrjRLk9ETimsW3mB50rh?=
 =?us-ascii?Q?YIXiJRwmokAa5LHSIPEzXVwfnobMXMWa10bFnfMLPfBJ3jUpv9Z5P9s5G4UI?=
 =?us-ascii?Q?0FaODswj8Lh0wscWVz9mFooy219Z0aMCGYjcPSxb63TWoupQGMs110bYBoAu?=
 =?us-ascii?Q?bZ/g2iosazHlyqVePd6Qy+QLasXaWfaZUjE91J+bisrrc/19MX9fnup6dG0E?=
 =?us-ascii?Q?0YTmFWDViynYQEVkwBRznr51cJ4acf1opVNmQmaO8IwmyOvE4Yl2HXPjP6ue?=
 =?us-ascii?Q?WDYA89Xr8L9C2Nef22P7jPmQIuSLSH/tHKMyvZJi+CTV6SHRSF92QRyFL+yA?=
 =?us-ascii?Q?9pxroX42QJwdvn9PgKluAvfnQ3Zf0dTxXdtIPeLCKZhp2qI06ZBs6tWFMXr9?=
 =?us-ascii?Q?e1yLpnJkw7PWS1n+FUkTa44Uek9kX9pZVCW29yJaHo3kXil/kVW/DaoZ2vr4?=
 =?us-ascii?Q?ixbPip07BZ952mnkywvYHOMPoUHVtTfGwIDHXRQt4SLLsJ0FY3vkjH8qeK6h?=
 =?us-ascii?Q?qmVWyUS+iDbL+vRI+ovRAuM9p+to/8Z/OJVlfoaUirPeJCqG4ISZb7U+3xzw?=
 =?us-ascii?Q?F99e2UAg7167B4pj9JYgMvfIrPhqSe7flSeJhYmwZ8WZ6AjB/Beblwl5ZPqK?=
 =?us-ascii?Q?r59aWy0/cSRCYShY2MY5F2loJYZ3Zfj+swFaqgwCd+NoIgQRGwjdnd/M37jU?=
 =?us-ascii?Q?j5ZcBsv1DCJH43UOT4Pw+dECGQQ0WygTG+/BGqWcqge64IJjE7F2OB4K0Hwl?=
 =?us-ascii?Q?iHq8G7rMKRSN0kfiFD2WTuMjkGuq2XMFu3eayBw6Og2MjoLAvrNZ64E9RHDD?=
 =?us-ascii?Q?NhSmekUmrdp7QZhip8nL5zy1Hhvlqjp/9zMBmfJ26nCOZnn2DzayD/J1u3v+?=
 =?us-ascii?Q?NjxzbRCy0rU5vTqDUnvfF/XERED55C9mxD3O/BuXMcfmKUpI9JfP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9907364c-0473-427f-6116-08df12a3899d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 21:02:50.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/dULcMPOqMM8VlTLRMIexeIfRADIbtgp/p6uYJKK7VE9k/msABFlVBzfZSl5P30Vpk3p/Qw/S/sBYRVK8hIrL/O7crepJ4UwQqLLbCjTQ0ez6ZmwSBfoxanntefJXaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12046

On Mon, Sep 14, 2026 at 01:54:45PM +0200, Linus Walleij wrote:
> Replace the LCLA ESRAM regulator with runtime PM.
>
> Use the SRAM device that owns the ESRAM34 power domain.
>
> Hold that domain while DMA transfers are active. The DMA controller is
> runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
> from the descriptor preparation path instead of relying on a runtime PM
> device link from the atomic transfer path.
>
> Add a stateless device link so system PM keeps the DMA controller ordered
> after the LCLA SRAM supplier.
>
> Suggested-by: Frank Li <Frank.li@oss.nxp.com>
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/dma/ste_dma40.c | 130 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 88 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index eda3f91741ed..2841af5b160b 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -21,8 +21,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_platform.h>
>  #include <linux/amba/bus.h>
> -#include <linux/regulator/consumer.h>
>
>  #include "dmaengine.h"
>  #include "ste_dma40.h"
> @@ -383,6 +383,7 @@ struct d40_lli_pool {
>   * @node: List entry.
>   * @is_in_client_list: true if the client owns this descriptor.
>   * @cyclic: true if this is a cyclic job
> + * @lcla_pm_active: LCLA SRAM power domain is held for this descriptor.
>   *
>   * This descriptor is used for both logical and physical transfers.
>   */
> @@ -402,6 +403,7 @@ struct d40_desc {
>
>  	bool				 is_in_client_list;
>  	bool				 cyclic;
> +	bool				 lcla_pm_active;
>  };
>
>  /**
> @@ -571,7 +573,8 @@ struct d40_gen_dmac {
>   * to phy_chans entries.
>   * @plat_data: Pointer to provided platform_data which is the driver
>   * configuration.
> - * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
> + * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
> + * @lcla_link: Device link to keep system PM ordered against LCLA.
>   * @phy_res: Vector containing all physical channels.
>   * @lcla_pool: lcla pool settings and data.
>   * @lcpa_base: The virtual mapped address of LCPA.
> @@ -606,7 +609,8 @@ struct d40_base {
>  	struct d40_chan			**lookup_log_chans;
>  	struct d40_chan			**lookup_phy_chans;
>  	struct stedma40_platform_data	 *plat_data;
> -	struct regulator		 *lcpa_regulator;
> +	struct device			 *lcla_dev;
> +	struct device_link		 *lcla_link;
>  	/* Physical half channels */
>  	struct d40_phy_res		 *phy_res;
>  	struct d40_lcla_pool		  lcla_pool;
> @@ -628,6 +632,36 @@ static struct device *chan2dev(struct d40_chan *d40c)
>  	return &d40c->chan.dev->device;
>  }
>
> +static void d40_transfer_runtime_get(struct d40_base *base)
> +{
> +	pm_runtime_get_sync(base->dev);
> +}
> +
> +static int d40_lcla_runtime_get(struct d40_base *base)
> +{
> +	if (!base->lcla_dev)
> +		return 0;
> +
> +	return pm_runtime_resume_and_get(base->lcla_dev);
> +}
> +
> +static void d40_desc_lcla_runtime_put(struct d40_chan *d40c,
> +				      struct d40_desc *d40d)
> +{
> +	struct d40_base *base = d40c->base;
> +
> +	if (!d40d->lcla_pm_active)
> +		return;
> +
> +	d40d->lcla_pm_active = false;
> +	pm_runtime_put(base->lcla_dev);
> +}
> +
> +static void d40_transfer_runtime_put(struct d40_base *base)
> +{
> +	pm_runtime_put_autosuspend(base->dev);
> +}
> +
>  static bool chan_is_physical(struct d40_chan *chan)
>  {
>  	return chan->log_num == D40_PHY_CHAN;
> @@ -818,6 +852,7 @@ static void d40_desc_free(struct d40_chan *d40c, struct d40_desc *d40d)
>
>  	d40_pool_lli_free(d40c, d40d);
>  	d40_lcla_free_all(d40c, d40d);
> +	d40_desc_lcla_runtime_put(d40c, d40d);
>  	kmem_cache_free(d40c->base->desc_slab, d40d);
>  }
>
> @@ -1516,7 +1551,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
>  	if (d40d != NULL) {
>  		if (!d40c->busy) {
>  			d40c->busy = true;
> -			pm_runtime_get_sync(d40c->base->dev);
> +			d40_transfer_runtime_get(d40c->base);
>  		}
>
>  		/* Remove from queue */
> @@ -1535,6 +1570,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
>  			d40_desc_remove(d40d);
>  			d40_desc_free(d40c, d40d);
>  			d40c->busy = false;
> +			d40_transfer_runtime_put(d40c->base);
>  			return ERR_PTR(err);
>  		}
>  	}
> @@ -1583,7 +1619,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
>  		if (d40_queue_start(d40c) == NULL) {
>  			d40c->busy = false;
>
> -			pm_runtime_put_autosuspend(d40c->base->dev);
> +			d40_transfer_runtime_put(d40c->base);
>  		}
>
>  		d40_desc_remove(d40d);
> @@ -1637,6 +1673,7 @@ static void dma_tasklet(struct tasklet_struct *t)
>  		} else if (!d40d->is_in_client_list) {
>  			d40_desc_remove(d40d);
>  			d40_lcla_free_all(d40c, d40d);
> +			d40_desc_lcla_runtime_put(d40c, d40d);
>  			list_add_tail(&d40d->node, &d40c->client);
>  			d40d->is_in_client_list = true;
>  		}
> @@ -2067,7 +2104,7 @@ static int d40_free_dma(struct d40_chan *d40c)
>  		d40c->base->lookup_phy_chans[phy->num] = NULL;
>
>  	if (d40c->busy)
> -		pm_runtime_put_autosuspend(d40c->base->dev);
> +		d40_transfer_runtime_put(d40c->base);
>
>  	d40c->busy = false;
>  	d40c->phy_chan = NULL;
> @@ -2246,6 +2283,7 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
>  	dma_addr_t dst_dev_addr;
>  	struct d40_desc *desc;
>  	unsigned long flags;
> +	bool got_lcla_pm = false;
>  	int ret;
>
>  	if (!chan->phy_chan) {
> @@ -2255,11 +2293,20 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
>
>  	d40_set_runtime_config_write(dchan, &chan->slave_config, direction);
>
> +	ret = d40_lcla_runtime_get(chan->base);
> +	if (ret) {
> +		chan_err(chan, "Failed to enable LCLA power domain\n");
> +		return NULL;
> +	}
> +	got_lcla_pm = !!chan->base->lcla_dev;
> +
>  	spin_lock_irqsave(&chan->lock, flags);
>
>  	desc = d40_prep_desc(chan, sg_src, sg_len, dma_flags);
>  	if (desc == NULL)
>  		goto unlock;
> +	desc->lcla_pm_active = got_lcla_pm;
> +	got_lcla_pm = false;
>
>  	if (sg_next(&sg_src[sg_len - 1]) == sg_src)
>  		desc->cyclic = true;
> @@ -2297,6 +2344,8 @@ d40_prep_sg(struct dma_chan *dchan, struct scatterlist *sg_src,
>  	d40_desc_free(chan, desc);
>   unlock:
>  	spin_unlock_irqrestore(&chan->lock, flags);
> +	if (got_lcla_pm)
> +		pm_runtime_put(chan->base->lcla_dev);
>  	return NULL;
>  }
>
> @@ -2628,7 +2677,7 @@ static int d40_terminate_all(struct dma_chan *chan)
>  	d40_term_all(d40c);
>  	pm_runtime_put_autosuspend(d40c->base->dev);
>  	if (d40c->busy)
> -		pm_runtime_put_autosuspend(d40c->base->dev);
> +		d40_transfer_runtime_put(d40c->base);
>  	d40c->busy = false;
>
>  	spin_unlock_irqrestore(&d40c->lock, flags);
> @@ -2931,29 +2980,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
>  #ifdef CONFIG_PM_SLEEP
>  static int dma40_suspend(struct device *dev)
>  {
> -	struct d40_base *base = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = pm_runtime_force_suspend(dev);
> -	if (ret)
> -		return ret;
> -
> -	if (base->lcpa_regulator)
> -		ret = regulator_disable(base->lcpa_regulator);
> -	return ret;
> +	return pm_runtime_force_suspend(dev);
>  }
>
>  static int dma40_resume(struct device *dev)
>  {
> -	struct d40_base *base = dev_get_drvdata(dev);
> -	int ret = 0;
> -
> -	if (base->lcpa_regulator) {
> -		ret = regulator_enable(base->lcpa_regulator);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return pm_runtime_force_resume(dev);
>  }
>  #endif
> @@ -3509,7 +3540,10 @@ static int __init d40_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *np_lcpa;
> +	struct device_node *np_lcla;
> +	struct device_node *np_lcla_parent;
>  	struct d40_base *base;
> +	struct platform_device *lcla_pdev;
>  	struct resource *res;
>  	struct resource res_lcpa;
>  	int num_reserved_chans;
> @@ -3610,21 +3644,32 @@ static int __init d40_probe(struct platform_device *pdev)
>  	irq_requested = true;
>
>  	if (base->plat_data->use_esram_lcla) {
> +		np_lcla = of_parse_phandle(np, "sram", 1);
> +		if (!np_lcla) {
> +			dev_err(dev, "no LCLA SRAM node\n");
> +			ret = -EINVAL;
> +			goto destroy_cache;
> +		}

sram is used at many place, is it good to put into
drivers/of/property.c DEFINE_SIMPLE_PROP to avoid set up device link by
each driver?

Frank

>
> -		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
> -		if (IS_ERR(base->lcpa_regulator)) {
> -			d40_err(dev, "Failed to get lcpa_regulator\n");
> -			ret = PTR_ERR(base->lcpa_regulator);
> -			base->lcpa_regulator = NULL;
> +		np_lcla_parent = of_get_parent(np_lcla);
> +		of_node_put(np_lcla);
> +		if (!np_lcla_parent) {
> +			dev_err(dev, "no LCLA SRAM parent node\n");
> +			ret = -EINVAL;
>  			goto destroy_cache;
>  		}
>
> -		ret = regulator_enable(base->lcpa_regulator);
> -		if (ret) {
> -			d40_err(dev,
> -				"Failed to enable lcpa_regulator\n");
> -			regulator_put(base->lcpa_regulator);
> -			base->lcpa_regulator = NULL;
> +		lcla_pdev = of_find_device_by_node(np_lcla_parent);
> +		of_node_put(np_lcla_parent);
> +		if (!lcla_pdev) {
> +			ret = -EPROBE_DEFER;
> +			goto destroy_cache;
> +		}
> +		base->lcla_dev = &lcla_pdev->dev;
> +		base->lcla_link = device_link_add(dev, base->lcla_dev,
> +						  DL_FLAG_STATELESS);
> +		if (!base->lcla_link) {
> +			ret = -ENODEV;
>  			goto destroy_cache;
>  		}
>  	}
> @@ -3663,16 +3708,17 @@ static int __init d40_probe(struct platform_device *pdev)
>  				 SZ_1K * base->num_phy_chans,
>  				 DMA_TO_DEVICE);
>
> -	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
> +	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
> +	    base->lcla_pool.pages)
>  		free_pages((unsigned long)base->lcla_pool.base,
>  			   base->lcla_pool.pages);
>
>  	kfree(base->lcla_pool.base_unaligned);
>
> -	if (base->lcpa_regulator) {
> -		regulator_disable(base->lcpa_regulator);
> -		regulator_put(base->lcpa_regulator);
> -	}
> +	if (base->lcla_link)
> +		device_link_del(base->lcla_link);
> +	if (base->lcla_dev)
> +		put_device(base->lcla_dev);
>  	if (irq_requested)
>  		free_irq(base->irq, base);
>  	if (runtime_pm_enabled)
>
> --
> 2.55.0
>
