Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BB2D77F7;
	Fri, 18 Sep 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720171; cv=fail; b=uuA5gvSGGVj/qce5GdtPLTTF/S/zAlrC6XOOt7J7ujDPPDe9tFXO/Z5RWsJt8+tsDhcbPmL4QiMiEQLotoGFyZh0MSZIynLslEf/Tz+uwlA0D/wz6e2MAjsyIwNeBtiLPWmwvp/IGZcuG2ZG2xfOC5frjJXwg/jHDCMJf0bk4JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720171; c=relaxed/simple;
	bh=sKT3YmF+5srXnVUUj47zllNY0eoC6dH4JXBDFpuqnHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YOKDKlXBvPNMvKfksyFrc+qnT/yaaSl9ahi1nZS6xTfTfUuuKZbE1uwP5R85ktXam74TmsIM4uj/OZasHrw9LN90lTTjfYqxAG8B/rC4W0j0vvXEDGAmPGt6GcAF4MV5vdNOAe6b6yPh50zZgJ+9vXleFHLOdGR5BD9oDkYnJsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=F00myeTG; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="F00myeTG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Zmzh1OD+qexInUYpv4CkGBn2Cgq8SrJOvyr+VCRtYEZbO7k1Rwx8IEfjNMWb9tNdbfOUNYTTLg/i4I/UcO2CTlo93Hgd1/i86djJO5vJRayC7qPJrxmFVUyLh490C0KKs7UeLMsI75FqyVuJI7dTsi/GTAfPmJnFvPWahHOg1fipdj3sJjcsyUiItkm5HefCxmu1GLyUsxtzHJACOnh91nhp2FtZUjKuk80CDnJEOnmETKvF+So8aBFS9qE2GPV59p/lrJokY6nLxds7DvY+t5HdfBHG3AcmwV8pJa1yAuW4Kqz1TGljirVl+OefY7WvthZVQytFejS+rcl/xReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2gfGzOF3HKY2tCUXe/Q264UR3d6Hpim6+wzQgglk58=;
 b=BFN8qiELvBr8I9+djDOIgp08j6q9sbXg26yOPYPynpS45OWp8IucEb18c+Iuq529kun8xBEXm2BhqeU49mIkaMdmSPIQVMzlUZciAE8lk9ZT7DTW5ncD9ye9cwjjzmi8u9Cl4+Nd/wYbC3SlihHudMIVk9s0+4p5JACOIIQLRtoYUlIpU3/CiO5g5XAV/n0Ulom6zY/QKOxnQLeu6ojZ2cgqQL6o7OXDKbFyb79Loaj98dBBYhGhhurGjnwsL4SnOIoWISUciCW7jBL1TX6PJsbEGej3FqbknJs5ZeFXdgDlGG9j36Ow3rAPe2ptbKkg1ZEafaU0Ok2lmHkwYI6PTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2gfGzOF3HKY2tCUXe/Q264UR3d6Hpim6+wzQgglk58=;
 b=F00myeTGDodiViSJLD7HBvQzTW1tnJv6Ppa6pbJAuXmL7NzQ2+tdAex1ChJ9jL4G8fVOGjC/hl26pIGK0cjWvHUIvNsOERQCLpMTVRDoiRZu1T55yPB80raQ+/PGEmLuiNoT45oDkOUCUX4Pk35qbKrSV9hHUxCD9B9xqE/9f44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by DU7PPF8C318BDC3.eurprd02.prod.outlook.com
 (2603:10a6:18:3::cd8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:29:24 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43%2]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:29:22 +0000
Date: Fri, 18 Sep 2026 10:29:21 +0200
From: Henrik Grimler <henrik.grimler@axis.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: battery: allow longer
 ocv-capacity tables
Message-ID: <20260918082921.GA1515928@pc67698-2615.sto.se.axis.com>
References: <20260918-rbrue-suez-upstreaming-battery-ocv-table-128-v1-1-f477ef39ef0d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-rbrue-suez-upstreaming-battery-ocv-table-128-v1-1-f477ef39ef0d@gmail.com>
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|DU7PPF8C318BDC3:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcdf772-75eb-4062-b21c-08df155ef106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RFvRELwxxfb26JMAdT8G1/PztfakUw7X16H39PAiDsgMP+SAbyBynn17XVSjmNVEDiSNM9WtKO26aQ1uwYt18izLf5ZwaZGOgi28KNbVSR2FPv+Dk2f4jr4vujh/NHhzWW+/b2aona9Jee6/RNUcbJrscj2au4W4jCtQP0nx3RT3S+BbfvsbwmTQexG0o5NudDVZsBRRwodHp8WGZYUvtrkhTjipHozKd6kXygXVxzW4sQ1jmyASrGIoSArN5Baw8hkpx7/ZXLnUTnpOsrK6h/BIM7txuvilC+xZJyQ5cOxmmy/PqQSDl8GFBSMd3EGK6qGMVWkWHu7AWjHERlJkzqmFc8n1W6VJ8AgEU9M/QAIcAqGEQrOTaZaWEkNe1GaBPiRe0tX9u5MFLrjwfZACOk6VScMoFbnw4i0odA72ATmCrlfivKKv/mqjfZ8NEjBgRaHlSkyX+AYnjCswvOKZiLFFku+U/HtYhYF+ukvn3vjeNsKD5ReiCR3hcsWd+hA8X98PKQIIBX7j9atFJXA26O+ZSmrts23BWnvGY0jx73l2/gHjqDLjgJfIwXZ8jUVHm8us7nj1Lqp9nxO//5DJjZoAoqdMDbKKVEBR2Z/rFCw/fhOAkuy5gLucYBQCO7oAQjJRpHmr3Vs9bFwaj/ysawT8cY2PSTaKxXmXlnBOReE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmRcbG51ALVhJPA6ElOVohdQczQXpkNBlMZvrchQ0TXyWBwSydns6iZJTQme?=
 =?us-ascii?Q?Stl05QkbPKIc84883isj0M7mWFwsNGNCZ027u6rKEQhs15nIO65hybro6RT5?=
 =?us-ascii?Q?RaYcGL5wypt+Jvk2dAxARrbXGKA8WEtMoc4p1HvlABkjV6czNYU5LA1Fo5LN?=
 =?us-ascii?Q?YpMnJdscHjsNt/OnavHF/0WWZGzHCI0qBfik9p7R94Phfxb35t7NV/9vx2w4?=
 =?us-ascii?Q?BgVjG959uuCngjK7tOPM5Dv/MHlBPDfMY/Tn8/zujSTSa1KsUfvY8t0/L3IW?=
 =?us-ascii?Q?vuAnjBZ2QBzbHpB5UUUugeaopen7tgywxmULC73Qa13kcOxZr3YvOkfMWoJC?=
 =?us-ascii?Q?qCYVYFub/bshmsrS1qqdrV9QXZxlfcIYvDxmt1wDg9JTi/EK3YhqwNYZxDoj?=
 =?us-ascii?Q?TD/bIyLkbgbtHDkljVRAs2kmDZyCv9zLE3SFi0hk1isGLA2gpJsy9cv2d5zP?=
 =?us-ascii?Q?iGSHX7c5O01x+e6aYG30pNQfXu22szmqyGkv+6Ah+4FMuxtChIYKKbCc3hRV?=
 =?us-ascii?Q?YvJEryV5KoS3xv9VHrUqtppWOdX2iBovD1C0pNTocbgxWXZY6bM8S/kFYnnQ?=
 =?us-ascii?Q?E4b8f17OkKgaCo4AD4vo3L2Ha7vIuRiiblPZ+dUR2XKHgptLyleA6y3CGu6M?=
 =?us-ascii?Q?MXPIljPpfixdCNWkVa0Z7MvwjJkX8VYPXiBl7tTcvV5NBRM1fwGGdRfUhmbl?=
 =?us-ascii?Q?PLfdobJg4NTm0Tr0KAIq1F67WwvupL1IsT4tMHry3oaZXkltBWayif0zU/l0?=
 =?us-ascii?Q?biWAQtodx+T4s3Wbpo7ygu1GYA3EeSx79omLudc+X5q0Tugh7Ii+/uSDyyKj?=
 =?us-ascii?Q?AfiLdvh9hlTFPiSdRNrb52X35ltwrluW0ryHHuzjjyUx2QTFQOfsLk8VZaiT?=
 =?us-ascii?Q?tmzsvmqmhc0pdvhOBCl/zXW0g8DU//2aJHrklIaYHIRYv5SXLb8PCvYs7HWm?=
 =?us-ascii?Q?LDCSdmHdyJ091XBkfz6tj28we25KhXunzJ+FT9WnkVTk2CLynHrzQURuchoX?=
 =?us-ascii?Q?mA5PVCRaKV4OP4ILLjkftEmdQdCLVFTfRvKqMvX0dH6729oTaA8O3FyblyjQ?=
 =?us-ascii?Q?6QzS/Rp0xd2O3i2Cw68xpZEtxrLt0WDYIQa7JdLPJ29eYrQXxm26sQiN0wvB?=
 =?us-ascii?Q?hI8OU4DbB7KXCz7dbCYYoAH0xr6JagVCOnzSckkN8njUoGIMaMFuc8/HWVEI?=
 =?us-ascii?Q?ZrBqXsl2s4qrIPgEs+cIxav0GjFHGDKu4CBLuTC65yIV9UzlvRHBbLfdFNJE?=
 =?us-ascii?Q?Ncmq9JPJn/GRJf44RlPQ6se+3St5Gt8y5ja2tyM/prLhqX3h+bblIaWu4sVl?=
 =?us-ascii?Q?zFERJYRcJmcXVeCwv9XX8IcDo/YIh6PuPOaXp8dxFfKu8xDUY91G1yQEJxV3?=
 =?us-ascii?Q?9IwyWOH8XXhRY50J+KWdGhBDQvf0T/0Cb/XF7DzbAqFMBa3qBc1uubdP5IOj?=
 =?us-ascii?Q?gBTf3f/5h99VDEh2LpNFaUlPpC7bhj+WDdb9yqLoJhMw37hCNfKFMTkhV0iN?=
 =?us-ascii?Q?BeI/dVUzCkyE4KKNt9mctJ32XUN3of31ahZnVOtdyyCR0W1sjaBMwxsVdJMm?=
 =?us-ascii?Q?T8ikugKTJvYqhqLcjD/6Lp95BJvtR4ZqoaFO6irWdilB10+vB7jPkBp5+Pv1?=
 =?us-ascii?Q?1xS2Lk8RY7tGhK8BbJhpwbAio4xS7N6TNXdXZq145to47TeM0xAzpRQ3t4M0?=
 =?us-ascii?Q?fP6tCcfi+SwivaqBJop+ftN75bxq4Pi+5sH38yBVoVmzsjwhGFmAm5HTi4hv?=
 =?us-ascii?Q?8Vmp6E+C8g=3D=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcdf772-75eb-4062-b21c-08df155ef106
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:29:22.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbNjar8Xpw6jPcDpzxTi7ImPyUaLdDXYQzmFjVcnDVGSffDsqAdrnnvzmR6GZGS4dVTA+ldUgy42QYeuPsrA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF8C318BDC3

Hi Ryan,

On Fri, Sep 18, 2026 at 12:36:31AM -0500, Ryan Brue wrote:
> ocv-capacity-table-N has been capped at 100 points since battery.txt was
> converted to YAML, where the limit arrived without a stated reason.
> 
> The MT6397 fuel gauge is characterised per temperature by a table the
> Amazon Fire HD 10 (2017) vendor device tree carries with 126 points, of
> which 122 are expressible here - the remainder are greater than 100%
> discharged, so the binding excludes those points. Boards carrying this
> PMIC fuel gauge would need more than 100 points to describe the pack with
> the generic property. Raise the cap to 128.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> No kernel change goes with this. power_supply_get_battery_info() sizes each
> ocv-capacity-table-N from the property itself -- it reads the length with
> fwnode_property_count_u32() and devm_kcalloc()s that many entries -- so
> maxItems in the binding is the only cap on points per table.
> POWER_SUPPLY_OCV_TEMP_MAX bounds the number of tables, not their length.
> 
> The consumer that wants this is an MT6397 PMIC fuel gauge not yet posted;
> its pack is characterised at 126 points per temperature in the vendor's
> kernel (Amazon Fire OS, based on Linux 3.18), with 122 of those points
> being expressible with the generic property (the rest are greater than
> 100%).

Allowing for points > 100 % could make sense, but why would you need
122 points up to 100 %? If the vendor kernel has several values at for
example 20 %, then a better solution is probably to take the average
of them.

I think only reason to have multiple values for the same percentage
would be if hysterersis (see for example this open-access article [1]
for discussion about hysteresis) is taken into account, i.e. having
one table for charge direction, and one table for discharge direction,
but I don't think any driver uses multiple tables to handle something
like that.

[1] https://doi.org/10.1038/s41598-019-51474-5

Best regards,
Henrik Grimler

> ---
>  Documentation/devicetree/bindings/power/supply/battery.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index 8ebf05d9497c..a6d4822f591c 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -154,7 +154,7 @@ patternProperties:
>        of the battery and corresponding battery capacity percent, which is used
>        to look up battery capacity according to current OCV value. And the open
>        circuit voltage unit is microvolt.
> -    maxItems: 100
> +    maxItems: 128
>      items:
>        items:
>          - description: open circuit voltage (OCV) in microvolts
> 
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260917-rbrue-suez-upstreaming-battery-ocv-table-128-9ba83f9313bb
> 
> Best regards,
> --  
> Ryan Brue <ryanbrue.dev@gmail.com>
> 
