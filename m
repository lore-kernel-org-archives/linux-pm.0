Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8B1DD525;
	Fri, 13 Mar 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403636; cv=fail; b=DxW8LbXhEU5YBclYsK/TLJyFTdmhFyb3vei+GgeuseUnTPLEdOaydIEsdxF3gX+9FKtFaLvocFnAQYAqlbEbQvQl1gwDemEySuyJiaWWPpx5OMNHxanLJPQDlSVGLLC/AvMyQHOdRV94z/CgWUEG445il2y6UUz+h43NGPzL2OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403636; c=relaxed/simple;
	bh=b9pSu5pzl37evLB9Z8HmJz+XJFS69BE19DyvKaQIEwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMAyadv5aSuu0VIDU08u4LCw1r/3iSsu8aeP/vqWKLyrp9MnNtJprNH1BkIyFZ9fzfohXls32W+tZ3Ri6qBq7DqqJJiABYr2lBgmXtC8V0XKDsXUs5BOz/1b8asLOVZBR4/3ZWOL90H9PwliqB+kEXtlEY3kYC/KFb+CvoXY5pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hVVZ16Yu; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hVVZ16Yu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv7ywo2hrHSnvgcWkcdMkijG50ZxjGrNJsMrP2A9hlu92ctOv3Ee4YSMEzN+iKVwZZvuNL966LHLWzQ7aYnydPoxoJm+Ue9x4vaWjS9OU+WXpxAjDSSThDzItGa6w991cNKgtd/q19VZ8795646nMdm2A5Az2Xf3wjnt5r8VmypoakoXIIsIYmJStEmh2KegSgret48LXiRVm5qqmmMt/hgM2BGu18HAuu4244koGo4hrwUtTUjwUQbTLizSJ28Iw7W85eJWNJSKg9FFgn/K2RxKK8uv2YGOHhm3UjjAdgqLj+37n/IprOKwjDipyB7Uxqhbfd4oHiNflnblyL23jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP/ZwzjFJlK94M1WuxoATn9Is2JUsSWPV6rrSthpLgU=;
 b=tAEDvl/jcTfgrYxgMfYDr0/W2h+k24ZCyPCXXChu0LQb8kkEYj5jYDW1LenLcr4fD4A2iVQWSe6zHFQGur7U248J0Ey1eO+qKC005jH0dQ99WY0TyXc5np2srKDDMYUPrWAyT3hYVLegl4Aif/0IBoLvaezy636lXIRdISuuyh/ophvHDm56lso9HDMVW+ywA4xPRnctDjWFfUyYWWNRSykkeWX7EHSl8egqLxedGdqZup3w+WDMQeoOr8lSxWVWIe9HW9n+AI62TrPZa916471zH5TkfQYnnBLozud8QgpZyovKAYVY4O2q1V99swNItU1wavaVY+kBqoAKMOe1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP/ZwzjFJlK94M1WuxoATn9Is2JUsSWPV6rrSthpLgU=;
 b=hVVZ16YunGvdxYLdG58m9yT3m3hG4aapz0FGJEiUXuxNdcQB+AAn9ryjSESyt6cqGJMgsm7yT+lpw12LfnkmNPoEfbjrK+ot9maKXCJ5+1je5jGkk9IRq4U5DdEch45fqBr+Q+wkPZfhsybmba9rXFoQU99i6RFW58oSMaOfoBY=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 12:07:10 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::ae) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 12:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 12:07:09 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 07:07:09 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 07:07:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 07:07:09 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DC78X94190594;
	Fri, 13 Mar 2026 07:07:08 -0500
Date: Fri, 13 Mar 2026 17:37:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	"Geert Uytterhoeven" <geert@linux-m68k.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] pmdomain: arm_scmi: add support for domain
 hierarchies
Message-ID: <20260313120707.jhkyd772wzuwmlhd@lcpd911>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-3-5361687a18ff@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-3-5361687a18ff@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3551a4f3-7057-4f99-e3d8-08de80f90dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4AXoEWM65yj4hXN14eJFFp7aZrIHiXyBUXUZWGs5hLms0YpokEAHBr76+PlwzHm/4URfqVSC+RcE3xdO+SjkcP1LPL0pSnloFP20HLg83M9UcjjmMh09PE88jHQZLMMr3JvOeQUE6b0KRn85JQ2xnXMHVw8FhwwNeoVDcZW1fZTxEc4fG4vGPnYLCh3yblV1HjEW4zdaF5AAyEVbzpxjo5YQPbT7O+vLFiKfUPCQQWIOn8dzg9kq5iBtKMrH5lL7/iAemqlQITiylQfWgJduSujF9J2k5qPmzg0f2dTHtmaMFTvaH0Jp1D/qdljJsHF91Y6b34vS/O6+v/rBQ+Srko5x/fOI6/dYeGuTUout245MRrIEbAVHxOZKgyOcULDXLDk9ycvUVLSsX0yVLMqLy4qUXOoLilDqUnJSUvaFSrckQ6X0GM4uuCkF85roBOu/hG0AeEiJupw11zfYX0pXTvXcvrfWNtsFwBJxjRI5xnMZics08YWKqOUkydRkpZmhOz54Hy8KMQcbVLDLw/X/Q2KyLodA/abNLVWYvbN/o8kAHzOEQ/TFPxKjlzM/Q13Vhp87QLri0T7+VFzW6y5lcp+0L7G1Fa0P4TG/zPSrjQeukaExIyXGvKeAY9pUwVxWKgjJ3I4EWjTC1T6OVbOieLIZMS0ox4fpdtUTN1L0QMTnZvMbxl1/ruB5P0BR+xaFuuXxsYVt1VxwbrauIDTMS32qxdg6cljMr2AM3t6HjGSXUaFxmPcxplufAy70xUYbezas+CVYyBk5rKogGE0VCw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	onGWnT9YmDzSqRQIQTfYWwroRumveI/buJLEXltbIJq56q1FEIpsU/Ai450PTqJUm14mHZDWI0fmqQT98+eAqQeP2uZewUhqwF5g+ML086Tujhi3mEQzEiAiLfC6kOqbudSUv11yrPn+kSnOUq7Ss5Yg8acUbdl9z/5JRoLadMwB2ar+2A1+WDu6nyJDhExSdB/m5IDISBx+VIbttG5/vKJx9s3cUsNKJlQRaFO96UgYhOsYh1pZ4+ixLUcdckpCyi/ajzArBlsfaR2k0ppN1UNMcYuVP7n4m76kbJU+NPwTtwlwo5v3002DmDBQmke6/vO5H0KmlsFv+SDHYIUJ/kiukgZz/yKI5CodseUNINGsdniNYoyGGn0OJNudCvczIPCoN+FsWjHklyZ9iHkdrjsJNiWgh/T+w+r5u/Jr59syaI+YlOTMgUdG5WJtuOhl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:07:09.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3551a4f3-7057-4f99-e3d8-08de80f90dd6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423

On Mar 10, 2026 at 17:19:25 -0700, Kevin Hilman (TI) wrote:
> After primary SCMI pmdomain is created, use new of_genpd helper which
> checks for child domain mappings defined in power-domains-child-ids.
> 
> Also remove any child domain mappings when SCMI domain is removed.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---

Again, since it worked fine on my AM62L,
Tested-by: Dhruva Gole <d-gole@ti.com>

But I had some thoughts further down...

>  drivers/pmdomain/arm/scmi_pm_domain.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index b5e2ffd5ea64..9d8faef44aa9 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -114,6 +114,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>  
>  	dev_set_drvdata(dev, scmi_pd_data);
>  
> +	/*
> +	 * Parse (optional) power-domains-child-ids property to
> +	 * establish parent-child relationships
> +	 */
> +	ret = of_genpd_add_child_ids(np, scmi_pd_data);
> +	if (ret < 0 && ret != -ENOENT)
> +		pr_err("Failed to parse power-domains-child-ids for %pOF: %d\n", np, ret);

Nit: I think the style of this driver is to use dev_err than pr_err

Also, maybe a dev_warn makes more sense since we're not even returning
the error or doing anything different if we get certain error path.

I am wondering if it makes sense to just abort the whole idea of
creating power-domain child ids if anything goes wrong?

Basically just of_genpd_remove_child_ids if we face a condition where we
have different number of parents/ children or id > num etc...

All are error cases where the system behaviour can go on to become very
unpredictable if we end up making a false/ incomplete parent-child ID
map.

Thoughts?

PS.
If we go on to do a of_genpd_remove_child_ids here incase of failure then it makes sense to
scream a dev_err here.


> +
>  	return 0;
>  err_rm_genpds:
>  	for (i = num_domains - 1; i >= 0; i--)
> @@ -129,9 +137,13 @@ static void scmi_pm_domain_remove(struct scmi_device *sdev)
>  	struct device *dev = &sdev->dev;
>  	struct device_node *np = dev->of_node;
>  
> +	scmi_pd_data = dev_get_drvdata(dev);
> +
> +	/* Remove any parent-child relationships established at probe time */
> +	of_genpd_remove_child_ids(np, scmi_pd_data);
> +
>  	of_genpd_del_provider(np);
>  
> -	scmi_pd_data = dev_get_drvdata(dev);
>  	for (i = 0; i < scmi_pd_data->num_domains; i++) {
>  		if (!scmi_pd_data->domains[i])
>  			continue;
> 
> -- 
> 2.51.0
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
