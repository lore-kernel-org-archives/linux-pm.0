Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8A1E5B88;
	Tue, 24 Mar 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376371; cv=fail; b=C/dA3wCNAL0K0fhMLGTT/m/cqNeDXzTAMV2Hw8NL/qY0wfZ4ap7Pjbdua00VMKgfFjtteMX2uS2g/uKK/8N6lzf3Pbj25JcSaNVmvUL9onS7UbQiYEXdFOFBzJmy/iijwHZ0FPjysAUtDhIk69HpIdnCN75g6jZr93UT6Fvnzco=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376371; c=relaxed/simple;
	bh=hFxqyM5RoVJ7AAia3+zgsExU2J4r6sJjmlAPlQrOYFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ruB8GT58l0PmU9tkMn1cN/jJMBfhdOCVnH92+7tdkk/2JA2bT+Oco+GTv9s8rSY5xJh+rg9SCEq1KhptA5n9c1JI5IP0qX77vIlYPKXwx+uqQmfgaYwBsoNAb1Pqd+oZM4vPbp/WuzlTXWTWEntC2lpSmwIQRppYDU2BPz0BWvA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ivjS1My3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ivjS1My3; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ivjS1My3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ivjS1My3"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PNx1SqfK4XTs+DDOIX9XSMMU4+3cIrwGEk6RfSSztRpxNBWeXCGKarAP32WLNSnjEspZu9zyiroxA7My2hy9i09sTYjKATNpXmfBdER1Mnyxm5p9cqbnYzSRPmMaveyGZLmHXzASU5Im6xqd9ZH2YIMwrzD9at7wWw7qrI6RzCliwKiiJOy0YygQHlSO+tHP/DPm94peurXtc1sTiXXoCOtmfg12HV4WPSNPQgjtcs0TFI9TpgL+Uy3uDw+6tS7/yB6a9b03+WAq/e0yCaDb55WiNqSqxbctlg8MJy7T5sN+oWtElKwa/VlXh/sc1SIowW8hz5hVSy+kZlQ86jI2/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YFHJusYqrmwAfM3LRT65HeC93ewh391bFevlFhUuiQ=;
 b=JyCLYJ1c0jRIrDjul6Usw5x3mVVaFXqQN0VQBalfSbFEq4MPM6lAmIgwigoCqIV9ZXhL+tQPpckSIjdCpZxtLpbNkwGEcGGRpSb7wThMX4TP7J7HRaUsozlSCA07TZSX1GczDcyw2tuNWjdPtbvbJfsPZd3QFDCIUEZ0910j1QSBg/3vkyhha2Z/uGD0h0wf7ApQFEd25WNlkmNjSFQq/ka+tiSlTQBm/DEYbL+amgqZNLHJ9g8Ig7FJEz3+F6k6N8OEXc4+m3dEhgIrkPRbX5963Iv9z5b4TKO7f/N4PMNvkbTOU7VpzIl/cugEyhegSsmj1RxmQrZbSX+MUeaqng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YFHJusYqrmwAfM3LRT65HeC93ewh391bFevlFhUuiQ=;
 b=ivjS1My3nBR7wlYyhIPHqgSrCESrvaN1UtjCx1LsZauoGMttyxuvXBU5Sk0+mm9VAR++VNyoQ56u3LOYQF3Rch7ItTwE+dHBQj6Rb3K4h4Px5xxzv+JpNPfZWChPv8U7b9VnsEib2vdtxtGmSFc5ghHbvpxUPTAaygzKtl0P/as=
Received: from AM9P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::11)
 by GV2PR08MB9304.eurprd08.prod.outlook.com (2603:10a6:150:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 18:19:18 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::12) by AM9P195CA0006.outlook.office365.com
 (2603:10a6:20b:21f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 18:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 18:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHjDWm4rgH1SQ4n9Vo05woRXLqAmjmeqaSIw/pTYHHbD9ded+vK0sEDs9zjVDFk2txJ22v8C6Oy5CC3Ui+tyfFMx299Sc86EegRzlMca2jaZu+AxKIGL7uUeZm+lo5m7bUa4u6BaOFhYhj/75PEssPweaJD+dqSjacLYoUKnoZ+qGOa7oQxqIXG7FA7Jfpr/8tfi7uXzj+lJ23mF8EVoWCwqVG5j1DVq28+ZmVYVsOobGxy04LPaoxiVr7krqdlDKVT91oS4uuiLsJrmJjxnbYx5H/eMDUQQ5sUJz5dSqUjT0v78iy2hV7l0yj3/qvVBrIIsSCaR29/OlJXtc7AZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YFHJusYqrmwAfM3LRT65HeC93ewh391bFevlFhUuiQ=;
 b=HTzLUX5NFvn9BfBxs+8GvRF1r7H0bWs0GS+EKVMHlTqz4Ca5KdSNkszIlV5YPt7Jz3F+EdWIA+AxTPRl5qNTVaH5GA1liiHpSFIOr6BW7nawe3bMp20SQhbn12mdcX3Goj8ldyxV2Sj0oz3a7kkx1J1XEQ3CmUPwkpRr+4yWPWItjsmK9NyCf2WdghUt6FaMc5JwZoyWdp+EhQnv/OsEqrv05Uzo+GO9Ee5FTAabhwjnCz9g1bcHX1aKBk3kI70ywp367vl1onlQtoUCRZ2Lfh0DtzbTvt0sSVzpV3sPQnzOSaN5XnrU3Luxj7s1zUE1y1ABR6vAVk4sBovnJ+2Zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YFHJusYqrmwAfM3LRT65HeC93ewh391bFevlFhUuiQ=;
 b=ivjS1My3nBR7wlYyhIPHqgSrCESrvaN1UtjCx1LsZauoGMttyxuvXBU5Sk0+mm9VAR++VNyoQ56u3LOYQF3Rch7ItTwE+dHBQj6Rb3K4h4Px5xxzv+JpNPfZWChPv8U7b9VnsEib2vdtxtGmSFc5ghHbvpxUPTAaygzKtl0P/as=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBBPR08MB10463.eurprd08.prod.outlook.com (2603:10a6:10:532::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 18:18:14 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:18:14 +0000
Message-ID: <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
Date: Tue, 24 Mar 2026 19:18:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, zhenglifeng1@huawei.com, treding@nvidia.com,
 viresh.kumar@linaro.org, jonathanh@nvidia.com, vsethi@nvidia.com,
 ionela.voinescu@arm.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 zhanjie9@hisilicon.com, nhartman@nvidia.com, corbet@lwn.net,
 mochs@nvidia.com, skhan@linuxfoundation.org, bbasu@nvidia.com,
 rdunlap@infradead.org, linux-pm@vger.kernel.org, mario.limonciello@amd.com,
 rafael@kernel.org
References: <20260317151053.2361475-1-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260317151053.2361475-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DBBPR08MB10463:EE_|AM3PEPF00009B9E:EE_|GV2PR08MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ff46bb-2c4c-4d8e-e07e-08de89d1dc30
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 szD66uWkzCZGnrZ6qzhtsZL5U+7mlF2FE7nQfGoEkpL3cg1wL0aw/b1jAqsiCAGYYrIeZn1uOhEriyIV+AAjcHgVfnPEVc9t3ew/iwlpuuMcYD4MF1eo/yzmo2wZd+L3eAlLVlHUZ/lIufTMjPnYCYWX7kL/pGnXv5JrpncO54On+YrPmtshHgvGhW6jd9a+zYK0N9mubZ3/yW3QPCm/Sit7Gls8iRCKQ0CFS1Z+K6kuUVaxcfh8guqdqlnq8wPFLOuONptvThT99X1IzPPzfBBzIhWgqutPuXxh4z/9cCT2CXUquCC/+4fgaPb8ZyEtUr1IMzUqVcdH3RDfvZymFbxOwUgw3HB3g2Z0M9Z5bdY3YG0bdyfRMFB9Wquspj7/tEnRrP/l11YdKyzdJTYVt7LtNwkcm4LZHf9gsb6u8Wzv4F6cNCrlLh7KPAwFGFuhLRatIESI+dXRiFwhr5KurHEuz+JNmci4P1t1V47Ia6XgqWjNRQTUViuQGXLQmsrKWVs0kgno0EtuBALWEcdggE3Ef3YlOxX6zcDO80tqRFj368asp6Jn96+KcfUzmKrFUC7jVQwFN/dPLu3BkxPHA8B3+ZlkZU0j0lvsYjowWa0aFRZpLDq905vRkF6Tdp3FXgfts6F/4wM6EK8FhRkyk9gjSOF/mu6ox7OOnG60IYAhg9W8RZKgZbjCi7NmphMYRCBA6l6L/g4WhwQNd7eYlhIxUjaNjD2TfbY4bU1Wd8bfrC4FB//jXnApznb2xIT9
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 uYz6kt5SKXoyFVJ4X+6NXoUzIpv0sxn8qonZcPR5xd9o+D4gpCXPqipyQfNwY6/l3WtvoqkBIXnDo2rOMTshA0cMcJjqlto8RkppkRmk7tYSYooJHxDcDfsKrmIN/eHFINjSgTmi3TxgGQfPhsWfTHEBzAF7FfLYuSaIgHHxyOgIbF5Si9ozQQKk+pZFwxh2AH8US0BsJSti5mB400ieASti/BhUcF+wP98BmU3xsqiqf5LMgLlM+rjgWjZkxZOISKS1vhCNdTpJysxfj+709AECtGRtOIyP0XFS6KSJ20O7UH4L9br0n+LCSsKuTFfG1cws0HmctdM1svXP2UTr1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10463
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e1f32662-4034-41ac-61e2-08de89d1b682
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|376014|7416014|36860700016|35042699022|13003099007|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	mWV5L9MFK6LvwWAAA8rmVZP/RGeA9KNdWggqiG58MHXDNrau0Vxws7cdCEYeKd+hakhSIyzlxEeJucTjZBn9y5pWA86Q+cEDOFX5Wc0ZSa6+RBaPaJNOEscAOAKLCTeibKLngJTmeWgL0S4tVut9PikLu8Icp6yDn1kYJKSxBjmFZd019MDvluldtaJikRw2xw6b055rIgrNQQYBjaSUGovnRLS/Jy9Jce9K51O7wnFVAaFwROeejrgXtglmagNNaBo/bSbAIybjpa58zpS6avT+PxK80Vx/+TfDStMdDWEthJxMHNxd9oPXheJBZG1FWB965sfspzDefEtuQ/gTnmzmgaIGT8ODwoPuinZz1MAcls1aT6I8+gIinrIpK+jxyEL6m1j5G3qC0GT2IS7nLIXketpmzN/rWHu2qmhBVtsYISoPgOME/HNxgQzTlTk1/T88B+398hEthk7a7MZAfnybOOHQbonveEeDKtdHgxaliDjw86EUCuOwTIR0jjEud9BVZyM94sXLBo7eL96U3I7Iwb6hynUmrZ5tzIJBe0fGNve2RHRhSkQOjOriN60wieY3z0v5fEtDqN+bA8MffexIVpwaK/TeM8yuBVIPV450BfF210PI2wUpGAJsaqIVeSzhMME3f1B30c50EtKG0nUsy73WAmcOYCAzHb6hDaMvS2Mhgd/hZrtvJBHzjG67x6MiW8iE8y7TegQUnPjd5CGaQiYYVRmU2a2sSyZXF+MRIZWDiTuJcesGcNfhcHUkN2iQhRt+jw+956DTairHf59QfNBjyN6c82MAo2GHdAo=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(7416014)(36860700016)(35042699022)(13003099007)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SFauxNQnsq0e6SeJzfDCObrZoT7MvpXR2XG4oNVE3ivh4Lf9N89IS8sJaRl6o8yFA9iFa9KPGnNCYLJL1Q8pay79KzCVwfp79Z3fAxz23Za1jdnLhSUZ2ST8lZhCdAYPhHD3sn2Lu62NyZ5O1jumNxit5N50RxhjGVDZJmGnU9kg38swp5M4mVshlx4AqLy7mM+lrrHyDITEi+S9eoq1XD0P20OnXY6aAqsi3xIlrYvemyXzdqgzCjEGUDWj6k5wBFZuVLtSCXTjLvYCamwFAh7kx+YnJCdrY68aBHclslz/mJMAucBicfqM+N0/D4xN0GAYaiurJ5Xy/wAHxTOMtS8Ef0MiAj74bseZ6es86nsVZCNEC+4Yvxv4Y1Hde+7LM3b48SGvaWq7i+c9+ZzC3n7+hxl60FuUiwjnl4mrrqPLGWEeWXnsaHJmJ97TcQnc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:19:16.7470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ff46bb-2c4c-4d8e-e07e-08de89d1dc30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9304

Hello Sumit,

On 3/17/26 16:10, Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection on all CPUs at system startup without
> requiring runtime sysfs manipulation. When autonomous mode is enabled,
> the hardware automatically adjusts CPU performance based on workload
> demands using Energy Performance Preference (EPP) hints.
>
> When auto_sel_mode=1:
> - Configure all CPUs for autonomous operation on first init
> - Set EPP to performance preference (0x0)
> - Use HW min/max when set; otherwise program from policy limits (caps)
> - Clamp desired_perf to bounds before enabling autonomous mode
> - Hardware controls frequency instead of the OS governor
>
> The boot parameter is applied only during first policy initialization.
> On hotplug, skip applying it so that the user's runtime sysfs
> configuration is preserved.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> Part 1 [1] of this series was applied for 7.1 and present in next.
> Sending this patch as reworked version of 'patch 11' from [2] based
> on next.
>
> [1] https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
> ---
>   .../admin-guide/kernel-parameters.txt         | 13 +++
>   drivers/cpufreq/cppc_cpufreq.c                | 84 +++++++++++++++++--
>   2 files changed, 92 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fa6171b5fdd5..de4b4c89edfe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1060,6 +1060,19 @@ Kernel parameters
>   			policy to use. This governor must be registered in the
>   			kernel before the cpufreq driver probes.
>   
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register support.
> +			Format: <bool>
> +			Default: 0 (disabled)
> +			0: use cpufreq governors
> +			1: enable if supported by hardware
> +
>   	cpu_init_udelay=N
>   			[X86,EARLY] Delay for N microsec between assert and de-assert
>   			of APIC INIT to start processors.  This delay occurs
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 5dfb109cf1f4..49c148b2a0a4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,9 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +/* Autonomous Selection boot parameter */
> +static bool auto_sel_mode;
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	/*
> +	 * Enable autonomous mode on first init if boot param is set.
> +	 * Check last_governor to detect first init and skip if auto_sel
> +	 * is already enabled.
> +	 */
If the goal is to set autosel only once at the driver init,
shouldn't this be done in cppc_cpufreq_init() ?
I understand that cpu_data doesn't exist yet in
cppc_cpufreq_init(), but this seems more appropriate to do
it there IMO.

This means the cpudata should be updated accordingly
in this cppc_cpufreq_cpu_init() function.

> +	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
> +	    !cpu_data->perf_ctrls.auto_sel) {
> +		/* Enable CPPC - optional register, some platforms need it */
The documentation of the CPPC Enable Register is subject to
interpretation, but IIUC the field should be set to use the CPPC
controls, so I assume this should be set in cppc_cpufreq_init()
instead ?
> +		ret = cppc_set_enable(cpu, true);
> +		if (ret && ret != -EOPNOTSUPP)
> +			pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
> +
> +		/*
> +		 * Prefer HW min/max_perf when set; otherwise program from
> +		 * policy limits derived earlier from caps.
> +		 * Clamp desired_perf to bounds and sync policy->cur.
> +		 */
> +		if (!cpu_data->perf_ctrls.min_perf || !cpu_data->perf_ctrls.max_perf)

The function doesn't seem to exist.

> +			cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +
> +		cpu_data->perf_ctrls.desired_perf =
> +			clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +				cpu_data->perf_ctrls.min_perf,
> +				cpu_data->perf_ctrls.max_perf);
> +
> +		policy->cur = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.desired_perf);
> +

Maybe this should also be done in cppc_cpufreq_init()
if the auto_sel_mode parameter is set ?

> +		/* EPP is optional - some platforms may not support it */
> +		ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
> +		if (ret && ret != -EOPNOTSUPP)
> +			pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
> +		else if (!ret)
> +			cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
> +
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf for autonomous mode CPU:%d ret:%d\n",
> +				 cpu, ret);
> +			goto out;
> +		}
> +
> +		ret = cppc_set_auto_sel(cpu, true);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			pr_warn("Failed autonomous config for CPU%d (%d)\n",
> +				cpu, ret);
> +			goto out;
> +		}
> +		if (!ret)
> +			cpu_data->perf_ctrls.auto_sel = true;
> +	}
> +
> +	if (cpu_data->perf_ctrls.auto_sel) {

There is a patchset ongoing which tries to remove
setting policy->min/max from driver initialization.
Indeed, these values are only temporarily valid,
until the governor override them.
It is not sure yet the patch will be accepted though.

https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/


> +		/* Sync policy limits from HW when autonomous mode is active */
> +		policy->min = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.min_perf ?:
> +					       caps->lowest_nonlinear_perf);
> +		policy->max = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.max_perf ?:
> +					       caps->nominal_perf);
> +	} else {
> +		/* Normal mode: governors control frequency */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -1038,10 +1104,18 @@ static int __init cppc_cpufreq_init(void)
>   
>   static void __exit cppc_cpufreq_exit(void)
>   {
> +	unsigned int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);

If the firmware has a default EPP value, it means that loading
and the unloading the driver will reset this default EPP value.
Maybe the initial EPP value and/or the auto_sel value should be
cached somewhere and restored on exit ?
I don't know if this is actually an issue, this is just to signal it.

> +
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
>   }
>   
> +module_param(auto_sel_mode, bool, 0444);
> +MODULE_PARM_DESC(auto_sel_mode, "Enable CPPC autonomous performance selection at boot");
> +
>   module_exit(cppc_cpufreq_exit);
>   MODULE_AUTHOR("Ashwin Chaugule");
>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
