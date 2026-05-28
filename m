Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCF3B2FFE;
	Thu, 28 May 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970112; cv=fail; b=TOHsjrr5wDDxNBYQsjg47xbtI0FL8y5yedRGOtTq0q3ZLQtAKQWuImwSI/IppYAe3i45DzprvwWMajKcMYjVi5LBd7q4KhWN66MAN3Of/mf23pfxd9zsttJfaVhfmUb+FdI9XydjLezpO6mEYgHCfyWWxayPFPszAVp0MVfctqg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970112; c=relaxed/simple;
	bh=HBluEzRoU29SiML4n4BRbOWEYAOHM26TqcFf+//g2t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FPX5agDwd/B2jfwIP1k1UQ+lcyOkU5S7RyBDt79CtU4ori3G+mUUnSH3FMcMUTaA9yNnnVGTWD84L4u4g5MNwbiX1dK2bP9Eg+3+Dhdo3qWpMzimRQxcW3FX3BsZz1UUdJ0qgxaqfDSvpsi4Y0FxBE26QzwFOCaDgNzxyO4tqbo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CScedXiw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CScedXiw; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CScedXiw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CScedXiw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=y+Ay+hCiqkvGPLYGcpNujdSZACOWcg2OPJgRA39lWrwVUtJPOgftgIB59Cl174uCqtpDehPtiMMuFd6UOZpJh9JJsrUyKTaGjWKdu35s8JcpJIDSsT6ZgKXTZ5xTbP6P8gUAzpvJmjcy82Y4DvCNgIoe5twHDG5zMtm7AQnT9lrP6JUPD8fdAiiLVZwTkJfqObcpvJJkcTR3k72aDx2WDR/EU1GlvkSBkmJ5tpvCon2yXchxFmB2yJy6KK9DDlRnUKbLEkipvVrNwonhXSPni1jTGm2QMoWmPtJ/5cg2sMMSt3vEnQMkXbVILCyLFPAvL0+ez7pZ4GB4ECKZDSaAZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBluEzRoU29SiML4n4BRbOWEYAOHM26TqcFf+//g2t0=;
 b=YM/jY9b2tlvEWdSGQJZuBkWq3q0KKtQ5jfuW6PC/ydyNXonH/vbJcZZfHw2XbG1SVONxpB2lxEqqmMl+xlsDoWnn9JaEQb2//GNWZcRYHm3IU2i3Zyb4jxNVQPBWRkyq7MymfQPqvL7yGtbYYRW8GNwpcyxI4Zsc8uMrMnL9YiqmqMSCXcRiJpW2T43CatOTqrTKAnOReNo2p+FzyBzsXiuUhw1zXTyfNIglAuSGh3OPXed4Ll8pS76iGJmnRD2XRYAOwCN6uxVpMACVbZBtmXUaGDK5dReIkkNE/7JKVbA53+anbKxU+qnEv77UKPA9BmcndoWMTauqj1zcPeaOqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBluEzRoU29SiML4n4BRbOWEYAOHM26TqcFf+//g2t0=;
 b=CScedXiwOE2QuyRVGyi63GwLH1qDWROo+KlulADZp632qg9ca4pgG9FBdu7tHIsncjzyt6Y+fJsckvxikTGhYA9nUE+fU0yH8Zhgu0fp4uxc5TezaxWlE6WVXE+xfcjDfxT4F5YsVeffci+aL41KpElISdBgyQN5+bB+d7tYGM8=
Received: from AS4P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::18)
 by PAWPR08MB11455.eurprd08.prod.outlook.com (2603:10a6:102:512::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 12:08:25 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::68) by AS4P191CA0024.outlook.office365.com
 (2603:10a6:20b:5d9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 12:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 12:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgxZ46O6y1u7+/dDatOLICUgBniv8McMaQIdnb7y2H1jkJPCiHA4j/KNiC9yGqq6WZpu1TkVUcdJli/ZefTNPcVM3wWw9U71EXWNGyv6vpIxzZ94U7llxWKVqz/FkwA/VdXphn0TbkRSyufaFnZaowrmFPOQfomhV9+TeX63It4JsuSjsJLYM6rIyBCTXgHB6lXWMmok1JhjkhPTLEYA0q1gYwHCXP+VwBjwcUSmWTZ0ieJ9LyV495w1M1lyMgxVdOH8NGZjE2kWvn0o7IkYiwHvH/EjAvKL3wZYTCIjsf7SQi1sRdFxG6Pxk0DhRj+HsXatw65W+4BuV2tv7/bSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBluEzRoU29SiML4n4BRbOWEYAOHM26TqcFf+//g2t0=;
 b=X8CXmd5wepisYpCKwwDXsGdNERCKKq2H5PKA7+HeIU9ktGN80gfoPYA54XISF/SW76juuowcBLsdocniXTHUcYq+FCK8edhS571DyxeTwZa1ipqnyPenFnIzSr3yPYGDneQHkTUgsCkuWHkHO/5bR/SzvZ75Wpmgx+8Fc0ShbcYT3wi9Ur83clROOtXN52xZ5YthaS8pI+VRKHRrtANdmz9bi+E0ktywzF7hvllH6m6s+qN1LjkMR7VfD4Rs8F7/q0WEPOUh7CP4bnNN5aM2AWeOR2fqdfTsI2v4uIGYPvpsavRy9yDu56/t0Uv9yu0HNEybo8g1b1/1rmoBK9p47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBluEzRoU29SiML4n4BRbOWEYAOHM26TqcFf+//g2t0=;
 b=CScedXiwOE2QuyRVGyi63GwLH1qDWROo+KlulADZp632qg9ca4pgG9FBdu7tHIsncjzyt6Y+fJsckvxikTGhYA9nUE+fU0yH8Zhgu0fp4uxc5TezaxWlE6WVXE+xfcjDfxT4F5YsVeffci+aL41KpElISdBgyQN5+bB+d7tYGM8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBBPR08MB6235.eurprd08.prod.outlook.com (2603:10a6:10:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 12:07:22 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 12:07:21 +0000
Message-ID: <86780f97-29ee-4a72-b311-38c89434b707@arm.com>
Date: Thu, 28 May 2026 14:07:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
 <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DBBPR08MB6235:EE_|AM2PEPF0001C713:EE_|PAWPR08MB11455:EE_
X-MS-Office365-Filtering-Correlation-Id: 73eeb0db-e578-4a01-077c-08debcb1d219
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|921020|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 N3w2O0cEplBgX9cJo4yKQZ0BnRW7IkC0NmA3leBZ62eFCKvBnIWpZbSan5trwNxQi9QQEe7VtaaNv4fTddXEji8nSrtFRcSElWuRMKry2/bXFoXB4KF1QTVH5WuSD4OrHiFcg3RihUAWyQ983gaorHT4JDvNNJ8pfOX86mpZT0vZMFxvzFzaamVxG25PSFjSjN/ps3F0uBFkU/FpB2hAKt/ObriTIIpptdbOGE9hFFT1p4HLH24+Nd8imteU2IdI2w9lIaxSyURTmXj3wPhi+I+rURXPZH97be/81nNclSDwuJ0vHK9AGmPEQ33X5gbA+BRL94gbw1Cz+U4q66nbkvNkMo8tbGsJ+617fGJaMSRjzAt/MgYMMOl4ZBzz1X59soVfFoMQ6jNBZiwjl4nioiYvlsKTxi4CpQb/uFagIhTjaw6zAmqhCr8F1cI2DOF/Q7Ev2RYHTF3QWN7IzuQgERIEFaZTHuBt1VbntbTTaYDAR2liVjxKl6mvHNGKcPD2EpR7LRL07KtejAm1TAjjw8st1rWdLDQAiLcPfz31ilLqNJGkE6o4jXAKNfk6uoHufvVCpw16jr481o3P9teGoPHWZzCfeul8hmhGjdIqQeIZlFAvcxj8uc4j94j5Laf5CTSt4j/OlRWbKdQcJXESYhScgAQEb4X6Ww9pu0hXngp2poS9tLbaR7TzeAoIBsKJZaSK9tIQEpPz8A35tqiMyZURVqzQ3Oaef1RVxPA+lps=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Yo7W2rGdfweOxVvQVCXd7xIwXAwQcMkpm8Na/vGYuUANKcJgCDloX6pfDtOzw62LNJBpyoSqTdLk1L/u1BH1KtkEjSP5/hsbCuR/2EfTdmRSikxROtp0IzR4rdzsoJR6YOnf5Bjddmc7UhJalAABwCp8Z6B9MY7Ldqj/uGoRMVwCkQmxCNX5Q+3YB6e6g66jIAAzMLGpSIjQ4HZDIPUhYoJ4H5GkVi9CWv3wYklg/bxrkFC0n5s6hfmS30929OE06dWStvFbhHePx1hBla78xb9Rk1GjSmFEl/FD3BH+6Z/Ep4lqDnw4ja118w2RNPkzAnhwMsnlO2TV8GWEd0ukiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6235
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	99a0e292-7568-4cde-e49f-08debcb1ac17
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|35042699022|14060799003|1800799024|921020|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HQVAvci6JH0HjndTbe6SVfAEooszKjvwXeBrUx4ggnH7gHP7BvD9Zd77+EsOT8Eqllth/U/AMk/IeFi0QaBi+7rqARMxwMyshcXAFVtudMbvxm3jS05Ryb5f3bc5qslCaizEbRXUws+2GSYTIL4/3oRyxz39n7nvnSlAT+7jU3xZZPCO6gmDuK99WKkGuilgER2Ea/P48UCikM7WG7sZe/6EUUA++aHPZmcV2vHZtjJVXwcx6gyTCZ6IrT8zY7jlRFxPNms12jlQdOReSd6VP8r60UkFI1CoWm5TbeGw2lw4mWv4jG71NneFZhh5hsO/Z392xGfAzBh0Djz07boeWWZe/O0KYTOhGSKcdijRAQRH4etFcSV9jvqPTHmU8qjewRLNY8z9OBcO8UrB8DoSp9L+KK2cJC+K6kvc1kBY5dmA4N76xZRNd0Lf5kZSadK9ScSv9yy+CjDgUlD+rAERB0+T+EuPM1zJ4oPCdFpYrMmLja1Lb5HX9cyMiFM8ULkW/eRznfR7wnoBvO1yEF9CwVzUhM2ffaM9sBpCUMeN9JfLL8jYO+mNvI18X8MKUd2+cf1Fnl/IITcO4oEsVf12Ywy7WrmXncSAeGYA6/FSYklieRYCnRNFhgD20EW5AmhgSOXFhnC42RGAmadZPhXVQbPCgYIhtJzuere9pC5lW6TO4hCb6DSm4OjUpSxvNDK5z7YohbyNuGG95ucRIkobMLq1q8pT7z1OOTHAVAE90MJv8A1ChWFEMK67I5Sl7jHQNGOqvBUp4NUN4TwZKjAbMQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(35042699022)(14060799003)(1800799024)(921020)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vr7kUfBxD2yxIdDU3J0U5UW1/+xBkZZg6Mbcf6E91JrHoHKxO9FW2rAa6ngSEgwEbLFplVoQv/seOXY/TBizfRdMHn+ePXpSqGT6YGuKwpTX+Ho8zIiZD4nd+4uZHz7YzH1krmVJmFmDwB3D7XH49eQXtVeXalyjJTGWqalAV6FG5P7wvGt6DF2BDHk9roqSeGHdUQP0FInBz0NY2YAtMIEW+drtRQ8bWoswPvnIH33wo0aS793mGawk2uIRnzjZb4JM88iD0AzxgECEKtlkS3qvjRIITB5CI1S66yio5s2N/Q90G1MnZMhmVQ/PZ6JB1SaJFsQhsQBH2Pg32qg5a9OdlLWwGdE3CtuGRrXLkepZXTpag2DLb58h2cAKKKmi9jGz7vE7gLkDrN0/XVMlwHfGKY2Yb+NF8WPL6MuhQmjLHjlXI46wXyCZ3M1dHdaM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:08:25.2318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eeb0db-e578-4a01-077c-08debcb1d219
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11455

Hello Sumit,
>
> Hi Pierre,
>
> Thanks for the review and the complementary patch.
> Going point by point:
>
> 1. Rollback for a partially applied multiple CPU write in
>     store_ospm_nominal_freq(): Agreed, will add into v4.
>
> 2. cppc_get_ospm_nominal_perf() and the show/init/exit coherence
>     checks that rely on it: I'd skip these as the register is write-only
>     as per spec.
>
NIT:
IIUC having a write-only register doesn't mean we cannot read it.
Cf. cppc_get_desired_perf()

> 3. Initializing the register at startup and restoring at exit: In v3, we
>     dropped the unconditional cpu_init write so user values would
>     survive CPU hotplug. The spec also makes the explicit init
>     unnecessary: "If this register is not provided, then OSPM must
>     assume that the OSPM Nominal Performance value is equal to
>     the Nominal Performance value.". The unwritten default already
>     looks well defined.

The concern I had was for the scenario where:

- the driver is loaded

- the user sets an ospm_nominal_freq value

- the driver is unloaded

In such case, the ospm_nominal_freq value will still be set to a
non-default value. The modifications suggested previously would
allow to handle that case to come back to the default value.

FWIU, we have:

+------+     +---------+     +-----------+     +------+
| User | <-> | CPPC    | <-> | CPPC      | <-> | CPPC |
+------+     | driver  |     | reg       |     | HW   |
              +---------+     | interface |     | reg  |
                              +-----------+     +------+

So if we want to handle:

- the case described above

- the case you mentioned, i.e. hot-plugging CPUs

maybe the scratch values should be stored along the CPPC register
interface. This would allow to handle complex cases where CPUs
are hotplugged and the driver is loaded/unloaded ?

Note: the same kind of scenario should apply to the auto_sel register


> 4. pr_warn() in show_ospm_nominal_freq() on HW vs cache
>     mismatch: Skipping it since it relies on (2).
>
> So in v4, will pick up the rollback and leave the rest as is.
> Happy to discuss further if you think differently.

