Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231F1DDC28;
	Fri, 13 Mar 2026 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402935; cv=fail; b=iKDhLiCsaECghrX57KqG62ts37KA+gCGmHiLtD+Q8uU429Na/jv5T4J39I2/FEkSf40H/eolAz0e51rumVJoC9IA5aFzRrWjWAAbomxTatFgg3fOFFOewMh6uQuRfhdFtg0oUFBoTEM6Fc2CAV5RysOuzQmIZrvajfKDT14JmBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402935; c=relaxed/simple;
	bh=+V0ZVXGTzSr7ZJYFjspXDb31uzM9G9vjoQ3WBG5GlDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSA23m5LWa1SwUUYA4hgREtQlN0nNCKPnMP9grfAf9DM7CH82lGteB4W39RtACXIbPw5gxckQEHhaIxOsUhBQ10T8L97TTxvcLHx2t9L6Otid3/nOJmZ0kv/2617mTVHFyU9m4wXYwc/ekRnxyP6deBkMb6oYL5JrsDyKtjv3NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QO2iVZA/; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QO2iVZA/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA25JG1aHcLQ/mN4UWu9Maiua4LjAZsNcCAg7vsELIjJOzGkPqryRH4OQVwK8Z9SoUggqiZj+IRYVWTjr1PkI8BB86kyHly8oyt1dWjGgJtNJ609w4BnbpvObE6YX7sk20PK0aIzK+EII97Otey4qeoAdLM/vGoPI52JLKF8+WEDpYJQYVn9fS6lbGH5d/GQLZC/RdMSoLO3tCZEhzCvKI2quGil+JMtLNxCLyBSyoh7f95/BM1u9ioz8vb9Aj9EYEx37zOn9oP6O23T0G3trCqKtjH/5/V1FzbSPUgO/TyjVBrDMpp4EYndM8pYkPmDogZXDX/qS+XH7PIEeh3xsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJYI/zjKJrFc266SciK9o33O1nT9aXWTY401E7EaJ5E=;
 b=sQqFQIdqkkWLHSgyQ8a4Kua8/Af65Ep9OHy50x9hGYBMQc8bVSkRC1kS4GtzqWSkzHLleo49HA42z5F2Uk3omXcedJavhtUfNq3wQm1Ux6e4l7alVIFl1RtfQ8DCJoxN39q0nMuWGohtjY57fNW2fQzAhmujnLxxFPBaTPGXo239zCVpPe096zm0DwPfuQts6C/gtunmhacXIDIN7dp7hf6hGB/+IBHzLvSX4JjpLzl+wOkfoXZOtHS5DfamqcwnfrodCkTjop6Ozyjc2z1b7imYOx9fVJ0vf2w6j8Yd7jLoxqB8QLbqNyr+QjASz8LZoxDGmxLtFixNot23wtjZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJYI/zjKJrFc266SciK9o33O1nT9aXWTY401E7EaJ5E=;
 b=QO2iVZA/YCYpMFnhF79ByY2G9azGq3y8s9gZMzmwjn5K7nuRZYOmceiOGfJ8IgfkzbcVDe0+0Imb9W7fDD7c93/KQzCxv30roYDbxFJUWw4lQzaAKO/p8awV+wyakDq52kBCugS4rq01cUIIXRPRtMoVdwX8clmxmEbqBeR4VoU=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 11:55:30 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::f2) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 11:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 11:55:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 06:55:26 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 06:55:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 06:55:26 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DBtPNb485559;
	Fri, 13 Mar 2026 06:55:25 -0500
Date: Fri, 13 Mar 2026 17:25:24 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	"Geert Uytterhoeven" <geert@linux-m68k.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] pmdomain: core: add support for
 power-domains-child-ids
Message-ID: <20260313115524.6eqm7xle5umhttzb@lcpd911>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-topic-lpm-pmdomain-child-ids-v1-2-5361687a18ff@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MW5PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fba719-e184-47e8-1bcb-08de80f76bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BaPH4Pu0Zkeh7TzumQsCq5MkMnLEOeAMczvW6VAadAUrEf5iVYY4fCf3JeOx/wfrebZVod9/7Q4IbTbU1GyiOwqpM8Y0LHSW5Nayf9t4tefcTmobZ5o4xG/wRchrbVDyp0Uofwa7whPvOFMg8lgGL6G2FbV/3sl2Tv4LXSs/nTv+zeb7bHnka6zke1F2vKKZQTu5hFlt400lAcIOEZK8s51c3iQxyk6HjJgW/OZllnmCkeOCJNHQM8OX2+vaS91zh5/5W6Kk7eWS9TaSd0L9xSeUAcT5UGY3uKYzaRdi1gJa8n1EyB8ppuCWX1pylCfIydr1T2gPDVhMkHdsHOZEsCRWg+8G4v1kH45PvveSqgEUnB5fUk8RpDeTNa3+uddA5sA8j/tb41yl3SUG8VEQhwguNCSlGN6fDmfQVJer/0GdoM2vuL0Kr7xY6h8HIPgDXXSZchAUqxeoBEDSR7ZMziWJgd4x5W8eXTrpZ1mI/LLusUnt3HH/wOoYZeCSxEYG+EJXCYDk9ifF8ptSd9egU8TJZ+CZ7cSIwAhc40gi2oHsou/5vvVtt/Qxix5aee5DImOJtzWjjvkpbEkRISY135/g1UYED264VEkqKEbhhuWLRl0J1n0poioUvrD498uZucFgrQk8/7n4VbQjgEqRGlJFOYtrBFRh1ftqgcx27il+ZJ2PXz4XOyPVN+8JgbwXXk9Guw9rjKBJ5OKYNV6tz0d/fCv6Hiwkaqm+ahcuBTxheygpksGTI7tbeC+hVjA5k4vIP3tOk9+n5yu+gk6/mA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R9ax/2FKM6Xi3WHhXKP+6RWb1tCjJ8MO/trhG/DwJcXvtwEwnfuLX3LKxqX2RIsAyNhICgzqd/IIeSRfwTuLRH/BKVOod5m32YZOq0ujKZLG3qs1axnnnmLg4F3Xu5V0iNRPHYN6kTBxyu+vd70/RgbCVrlVPWzmUJUJYH/vM70IhTx8O0P3rJ5GJdIjbLm/xEIInQhdnBXXjbxcTS7ba2346VCaYXgc3xzDKXcwh5+FRg3EtbivRO8Nsub9OgrtezdhqyQkUdJKex0g3Sb+wk8W3Z4s3X5KTCGgR6t+0zWO2hcD5oezpxgFbdtZpW/gyxW9N2DBUW99KgfYmvv3ufNvG+R8bHu3iSO5VI1Z5e9Lu/vDJhKX3uzEWc1s+AxfvT5anC8jCB/1lpdP5bXOfJwYrJHdZEGMZE+fvOsVqYUJQvcbZlZYYGTAPICQ+ZZy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:55:28.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fba719-e184-47e8-1bcb-08de80f76bf8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761

Hi Kevin,

On Mar 10, 2026 at 17:19:24 -0700, Kevin Hilman (TI) wrote:
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
> 
> Add support for oncell providers as well by adding a new property
> `power-domains-child-ids` to describe the parent/child relationship.
> 
> For example, an SCMI PM domain provider has multiple domains, each of
> which might be a child of diffeent parent domains. In this example,

s/diffeent/different

> the parent domains are MAIN_PD and WKUP_PD:
> 
>     scmi_pds: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>         power-domains-child-ids = <15>, <19>;
>     };
> 
> With this example using the new property, SCMI PM domain 15 becomes a
> child domain of MAIN_PD, and SCMI domain 19 becomes a child domain of
> WKUP_PD.
> 
> To support this feature, add two new core functions
> 
> - of_genpd_add_child_ids()
> - of_genpd_remove_child_ids()
> 
> which can be called by pmdomain providers to add/remove child domains
> if they support the new property power-domains-child-ids.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---

I've tested multiple possibilities with this series on the TI AM62L,
Tested-by: Dhruva Gole <d-gole@ti.com>

I tried having more parents than child nodes. That failed.
Tried less parents, more child nodes, failed as well.
< All as expected >

Tried the proper thing , worked :) (attached a short log of working case)

8<-----------------------
root@am62lxx-evm:~# cat /sys/kernel/debug/pm_genpd/power-controller-cluster/sub_domains
GPMC0
ELM0
root@am62lxx-evm:~# cat /sys/kernel/debug/pm_genpd/power-controller-main/sub_domains
power-controller-cluster
WKUP_GTC0
MSRAM_96K0
MCSPI0
root@am62lxx-evm:~# uname -a
Linux am62lxx-evm 7.0.0-rc3-next-20260312-00003-g9556feac2532-dirty #2 SMP PREEMPT Fri Mar 13 16:13:51 IST 2026 aarch64 GNU/Linux
---------------------->8

changes in DT:

8<------------------------------------------
+&scmi_pds {
+       power-domains = <&MAIN_PD>, <&MAIN_PD>, <&CLUSTER_PD>,<&CLUSTER_PD>, <&CLUSTER_PD>;
+       power-domains-child-ids = <58>, <63>, <72>, <37>, <25>;
+};
+
+&psci {
+       CLUSTER_PD: power-controller-cluster {
+               #power-domain-cells = <0>;
+               power-domains = <&MAIN_PD>;
+       };
+
+       MAIN_PD: power-controller-main {
+               #power-domain-cells = <0>;
+       };
 };
--------------------------------------------->8

>  drivers/pmdomain/core.c   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  16 ++++++++++++++++
>  2 files changed, 185 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 61c2277c9ce3..acb45dd540b7 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2909,6 +2909,175 @@ static struct generic_pm_domain *genpd_get_from_provider(
>  	return genpd;
>  }
>  
> +/**
> + * of_genpd_add_child_ids() - Parse power-domains-child-ids property
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the onecell data associated with the PM domain provider.
> + *
> + * Parse the power-domains and power-domains-child-ids properties to establish
> + * parent-child relationships for PM domains. The power-domains property lists
> + * parent domains, and power-domains-child-ids lists which child domain IDs
> + * should be associated with each parent.
> + *
> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error code.
> + */
> +int of_genpd_add_child_ids(struct device_node *np,
> +			   struct genpd_onecell_data *data)
> +{
> +	struct of_phandle_args parent_args;
> +	struct generic_pm_domain *parent_genpd, *child_genpd;
> +	struct of_phandle_iterator it;
> +	const struct property *prop;
> +	const __be32 *item;
> +	u32 child_id;
> +	int ret;
> +
> +	/* Check if both properties exist */
> +	if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
> +		return -ENOENT;
> +
> +	prop = of_find_property(np, "power-domains-child-ids", NULL);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	item = of_prop_next_u32(prop, NULL, &child_id);
> +
> +	/* Iterate over power-domains phandles and power-domains-child-ids in lockstep */
> +	of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
> +		if (!item) {
> +			pr_err("power-domains-child-ids shorter than power-domains for %pOF\n", np);
> +			ret = -EINVAL;
> +			goto err_put_node;
> +		}
> +
> +		/*
> +		 * Fill parent_args from the iterator. it.node is released by
> +		 * the next of_phandle_iterator_next() call at the top of the
> +		 * loop, or by the of_node_put() on the error path below.
> +		 */
> +		parent_args.np = it.node;
> +		parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
> +								  MAX_PHANDLE_ARGS);
> +
> +		/* Get the parent domain */
> +		parent_genpd = genpd_get_from_provider(&parent_args);
> +		if (IS_ERR(parent_genpd)) {
> +			pr_err("Failed to get parent domain for %pOF: %ld\n",
> +			       np, PTR_ERR(parent_genpd));
> +			ret = PTR_ERR(parent_genpd);
> +			goto err_put_node;
> +		}
> +
> +		/* Validate child ID is within bounds */
> +		if (child_id >= data->num_domains) {
> +			pr_err("Child ID %u out of bounds (max %u) for %pOF\n",
> +			       child_id, data->num_domains - 1, np);
> +			ret = -EINVAL;
> +			goto err_put_node;
> +		}
> +
> +		/* Get the child domain */
> +		child_genpd = data->domains[child_id];
> +		if (!child_genpd) {
> +			pr_err("Child domain %u is NULL for %pOF\n", child_id, np);
> +			ret = -EINVAL;
> +			goto err_put_node;
> +		}
> +
> +		/* Establish parent-child relationship */
> +		ret = genpd_add_subdomain(parent_genpd, child_genpd);
> +		if (ret) {
> +			pr_err("Failed to add child domain %u to parent in %pOF: %d\n",
> +			       child_id, np, ret);
> +			goto err_put_node;
> +		}
> +
> +		pr_debug("Added child domain %u (%s) to parent %s for %pOF\n",
> +			 child_id, child_genpd->name, parent_genpd->name, np);
> +
> +		item = of_prop_next_u32(prop, item, &child_id);
> +	}
> +
> +	/* of_for_each_phandle returns -ENOENT at natural end-of-list */
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
> +	/* All power-domains phandles were consumed; check for trailing child IDs */
> +	if (item) {
> +		pr_err("power-domains-child-ids longer than power-domains for %pOF\n", np);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +err_put_node:
> +	of_node_put(it.node);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_add_child_ids);
> +
> +/**
> + * of_genpd_remove_child_ids() - Remove parent-child PM domain relationships
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the onecell data associated with the PM domain provider.
> + *
> + * Reverses the effect of of_genpd_add_child_ids() by parsing the same
> + * power-domains and power-domains-child-ids properties and calling
> + * pm_genpd_remove_subdomain() for each established relationship.
> + *
> + * Returns 0 on success, -ENOENT if properties don't exist, or negative error
> + * code on failure.
> + */
> +int of_genpd_remove_child_ids(struct device_node *np,
> +			   struct genpd_onecell_data *data)
> +{
> +	struct of_phandle_args parent_args;
> +	struct generic_pm_domain *parent_genpd, *child_genpd;
> +	struct of_phandle_iterator it;
> +	const struct property *prop;
> +	const __be32 *item;
> +	u32 child_id;
> +	int ret;
> +
> +	/* Check if both properties exist */
> +	if (of_count_phandle_with_args(np, "power-domains", "#power-domain-cells") <= 0)
> +		return -ENOENT;
> +
> +	prop = of_find_property(np, "power-domains-child-ids", NULL);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	item = of_prop_next_u32(prop, NULL, &child_id);
> +
> +	of_for_each_phandle(&it, ret, np, "power-domains", "#power-domain-cells", 0) {
> +		if (!item)
> +			break;
> +
> +		parent_args.np = it.node;
> +		parent_args.args_count = of_phandle_iterator_args(&it, parent_args.args,
> +								  MAX_PHANDLE_ARGS);
> +
> +		if (child_id >= data->num_domains || !data->domains[child_id]) {
> +			item = of_prop_next_u32(prop, item, &child_id);
> +			continue;
> +		}
> +
> +		parent_genpd = genpd_get_from_provider(&parent_args);
> +		if (IS_ERR(parent_genpd)) {
> +			item = of_prop_next_u32(prop, item, &child_id);
> +			continue;
> +		}
> +
> +		child_genpd = data->domains[child_id];
> +		pm_genpd_remove_subdomain(parent_genpd, child_genpd);
> +
> +		item = of_prop_next_u32(prop, item, &child_id);
> +	}
> +
> +	return (ret == -ENOENT) ? 0 : ret;
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_remove_child_ids);
> +
>  /**
>   * of_genpd_add_device() - Add a device to an I/O PM domain
>   * @genpdspec: OF phandle args to use for look-up PM domain
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f67a2cb7d781..b44615d79af6 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -465,6 +465,10 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>  			       struct genpd_power_state **states, int *n);
>  void of_genpd_sync_state(struct device_node *np);
> +int of_genpd_add_child_ids(struct device_node *np,
> +			   struct genpd_onecell_data *data);
> +int of_genpd_remove_child_ids(struct device_node *np,
> +			      struct genpd_onecell_data *data);
>  
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -534,6 +538,18 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +static inline int of_genpd_add_child_ids(struct device_node *np,
> +					 struct genpd_onecell_data *data)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int of_genpd_remove_child_ids(struct device_node *np,
> +					    struct genpd_onecell_data *data)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>  
>  #ifdef CONFIG_PM
> 
> -- 
> 2.51.0
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
