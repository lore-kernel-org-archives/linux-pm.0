Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF91311940;
	Tue, 30 Jun 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854005; cv=fail; b=MpOmKXlVXaa1v1CH3P1dtxepAbhSkRfsO3hN2NGFn0dAfCV2FDNns0gKRv0OHQnT0gZ/o5Ucgrf7SW3uwvnXY6pXYAjIduD4AXdTAL7eZ5JFOC+8o5a1Oe5igNY6NFHeTSDtB+2baakxHzWoM6tXv67DMQ9cVoKP0YgywR1gUco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854005; c=relaxed/simple;
	bh=t5s0kUp5YdCB8L4s0WoXYywT7pwHv2qjhkDndyWZupI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co2n7LYCJ9K9uQRAqlj+0aeKoqeeq5onyy/bSB+9+JQLKTtSGfPp8I22sSdEoFsf4jUWp/WUqRiwp3EJ1sYzD7+2g9vjBTxPniwiCTo/QYJvd/9rF/RCFAjf8N8swpTEL1ZO72DThM2CgRhJZoJh6t2lJWANqtJ+c+i9k0P+MbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Pm+MIHy1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PtTr0Ywt; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Pm+MIHy1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PtTr0Ywt"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65UJGCtr1617025;
	Tue, 30 Jun 2026 16:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=TBV1b2vwCvcssGA
	3fnIQ7TWFXoyv2hBlzvVub0qW8hs=; b=Pm+MIHy1jAHV1vbngN/xd3LLZ/wbXAf
	9wRG77B1tQbh7v8yCiM7IIKVUe86ccnfFx8rMeyabsuGOEEYN0UPcPH0MDmAaOZX
	FfDpxHLwTMcgBCdMhn7fdhcsC2qZQe5a8Ona12COk37EbXG+nmfdYJfPBS6yjS0N
	SYXH6Sqttob+FZw75Q3DQI41Lg2myVtZHf42Z6s4p7Umfi35SYJkP2/Ze3Cs3Lrf
	cIFWAs4Zkxby4oNORjFwVyLwuOrIGen8EtMsFPOF/qrBYf59hzMF0GN2OwJub2Qr
	zLXOcyGHLCVuUCnYX8rfMQmnWmabCjwWN6rR/G06M4Eb9lJhQeOqPZg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	by m0380145.ppops.net (PPS) with ESMTPS id 4f4cq6uary-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:13:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6ban8L6496ZUrx17W8XDpFW9qPFqo8XYQ5JOtNYqm95xYkwnU+N3+PH+5rgP0eV7Tlh3Z2jm2DmjTXPEt/qjxIk5paf8nlWn9cawc4N00VlHK1A2h8ox1FGEeFaIiCwcgQ927H2XEuYHxqSg9HCNEls2ZID1R7eL5XHCqsGeUFqBMMToQF1h5/308OTzWO6QBcIqpiF0qHHJJoSw1IB0Rbo3Mp9CeZw2Ux6Qb/BxX9RcAA8MgJ5/6/N7HnklpaLALK549W8oRB0rf0Wg0evRw0z7ojTbr0FOjeWH3sx2tDf+Ip33DYBsb2ga82TWPCINW5+9A2aF4G5tMXEEdUChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBV1b2vwCvcssGA3fnIQ7TWFXoyv2hBlzvVub0qW8hs=;
 b=Nsxg0/UbbJZKhbswLWh5uJccRPs+AkzYmzgovkEl7nz+zxT6k7D0d9qZ1E8Xwi2k3oCu04xHxdD/HBhoSFGMyYHwlqXJs8WYc+ASdk56OBwjPZjn5dySTzybIrlD1Cqq5q5aNcP7zH8wcmjGIoOx/QMdKb2UeFiGZulOqFnZulqAHKW5D6lWvRqgpZ6hTJxiz/WJo+VtJvvaGM6Gp5jlALW/YSh+8X0DbhVmQ7YluUm3S14aisPsbRSdDhzzJWdnoFrMY7CeSnSUKB7fIrGwTICM8cxqZ+W4qCJ/GGKn06JkZtHucexHmG1vqHOL6WiZxOIxufsthwz/hiCGIyShQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBV1b2vwCvcssGA3fnIQ7TWFXoyv2hBlzvVub0qW8hs=;
 b=PtTr0YwtGHTQ5pGvi9Y9qErZJUJMR+Qudghxzcl+T+YrvfkUWc1faPpFOny0qTOdIEI4r9ZWTaakK1h01yQxLdguiB40pp2o6a+7vBnJx+p7uhg6x/++1SfssKxY0U1PyNP4KcqliVRPs0Oepr3y/IFFiID/kqshvaLdOo++epY=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 21:13:15 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::4d) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 21:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 21:13:15 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:13:14 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:13:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 16:13:14 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ULDE2S3412732;
	Tue, 30 Jun 2026 16:13:14 -0500
Date: Tue, 30 Jun 2026 16:13:14 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] pmdomain: core: add genpd_for_each_child() helper
Message-ID: <20260630211314.zf67gkb3axounykb@uda0506412>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-3-75d69438518b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-3-75d69438518b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fab020b-78c3-4a19-1cae-08ded6ec66a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|3023799007|6133799003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QcB9o4RbXMR8UaAPhfbtJIrytAt5h47ZPPaoLoZNgBCPQl7ZSwA+B58MmwqxSwfIYCN5wjAmERQjMQTFNXjWbxKUaOtiWZW+FGDtGv1bl9PK/LIijIOe3792nU+wwXOms8nAsmAT6u+ZepGYpVpsj5xgSzaxeCxuwRGaKEqkFTcvjI+pfSVSGsKipfgTVIRDmpk+E5+KESogV4R9T/ZBDbzce5FXPh8YisUvtwjoZdDf/xJwflWvfy5YXk7c7s2dwIf48bVlPxqPv0rQIe8K692h6GKt5apieycuMJ0ZPqah1VkbgBAqZrNq/3fhTGE1EJJnvi84TBC8uNWWzMXC+x53fxRMxA86n63Fh+/R/8HInX9590G6XipU93qUith3vYarJzJNqrSPSipLJoPiM0ELBW1D6+SyI4+dMcw3XeLhOC+8MJmoEQR0MZ7ETQbZPTGe6A4/PhSsCff4CfKYZsG8KpXPE7qEd/nO/xtnX/U5i8oivBMosV+o2TvyMTxOqEsCW4lCfpW9G0hOsO5h9pQdM6fsiseEGq0ml3L5U8UtUvY4cwePTr88RmMBFiTB6rnJPdC3grY/+w2+P71IetIQq/GgI32d6Hzpgh4cBNtPnKHQkSqtyCMeigBj3kQwZbCkdOybC6MlsMTSvLkyVx+UvV3nm2f2dUyxTh37GIHrZb5r7rfwWapoofHziPrNi+iFVfprE4mDrsKUIWjmUw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c5mbB2X7m0NIGOEQ1yX8og11+21QGb6hkaN/0hEBye8ktJuYw4TgJQLtDJsgZpYwjA1b2oeXPthvGHzXFESfnNRc1gODdrXtL01ZdFbdSZvbOBxRDCnEGtgn5sbuMtGfcWS2FDYivoIn6PWWT+TsW90MmsYLIteaa+v6yeEwAcBaHrmFOhe6DMBMhBuXsv+Z066ffmcHl+hVFMLMpC7msS/n+QZbVZogPVFHH8+yRQv6/3ur8QC9Pg6K3lKXpfLJRW3MINQIjw9Hav9nu64CulE1mFs8KdtK9VLGXov3vcG8/aqLxuGPd1XZo0uXPF44dK/bZQLAoQsYjf3wvg8xWdSjmjkJenNnp5XA0Oj5SSkCB17Ybvgf/4Uuq95vrZVrvFl8EVh30tvT4Xt32iPcFESjLaesORNvIUGKB4H0W0JnaVAUAQG6CpRFq6DdA3tH
X-Exchange-RoutingPolicyChecked:
	ie5l9aMrDoo2iDzFEzxKD1RxmXPavLruFcHLb62iugqati1WDGHeaGLFCVXUJ6SRfbUOuVr5ve6dvXJtQN8Bd2j34QHX9yGiMlpDYKasK9PyOvd31hEBTHs9bDy/yusKtXpUR1C6SRoxyV4+YJwhVD30//XshRbEin6ACroc1SgQF+ZzF3Nx/LGxY66k0+FNSjS0mMvHwjY13XHXSW7aO0fby261C1j/jAxSnCwERLphdJQMiqlOchAFmC+vbSXFal6zWI9sq5+VxYG/K+T3ebA28hJK7wRNd9AdWt+GSX5MMJ8UEXNBPjPjOXbQRAczKB032kULcO7PzmZ5OB0Y9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 21:13:15.4485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fab020b-78c3-4a19-1cae-08ded6ec66a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-ORIG-GUID: OuUUQAv6A-wCO8mdU9jvry9hCG2tnm1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX8iY2NkR1zj6a
 7L9Eq5v0t33IHrlad+1QUnZcMOPW7nuEvEPVf1WtITULAbJ8kpv2HlJiZYWnAGEJ9u9KSs0cBrr
 z80zHXAbHsSAlI4qwmiJV3d9cVj9U/7OOGpse8cUO24exPeOjOp96AZuy8cXqV1dgYoCDcZL+mC
 iwZdRjX+5MBW0SHEiO1KnCB9otli1pI3Ek4pSZidsSJtFI8JloUmsQOUIv98uzMFJL5o+ixgEX8
 SIRYBqtmcCyt0UWOSS52TSYCLRkBKDo6c1uN++zeNbLFLihT8GiVgxpL9huD3DPErYqtuAaCAh5
 N2+85ARFjtcg1FvqhdemXrmCmicV7oAnrddIlKegigIczkwzRFA/HBe+5IVRRlM/xt0wixUzx+r
 L3XqElbUlN7X5w1JfmJILh135TmduTwzu5Xd11sFCOZ4j4ehdIlugxS3J2oUKvGVRXxzAldamdp
 ViXnYLd1PFQD27YaeBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfXyD6ZdiAL77BD
 KMAYd7f7FO+usMXHviOSaWfJvW/+987l1UcZx01ClaMKABT+PPE0x3EvNMkSz32eUTUNHiEZ/FI
 18sO8/riWk6zd0uL6vsFfaUUX1IGeQM=
X-Proofpoint-GUID: OuUUQAv6A-wCO8mdU9jvry9hCG2tnm1u
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a443170 cx=c_pps
 a=NtDnjKqRhcbz7rYDj/0C3A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=IpJZQVW2AAAA:8
 a=0vb0xtBZJQso0sRTBO4A:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300205

On 12:59-20260611, Kevin Hilman (TI) wrote:
> Add a new internal helper function genpd_for_each_child() that recursively
> iterates over all devices in a PM domain and its child domains (subdomains).
> This helper is useful for governors and other core PM domain code that needs
> to examine or apply operations to all devices within a domain hierarchy.
> 
> The function takes a callback that is invoked for each device, and supports
> early termination if the callback returns a non-zero value.
> 
> The helper is defined in a new internal header drivers/pmdomain/core.h and
> implemented in drivers/pmdomain/core.c, making it available to other PM
> domain subsystem components.
> 
> The first user of this helper is the cpu_system_power_down_ok() governor
> function, which uses it to check device QoS latency constraints across the
> entire domain hierarchy.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pmdomain/core.h | 17 +++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 52ea84e548ff..347bfb7db75a 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -24,6 +24,8 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  
> +#include "core.h"
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>  
> @@ -281,6 +283,49 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>  	smp_mb__after_atomic();
>  }
>  
> +/**
> + * genpd_for_each_child - Recursively iterate over all devices
> + *                        in a PM domain and its subdomains.
> + * @genpd: PM domain to iterate over.
> + * @fn: Callback function to invoke for each device.
> + * @data: Data to pass to the callback function.
> + *
> + * This function recursively walks through all devices in the given PM domain
> + * and all devices in its child PM domains (subdomains). For each device found,
> + * the callback function @fn is invoked with the device and @data as arguments.
> + *
> + * Note: this function is inteded for use by the core and governors,
> + * not for pmdomain providers.
> + *
> + * Returns: 0 on success, or the first non-zero value returned by @fn.
> + */
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +			 int (*fn)(struct device *dev, void *data),
> +			 void *data)
> +{
> +	struct pm_domain_data *pdd;
> +	struct gpd_link *link;
> +	int ret;
> +
> +	/* First, iterate over all devices in this domain */
> +	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +		ret = fn(pdd->dev, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Then, recursively iterate over all child domains (subdomains) */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child_pd = link->child;
> +
> +		ret = genpd_for_each_child(child_pd, fn, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static struct dentry *genpd_debugfs_dir;
>  
> diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
> new file mode 100644
> index 000000000000..7061891d31fb
> --- /dev/null
> +++ b/drivers/pmdomain/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Internal header for PM domain core
> + *
> + * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
> + */

Does the copyright need to be updated?

> +
> +#ifndef __PM_DOMAIN_CORE_H__
> +#define __PM_DOMAIN_CORE_H__
> +
> +#include <linux/pm_domain.h>
> +
> +int genpd_for_each_child(struct generic_pm_domain *genpd,
> +			 int (*fn)(struct device *dev, void *data),
> +			 void *data);
> +
> +#endif /* __PM_DOMAIN_CORE_H__ */
> 
> -- 
> 2.47.3
> 
> 
