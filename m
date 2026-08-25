Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56648349CD2;
	Tue, 25 Aug 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674837; cv=fail; b=lgRbp8yRKLH4quaWrobwsQ6+/fY7BJTulpZ6JdBvjfPfunKQUlWeB9KJhUscSRJPFxrKAk6F2lBRhtI6QHPI9vTn3eb/+XWMA+PPvXSz7SjAe/+GdelafbgCWfm/J74dsq1qs6cFWi5mMjttgkWO+QwCTxbFPncSafYgxewAIb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674837; c=relaxed/simple;
	bh=EvPzYbE1/oWjPisyrhu8XizWji7hSqiWLSdzY2kf0b4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isPoamgM4eGtcKAIUfZTtTUGDykb3B0+CLuVHX8hRAONeWWzdFPHCcCXd89xy3WcoHyPAIEPDVgfRZwts4hW4WJylxC1MZXALcaUy15ZxA1CkD5kWSc8pZn8mH4vC3TitaMD0qZIzCATtK87mywNzVAlhQPWS61F2ZurNhCN/UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pm6MtKFl; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O4FqEmI+; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pm6MtKFl";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O4FqEmI+"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVY511165223;
	Tue, 25 Aug 2026 11:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=JVzazoyNEmbL6Ng
	i5ZQoSAf/4/cZmaauZwM1UocsEws=; b=pm6MtKFlTy2+zVL5zkBEZ8j8fHCfJ4k
	MyBbuOddNwKOaMcSjMEggJtdiNZm9veiz2/FLM2S6AVsr2tivJVhdXM0M/DRNTVr
	G9nXsGLbqh2+ZwwAPfDngtx5Bp1jgezWJqztUeB/Yu5fLZt4vBs61bQIL473U5zU
	6pCPvKxysTkRquKQTOqkayy5bZgd2KmeUilf0Xak6vBKLVZc+6khVyp26E/BagHG
	UvHdT5hpJZ8afg1rt8UdiwZGzwH0mM3w8RQm3PeyphmHCeRhVqssBNqeW0TDqUo/
	OBmPvE+/s05YtNxDvzBbV3P2S738qiqMYV1Sr6Z+p5XaXVsSijc+vZg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxm91d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 11:20:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnEOOadnpNQEOsY4g8ObllHwkkP/UCGOE7bjmGoW/+ZnEbCs4IhDHaVFr9rUlXmYD9fxM4lE1v2LilswpuKnJXI22pVo03h5HsuDqpAAA3yRXbB2fORX6WiL2XMaJuXkUOjdwwYcqmDSeP5LsStl7pG1Tjj44HOC8LoFxaJ54Bs3bBCg7V7e/pXfdwRWmy8Aa+x6uzaHlmw1ycWqZ5w89OFo0BABAy9Pjjt39OKbLiPhPiQSnXcs6VfrQ4tFaxp/tw6gbT9gW4Ph77Ze6gN1QXovWTbonyJQq0do6UHfQ3UlwU0z1SQ9Bqpo+nVzVYpKOcLXlmWVIYy/vW6Qly+WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVzazoyNEmbL6Ngi5ZQoSAf/4/cZmaauZwM1UocsEws=;
 b=UNm56Km/qjjGyVTh/I8fZitX4jBVsboQ9hMcDpmojwzobBDqSbXbGYZaLTKgKHXnZ9Mg9AuFzUMe7WiFlsw7/YASjW/YKOAKB8n9gtmRX0O88gXsjZvkgXSUlWafR2DxnHxGpa+j1QQfULxhzK5LS/RaVGqapHXOfCWg8sIOmcgpXj/Tgfl172fJpoY3yQbod8lVgmNTz+8k9F5ZHGSUGwO5+c8WZMFYN97a1gbsE4aFt8G5VspCOi32iTqN38RgfzhREpnFJZBca8jHsIgNIVzjATivz4kW7omgTLsEBJR9DS6c/+2Zcv+H3o9Kj0Ppk6/pqObiU8g+eH/fuf+T4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVzazoyNEmbL6Ngi5ZQoSAf/4/cZmaauZwM1UocsEws=;
 b=O4FqEmI+QEVDcrz/26wMfVf9XVMM0bIirDm44ZXvc1+2rVjaFxjYsCh+ZVnpY7zrtxtp/Cu53jFxOUGZIy4lPrmcuqzyq4PYF/02LE3Tm7wDOyo0sE4SsGj9EQBqvfAe/lI8J2i4EcvUY+eD0P0MYWJsDd1w+Cujn1Arb5FsgvQ=
Received: from PH0PR07CA0071.namprd07.prod.outlook.com (2603:10b6:510:f::16)
 by PH3PPF57C8E5D36.namprd10.prod.outlook.com (2603:10b6:518:1::7a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 16:20:25 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:510:f:cafe::f) by PH0PR07CA0071.outlook.office365.com
 (2603:10b6:510:f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 16:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:20:25 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:19:31 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:19:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 11:19:31 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PGJV7N1350703;
	Tue, 25 Aug 2026 11:19:31 -0500
Date: Tue, 25 Aug 2026 11:19:31 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] pmdomain: add support system-wide resume latency
 constraints
Message-ID: <20260825161931.l2n535hfpbxu6hm7@uda0506412>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-4-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-4-7ceb095f5474@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH3PPF57C8E5D36:EE_
X-MS-Office365-Filtering-Correlation-Id: d924e3a2-5fef-4c0a-0e55-08df02c4c50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|3023799007|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2hG0pzhSGdyDm+uH9yRxCgjZZmyRiXV5cpn4o6oLxs3NDgw8I/Hd2AAwDlLJy2dz92GccK581sZhqlYU+cfKGzyid7NnKqLkCp/zlsoBJ4qt+ZGAgpTNmtzSlffqEMV2weXHihLuuFaVx252eU1e4PQOY3vI1VXrZ7o+Llmjlnu1mW+lhPaBM4SIedSOcxWF+ogZ3DJXx7T4hIWGkYjlmAQQ7IF3E2eYjqQN9Khp7Zz8V06QUjLr/Fq+e8v5nW3di3JPMa9afX22ehDIal15z3wQeNhOZ9XaUEY5I2f6BcxeGEuDB9+ANxFHHEH2kd08YQK2lKAgDg27x8bN8hXZLWWKe0PwvMRFIHhXGSNEGHAw+ndt9ecaBF1DgIObOxEKafWU3sAd5srEDmHPzvVqxVnbCoTkKw2YFBS36hwq05S5g9AqUvG0erzSWPt3DLlHK7AzEp7Z5plnvbBFjgq6ohKrP5gUsf1TZxf7pO93H+s0yTXS3vki/a10s8ZfI6rREYVC5Dx8jQRXipf+doIpHMgmaL/bWPaIXgPUZdNP9uF/EtO6PeJEhJVYopizsEbw/1bMHnYlJg9MW2vD+DvQ9sJRvtlywEn4TRGx66/T/duWQ1mSf9YQ7cVgFmQcImap9q5ceTKmq/CszEppatynZ36kgeUHvQ1xR53QLpNfG2fq6+U8bljm8Z8WbSDGl12+rHURaXdx3yIxANIRFNSN7g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Wz23jU8SSqQY5HgFMyJWRA0BGFS69gZVBjcWzcTTAeZP/mRYuojZR7tB0336owZST7dyOstxBiN1mRLgr8ijYpsXM6m71U/U7/VEeQdRorNgUk5bUTuni9CuH6cas8eWH0zwzvDPK2frNz6mPNUU9TD7rHUAzQ8KKIeJ1/5HAiS3+ft1HM+ozwqdyWV1gkhGNK2w2a5NN0cOnZfASkYTGh25N6g+tsyrA/6dMi0vRyDv8bjooYtDV45U/c2SjbUrHqTaytCNt9spDi/1pGxXcxJeIgAmjV3xY+qPEEk3t4OTMoKk2NUhZkWAVFjheDTdWpXtFw0c3sZADIo0PkgZmbTTakx9yiJBBYPYC4cvkicgOQB8NlgunbAH6dH9EJB5bjG45UzubtIRyAKLGzFusRSCvRi9pl+Rpx+DSkEmiQJ2lSof5Qrn5//4hRYHuxa
X-Exchange-RoutingPolicyChecked:
	usPy7dfND8xOhNlriDR9ixpMQaoUjRpjli5YTexFb3+H8pUcuENuv1jY7GKFtbyl4M7wz63mDHxiMEhGRlZMX/Y3LtiZWFcE+a6tYU3ofTBmPn8EZ1xTI6CXDahQq4sj36OS4cKzjjh67GVO1YuLQFgzPURyg1UgQIrNsENAMfzl8AnVtyz321JnwMSoZbR2ELDO2p7b4Q6BcCFm0qKP9lqnU6ThlQBH7XGkXzDFECIRsLXt6GD0nOIcNPuXeF93p+bwBw43j2alFU87p5v59/SQM+c9lM+9QH96YQmcWf1rktGVWTyY/c+KmyA6B06k+B7b2Uzahpfm9MZCtqxImw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:20:25.1987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d924e3a2-5fef-4c0a-0e55-08df02c4c50c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF57C8E5D36
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzOSBTYWx0ZWRfX4PtmduMbkaTQ
 gFz/7/NdxESRHWfBWLmStR6T60almR3tyR10xlhQodaAS+6SwqbWlzhpC7rBaFluDu8fxWPeU9E
 jsYioJuQFpbluyhSCweRiEbGKLZXh/s=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dc0d0 cx=c_pps
 a=EZwmcie8zcfNvCQIxZ7BwQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=o42MjlPNU9PXQ6s_XnkA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: ykU0ufjHrw3UBI0NhaxY3pFUzY3btt-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzOSBTYWx0ZWRfX2VAvVMj32ccl
 L4Wa28eCiRmCHx+LJgCByJFxksSZk8Vxb65pm1m3y9/op2LsQZ75KIe3iMxU3slNz5ixhH4MnjT
 CoPAIpafRQ2bJHttt25P6OUqRgmseijxAhgf398D3q6qus6+Q5mwLRPyvsDII0S1wFoHjjfvwTq
 2CUtIiCj9zCQskdvtMfN1jj585e0mIMf8aZkrMcacqQ14QeLQMLSeCr2USOomCs7Oq/VbGrtwHS
 1tV377CHZKPUWiHzYSeV28KVk+hVhBU8Zxrw9VpZ6I6WI8TcbYw1PhSEgmrSgiQtEyxZGLW3QwQ
 Xw6BmhykExY7yIic82oaHYeM+95muvI2H6kCKCXXpcZFAFqHClz/CS6hJvVbuvk3G8HEtRxmEQ3
 poO7F/fupE3AwPDX0JlCdQDlJ6haW41vmuYi5ofV54pVZXmK+Un9UkW82kdeor9ysESu0rduPMK
 tR+n0PqAt0yCeGrZIcQ==
X-Proofpoint-ORIG-GUID: ykU0ufjHrw3UBI0NhaxY3pFUzY3btt-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250139

On 10:08-20260819, Kevin Hilman (TI) wrote:
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
> 
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

