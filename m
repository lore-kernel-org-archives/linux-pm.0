Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B75486BB4;
	Mon, 21 Sep 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008586; cv=fail; b=BCKdcLzVk9/MxP5+SUNtaPJqygTAyREAkFLUhlI91okNDfZ/sETkdHv99WRRJ+Q2By7wZXSbYyqT3Unc7d9IeUNLN4AS2j9d0DLEWFVC8Oic+NlsPQpFjGbtHJd+iMnXwhsc+mMQthHEQubVhXIiz4PBTMBNcd+AH5mtpNbguL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008586; c=relaxed/simple;
	bh=CcM9xItUFfxzE6FRHKtqE3W6nsz6eDx+fMNhBDJRS3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdDqVsI/HOWhg0adf8E5ZD3bv3VHgH831GF1oN6KENLVbnhdeEnfXNsTNeI7e1X/eUq+UOAfN3+VFmMzBsEcxBZYP/nZ4aFCh73NHoS2K8ODzWroi7USR1pql9sNrctYfCb99rwdkhvu5GNuXHShbbBgwYzJeGuhTu289uIpBtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T30LGSJf; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T30LGSJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/wBc/YyvWxgE4dW4UDQJDimjKPPx86bxOpGQfmjX/XJKSQ2T2oMI8GWnJFmYyhj8kGrolzqqgihS0SM5qenk7g4uIvxFe6faSV0ds1fg+lIPSxRe8ZnkU5EZQWZUctFbbsJQM5fkSoi7va2D6BtqoGlf7S4jHamfUEOH+wZvJE9nqS1F8yQ+8HBqmb4fSrj6vdjBzdzFZJk2KmNuv8VwQpmkg6kCRzPzpXDooxNsq0DMbqHlgOFL6TBmu6cizvQjYVlfnPdR7RxrXGEI0dZMogcSWfz2UZi1ugo/Bk6aulzuYZYO1v7O7aqdgVWsZOKZIAMvnkbEYZBT6wkz1R/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxdSjgNvAWpO3gdUVnrt1LONLQAOcIYbL7FljpFcSwg=;
 b=y9X9cQULRzBPmbS75wBlIUpANAiEY/1VkDKuwSe+J2+fAJM/Wj+nwk2xLFGVV2xW6vQAdy21LK85dH/zs6oucxz/Q5ZDcuCgAVfFbiAStcoKauLNexOxtIcyOkVghrSX95HYJcqDL4aHE8nlOVv3CV3DPqpYJe84saDFAcwsrtjxsC5QoNGMeaSfSdiFhDSkXIGTUeZxtx+sUvbXpjSih6UYFUoHlT7+5fDItvrDub2E2URe5Ck5rqh4mg3et0vbW3V6RffvpdGdV0YQmeUnAfSCnIXYE4XvPenEhIwjj6SMcqVDdcAbx+f1z4J/yx2DeROWGZhdhN6Fm55wwGuaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxdSjgNvAWpO3gdUVnrt1LONLQAOcIYbL7FljpFcSwg=;
 b=T30LGSJfQvlsGfY1Axay8qK6wzDFC0kOtLSADZPufsiGf5gxA9TTeAKo+Ath/Oe4PcJeQI1NL2Y2jV8aVGhrk83VrHN7OdH7H1+Ebj8SUVTPMz6SEoNy/1bz+TlI3Yn+C3AW86QMpkuSC0wLxzBVo0M31UMWOG58DhF57cgvui78DsVuiZob21l8ht5K33Ru4j57RA2BG8BjgOOtzseSTNKSBVFB6WY9mQCRy8E3rDnuHb2xXrE3VPl1yEbtl8Ah8IZ6uuhpMbPaFQkQ82Xj4xo0Oj1gQlJC3bdKYhWOAGZUm1pPZl4PUkiNPk6+DoSLrXdQVLfhdxyZgP74vvLNHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB11717.eurprd04.prod.outlook.com (2603:10a6:20b:6f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:36:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:36:19 +0000
Date: Mon, 21 Sep 2026 11:36:09 -0500
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
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Message-ID: <arFc-cyOEESzVnWn@SMW015318>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
X-ClientProxiedBy: PH7PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:510:339::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB11717:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e1397d-9271-45f9-815e-08df17fe768d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2qsk1+kr8kX8djZE1wIOqCzZQ1OHqMO4t2y1hhKXMHulZ/vgxjx0ZuyUtjQwULt0eMQ83126W0HB4NoySU3wvSQ9BLWjm5FTgx14ZT3wCbDoofayjdZGF/c3ecVFa5oPiU6MzaPhLA3PSMFKa2kcuN9o4D7JQCkaAF+rqoVunIzwDQGctNhuMbp/Tkdw/O9slNLc1BW6Ks4jl1u6u2ASLN7d6sgM/5340Ze6qF7qj19hqgu4ncOLBPMgT4OhudwBnQoecQcgCh/2x3+fswsoqqmZOTHvPhxPms3xVOp72wU12wCd9LsQOia9i6PlHBGz/v3ugg9XBY4EDz6AmLaQoHE+X+70kqk3tYOOyQHJ0dgnCd6pHhQxd/MuodA1z9UNywrBcf4Oe4vdVozprZe/QuR4spnFYcsn6ylkMeU7odSytUgaUV3bdYELF8GzbSc0gnCnz6OmYrhtN0PdSHVFRtbKH7El4/ABrkJ8vV0sJmzaCHfR1L2wwoTPPqZ4p4mkTOue+oWY8B4xDjGJUM+8FBOK/p453J5MGJGtzMezmyVhypJQwp9949E0XadN1INRofVer8ljC9CwFQ95Pkm3KHDnzzqBc0nDwOx7iEwgrAK/tEs9v8ELigP9/ldjyD2rbdzTbkCKt0U/2X1PvUpcVb/ntIL9H4sexjzln7XMojk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ma/pHe6vlUmuXH0qJQE/Muk1Eh3zr/Ma3PP1r8oVcivRr47OkpxEeZpqxyHL?=
 =?us-ascii?Q?RP9RA7HOucEKwZvTO/IgUMIg8UZtQlRQqk3dfy31NLoUCfShGLfJ0OER0qYu?=
 =?us-ascii?Q?ohfRJ4xTItV8SHdQf+KolfMPR7++59hBeBjqF9nP80OXvnBJ0z/ql8OSLN8/?=
 =?us-ascii?Q?1KiPHlslV6Ubb2ws9157J2C3A95RJxBbjZSjXFZZQ4EpjnsK6k1iC3ewHyHe?=
 =?us-ascii?Q?ymswI1G41CEyMc65Yi53YLFBgcuGj6biBwLMMuRB49UEraNfgUcpzH2xU+Tf?=
 =?us-ascii?Q?MJNef4NOKfZIz4glWKhWreRyP67uELfkwA7W5ogVDarCDYg0bB3wcX5m8y98?=
 =?us-ascii?Q?5hbEnYyyN+BRySFnJcHi04imvj0aCYSRuiqT9c+WZKXogeB4ZNuUYUJSK3uD?=
 =?us-ascii?Q?a+j/g4tUiHb0mdBeC90pk/TLnPbEej/KOWocQcJ6cOuQDrlhA6jUG3lFPIfr?=
 =?us-ascii?Q?s/atqNrpuEmm6VRLm9TAL6oleY4BI+Jbpve5+RDPSPuMscmi0PI73htLHqC9?=
 =?us-ascii?Q?k5hmj1V4ahUBfXcj32k3VOs40M58KVO3zzD1lXRf8fy/ou1HP7nmpxaTLpxv?=
 =?us-ascii?Q?SVgdpWAzl49IzAQ0CERVBCJ4+TwW0Xswioulkf/cHoOj/QoIKlmapRtgPvJZ?=
 =?us-ascii?Q?pYQhj3U1I5HdPEPpygn3yGL19XcQRFMS/QWfMzdOf2IMGiZDeaYDqQEi3aWk?=
 =?us-ascii?Q?Dpsl4++5NzFGOWKUcfkY0544IvKp7b1YYeHENbguLRu+h+V1Yg3YAgAyDLeL?=
 =?us-ascii?Q?Juc00ji+UAYkt6sW/qOarPqmexlMN5ieciemxlyHBljEaEWqimkvBkJks7cs?=
 =?us-ascii?Q?ky3kjAg4zJwLaa6E6wlF1tPOCOyXMH1nDOsAdx4h2XWJVEc90QuQ5d9IEw1e?=
 =?us-ascii?Q?JVGyS5OXiFR1SBJ2/CBxZWAc/g7feY+lsmfNvQ196iFkDnLt7N7bvNfDU61/?=
 =?us-ascii?Q?PbluOJpBvli8jnyqGmecrwV8wYXRgnwDKYNQh2kw5UTXVZ/X8Hr4N1GUZrn9?=
 =?us-ascii?Q?iWBi0GSx8SSAUFrzK84XbFL2yZU3rSK9HJ8q4C5Jisu16IgFCc9LDTiF/z9E?=
 =?us-ascii?Q?gyjinmvVkTGEXYpLqZNqzO+g5s7gVj9N5Zx+wsMWWaW9dQPvumS/e+Vs1WDh?=
 =?us-ascii?Q?j5rTXN3uwHlLcwsq646sYDGlorkHoVtjVX0aIPioc+IcK881xrf11SSyVH6w?=
 =?us-ascii?Q?dFMSkW4W/mqGBW9mMnyZg+Wg8vkAtX5LRDUDmqiS25/8wINMtP7FMvfTl6KS?=
 =?us-ascii?Q?i2dQ2DOggx6KtYDwv1vWz2RtN6mV568wESmDebHt4eBTQW+/FB21BUx3X2/U?=
 =?us-ascii?Q?IDn4fKFVXN9BTaJ/Xh/S6kARcn+BueE1E1wcKXb/wtYmjMt/XsY2394VtPmC?=
 =?us-ascii?Q?gKRAxbVq2uU2h7dEsQTPCGtdHzwB5wepakO+P1kTFknexQaTJY9nEpvKBgzD?=
 =?us-ascii?Q?ePFZmMgQ/gZipUsE6XjlOWQN0adOcjTBnSfuHdblB6oDuFJqKJaFWk5AYX0s?=
 =?us-ascii?Q?WtNljQM7VkVimB+M2Guoy9l4K0G0buBopq4q6nEkIa9CtoTjyizd0h+sjLJm?=
 =?us-ascii?Q?pdnArSQ7FWPYvee9XIC0pYWB0WdyXBLe4sf9uUy+J/cN+i/GRaug/gS1dIRS?=
 =?us-ascii?Q?awaYYW4umHR29RatV2swIw5k1dpOuJZ1YZ03dnll8hPe6QwkWHmG+OzxwfJw?=
 =?us-ascii?Q?12g4UlKOfxZN3R8mOy/f7G2lYYC4eLr7SnSbf008S8+m5A1JZjNry+Ev9r81?=
 =?us-ascii?Q?ZVyBxay3lU4aGmpZyawrORzVgd1eA/nT8bbdMcDwwBxXH15kbjqK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e1397d-9271-45f9-815e-08df17fe768d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:36:19.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rUV7CaolFC7hj566Ok2Cp9BxJo5S5cH2RY5AzlaIrRbUKgCuZXz4BJXay1CP0N2nY4eHUHfMSFXC2IuWBkDs9lWGFyHTP05ZSW4yWSWNoC0KAr9Y3ae+m12RaYwQvq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11717

On Mon, Sep 21, 2026 at 12:48:21AM +0200, Linus Walleij wrote:
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

should use pm_runtime_resume_and_get() also? avoid need call
pm_runtime_put_noidle() to maintance ref count.

pm_runtime_get_sync() many return failure, why needn't check return value
here.

Frank

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
