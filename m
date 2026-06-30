Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C62FE057;
	Tue, 30 Jun 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853889; cv=fail; b=Nhs2ofow4zmAVGhU/LkVYYvyQgxnYg9h6z2an/bxV0705G5BC8J8Rd8ALknrqCEeiEvG2GT6m2FSsUaCV5X3tGM8DiiyQ1HA2FtruVavgPruXyCN05I5cNh9llw15P4NXaTywVNc8+w+aT6sfrznOzgs6a52WDoX+ii57e5ynus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853889; c=relaxed/simple;
	bh=/z2/vrTY5gF29I43dMwtuQakDekfeoQnaWYRKl2FNFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b45h3mLgM0gTtfS5ZYq0bvALTQBeeB/OqHBKdkW9k/n6gFxdcesZ4foV6Ro6+nnCcR5zLHmKF6wJU2j7FDMe1CH+ltx0RmWi5ObaxdSZqgZ1o1Smkg6QathHosTwzMIfqIBvQD38lY+pPBEXDoYn0sJhbsOkkOCLq6tIU0AVojI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=cFIlX3t7; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AE1hkPAm; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="cFIlX3t7";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AE1hkPAm"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJGhMI1634179;
	Tue, 30 Jun 2026 16:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=ND+I0I3XSYF8eoL
	/b2+0GRXj7XUF2dalZAEXhDjS7X4=; b=cFIlX3t773ndPklLNavXyUupl2ZwPhE
	Uq6R+METiuSw6jTClJNw9PxnqRKuZXjvhnE9cY5z8Hr2d9TCFKHw9/BahR3N9les
	7eYf8yZ16QecMIfvGhPGYZOodWoFtGbg7nApl8+rknt8IpEh1DHXAWDKo74b2qsV
	SBuKivIajvv5o7N3zujIXZ1E1unQUY5SDQ/PyrJOrhX9HX3VSltbXA+bn+DnI8cK
	o4b3HA0AnTOr8wUfZ6q6n8rlOS8/uzQcW0aIFsIVQGhbpy4ctmFUxqZoPmiXUflq
	I85nQ+bbhtMSRzlLH83SraKO3E8lb4xvnvgerlDKTU6Pt9+TiZp1UTA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvub04-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:11:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTmRD4naedWVoznWHUnTbYxwLDMl6rwZK//wBOLKPnqxZMJkG8ymrn4KNa1x7RYFOAOwVCHWVvopFhwI9x9HT1OUcLBhGt1sjDBqb1LFX1siSqlIk4HF1p2ZcDs76gCD/gUsb5kSey5Vesv4RUzNby2yg1rz/hoDWChYA+NzkiUYzEeBq/f0e70t9wHs70xnc90gEw3InoGEjhAgSGq78iVkp2GqKWU4Yo2loqE8uTKkXOABxUhT+Awh4x9Wahrhbyn/youzUx6mqimhOex0xMkwNxbw26gGLJhRlmBibdpZzUdd40disOwnb1JdDB2IIaUPUR6OSOUyzZxt0tiTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND+I0I3XSYF8eoL/b2+0GRXj7XUF2dalZAEXhDjS7X4=;
 b=ja+fdEUAsX8sLOqGJDOWxT0413DwZ8lt+aPsLMKICcCHVMN6qpe9qtUaOirsGqh/PpsBfxsHoN3PeWsAmmgHTAYMINxXSLbOwu4/znJFOBi+4BJPp3bIBDt3mwIJc0LGV+YY9m/VvhfOxt2AFT5gwYcVuD3N/Fx9wcME0YJD8H9QrxL4KU9zFKF8GfdhtBEufWDL2vNQp6e+dIBtaZPS226FelTXRH3jDM3O25fhs9HVmrNc0bbZOpOurqCvha6sz2axMAalPFdYRpA8cSlNX9SJaRse5P9mvKSvn/BqQM4rMCxlKY/wiUxH0Jt5Ib0RL2UzF1/9LNMoW6mo7U+sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND+I0I3XSYF8eoL/b2+0GRXj7XUF2dalZAEXhDjS7X4=;
 b=AE1hkPAmQ/eJnTQB/EPXd2fhfKNC9j+Me9/g6Pnl/+C5+Ha453bJV8nprPqohrl7XSoFFGimW0S9s2Tknyj60GGPYypZ9SQtkK7oYa6wPUXfTUfepCUbqlQ7Bx9BnREqT1YUbVq8ts1QLpLCn4ZgK+g2Dr3wMqVsgpzLptQ1Cak=
Received: from MN0P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::13)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 21:11:14 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::62) by MN0P223CA0012.outlook.office365.com
 (2603:10b6:208:52b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 21:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 21:11:13 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:11:12 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:11:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 16:11:12 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ULBCkS3409443;
	Tue, 30 Jun 2026 16:11:12 -0500
Date: Tue, 30 Jun 2026 16:11:12 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Message-ID: <20260630211112.eqagovk2y5uhdbkw@uda0506412>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-1-75d69438518b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-1-75d69438518b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH0PR10MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: a9321b37-31df-41b4-4df8-08ded6ec1e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XhX/GxxhQxVQtJEigR2dWjFvV/4KlKN4GANCLa/NYpkRjHeEBezzcKSyywTSBZkebBFV9C6C1yewiplnrPo2uOY6rBxGrWBneUAXrethbKIj4dnL6GFjZr0/oqWeHl6XLUVk9qsNuAxX0vaDOM1CWjT/v5Kge3CFbheh5GC0TqJZTxtl8VKAppmdNU4aQoncjQ7CWkCW+McpiHFBJJ+TQyuDg6yfNnCUQGvwsHl4Ix480LMWr6iSMtaa2xH7uUx5JltpzfwPtjd5uMUFQ4/w2laCyAg5ym+yHS6iyF+Oih63809cmLp2GzWnbb95WscpTqLJkCHuLRA3zoD3vF8nI0+lA7xf/29QgZhkCE3IErV1M0+nVH503JT2hu8n+RnjAnc8s8nc+jZPAFlMnZUv6zrRbo9Szoh4KmYM6cAr09D1wc3T6CmoHu4Gu6NLC416yYjTCDr0mdS9ynWPZCgbyqHTjRIzA9V0duDBT5c/tThML3gifR8o4F1XOB09x3EwQO9rpAyLgl5ks2EmDMK/nz+w9mA9+QDI5YPIOkt2/g2Xnwf2INCrCel8fMzM23iKnNfswqFIDJExViFgSUcV29PUuaIjOHfgJsQizhDOIWYgnddem/RhXN/iTOEJwNp8rr8NgfByXn+bDyG+g9pP1iligd/m253YAFScP7Pw/uxPplZD6jw9yx8NMsG47lnnwi6JQ6wTV6Eu7emjS9I2fg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TdGPus1gnvbNU/G/Aa0Vn6BVHmv7QMDpwyuRL3SpyoORefmzjKcjx0rJT3DChcZmpCud1wqK5sEFghgAO2x5fWGEmp6T2sO2FVYqeSbT+HzN1beLj7L+ZCU38qEqzBgD76E4593UmCZDrd8b1w5CQORjm/wvpmmQsfvE7EAh/DHHn40KublE04Nlx25jXw1j/wauejsV79SpGM/PsRWQFzszH+rCiIwcQfhFVaS89Cwu7d9GP2JPQRebNNtIbWqTP5W20oLxoi3vf97zRwBz6uM4YgSZGfcCSVsocF5T6YssBv/JITU3HtddT6LQWg4L3kS5L4v9d/8X4I8GK2AZbE/JpPAV2rNXl/9w8ucV3mQ7I42dSAH9zEVGPGaLTmDFil3JoraLutzju62nGJgiSMGvZdxdYtvWB2/LFok8ZY9ons01mg/+q1dyNqydE1Xu
X-Exchange-RoutingPolicyChecked:
	O/TqnxsfnsnsDkWLMqyoUcl6hfu0SI1wLU4EKxhV3vDh0c8Qz9oCet8t/NDrV0g2sW/VRl+TpTN/Q8CJBNrQqsRkMMDrcFvAb2sWCbQLZTEQ52CE5QdfpwOHGgiH31N4lYGLmB2xKrNl2ZLPQM5PKEdT/7SQFnQOmVToK+3Y4zjPrX5uHh3eoyzQaVEPmjVmNP5vjC0M3Pda6pZ+W8lmjwv06dH+PusculPaFmC3DadYjmd3VsOV/y1Mi4XkMfzvLnWvN0teu3jHREivYwyvWJIMNh1XkwS4rwWwHAi2UIyqxIyvj6rlc2eLbAhBDbIATroqFrvZ08c3M7qKoo3TQw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 21:11:13.9297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9321b37-31df-41b4-4df8-08ded6ec1e33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a4430f7 cx=c_pps
 a=F8U3mngwmb3oM6JELIq/Eg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=RAbJETQ_UUA8xOfZOBUA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX87wH16JNzQXm
 sdt6OBgmsNJkKSd+bOZrdBR0xWpBL2gHJ+RkCWNcK608YBpf5taNHNMjgD+p0o/tLrx4Wb0FBA6
 gj9EEQPOgvcGGz7KECc1VRXik33BOj0=
X-Proofpoint-GUID: 0Zyv8CY4nZjxQUubNcqt-LBM9NFpWO_f
X-Proofpoint-ORIG-GUID: 0Zyv8CY4nZjxQUubNcqt-LBM9NFpWO_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX9JWUUddajH2X
 GKfqbcIoMrAHDM2abrf2tlI9G41qo9BrJXKzbCgl28wyZbrdOr+HRzpao5810GzicqksfAoptXT
 91YfW6sO4fWcQ+mCQfssETQTvAAGk5/tULAw2GSsYguBmF5OZkVqLbfodija9e20hwh1Az2ynsE
 nrsvFBb/pXT7GBD4mjgzR7f6krnkcktaGOCvmmYhImmSWzwinmyd0b6aGd8rzfWaiVfRhoJgo3d
 ajzekRUTXirXFYXAmsinLbg5fvLGVrEN89P3dJbVH2hu7BdavoMZoZgoDguRaoCjw4sL7sMCIzm
 65jk9BMyBzDMWGQdJqAYct+PmpswXhTThpec3Xh0A5/HF6J67e62czzV8sM3H9KHB/2p6ifcQwK
 jdd+8YycsbKvzm7QgKwFwM7rpbbX9m2N8VjCevQXM9f74JOprsE4tDbgmWargJ5axdP2zJK1bxG
 qbVh+eJQV/q3mLcuNrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300205

On 12:59-20260611, Kevin Hilman (TI) wrote:
> By default, the QoS resume latency currenly only applied to runtime PM
> decisions.
> 
> Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
> resume latency QoS constraint should be applied to system-wide
> PM *in addition to* runtime PM.
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

> ---
>  include/linux/pm_qos.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6cea4455f867..aededda52b6b 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -37,6 +37,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
>  
>  #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
> +/* latency value applies to system-wide suspend/s2idle */
> +#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
>  
>  enum pm_qos_type {
>  	PM_QOS_UNITIALIZED,
> 
> -- 
> 2.47.3
> 
> 
