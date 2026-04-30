Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56715351C1C;
	Thu, 30 Apr 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566411; cv=fail; b=PLWTDudpypfuqajU5PkD7ldwRNjsYyD+E21Gs/WQ5NI2J2+PcPTdMcpnzx6Crl3ijLVPEc4ivTAMGGUESXEC8PhU1tj6EmZRo2VC1ax7g1PUyXyGTLifiOu6K3egc87t4b+0oRRv6IDCV3CQC8X7eSFqPDAeKzpV6vr6mgB/Quc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566411; c=relaxed/simple;
	bh=SaAlzw1cx1JgJ3GIWSm1bixzG67VXao365brfBucJGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=izGUWA1kvRV7ykja8+98RfI9By1q8mch83RGyFUi1RA4MCugfx15vZBFvPEU1gQhSIV356KciuMjQ1xtP+bQUA1H0UEkQnoNstfY4iB8DZYujkTNN+xYdybZClOLxKjVqwOWbULcKkjnPydqS1lMRwNrlQSnhu0Z4jEvedVFXRc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cyrFoNgv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cyrFoNgv; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cyrFoNgv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cyrFoNgv"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VQGnlKv7RNIplr0fvYD3rX6Mf/zBejeelxU/vrTY9u751JBSpusmqTa6ZkrnPsJWnDUdzrgNEk3N8UretpqYwyuU4aGHKBWXyWFB97FFNUgKGZ4Tww911pObx3VaO6/iaaOIB/jT8g/nIMqRq4Dv5+JsAHAb6HhnDpMhO52AOeOWrksAPKDLr3PnOFbCygJbnWyqhg21gmCbpiAv3jvpheJTmc4ukWpL8F2t0K4UkTEEUrNvs2uSBh0Gh+Ods5N460499/X3oRaSCRJARrmruxVsrNw1ocRurZG3SAB8Lvh4Z15uNACivmhp9wIA6nr/aPg6pv73QGPdbHyw3M9Qmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W4qFj8VLz7QVaoCK5FlhYTz3sB3QdokN8qSvYvzxBA=;
 b=Yb0iDonhhAWPjumcqAb5cE90nEA2k7bppUBGGrjJSWrllk/0oMOure/Ts0NN2I3spiZNEGTZRaHo6LG0OSgNIDGhaxDn50ZrY2wJ64Yo16rd3T0zQa/8qhqXlpoUHVZ1jJ7GkF0fCeuRKA57uTzEX7NoZuHzfNk+dzzeNoVK1HPeVwmuxmCCbw8pMYrhT7XMneJCn1OC4AHr4lzOZfnXSL9IdrvBiUdvmsTQhmtC5+TMJ12M6xOSx9JDEqI7RBbZi8hI0UlE10d4XZEyNRUYewV+jksL+t5nYfTG/CEqUw2RABMbLdalv2FYkQZYI+MKcKT1rKlQzhL5rq8MbSDakw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W4qFj8VLz7QVaoCK5FlhYTz3sB3QdokN8qSvYvzxBA=;
 b=cyrFoNgvVhVBsB+q43wuzR+bGDgWgRviWdGiZg0JGLYidxILWUC0OYprZoxPxpeGuhQcf4tBySLotj/aAYT5KAY5VyymzX/i2t9zRyEiQgy3xszWIAlCpoL7HCMOmaYkNHqkRRSJ2RoOGtAb4lcG1YFdbdytGMxFKvZZBnXOQ8o=
Received: from DB8P191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::18)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 30 Apr
 2026 16:26:44 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::73) by DB8P191CA0008.outlook.office365.com
 (2603:10a6:10:130::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 16:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elG5rkArT7Z3VV/YHGkIzxNDJ1kBHXjogVGLZzbwUOipwpSYWZjC2QDrTdvqAtPdDfwHeYBEpn/fcg3DbgPGPUFM8JdRPz0RZr/YcxeJyOL/gxS3SkOUOMFkNX8mYUNQlN65htjWxa/GGDQSsBMnd5aAbnTEEA6bRGGi9fqhvXZBMdWRBcz66S8T2CqzsJ1x/emMi9D32hAt9O0Q87xahBpiH3YNQIvcV1RaWTCsYEy6Y2JrHKoaGlsNZGg+dVGC2INHIiB0uBMJAfBYWsE3afb9yux79FbiAZYjVwVud+xpBX89hFc7YyzZIoawWo8hjSm+QXLcR63uwIBHsPnDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W4qFj8VLz7QVaoCK5FlhYTz3sB3QdokN8qSvYvzxBA=;
 b=jHlSprLea+tf7b3orPJVihyzyFrnt1Ej/sqzzTc/K4nYyi6wP/DrI+9fhnXzf1uFWicecGhYBWVA16aQDk5/3Izs8yBdRU6NGc4+NY+wQhH2IW4qF6IF7U5QLOPrODulE0pFkS7M6aVXHOFplRPcbh56+E0B1l0yRQlyYkUFvLE+Hg3ICPgyKTg97ppC8FVn3JLzjdjsrEG+a8M/d6xWUGzD89AT1uDhCyOxd+FHZmPfH+/p/5zQXFYrOeedmt8XJusbh67XWMXhLTPUugHGwdGnFHGYGHSb8emBaVNWB9/uBXW8gN0PVNu51fhd3RPMISV5AdnaSPxm0UyC48p/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W4qFj8VLz7QVaoCK5FlhYTz3sB3QdokN8qSvYvzxBA=;
 b=cyrFoNgvVhVBsB+q43wuzR+bGDgWgRviWdGiZg0JGLYidxILWUC0OYprZoxPxpeGuhQcf4tBySLotj/aAYT5KAY5VyymzX/i2t9zRyEiQgy3xszWIAlCpoL7HCMOmaYkNHqkRRSJ2RoOGtAb4lcG1YFdbdytGMxFKvZZBnXOQ8o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB10267.eurprd08.prod.outlook.com (2603:10a6:20b:647::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:25:39 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 16:25:38 +0000
Message-ID: <8516aeea-f20b-4afa-a737-1dff636f5c2d@arm.com>
Date: Thu, 30 Apr 2026 18:25:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <20260430142430.755437-3-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260430142430.755437-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB10267:EE_|DB5PEPF00014B9D:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eb965b-9ba7-45df-eb6f-08dea6d5439c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 h7rmyB3iGG0aT1Ckwk33x2S+op2wNg9bLjRS4aP98IYOVsB7TV7KM4TzXn0DxqWXkIPXEfFLUFfgrrerTx3ekKYX3W7hOxlKi3A/qrj8iqfGQAelSSB8ayZbcEZtU+xoN022lHD/oJByE7dz+hHw9s0k+IYgw0JgQ7i1+OB/oyn/qt/OkeZSNBchq80TN9bF2PEMys5g728Kp0G7W4TXUgJh2zURaZrAr/XEX6FPpzIen22wzB7QyU+OmXjDUpPQ+rQ5k20TfHCCDeGbXnZKLHIWYKcu1JW2ICpt8FWEUEcTiC9o+2EV7dCXeGQ7zoUu5O0/hk2pmjo1/MGkF8oVygpDic55wEeYKtFfwReTfeufvCYkJLGpcFEzZFAZ5slceR1F7EtJaXa6L2WMt3MCsGM996Pt7KG0usyC4/fjDnjDvj+gTF9DA0IO0HZyK26FyUvTIl/+3UubjJc4kWua25Hct5AW+HGXf6aJ/UhQP1eTUTIzJD0ef00M7LBcbQnLw+iIWeir81XXU7j+RRgQm40NMdyamKUJVrp3oWZgVG4yAVxVk6YCVyt2f1OoGfDQlwnfnLghls5dW0hxKByd315Pbd5Xc0tbCxY97k3/kYRSFo9YY6b1hlABP5Hl4DuoYT99HTaEPpK+lAzjyCtIIOFJ21kMFaBwRlko3Bd5IMhzt2tgT7fIXeGdPQD7kKW2jxBUARv38aGIwTcpzE4KfymqXMS+Dh+ye6bLHQ5OOdtf8XBUpO4LZIteGAL+KKokFHC3FHnUA6NreXxKIl5IRQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 LLqmNeXZqGY2LzTk2SX9m/uSSng5j7un7RvGj9oqovK9mQHPRumY39PdHnG6HJHwBQtKLkMP1i1zbk0gaSX+TrGykjB7zOQmUtSzeIG6bUwmzu7idOVVDZ/xJTp9bybmGzQT4N/163ccgyPaL3r1M4/cZZ7PwYoymxqae0WaKRK9v5H26BcPKfEmwF82b29aO16ryE5QWpehZvI74ZG/pjK7IM8DwzMOhMXqrfRafL/30ZFIUH3WmQoTPbavxUFTbzyPierKs3Vcs1DNQufeMCPN7bSYpBOK3S3sW11nuhRqpbpeQD3zgyaIxlAyb/1U4WdMAYABVPIaF31W2FK/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10267
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1f128407-3d49-400a-e9f8-08dea6d51d93
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|14060799003|35042699022|82310400026|56012099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OZpsMjAYYvbzNeb2/UqmsmNhcBlFpXkWjob1D5xPyO9dzCz7XthoCk+tBi7WEAxIo1Zu4J3gZ+Xgn115OkXHusWL13GDKt+2DyxFbTjkBMHBSHEfBvWjOvGcHMapqj43KSNgZzFVIvQmVRx9kaJicsfR0xu+oCcudqirmMoXdKtwHOqlJnDFoaVTkq5Kk9vF7xwqROAoPGPO6hWRuKgiZBKZLXYpAPbZ8OySLuEC2LRfyMYDjLOyvnkkFOFbm4ERyT4pFtZYDsgS71SPVG4LqE+kDkpeM6ODwHRbZ00Wq9XuYMSdKhxQOYs6lg8uozNPn9nvRgKS5FyMx4q2YK6ZAmRfFMHTe+rwfchZ0iyB5zgBy0H1jFjSt/3Z6qg8RfcR9geRIDmZ++rv3olBcx9X0Tq9o/9hsz2cLtAPkTjyp7erSisrT5BStmLCt3a6yiEsCRjnWnZZ0+402+enKI7zYocmq2pjwyT0bKjPEBXxVMHSLOeiBU0utOalLTyJ6DN/2JwGqwPazfXTnutMtuq9qa5LoPloAhncbXN/rp716EEA3aYRRbbIdgdNEdZDHqUjPmAnhEt5qfo0FDygvV/VtJWGgkdH7Bu3FoANeYagvYoWWu6JLGKRQ1j8+REAQTycNoOISFvyXZN+R0EBW8ltMTf4FHtOGJnz5DXpazFUatEFsDXvJz+CZNjzHpLezih5dvkRAq4WXMsN7DivaHSRGpQoVNxAOlMv9+fL5EopTzAchaKQWTPBeX9hsS0kAjZKvxVjH5g6BiJtMCiFnkP4qV0Xtt7xVRL6eL4YuzgWulG/2T2BjTix9HfWmikzYZbj
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(14060799003)(35042699022)(82310400026)(56012099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hAGLw1ZMVy3RlrIkO14YKdo0aemQje89D5WsLtHJUyaxYdGb3Rj95YK+6i6UDIpa4FcEU61qLHGjcOYHwvGy+S2wzMGNFCm+RT5LrNyBIjdoVN54ccDPCwQA4Hm+lTdSAvMnnfxEUsOLzdCtEnUKrpiaSpum4VCQn3URM6TtORBiSCpDQ0rEnD8U5afUKXwKMcr8eIZJNKd/rC55bttYfl15pQ4C7c+PxIobmcMhLcsIV+s2UdcUOMyB3d6VBxFnpYfSL1wh/Eq3DS67U5G7Rq3gKkjhamaahVU4hR8dTCUsL5Nfju+jUY4XdJGrjLRgjgNujQ8p8aMye5UddIwURIhbdiMRBkBjzI6vcJuYtSe8fRQfOcMO3KyMQnwje9p0DMJHkiUyPP2l8zvK7TUtCbXon06BKDta/dRThtdfxfFwgyUWyh5TImty5YR77pLI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:26:42.4710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eb965b-9ba7-45df-eb6f-08dea6d5439c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786

Hello Sumit,

On 4/30/26 16:24, Sumit Gupta wrote:
> Add acpi_cppc/ospm_nominal_perf sysfs attribute (read-write) and
> cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
> register (ACPI 6.6, Section 8.4.6.1.2.6).
>
> The register conveys the desired nominal performance level at which
> the platform may run. OSPM can request a lower level than platform
> nominal. Valid range is [Lowest Performance, Nominal Performance].
> The value tells the platform what OSPM considers nominal. The
> platform classifies performance above this as boosted and below as
> throttled. It uses that for its power/thermal decisions.
>
> Although the register is write-only per spec, cache the OSPM-written
> value in cpc_desc so userspace can observe it via sysfs, and to
> skip redundant writes.
>
> Initialize to platform nominal at policy init. Override via sysfs
> if needed.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c       | 69 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 10 +++++
>   include/acpi/cppc_acpi.h       |  6 +++
>   3 files changed, 85 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a1c91ce20cc8..fbc620adafad 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   static struct kobj_attribute _name =		\
>   __ATTR(_name, 0444, show_##_name, NULL)
>   
> +#define define_one_cppc_rw(_name)		\
> +static struct kobj_attribute _name =		\
> +__ATTR(_name, 0644, show_##_name, store_##_name)
> +
>   #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>   
>   #define show_cppc_data(access_fn, struct_name, member_name)		\
> @@ -211,6 +215,38 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   }
>   define_one_cppc_ro(feedback_ctrs);
>   
> +static ssize_t show_ospm_nominal_perf(struct kobject *kobj,
> +				      struct kobj_attribute *attr, char *buf)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	u64 val = READ_ONCE(cpc_ptr->ospm_nominal_perf);
> +
> +	if (!val)
> +		return -ENODATA;
> +
> +	return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +define_one_cppc_rw(ospm_nominal_perf);
> +
>   static struct attribute *cppc_attrs[] = {
>   	&feedback_ctrs.attr,
>   	&reference_perf.attr,
> @@ -222,6 +258,7 @@ static struct attribute *cppc_attrs[] = {
>   	&nominal_perf.attr,
>   	&nominal_freq.attr,
>   	&lowest_freq.attr,
> +	&ospm_nominal_perf.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(cppc);
> @@ -1683,6 +1720,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance allows OSPM to inform the platform of the nominal
> + * performance level it intends to maintain.
> + *
> + * Return: 0 for success, -EINVAL on invalid input, -EOPNOTSUPP if not
> + * supported, -EIO otherwise.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	int ret;
> +
> +	if (!ospm_nominal_perf || ospm_nominal_perf > U32_MAX)
> +		return -EINVAL;
I think the spec also requests to have a value in the range

[lowest:nominal]. As these registers are read-only it should

be ok to read the values here ?

> +
> +	if (cpc_desc &&
> +	    READ_ONCE(cpc_desc->ospm_nominal_perf) == ospm_nominal_perf)
> +		return 0;
> +
> +	ret = cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +	if (ret)
> +		return ret;
> +

Shouldn't we have some protection against concurrent accesses ?

> +	WRITE_ONCE(cpc_desc->ospm_nominal_perf, ospm_nominal_perf);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..d06cba963550 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Initialize OSPM Nominal Performance to inform firmware of
> +	 * OSPM's nominal level. Performance above this value = boost;
> +	 * below = throttle. Uses platform nominal by default.
> +	 */
> +	ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_debug("Failed to set ospm_nominal_perf for CPU%d: %d\n",
> +			 cpu, ret);
> +

IIUC, if (ospm_nominal_perf == nominal_perf), the firmware should
not behave differently. Is this really useful ?

------------

Also this seems like there will need some synchronization
mechanism to keep-up with the boost state.

If the ospm_nominal_perf is lowered and boost is disabled,
a freq. update should happen. IMO it looks like this could
be handled with (another) freq_qos_request.

This new freq_qos_request, if we name it ospm_nominal_freq_req,
should only be taken into account if boost is disabled.
Otherwise, if boost is enabled, ospm_nominal_freq_req
should be ignored.

------------

Also, the function seems to set the ospm_nominal_freq for
a single CPU when the policy might be common for multiple
CPUs right ?

The issues this field raises seems similar to the auto_sel
ones. I.e. :

- concurrency accesses + need for a scratch value

- what should happen when unloading the driver

- the value can be set for single CPUs but we might
want to have the same value for the whole policy

Maybe a common solution should be found.
(I m not suggesting anything right now unfortunately).


>   	cppc_cpufreq_cpu_fie_init(policy);
>   	return 0;
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..3771e2ed507d 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -86,6 +86,7 @@ struct cpc_desc {
>   	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>   	struct acpi_psd_package domain_info;
>   	struct kobject kobj;
> +	u32 ospm_nominal_perf;
>   };
>   
>   /* These are indexes into the per-cpu cpc_regs[]. Order is important. */
> @@ -180,6 +181,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -266,6 +268,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>   {
>   	return -EOPNOTSUPP;
