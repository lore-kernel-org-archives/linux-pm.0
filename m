Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8023E5A21;
	Thu, 28 May 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970443; cv=fail; b=KG+ILdzAvDeLEHVAdik3kbfgisBXMQ2vWELh8mkGVC/FbpfuUZLzCZ2nYBsrtgLrSPDb6vSqsItvm0zld/jumzmmo+bHj2aCHCN1axfz4Ji2wdHI3lCg7BVvntdW6+a/xns7vfgsmLQMT47zPQ/1mnkxP2fowYKDe8SuaR6ENgM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970443; c=relaxed/simple;
	bh=z2GcthuIPth0uaF5eJT8WLOLkiL2QaWZ6bzP7lLVGBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKYCx0BJKCxqHbLfFLTc/iElu6EH3MzmMDS4CZHegYN+0UrKlGRyyoj2t9HKeVZ8xXYaOpiI5a5ULa/MBRmU3WEkwWUvkcqP0dSM6/6XUaT38pngYRzIOMz5nZAKidDIu4VLGO903O8xTBW7elnKTMpuBtmFj2K1bT5GzMRHYHE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i1qK021N; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i1qK021N; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i1qK021N";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i1qK021N"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EhWwNslChaqPbh1jdz5LVPWkiGatX6UJpa2hE0Qh+UAYjtqLUUpYAovVh9svLvbD7QEgzYM8xciYuBnqT46gYcjrCMCh0NanFpVC9JICVbrUJ2ssd8TlN8B/G5STSJNdNpXVULQZDsf0Ysd/urr+fgm2RxHkrAP6KykEcsjjaUM18ABdwnptXk6Y6KMuJCLp0T6DVfplUgW9vjyIenuv8VNkYI9gjer0r+5NOHZ3aTgGOVD3bNjc9LHRsOopV40+MbF7w4Av46uIi2rwxdpUfKwihFBdqCL9jHUZQfPNBCw+/WMfhvd17F/ep6J5K6yGAUxqm3NzP59C8muuvda0lA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjOUYr0Mpz5A4D3v1RbD6aybUPlPwai0SnDSCUbwSZI=;
 b=HkPzLE49xm45bm0n04KsnbpfoayjtzHmTeQwQncSB92rkmhnlKkYbFcZRNzc6AuUkMDZK0oEwnAhQZbNIgYj7NImeWAwoDr9XYD8QOIm4gfKHWcMb5Be8xs5NmbnReCEdk0h6lBuPQb0Tp6keXupGaenn+9pUVgxsiugvBz5eR39IKoOc5hIz+1UCQEYmUYKPWnuxPGlp3HsnlP9UwMqNB4+3+5wV0O91HCI7GyJ+isN3OugMLX50FHMAe9altDcHM7SFf29xDZ4FtXN2iY6VNym01T3cr7df/BulqSr4HjCM9qik5lS8ZV/MD/yA82yNyE5UXaLvMuOpFX/aBrLtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjOUYr0Mpz5A4D3v1RbD6aybUPlPwai0SnDSCUbwSZI=;
 b=i1qK021NAGSSeQRNEH24d2QjOSEFLYbVxHwZk4RYQktN0x2RDLIGVh//u9zMZq1cYdR8Vqd+5UcwYgXreIkndHsbAs/PSm8TKYFLHAjpzluZPrTuUhvKd5muGkRHxLLpu80RjrF29bphN+7vYXcxBzC3sXUhvwltoji1njy49mA=
Received: from AM8P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::33)
 by DU0PR08MB9824.eurprd08.prod.outlook.com (2603:10a6:10:443::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 12:13:54 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::3b) by AM8P190CA0028.outlook.office365.com
 (2603:10a6:20b:219::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 12:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 12:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2McfKhF+CLiGBGjr5YCU1OhfjGt/ur6hXq2OrV2K2BVyXqoE/lB5x0w6u273HsGPrrT2rqU0uOZHrP63X45zKOwvSLsrffjg3UeA+QXmbE7smQQYEqqD0K343u2yC50/jYe6+azYVzxWNAGP8+Q2MH//UtonqwV7LBTopLM4I0dULaBiTv2AzeWit6R2Ns7vJ61tbL7gsg0S0yABvk1m/egRu39ifMuQMAvp2OY5cngwLQIQUDWJy4aKRzs0U1qaZLehw5LCQ7yCGWSlk4mjfSV/sXH3Z2sXP2SX0pLEzz5tof7CQ8VAi+Z0pmwo+R1QhCvjyn/disoDY4SswCH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjOUYr0Mpz5A4D3v1RbD6aybUPlPwai0SnDSCUbwSZI=;
 b=Ngmat1VhOdXL3j85FGeb2DKTfrw5ZPcOln/uuZAtc5JmEbuskbeXnp7ZVnO4iqyRFeb86rAz5k+Lejj5H5qPg+ToxMr74I76NaFSJ+08mLfuGshLX9W6xKv4syL3kxz/hjbHDDWmRcXYOw7+Bois6PXfMwDwsWW8Q3G24Ozuf/jK/fq0+LSgyh/zcV82SL3ySQHXPFT+dC9+8IdLOhocnvKiHhrt9jH0fl4bjGNK67AKVx0Qz6mWD56HfaQuocexcNk/4zCbx4xSggno1kVcJMKl7SG8BLw5uGFtcP+ENCW/EWQLo90fDh9SsgQZVzhshjfYfsNjRTLln6Rq3rR5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjOUYr0Mpz5A4D3v1RbD6aybUPlPwai0SnDSCUbwSZI=;
 b=i1qK021NAGSSeQRNEH24d2QjOSEFLYbVxHwZk4RYQktN0x2RDLIGVh//u9zMZq1cYdR8Vqd+5UcwYgXreIkndHsbAs/PSm8TKYFLHAjpzluZPrTuUhvKd5muGkRHxLLpu80RjrF29bphN+7vYXcxBzC3sXUhvwltoji1njy49mA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU5PR08MB10398.eurprd08.prod.outlook.com (2603:10a6:10:51f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 12:12:51 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 12:12:50 +0000
Message-ID: <e3528e78-1397-439a-b8c2-22648d66efb5@arm.com>
Date: Thu, 28 May 2026 14:12:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-3-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260527194626.185286-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::16) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU5PR08MB10398:EE_|AMS0EPF00000191:EE_|DU0PR08MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5ff80f-fa5d-4e7c-6eb6-08debcb29611
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 orrRzK6c5HAgbExmS8x/D5EJc/0hW2k0Xub6fqPljp2+UoBP6ZN+sD4gBZ7r1U3ubHTZc2XWeGB/F6vwIFfIOJ467VSVK7tgXfrUCw2tLW6xeNeHNDoidEkuZ5JCTzdS2IYwkWj8DioZ8d6PjWYbusuA1xlNPl/irPc/F74DM3ecx8ot1GGdx5bIZyNqmmiDYvW8ig7Vbdn3amiDyj60zm2o7qhDcDU3NzMHUDyMk5ZV82GMUM2LAnH4rBjBSJhR9GiFP7pzFkm62Ot8FMD8h2q0Osfd8Qd/gfVXWaICOCpq7eVegWPvaqqzBuIUj8jo5bhfklUlC/CfDc+KrAYE2icl7rH9gdu8dsY6hFgds0sDVwiZ57vw+XzBal6BQDVpDO1EsVIdgRcSmqi9Iv+SR5q4wCMocJcTMzWcFUkEZM4ihcOvLwm+Y8Sda74sOuJNS5fPCsTVSNZpGFunvr7FVoO179NRk8M0bdhwmPRSgMHpZCokf8Vwp0D5S4J1a7XBIN4esfOfSqBEx/1ecbjSJvMarBeYR8PnaUeJISzyzVvQTUUBAWuIrirlWBdvlgmDAcauhdp6hgIZj+9BIbitr4v9niWGR7TsA/TCJUsRU4UPdiUsAt1V/yz4zNiYKdX9LcR4XTTY7BNZsfr+9eR2Brs77oLlKP8CC9aMUkUbrvxXsS8BWLSGhv5Jn7kyc0jCJPCPw7J0eLs8o0ItTU6DG60fXQaEO8Dco+8kB5crKuk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 KTTG/OVA5wSui33W9Gpr/mSvM23ObXniCkYzAv4M5wBfoWyWlE65COM8K2KlP/mOQYdFv40sCrF1jABaW6sOqz3csZ/dg3sFpRvdxyFR8u/y+5a84GC12HjHjNRS+UPts+JeTOzk+8N2ePfF4OS8md5Opd87XguBNT8pDw+dnrSqVms8crY2RSkSRsLgJZsYaTd2d+Dm9B9jTE+tHrZfH8K7GYeD38eK/TndY4XnqNy6Apq+nWY5ymGc5nYsICJ+OSYKifRCUYlG8GR1hogiYsOa275myqz9k3m/lUXMFl2+uX2g9blNVnIMHcZ8Zvpn2cOmwfO2NBgJ0/bRWoM31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10398
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1f5d5c24-a66f-4cef-0179-08debcb27055
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700016|14060799003|376014|7416014|921020|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P5Nc8jeZuepENDQ3kUZx12Es9PV+3hfwlEfEi+j2iJW8BfrFTbaNJyU82bxZUPCLUSNIsDGa5VYiQoESYyYse+9r+7wXSSA74gjaMezBas7aPa8JZ2noppOKzwQiLpijCC8Agt3kaJd5bONrtgx1FwRypcQu4w1xmE+7Q7kW+97nc7gkEG64qdpYPCq1XIkuqwaRSRjRQujRtwam4UWxx3DDNwvQ/vJtJpVblaKEwQn5cpcAfRgpFdYvhRtXaKHThprKSJ8YghXgahPIarkt6J4IyWONR/B5vNkEGvkcVi9cMCYAfU59jDBAkBoJ0qoHGOlie3IxSQDapuc5pk1rKagl0tPLrErvFcrCiRjrFI3o8GY4IR/EGnyEw9pHBad8decbr50TznfDrYUY/d/j+Uwz2aXgiWHtRJmKRQRrdcvSWik5crlt8pY8XUF4AQugPPqtLa+GMxwqVE81+l3OE2OGiA+D30/pjjm3PwCMMJEhLLx31bCMhnkpzBWWmyUS5yKZzOuVrEYiFRE77Cg+aoaoIrC89QV6VnPMo8FLoYvP7BimuIBGKylIc6HTTWqW8jj0laMxmij+JYZkR7VJqb/vbj9V8A6auskeH6m5+wpFhQXQz+eisY6a1v2fTxVzDeJTUKrw5Y15x/T6wDmHkNqzKbHvlRFxFUPzucpiOM60HRkDaS2BkmAwK/YWjnuCLj8kzieNfQb5qCT4A4V4UyLN09J3YyVRoXFxF7ZiE0/RDCcg2O++K7KVDeBr97aZjUEbevYtwGB8QPWUditWjw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700016)(14060799003)(376014)(7416014)(921020)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YgmYjRrLP2fxpox6DcaOpH+IElmdEpbA2r8I9700jC5rLn/Cs5BlL0oqHHgxu2ucujWz6vLBIJwGmgjp4QfLwTIcqbjeAXT4s765NjQzBI5GXnV9+JgrJl0du5GjZxipwOiIIEt89RP/jC+4lGzD6EHq9mUz8tDS6GAEJgUeHE/uFykMvindRfBa/Kn360J5UxEuDll0WLG0LlEqeexUnKhdgUc7aj5w0HucnJTnCJ3R4zz5Fg+ZFz9vJwKJ4sIQCx/YxZiZmJvCrTiuP7lu8kIRMZnR65Whnja4UMie55Jn28zzncj18AsyDccEAYmsE7NuQkyX8tqE49mfsFUTc2EITOkoAZb3Q/kRph6cM9HfU+xyB9f5cF6iPsXpi9gOViQ2bDByhLjm1b4W+LMMo8bvNMRzrY9NNsDrykwdTICqOWhfHPL3zPBQDozasi+n
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:13:54.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ff80f-fa5d-4e7c-6eb6-08debcb29611
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9824

Hello Sumit,

On 5/27/26 21:46, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
>
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
>
>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
>
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> every CPU in policy->cpus.
>
> The register is write-only; the kernel caches the last written
> value in struct cppc_cpudata for sysfs readback (returns 0 until
> userspace writes a value).
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
>   drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
>   include/acpi/cppc_acpi.h                      | 12 ++++
>   4 files changed, 124 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..ac1bf1b89ac4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,23 @@ Description:	Performance Limited
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>   
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		May 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance
> +		level lower than the platform-reported nominal. The
> +		platform treats performance above this level as boost
> +		and below as throttle for power and thermal decisions.
> +
> +		Read returns the last written value in kHz, or 0 if no
> +		value has been written. Write a kHz value in the range
> +		[lowest_freq, nominal_freq].
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008
>   KernelVersion:	2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c76cfafa3589..ad6ece16c30d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance level
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_perf_caps caps;
> +	int ret;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = cppc_get_perf_caps(cpu, &caps);
> +	if (ret)
> +		return ret;
> +
> +	if (ospm_nominal_perf < caps.lowest_perf ||
> +	    ospm_nominal_perf > caps.nominal_perf)
> +		return -EINVAL;
> +
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 15a728dea911..5c54af1655b5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1139,11 +1139,70 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>   			 cppc_set_perf_limited)
>   
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +
> +	if (!cpu_data->ospm_nominal_perf_set)
> +		return sysfs_emit(buf, "0\n");

The questions on v3 might be more relevant,
but for instance here, the ospm_nominal_perf value is not 0,
the hardware register might contain any value.

So reading the register might be more meaningful than
returning 0.


