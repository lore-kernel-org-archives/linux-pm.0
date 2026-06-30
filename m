Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FB2F8EB8;
	Tue, 30 Jun 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853952; cv=fail; b=NzZVcKWop70DbPKDalPRs5DkpBcAcmTRB+jXIdSEuqv0HwM0XcLGD9n5GhWuK5N+koN1zAzO/8AijkaV8mWRoGnf7c1DjjeEpUXPzs0VOvlAAHKfSrSGvXz1GstaqGBbbIn1lq8pF8hepgnQIVUK2GqE8PmaYfpESkU1josW3rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853952; c=relaxed/simple;
	bh=CH4ayXb713cWOcpY3NgQZ5Q3UHR22nFcOm863tE8tcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpaeFtsvg+RrlGtMvlT2OMyIA8U5YOe5UkJAzMxSiTCAupJ7N/T7cYbZ6eshYRY0W1iekDfDlH9nlyXTx293EJ3QHX+jTaWRPhDseK/4xqeFnHYKg9KDGiOAaN/mtKEFJG+1+drk4hN/qKW8XKTR9RVdKX5Fpnq+rQYSrc1XYoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=OSEex1t1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jUppeWTY; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="OSEex1t1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jUppeWTY"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJGQl41633753;
	Tue, 30 Jun 2026 16:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=kzB9zloSdc0Nwbn
	OsksopwRS1W9JsRtuAxmbcuM9NvU=; b=OSEex1t1Zl2887sUrXca5g3RsLa3Kny
	6XbAzsejhMSdeeR9aIV5A6QZMavUtzOzfACHZi74Wgh/KtbCpTzazcee7G/BpbS/
	5fAmaW6pRFP/3R8XFTjH7Np4ooOBAj6BOMnuvW6XN6VUxgsywV6R1ehMS8Qxn3kt
	6aExVb1YcjIp6GlphCfb88w+h7DGdjZvCQfWRYnFn9bCNdFp3DpVJXNQ3/wf1cYR
	gnM6ovDuS6zyLnxqeEoxLcWwWltANeUKJcPT9q7pl6eALhLRmwWDvroy9kZbocNn
	zK2ZriUM+nHxR+HWvcfhizMqWd9QBsxdDveKfGS6e+kflshNEnnWbeQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvub9f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:12:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtlPd+KdDRHGBgmkGX7xpfrvapU2StK0McVebzSP9fI7OLLHNtikJYPk+pOLobuJEUHVrt/FwVUUM5XRMGXQ8Rj9FibvY/2ZiWQ+13fDSpikVOnf4W2n6fL2eN+OonjUBZkdO4ye01mRyb7eWqRFpmqsMl/PesuoLJNjr29c5P0sAifA2ZNfOENpSj2zWrPaINmNmMrgABvXaZZUcE3ICGJ3ljg9X42MZRyRbnJM/xMHfJ5qTgO3zgFpwh3H2KmQoJYrrQPdRmkG/mUoyQZ0dftMlOu2k/rJxXcbT2Zhr2z03bzqxcgZ441XQkEtUjzJiHzsedoK7OAar6OKalGKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzB9zloSdc0NwbnOsksopwRS1W9JsRtuAxmbcuM9NvU=;
 b=tbG24tjQv3/iyvWA93Hr0dr6LR0E5R4q3MHHh9DvBERiJvXOtbZ5k+OTR6gDpUMqTy321VRMPH7HnOU60SsV1XhpxeFeTf/4imyUxuEG29juTd2SOihf5uZMuikflG1xbJglT+MLg8MXzQIyMMuO/1P0HoWaZTk3rl70PQfmK2AC2nLMzepF8e0Cv6bnDq4aJEQlgF0Lujr2ZXhrOCKE22DC82xVDFYpB43cz2gzPwugQqwy94fC4gt9lDUJOHX+mwaq6U4cnbh1nBvgC69Xm2IDXvLWmuqiQfIHdAa0ahUTD9L5x3lPxb7OpvIw8WpX4Mdlf8TzBxg6oQO+OnMNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzB9zloSdc0NwbnOsksopwRS1W9JsRtuAxmbcuM9NvU=;
 b=jUppeWTYQ6MWzSu+iz3Xi/Ksd05HCA6WaqBHcMusTxItmUhfRGM3TVhyplA/imdlE1b4hzs3Tf3yn7WO1BT1mJNlKUAEX19vSyDAlkfpRg786ttFy+tlrzOnfy9MrK74s+Uvd45qFB4iD7xi+a8gKeMLEsAkNUsouj4Zd7Jv6Wo=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by DS5PR10MB997707.namprd10.prod.outlook.com (2603:10b6:8:341::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 30 Jun
 2026 21:12:23 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5b) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 21:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 21:12:21 +0000
Received: from DFLE20.ent.ti.com (10.64.6.57) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:12:17 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:12:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 16:12:16 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ULCGvZ3411357;
	Tue, 30 Jun 2026 16:12:16 -0500
Date: Tue, 30 Jun 2026 16:12:16 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] PM / QoS: add lockless read for flags
Message-ID: <20260630211216.idmeifmrg23h3b3v@uda0506412>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS5PR10MB997707:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c4cc52-fc88-471e-97f0-08ded6ec466e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A9msq3pmQp0QwZ5s93Uj4Kg2ApMPxSbCizsgrhtMlo95S4WEBhQ0+nerAzL6O4o10NVeKSMlGLqWpNV1AlUHeYR8vDkKJibpedKHQwATBx+OqO3DkrfOCZjyvLVyXueTrb1Qb3RYEI4naN4weR4HmkQAfLqL7tymWeuoDI0fgAadJto8o5H1FZUekBBQMK0N4vNBOe7etrz/JHaDeN3Po/MW1azDZT4xa+9ilXcQr7BgcCCsfh7kMq2MSOoyb0P8HVIwkw/lMhwVUH7BhEvX2mcO9ixh32pdKBj5JQ2mWXL4DqG64oZKVlYtEuZKq6TLeKMElncnqczGZsetTOClHdpFAMFfpJlqCxm9ccel/LqUd01wfyz0YAkMyD++OPCX+xsdQJBa93QfLcjX6KOVpQ9cbgGy3Nmk9nzvFSBLV8A7pjXj5gI40YbJYmUZgKs5M7ZGBuQC029uG70vgUX67ysarAxUB8Tr8+hKQorSdWNYOwVQbuVjC1XXlpsr3WQbgtGkgpIjgClmGxIQ7pbYg7EeejDQfNW9oj5EplDGvdieZEmakqRXG4Uukr82jHm61KQxow5auKBTy7XH0GVAQhxC4/iLbigUytJHMdMfBUJvDOXm8esxhYFG+j1j1LSS8NO7+Z87rChKE0q9rYHszbK96MuYUBKdUWS5hUpWhyJx8+DgEO/SDZn1nIYRyJbeABJWUvLIIoG86k8PV8VAIw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4EJbStTxIBpZDPBQBitji9CjFnSva8HHq5wQ95PRb/dQC7TKljXVQmKNYPP3X8O9ougvK3EPjbPDQ/887I0ehbcD+95rmxAwbW7AAFqxEzai9Nh8Spj+55UQ6xi4wFcbfu9YraR0wM5SpRtDOCBQS14a4JlA+SyjqdItHkbYXtD65JLZ87cwwnks4tAfN6wP2wbgPDXBLRD5S8Qb+kvOWhJYeG1L69kj9ZpQAdhaqPeG5Quz3u6rTk7ABJinvADOqax3+Hv/IJF9YCjdK1LnlB8gKqgAR4xZm5C9an7HdtVnhjjomzDSLXxJC0Mc/TttOWnEwfg2D5MqwPc0i0FNoybHGQ3nm7KzIHyN+sY7w/GMBtK3y1qUs01LfGHpizVhFaxwzdDWfp8Z/OucVdqp0CjnHeWUafo3I+yx1XwgGcJw8s1qww+6gWIDO6Q1lyZ
X-Exchange-RoutingPolicyChecked:
	YMu+tcw8KnOGc4XOwQ1oLMA6CL2Yz01qqoVQE0vWnvLMgv+98/K2apyCF4NynNt0nH0uAx0zHvmENSqvPbM/lAgvRIhmbN5rjzSkzKuStVQmzusT6LA43Oz721IZTPkTmnU+xxiNvhCVMKb9l24m4F3HhS7lSS5zRloJlKMUCojaCMW0IwrzoDPehAmDOpjq28dEFQwZcy+76UYA7KwpnrQTX6BUjEFr6eFl8rrA+UHoEanME9+lD0J51K5QJ3RS0IUosw4LDGrbrHcy5+f+GuWj5VGyvaeTG3EkDEvOxHBiGBEOjrshAhMcjV/vUlC6dAwG+2YrFcof9nCFZZ7dsw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 21:12:21.4323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c4cc52-fc88-471e-97f0-08ded6ec466e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997707
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a44313c cx=c_pps
 a=AhJDvPO6yzy99x9PXTlr3w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=2JwNYlFK3mjBhjPuiZMA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX7BSDpl2JzX3A
 fyGh/X34k2vFhX2f+MLUSXBcKg6J5Q7E74mHNwXxmjLJgMz/GGM/atpCy+kuhPVwF4vNpkhJs/S
 6tOXpbKpsTjXpTypeOclvhJVH4YXEZM=
X-Proofpoint-GUID: gMlVeSbWQUEix_NDDDKKYW_V33AEDAFx
X-Proofpoint-ORIG-GUID: gMlVeSbWQUEix_NDDDKKYW_V33AEDAFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX9FviQ5Q5pbYI
 WCDATrFIbE3c7okVuZRkBCp8BSbSx1Z/LdB7g12xI0bPuV3IdUpAk8e0VvOjKsoiZVtEhTcipsc
 UqEO0sHbGR5tDvV4CIl1s9anqkT0fs1TG/0dU8kDtHWRgj1GLOAp/wQ/HGMLC0hWApxs2oyzjCt
 4Z3O4E/sa4ys2hT0XK7By0kBa3/TicHmEYivDDOfJZYX/NsU1lGprJMruxvWLD99R50cZia3/KW
 4c+GMBAdKIXfsNx8zF7usyUKJtp0/5kSJuS42ayQQKhi8R51d6eS87xkoP7XTM+Rx3VfQb5I2Bg
 MfZAsH+m6pL7Gix9N4vwXUPjRfwC1VNcY45+3SsMgOUDa0n9WEcHh/NTxpP4ki7M4QAj1BFX3+2
 JemO9TDH2KQH1zDlA/lk9IFhXt2vPF8hCv2/lBmlsH8n9fy/60itzE7PghxrzEJqjr+sCiiD57w
 DEaREdnYPisa+pkeHCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300205

On 12:59-20260611, Kevin Hilman (TI) wrote:
> Add a lockless read for QoS flags similar to the lockless read for
> resume latency (dev_pm_qos_raw_resume_latency) which may be called
> from atomic context (e.g. genpd governors running under a raw spinlock
> or in the syscore suspend path), where taking that sleeping lock would
> be invalid on PREEMPT_RT.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

> ---
>  include/linux/pm_qos.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index aededda52b6b..439a9e779d81 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>  		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>  		pm_qos_read_value(&dev->power.qos->resume_latency);
>  }
> +
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev)
> +{
> +	return IS_ERR_OR_NULL(dev->power.qos) ?
> +		0 : READ_ONCE(dev->power.qos->flags.effective_flags);
> +}
>  #else
>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
>  							  s32 mask)
> @@ -300,6 +306,7 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>  {
>  	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev) { return 0; }
>  #endif
>  
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
> 
> -- 
> 2.47.3
> 
> 
