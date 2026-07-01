Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F2370ADA;
	Wed,  1 Jul 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925310; cv=fail; b=VS9Zv7A8gQigsUtPLkzlhom9qrLb22If+lQIRmT/Gf7+vQMlva/zv5RNBl+6f8AhZRXJTFFB3xAHPRf5SWI3i8uRMHTBaNXBVabDiJ4TwhZ5GDOuJA9crjWR6v1eZTtvJC/zEQh2Q+GWrExDz/Ibvoicu4eH95UGBmHhjCQYfGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925310; c=relaxed/simple;
	bh=0oJ67T28xcKUbn/lid/tIFx46RL+NBVyXX0GTmIUFVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEJnb4cLr13XQD8+bYpF1K6KyyCz2Dt0L5waoPyicfSxnyazWbuEK0aI+VhHZydiaLUyD0J0qPNUXUfpHlUhhsyHSICQorYXc3VL1ryWvVmN52m3yXB0J8ipOcv+ovRls5uS65mcvHBM7wUBBIXj6ghKBWxvm/L0r/t3ONjK998=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UacWjBQN; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DYa5MW8/; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UacWjBQN";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DYa5MW8/"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 661GpcIw053525;
	Wed, 1 Jul 2026 12:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=t9OqgAsAAATgx6H
	HPOiI5k7gPaUZ0UH1z2syqTIyDS4=; b=UacWjBQN1ona1K+c0u4g8e/1zSbD4I3
	9TuGVN0tjX2TzDKBG6wNVv+4my6PqFBpqu71tmXCsDtnxqpdyyX2nMvoFRdqMgVh
	RKURyukYXo0KT01/EdVQMETNJmDxO3HsU0YhnHEw49L++GVcYHAnI57V9E2mFaqc
	kC51wefQzHMBS0wEidiohPsclqjvvG5MM/28F9x8mBPQHDRydtJBl6xEgkVro0Km
	u1NAhSt6Hg5HlbDBBGtNAqvpeDdz4t/iHLYbdQjI53yqkc0F0+V1drmiq4OeBMhO
	USnAsTnAPTnhh46fm+wZG5OlzCPiwRZIxMoSJBD++Thg3USDnpP/CxA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	by m0380145.ppops.net (PPS) with ESMTPS id 4f524824cu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 12:01:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF6ZF2ETy+7mzoUhErP+S3O8LlQbNnUFa/uPR3O1rTzDm7Z3j+b/MLXkYMLJlH8gOonZhTv3GIDO7vb90aJp77C1KHAo83+u6cehRmyRdWRZ/cSiNkSMShSP3VcLqEjD/m2ycDo1vR5X3KvpKUPMefcH7glSljdYySGODbUv6xRaXvzo1yN362MBwb1eQa/AkhBoK+cDOWF6QWzlXn+ktfQj0PR9fDt/8G7v0JGj+0SI+XM+VyGd0hYiyiJBVD+Hc2tVO+bXdzatFnhFwbCfG0HPTajiN1BEKBNTotfOcLXX3MmZHeZNlCyXCuasM3uHdcz4OKSMGQezf+31BwlJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9OqgAsAAATgx6HHPOiI5k7gPaUZ0UH1z2syqTIyDS4=;
 b=QAmep9I0oMjmbA0HTdDQ0mfIJPDFfqTVy2L/iwyg8HTFJ3i3Xc3P5FejfVmcT1UcTUhNBAj3rr1MY2gtV9yWyQI0DDjO/dzgbVk5tHyFLP4OLA/FtAoKhUs7WPV0XZs0ymZnSiHup1eLWy4F5J+4kfPlFqIfm+2vty9RgLPqzGok8uHGlQ2J8gCWa1ZYYFCBger6PK6KHKxAEu0WMpvE+S119deQnYwDLmXkKsDAszzTV2OYyi0idOIQUdPijWD1n6cOcuxwEOseSUyJ3OICzhh0vRa3ZHLpSB7arNOmIFcHhRrogq+hgV9hsUGFjJZzzIVY8QAX7UMcNqkRiAEglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9OqgAsAAATgx6HHPOiI5k7gPaUZ0UH1z2syqTIyDS4=;
 b=DYa5MW8/eGtZiYbkrFgWCAT7TY0+jmU5ESMVQGon2jXSlDC6iSRk24IJqtvWu7mOTvAaA0CsI86D2gz7V2TA1G3BdvH257SgB561X5BMc32//PmV/wLTSvYNIum4S6yvTKBeHoBQ5IgfGHt2aGPykabKvL6+KMzfuayGmDt08mo=
Received: from PH8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:510:2d2::11)
 by IA1PR10MB6686.namprd10.prod.outlook.com (2603:10b6:208:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 17:01:43 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::92) by PH8PR15CA0018.outlook.office365.com
 (2603:10b6:510:2d2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 17:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 17:01:42 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 12:01:22 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 12:01:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 12:01:22 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 661H1MYV1842617;
	Wed, 1 Jul 2026 12:01:22 -0500
Date: Wed, 1 Jul 2026 12:01:22 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] pmdomain: add support system-wide resume latency
 constraints
Message-ID: <20260701170122.pwiyr7yz633miv5g@uda0506412>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-4-75d69438518b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-4-75d69438518b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5edc11-ac87-4de7-a4e4-08ded7926cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|22082099003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	nJ0dpm4FtADaRDQNFAAvKtm51EI/eHiSI0/DRcXRy5VzN9VOLnlc6P/Z0FRxhhOoBEjXLMGIUh6DKLs0Ir0O5iQX85rriA0+YcRXfILb/0jr6YsL8bV2kxs1Dh1+fDCAir9bAjZZhqk4rSfpc37gB3iYqlK/5fH8YXQJAcSGbZAh+XirQGJbCHhKRurxSmVjV25QIJt50zgVRNf6SIRwPNl422ApH5j6H4Qrikajjt6gPOteus3uJ/K1N/Q/wj3muuz24rCIRaA3fcTOQsM4cbE/0qUDJlbGH83TJt+j0T5RY4dBOaxECUyuQSHoZRZAeBQ/ta3snplMEn4BPtMR/OWiyk5VnNPK2afB8sXvLX1vjwLLJS6CI9XE1LPrPOiRx1KCHF7zy2Z9p/l4/81wGrrFaxEHNCGTJrmn4ZpCCZk943BRf8ureembYKwxNgO1mjduM8Lach9arEdJYo8bH/pvLXq00zhHJKDpPpZHWDO+ihKKbSpj4Gk+4bsuiJHU4lwpw0r/X52FOjRRQvaNidSK8TD1Vai+GCR30kg+A5stETirhN6xiRIGFshrZiUDM1aIUcsnJHl2j4quC5d4y1t5CMYyNvrWXpNdW8egkezAO38froTPUtiEDT/GBTPK/oOh0IHJf9unACfDVD8a2v8p++UdbryJc9tpsSetsey2jPt5P5173yRe9f+JGa4pjwY5Y0O3HvccuEGP5E2gpQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i5yoIjIk+7dOTVlYyi8yFPdEjPYWhVrkXsasgdGHHz4iyy5+P4zHl3MCagBgTUX20g1HLR1x4ARZhuboLsdk901GXsRPqwPFPz7sf/VGpebYjfbu33Yf+eQ0r1Ca8YlLYY0W1drWqMlWhFmk3xObxdxWQMWpDd/RYm6s4xleRQx4BMlUUM/FVu/0wATT8bGZSfaCx38AT4ttJ8+QxA5FMRAwDSQoveU91X8dmmhnfn9p4LSseftxyUJTVQlKYzUUEcAVaz507EdcgaynEHUpw/n5gJD5pYAVkSYWvThuP/+yVn3mQMkKy/jvkAVXrMiAHWs9o2t2kWv+Lahl5JOW3X6Z4Yos3vkah3Q10bVP9wQ9osiN2zmtcRXc4HbYISKnolWQ7NfuA1ImLHBMDPEZgMXGdQ3xvt4Nzt3FEAA0DTE13jDjaOlh/rVO6ZkbNkcY
X-Exchange-RoutingPolicyChecked:
	tAXMtNR9KUR1uQmpcw83KxDcVis7dHQwIViFNK3PSNmRCEzstN4tKPXf87HlBUDm/xwRmgU/lnl9vgBl11D0yJ4rPRon6gyzb6feyIPv5XyaFZB4M9gY/8qzaDmuoFSu7N3Y5wvLaXqWozwufBaSug8AQ9v9Bdv8LRgbKuFJ0NlPTDCKQ2A8hVXsSxpWoj2xNvodS4yiFrQb7yI4uEPwwdCGPE+uZTGKIfKfssYU6I/35vmYiIYOGfwryoCaWkhfUAnMGBMe4IfgOdNwUp3/k+8FXjVVEa2rD7uJw+jV2qomlyxfKPPQu1NRbYhJaurqpisCgRppSYp3vRU17sOU8w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 17:01:42.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5edc11-ac87-4de7-a4e4-08ded7926cf3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE4MSBTYWx0ZWRfX/mqq2Zy+pOjA
 7E+GpaztCTp+Ou5r2HD9TUKhtS7dR+Smfr7dIeEEgnJb2xlDT+dyIf9xijUxdFmtrdJJ0KpgvjB
 5ZPfs/171Zmo7b/wWXJhQtVgmsK2G4kOwhRzWYl+HHsoUUti0fkG9ui7VbPrO0cSQdH44RSczkA
 3Nym1foQ1QVeIyfUv5J7qbZaJFkq/WbaUVDxLA2s8ZD4n+3r3IFasCOm1NrTQKEn7z0SXfmmJKC
 3AuHKFDQtacrP6vran7eTU89Mj8UBGIY25eE+va2d5cxdB4U7u9TbYQXk0yi9Pzdy1aF0nAX5dS
 3etNm/2nU22vcsWksmvRaNEYOVEqG6VdV3DuemTz5mVnuLXkOv0uEih9B4Bfqn/TfWrqRJ7RM9U
 2ObnKTAx+peQnJQGSqB1Gs4kXtX5Gcfej0zJg9H/jjS2GEI65s998PoxStQJKp0RDpwtHbHA0nj
 e1VoRUcd8fM8psO6b1w==
X-Proofpoint-GUID: yvCEZrf0L59MDG9XDCFfaBbDGQnWlEtD
X-Proofpoint-ORIG-GUID: yvCEZrf0L59MDG9XDCFfaBbDGQnWlEtD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE4MSBTYWx0ZWRfXxfRlB0CV0ArC
 kBNW5GbT6ZjoNlVJiMhogBQGYl4fnhsCstbiRId+zYi7BpzRa4Dn73pJisVBfAzp/SKuQwKuOCE
 fTy5FKIwTgLdDAeP1QFb0D4Jyd5vxHo=
X-Authority-Analysis: v=2.4 cv=EsTiaycA c=1 sm=1 tr=0 ts=6a4547f9 cx=c_pps
 a=fq9WP/vNXoxpaIAZvvUcmQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=bw4GGd3sH6Bj-FGFOR8A:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010181

Hi Kevin,
On 12:59-20260611, Kevin Hilman (TI) wrote:
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
> 
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.

nit: s/constratints/constraints

> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall

>  drivers/pmdomain/governor.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index 96737abbb496..1a85fd375db9 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -13,6 +13,8 @@
>  #include <linux/cpumask.h>
>  #include <linux/ktime.h>
>  
> +#include "core.h"
> +
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
>  	s64 *constraint_ns_p = data;
> @@ -425,17 +427,71 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>  	return true;
>  }
>  
> +/**
> + * check_device_qos_latency - Callback to check device QoS latency constraints
> + * @dev: Device to check
> + * @data: Pointer to s32 variable holding minimum latency found so far
> + *
> + * This callback checks if the device has a system-wide resume latency QoS
> + * constraint and updates the minimum latency if this device has a stricter
> + * constraint.
> + *
> + * This runs in atomic context: for a CPU domain the genpd lock is a raw
> + * spinlock and the s2idle path runs in the syscore suspend window with
> + * interrupts disabled.  The lockless dev_pm_qos_raw_*() accessors must
> + * therefore be used here; the locked dev_pm_qos_read_value() /
> + * dev_pm_qos_flags() would take dev->power.lock, which is a sleeping lock
> + * on PREEMPT_RT and must not be acquired in this context.  The values read
> + * are best-effort, which matches the sibling cpu_power_down_ok() governor.
> + *
> + * The system-wide flag is checked first so that devices that have not opted
> + * in only incur a single lockless read.
> + *
> + * Returns: 0 to continue iteration.
> + */
> +static int check_device_qos_latency(struct device *dev, void *data)
> +{
> +	s32 *min_dev_latency = data;
> +	s32 dev_latency;
> +
> +	if (!(dev_pm_qos_raw_flags(dev) & PM_QOS_FLAG_LATENCY_SYS))
> +		return 0;
> +
> +	dev_latency = dev_pm_qos_raw_resume_latency(dev);
> +	if (dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +		dev_dbg(dev,
> +			"has QoS system-wide resume latency=%d\n",
> +			dev_latency);
> +		if (dev_latency < *min_dev_latency)
> +			*min_dev_latency = dev_latency;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>  {
>  	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
>  	struct generic_pm_domain *genpd = pd_to_genpd(pd);
>  	int state_idx = genpd->state_count - 1;
> +	s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +	s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>  
>  	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>  		genpd->state_idx = state_idx;
>  		return true;
>  	}
>  
> +	genpd_for_each_child(genpd, check_device_qos_latency,
> +			     &min_dev_latency);
> +
> +	/* If device latency < CPU wakeup latency, use it instead */
> +	if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +		min_dev_latency_ns = min_dev_latency * NSEC_PER_USEC;
> +		if (min_dev_latency_ns < constraint_ns)
> +			constraint_ns = min_dev_latency_ns;
> +	}
> +
>  	/* Find the deepest state for the latency constraint. */
>  	while (state_idx >= 0) {
>  		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
> 
> -- 
> 2.47.3
> 
> 
