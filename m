Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D83471254;
	Wed, 22 Jul 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706814; cv=fail; b=TM5FKfDHuCKk9/7YY0AXhiIdqr49w+G/f/u7fIoO38Tg0Uy3lRGEOKaRaV86y7mcrYc/ozcfQFfDi685tSAM4oOHzpUrHyYZzCKPJpelgndS1sPRH0BmFts4VNTUr99quSkYpMSu4kPXSikf3y8Vui9uTDJgYAffS62ag+tqL3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706814; c=relaxed/simple;
	bh=U/4L6x2COJt6BnssLm3QKzMAM1hORfxmJYo1xD0X78A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q2DxKgOwArl1jCCF7n/riNdCRqXJPvCCXBbVg6mNYOCWvoaRHWn/DQFEGJyc/lsiLcK8Z/vMNJ/10qoD0ANF+v+QE388nWjeaN8F6liplvcL4k9on5s+CBkCq8VfX34jj1MEHuCp0Yr7uuponUD9ELmsbmCWoEdoP667Ahx7J+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NYjtViwN; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UiztIHHM; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NYjtViwN";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UiztIHHM"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M507ir2797164;
	Wed, 22 Jul 2026 02:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3WacAD3Syue1Alpk5SpO43Ck7Bpm3IsGZlZ043iXb
	+w=; b=NYjtViwNYdQA0vxLXvWUSrkpeXtNsu7USPW1MIdN7r7Jnt4MdU5De9Rnf
	RnH83nV70JMKMh0TaoRe4OvIe9XOjaDAEUaWRQvzvVaW9MFsl/0JWGyGze6coE2w
	qySxZRHlOSKmx2O2dPxn74Ab0qeHj5/XpsirnyzTaOkIAACmsXrX4cN+ml1GrgSy
	8swBkG6jYreNOkbyCcX3nE4L+iWkD7kqaYO0Up7RedY8ahm5IPlms+1lDRneEwhq
	tBVvFEJmnvI4rnbaIDZ32GG7qqnW+Cu8WRdu+P7r/pdG9eiWHuNw5Bep9KSRhodY
	k8YmBs1vCDj0KuePLquPOtZ23PFtg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjpxvrwhy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 02:53:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtHPw4C19VSEyQdz27JeuqMs5VdqO3y+xP+0VRwtJn11PqIBmNmfisJzA3vC44RKzr4/VHrE9IxfRsMKINl5QXDdQfQBc1G9Hb7dYM+WyMKy9vpmanRNNjmLeN5ITx7JwUvU7dGLE93K76naPzP3vx2fa+f9BNJq6aJ514HEZWQNxxN7hVG1nIMguzhVwX4xaYOjfqUkqlFtFYYj+l7q+zc2pi7hULb+d+Rs4N60ORZ7Vi31hF0ahLCZMGtdTYycNQhRG4GBGWB9oKJaeCkhz2G3GvMjUJa/vnLeZd9XCNtACRqpyIL7ClD9EyfWUqryI4qg2xlWKJwZtrnQuEin8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WacAD3Syue1Alpk5SpO43Ck7Bpm3IsGZlZ043iXb+w=;
 b=gIIEOxrk2pHaOaIl3sDdRYa2JhNGDlq2ZkLuVKnujpL74CxKy1tRzKyFCJ0M+vAHc6Y+qzD9kA384v3qLcsYyo9dXhL1ybwZaNjsiOJK9xe3rL0klKKHtbY2FvkV/PU0gCFxnZ0Q/L4oMjk2STsOyoK+6wD5VNl1IyBqCEV/ThGqHceOHavmvjsA2Ew0/5/kQhWr1+o4JxrofO9LnMTPq93s2MAxA7zw4MxP9BvuVsTIzCL+kH2od02sA3+o+B/4vIHHgn1XUWkwNSNVNizEpmqUdACNaxH7zB/+H2AgMLMrM2vjOshA9YQRESkg8No1af0ijff1zXAT8CLiPbG0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WacAD3Syue1Alpk5SpO43Ck7Bpm3IsGZlZ043iXb+w=;
 b=UiztIHHMx/jCdE2njfFthgFjR0GPykyGYhnLZEZgq+iVzX1IaU1vm79ZE1dRipB+D3xz/VtMp6f3QAMfWaqv8UgT77qfu9gTsxvW26rDutojiXcKeQ6/joWC/CuLwIif+MeahVi6KroD9ffV10Vg1ca/cb7OFCY0WLTA+tsbQ9Y=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:53:20 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::4a) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 07:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Wed, 22 Jul 2026 07:53:20 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 02:53:17 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 02:53:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 02:53:17 -0500
Received: from [10.249.138.105] ([10.249.138.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66M7rDlE3345699;
	Wed, 22 Jul 2026 02:53:15 -0500
Message-ID: <90ce9862-9698-4158-b417-9e5ee71652b8@ti.com>
Date: Wed, 22 Jul 2026 13:23:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: ti-sci: reject maximal power-domain ID
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722041142.95204-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Hari Prasath G E <gehariprasath@ti.com>
In-Reply-To: <20260722041142.95204-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d516fc-ce00-4632-1d1e-08dee7c64c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vMET4Wlmn214X+vdljM/jSrir7q37uAtQmztRXakKb2EDbSK9HNcQlY4Oce9ShUrLW9uz4rJv1nWbcFdwsfQCuhGTpIlAbxBeGyCplDJI+IvT9KcL/R6hD9e96nUl/MOTCLZ5jGktF7pfVgdEWqMGdOrHjT06ZUc1dsm68ZRqpCSCq0pL+8NXAABteT2MOv0oIC9Q84Po231oys+wMvorEa/Y2NUxPz/wo7cfJDto3IJ74kUBwCEh+7X9fYp1y6Zj0DXnvCfW8mExFTlRjiWw4TcMzfwPV9ZRBUEFfaKYsRzkIpi4CR5ZhroZUGfPmJV8ToGNftSKsraWW72nMn5qWLqQr2yc/u0o40WZS12gEcablDptHMRZ8XmzEFd+VvcVLqL4BMDONvLtt7j75TVRk7eYCGv4Ck597VAJvoJYZVl9mxBbjBEjAfI8LqqEunH117nQuEddQS/D8YYVrNPzO2J2SxOH1Gmu18NhX7AcBwJylIUKP2l5rAdCauj4gyK5u96MVK2KdgPfa+/tLnSciAAkAFwZDTZkDs44a846nrw4PfMXMBuAf7S7BEWr1fsMt6fwaHr5p3oR7br+vke/8LciAV6h6LIIHXssWyH/gZMq4VxfpEippr12FS7acGb3vpw8E7OvV1Ff5plt54oqJH3qdJte9eRsz8V+4CBcMHf2InNx5z2BUztakfUebgC+w2MHdTUEk6Q7ED4AQZ3PQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g7af7hNG+FIkh7uPsPfmJT4EuYDh5ksyl8yUbkxmjM/hHTZOGY4Niwe42wl6ndHrFeilrGC0TgCDYITI/1qs4P2UbljUWFgB6BM4yuh8dbcR3omGzmgF5xwrEUlvP3yYXJQCdzukdPr6TFNT27Lhg/xyDEqPvdJjB6gkNia9RUWwR4/kSZtpkJKq4nfQEHh0A5QhmHEsaDhWWVYQyabRJ64XheL6Z1CogloMvvk3Dp4B5WQUPeVh3dU22DeByA4SECZw7Ei3J7O8Q6XkrZhj2jww5tnkgy1z1tz9oYUqndACl+CTDQXszyDQQm+KupJU2KVtZx5qWdH5fX+hTVqjhqnj4KWITm3FVYwZU3Rs6RvCuaeyGTcyD0/ucjXTQ/Vol/eOlZwyAf0HQwQrDQO9teggKc9sS2YM6plPgM7EWhBpAHK9KbJafOgkdXHySJis
X-Exchange-RoutingPolicyChecked:
	q3xlaliRVUCaOmpMVpGeXZAM6fwb8Am8R6u3qs2lyThu+ZS8l3xKCYNPiVAH0T12lmz1VWWskuZ7OktFFDOuN7SxIpVhyF2GBWZ5obT4ZmxbUK0SbpG0dE/W9AVyXlAsjwQMo5mf3E0jJhL8FtCKhoquJ2KYhCGeyQ6+3YuYbKQmpvSgXZguf3QWP7HzGhUzv62+CwWtVZ2u1VnQ4NSGpHvF1P8XRLJv57xb9N1W+tqoZ3N+hj6TSbxqPI4ilX38KNDnTD0i9ABTnDkiFuUqcDChhD2wSJgvNPLgesjxLRRnJ4JgFiQMVLNrbhYJRdtBWmZUrncJ2gDhtCCQgJbbEw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:53:20.1406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d516fc-ce00-4632-1d1e-08dee7c64c4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Authority-Analysis: v=2.4 cv=J+uaKgnS c=1 sm=1 tr=0 ts=6a6076f3 cx=c_pps
 a=Pcpo/nSjxNMkuCW/QO6CAA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=1JBX0sna3Uie_MwCzK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lLJPacgV0Tqb5yjiCb2tRtsnPLHCqHbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfXwDzbAHFyUY51
 nZ1JFA3qOloIFIqhc6kQab09L21Wj+ppShXO8QMxgp43q8KFo8V/lQ8AfzlQ3O037I/DH9vseO0
 uANZFQU1jB9UGiW77LNOH11IX9LLJGpyrXtfCq7df/hIMAusrV3ZFO+Er2B2fBjg6ZOAaax1i0X
 I5ywNPbinsPlJnDv6lrl0xiMovshICvC63576rKRSOgUWNfW3W3Y+1bLrH6XXjlv/Dp429NgXB1
 3451xgrq+9yG2r3xcPIcZGvZSFqvLBTqN0NVAAo+jDvc9X/i3fz7y0fie0Qc2aUiNi7REPffoFO
 RQdnhUbTmfPtaHh4SJ65wnwBRoG1G/vUom0bnEv1rEboC6vNN7zaYrreUI89KMfQsGJooOW1vZ7
 73+EzRCHEFAU+NSWfcyTrXxeV6TbFLysyOoGhWh/lL5K0FaTJcvrrc4en+24SQXey5GPdVkIezg
 3mUdEw7B4wg7O0a81kQ==
X-Proofpoint-ORIG-GUID: lLJPacgV0Tqb5yjiCb2tRtsnPLHCqHbv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX1fNv9iA7lV+t
 YTWi8csZilKYrl1OhnZKiMtj5naceklqLMhNrig1w6S+Nn9mDYPucOid51EpnUF5vvlrxE3vJ+V
 k1/EROcTLluw36pez/X2jqbprZGn1iI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

On 7/22/2026 9:41 AM, Pengpeng Hou wrote:
> Each power-domain ID comes from Device Tree. The driver allocates the
> onecell table with max_id + 1 and later uses every saved ID as an index.
> If an ID is U32_MAX, the allocation count wraps to zero while the index
> remains maximal.
> 
> Reject U32_MAX while collecting IDs, before the arithmetic and indexed
> store can diverge.
> 

Pls add fixes tag and add CC:stable@vger.kernel.org considering this is 
a memory corruption fix. Both should go in the commit description above 
the SOB.

Cheers,
Hari Prasath G.E

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/pmdomain/ti/ti_sci_pm_domains.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 949e4115f930..5fad21c317c4 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -251,6 +251,12 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>   			if (args.args_count >= 1 && args.np == dev->of_node) {
>   				bool is_on;
>   
> +				if (args.args[0] == U32_MAX) {
> +					dev_err(dev, "power-domain ID is too large\n");
> +					of_node_put(args.np);
> +					return -EINVAL;
> +				}
> +
>   				of_node_put(args.np);
>   				if (args.args[0] > max_id) {
>   					max_id = args.args[0];

