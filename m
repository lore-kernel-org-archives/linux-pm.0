Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60E8003D;
	Tue, 25 Aug 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674726; cv=fail; b=KaxyUMHb24ki5z229PA7C3KluWxbI14Qz6aN8qYokz/VdtWXroAhao9EEIOXSdX5sQ3G5U/65fvO/jbLXYFmYSlZ6LvQe6qxxioqDIPuQ7QrXHYGC/IwmmEwJvwqKJ7hPwRTqJz9Oa31J1u6GkhjpUy/z5IdTb7wN5rsoFVhDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674726; c=relaxed/simple;
	bh=Oi4LGcCEUZiLTmMZ/3eWfFU5e1AZSzXl65ND5BR3l1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffxLktP8PbhU7nmUUMlI9sJVM1vc+T3RQZzKNUii7r55qiW7hf0njgpRleTv+8GQPcTVKNbtnlOvm9CFPOpufpqUAdn7g3NBBRYs/k6HwSjrI1xWiDpABV4Ru9DqowL2AssnV7Y46BI//xJl5OY9F4ellmBbZHiXt5dhMGemDC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pDjwttk5; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ix2EQxWF; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pDjwttk5";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ix2EQxWF"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVhXF1165448;
	Tue, 25 Aug 2026 11:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=sPBwSeLQNCwmuMA
	rAyO5EmXKN3ub4MTOu6n9AUIk2sA=; b=pDjwttk5JYQ1paPbjTuN9B+Pud0f6O6
	msVSiJCqLKwG2NSpVL54s58YQ5ynE9/tdSuYpUOAhP4hckgz7Z6/ApGZG24lHTri
	F9kfEoU2KqkBMUIaEhoMrgwh8u1ThM/fV1tqQsGWSM4Io91aVAXFTL4rNxdDyJbm
	ekuh8jSE6cbwKxuFboPh2anWQVg8v7eKtZqRKPmsMlF+Didlps497y7ILvST02Gr
	jrcTBR0q91FCpP3nbK8ofDsylge6X2oBEMZzJU4kanC+aeESgmQPlowEGkDGaWxv
	ZT2IagI1TvPXlKARote+++Uirf9uBRFbZpf7RtMKdmqPeZidsqp9APA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxm8s4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 11:18:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeCpIlmgGuwsgxtBfy5cmNoxB3haAfmh91eOT4sngt95GYqbmx07tDZ4g/vZsYFbPlxT2cFphpFk2pnunsiaXm2SXES4x6jhQ3s+NwnQy2/SEIacc0l21YQEzkiytJbU5bkl4yrAGfEJbzAXqCh/jBWrxrVEBjqbhVcsBUeRdkA29PB9zjGznnQ7FMPRdBIDiD+tzlvo++FPtKnFiykYW25uL0qetPx1VTUprsGhHs9F5fRbhaXHsfKHuGb7DzAUdEN2Mp2zxv01N79GENYdEZhEoNIjR36JDFn0SkX/Ws1A++LSuAVRDsf8aBVkZiPM7EFBdhCj5NxgWXPICb9Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPBwSeLQNCwmuMArAyO5EmXKN3ub4MTOu6n9AUIk2sA=;
 b=iVkreO/QNcK11oTjfbHQiI3zIK/1g1g0ikJOC+IhmqLXlbQ/TDkeQgYJqCSWNR25LrhPlzAvyK03d9+GCBJxhVJ8tl+CS0vZTGKLoFDTd96sCOlXayA1ofaSy9ZEqkQvqvT4xl4DYW860PbjwrDZAq6K6iDwXM44FiK1cXdVA6EXRjDwTgvMjBr4bVukp1reu1ss2NpXClEJ/MBgkyrggXgpGRCR8fBPcH2EdUp+kr6igTw/IrLZ9bYRHREApl3rvSWvCdfGOX/SQxuSb+TGNJiWpfeAyLgpqYk0JzwFp3eMl1AH3HYl/ObP27NWdkTj+isoNi2Yrhkn8w2qUjo8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPBwSeLQNCwmuMArAyO5EmXKN3ub4MTOu6n9AUIk2sA=;
 b=Ix2EQxWFfrVkxA/HS/Ao+vdXPifLTx+9kVhcqWT1B2K9w8/X2ncjYoBUy96UyKvRCZu5ndlbVGeAIq/llX7TEQxYvoxSLOQHN5LmT0kjrBlQ3VulAePLKlIHwiMEd9w05T2FGji4ft9IU/OtwrCt2m/n530vDGxmWXU71LLFRAY=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:18:24 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::27) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 16:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:18:23 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:17:48 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:17:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 11:17:48 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PGHlB91348222;
	Tue, 25 Aug 2026 11:17:47 -0500
Date: Tue, 25 Aug 2026 11:17:47 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        "Ulf
 Hansson" <ulfh@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Message-ID: <20260825161747.pgxxku4wxibqqvay@uda0506412>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-1-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-1-7ceb095f5474@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 993da409-3544-48e4-e033-08df02c47c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MXk5GDv4psSlgHro2FFmhD+ueGYqiQHXyh1uZHfM3q7lSBnBi+1ZII3jjV8Zs4tW9VzhPJwZMR/RroaCEosiSm3rk2c0ZBAvpgcZUMVYnluaDfFmbh109kYRp5Qh9GGlrKdH61euhMFyDnUUYNS0YuNZTG57sDn8JXArNbK2Y0jjOdU66i8cW1qrHKikAHj7L3X6tA9x8rd8Ff+t3HNvCueCyX5uLNvxg/gywi6sEpvybVAGfJUGGUd4VvqQ1WgNwa+ddDxYy2cgKd0Tvcfv/gOViJL2dgFlBRVFe8PkaFw1ccIU+c5gNdZ3mIS4kGyR4W3xEeorGDK3TdmvJ32QRn4YL69cwwVe0/O9XXKyWdHUf3A1kOggE3M4wGQxwUn5JnfUbLMtDGsysOBYGcS+bVDKdUVZgi9r9/ATMEr/D5WYZZiXdoRCJnImL+YLsPnmuCbBdyymlUgbcM0MWOvg9wn6OX8mawRd/w4eHjqctHbswtw8LncQQOTD5n3Fas/ViIItYC6Y86GCTrxCOmsU6q4rDdV1+cWOKbkC1nD2mSG6JufDiMwFRurmMEpPQ+lxUYXf8DKgdj+1OWsIDH8ffU/qRj+UGS3s/uGmLeA0DyMT4JcR7VGAlCPVgAgxGWEPdkUr79yo7sUJ6P56ci6pt50K1uadVJG8Zf8Av4tu1WurBft6w38ETVYGiIBDZAABI6VtsIl9ZDJnh2QqW9FpqQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GQWVhACKDo+Bud5YYVSyQqsNNfuTsEWTw8d4jtOkyy9B2P/9OLR0n30mLT9kK3YeLFXJTTEgL/wHuwRggKFyzJ6HZpQ4pdqzvLP9WwmJsi8hc+wRWFuTjXArHsnHcWGATOLVmw0m0smJ38JodHnVhg5175x/Fsb2htR1/h0jFm4JSgm0O0KjinuejDSfExxllut03e3pGMKb1tWVC5y7V4pAiXW5DqhTMvtobUkqfJLCY5c8tp1cE/2bYQ1AA7i8W5DlvUabwbN9VZqTlYy29QfTgFNp1rPlAo9w9N9Buebz4MUzJnxX7IU5PNpzhUb64IZvYCyEJMawQsDK+8o7bQFL1JsNlJlCqpb7hgncCGRtjCSFW7hAv1AeNFfUkjR6okCCk1tY1xBRMPFRCjQa0QSxr48EoDgGsBA31TD2n+GbEesb49408zGj8/sKyFvd
X-Exchange-RoutingPolicyChecked:
	5tvgVGnbXfwSDZNPFt6H6QAJ8dAHT3+xymFh7rr3Dc8Hvc64YyissIyryhTruesoxlHPj4npW07HmgzkQKSkH4IbNQAWq6ZDiQNxAhRpjbGH7MjWLcWbcWnuxJm//CizRmBNfEMYvHsEc4fpYjZu5iKfeLea5Qnse6kvNES1ky1bIVzd6V25ggBzs+5uhcS8zhwsCWqC95i8ngXwjwi1iha8eus8dqEG75i7UL2MgOqyvobJ1/2mGjWRgLMf0AOXIkO5w8jRrv99PafZnm6CWKW4xjBS3J5BISqsIPWamYDKxP36jdpt18pPz6rvE5RosQpfhD3uSYCQtfJDnYcbQQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:18:23.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993da409-3544-48e4-e033-08df02c47c88
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzOCBTYWx0ZWRfX/34BgzV3uL2p
 4vFp7RQsNvBpE3f9F2oGXmTj7gRfsSIzhdvjQ0yRIOpSSkbLIeYXQ7T3UddeHjldLSQY3TMHvd6
 bwp8XgSzmwBbsg7U/HuR1OZTkpZyJbw=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dc05b cx=c_pps
 a=zYHeo5UF1QI7fA+G+QDVSw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=jCRpJpwa20Vs3UM6ru4A:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 25q0ehZFNR_rucL0Ln_cY_BcuueXsm_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzOCBTYWx0ZWRfX5JwPhIRHJgrJ
 Vf+jxed/PrUJwA477qPx+tCOJ73h+nQbSBs86lnE/bNU8P06aHDAvuwfx3N6eqzwTvAR3t4KrGV
 n3XgBhB0wcTKIDBjBU6L+cHwFIGmhsJCG11Kh1xsBg/hJNlgbFnCddPkHP77UTN3NjqhUP9OgKR
 6IDWEGwA5eth09wLVyylSgZH8qxGYlmYLtnVwg9h6iw4mvdHqjWphoVzOV9MoVasvzkuOLqjN0w
 e7fNdsAKxUyOIBOEqXFzDdHmy5wyH+utO1yo6Hlo+iym91f4FNHTMfBQ9rsMHLaEMt41o9Um1Ce
 6bwD/Ib7Z+0wduHBn0MxS+hagyy0ohok0By6cNxYN+sYCQA8SPuctROwBVAFxaIlbS+syirQYNH
 xoxtFBW3w7Y1YJnJNMaTX2phS0C0WoUPno2/1lXV5wxWMRBZ3NCXEaBVL+ztxafgj6EUJ++CyoK
 6ro0pK/9vxD/643fKBA==
X-Proofpoint-ORIG-GUID: 25q0ehZFNR_rucL0Ln_cY_BcuueXsm_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250138

On 10:08-20260819, Kevin Hilman (TI) wrote:
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

