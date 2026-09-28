Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A78C1F;
	Mon, 28 Sep 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598101; cv=fail; b=sF87sv8AYjwu8rX3F+b5qb+j66X67SQRlh3Pm1JJnHdiiTaS7bm03066s4osicJ1y++etC+pDygJTUKFxreZ/TDEjRvPquCO7ba6/tjAGvxMZz5yqmEp4JyVUKYxAXXAD6aOqjIvDuOG/1p0qk31sanIxODituHR5/EN8a0YVJo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598101; c=relaxed/simple;
	bh=sKbaLOJCX8k/cx16m9CphLQ3A3H8f+v3YxonQRWoaT4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKLAHoZFtpgn5AYT25dxD/sOphPxI8BGHFpwPUyztey239QgXeSVkspbn7Muypd27Cn/BOmcDOn8gonOvkQc3+7pqy3vh5m3gkng6sR62hdUjPl5Y9nYuS0e0o0qI/rSQE6s3VBYodGTN8LpPVQEyQFEsL0yxzXjtZz6jGyyOE8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aN0Kaqgb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aN0Kaqgb; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aN0Kaqgb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aN0Kaqgb"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v4ShqF0wDKR8/5LPrNEvKs+0KU/4i+8Xp8MTSWglL9teT1RGCo7CjNXqhJL9s22TU3+g5curFzyCvhY0k2eB7JEHfWeoxsUJ4e7HeM19+RKJqAKlC3L6PTDTz7Rg4ycQIwm9B4Aven3Wfa5AKMFvQYbBNu4+cqPqLTsCjAe6SNyWd4ca2NIgM3l+1LankmjcERSXl/IaRqc7nmzaEMg/xqzBBQTZp23OAKvmEg0+R6eu/w09A8N9DP+cBuahwruAhDMPL4Avy6pezL7HZHjYLJWgIhCKwoAcRsiC9nKDcprpu+1U6hyHHzSy2/zhWhKjXyCpR772Q7x81XomWn5tHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4LIKjwOrWfvVYctLkKsRHu8zcNl6ENsS2P7+2/tYrc=;
 b=G8XjaCqPAanWibh8sBEV5rptzcqlFQ1ijXt+xUTLcGJ9Mss9CQtK3KmImEv2s+mHa13fWXZxSA3Tu2ppeDKRV7ewr0RsPbl1/uwTsyzErzT6HNG5e4BfvGOv5FdFxLM9QuyIwfy3irVCCjIyaqGVfxg9BToA4qtVt8i+AX9TaYKPcvYTbg58d43tFIv4aDV/tSmzwvhyNcAdUvrHDjd3HWeIX3qLr6snvjkGD9cGqkyojl1F6jnvF1fDP81gfEQqTo0GmSOh7VAdRKMD47qL53yY/AWsJ6oFt7bMM+r2OKeaSKa9/Q1No945mFAG5QHjYPiyqiQ8eIFShSQlBij9Ow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4LIKjwOrWfvVYctLkKsRHu8zcNl6ENsS2P7+2/tYrc=;
 b=aN0Kaqgb5ch9fQHe28nssGZMkQpqfOAqlW4AC2BLSFI+D0wT5ahxprMic7jT8AakaUyLVp7p2hDMU6X2RvgxCViVMCTlUNM18C4QXZ70CzZlggla/hqW1ftkbUjpGVH2uSFQLKjQzOtiIXH7hvQ200kxAMCjloEPax7h7O2M/So=
Received: from DU7P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::23)
 by PA4PR08MB7545.eurprd08.prod.outlook.com (2603:10a6:102:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:21:24 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::43) by DU7P190CA0029.outlook.office365.com
 (2603:10a6:10:550::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 12:21:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 12:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZUg9q5jBXxxwRiTCDgsPW8690Ieiy+E9i6aTOvDvJ2ItqbNtFNQ6e+tE9wBgbUGkQy4H3F/aRFlrhdAbMx7nXc3XYbnbsNPvV3GElngogDGigmbC//ZrsMBN1MeXZC3P0hXcW75dpk7Wdoewnc/O+Unrj5t6KWA3UL/5iW0WsP+bBv3U5iMEKwe/kxknviCXPm7tU2dVjj88fIVL9zYwfUfvf2bjCRXTLp23E3KnP2eMY3nTjnxRvyGmvEWHm4L1cUl2VjU3dF8i/KyDTOYmF2wbSU6AhiDwxkcyiOuUwW6AaXJ3J1226zGy9Yowk5o4g8bySo26JqarR4C/mz2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4LIKjwOrWfvVYctLkKsRHu8zcNl6ENsS2P7+2/tYrc=;
 b=fQk5HWFc3zrfLJKmRVX+0VsypvoRgb/pPpl0IH3YTdTWuMR6TLxxu5n3e1u+gqj3EXOxpGuUfEaQmZtWiTGACBSLZ3eD5w1FMZHivMtFtg0veCCAgdC0cwC9jjM9jd4xtdkjbvDPSqnvgRkSUJd9eIFYICojldwwfEGVNk7cswhg5NZr5Ii4nys+VAuhu6xFltipTiQk6NpFtRSdsvqlULgXmhAQH0J+3KB1jxj+bGVsJOLXwVG1gu2k5yFg8e5pQyOD6MxXqT4s7R57yCKdFK4YV88xe3ZwWYdut/fFNYfveHCOEmRrx7OWViajbqcWSjsaEeYxtm5gDaK9XTfKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4LIKjwOrWfvVYctLkKsRHu8zcNl6ENsS2P7+2/tYrc=;
 b=aN0Kaqgb5ch9fQHe28nssGZMkQpqfOAqlW4AC2BLSFI+D0wT5ahxprMic7jT8AakaUyLVp7p2hDMU6X2RvgxCViVMCTlUNM18C4QXZ70CzZlggla/hqW1ftkbUjpGVH2uSFQLKjQzOtiIXH7hvQ200kxAMCjloEPax7h7O2M/So=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB9748.eurprd08.prod.outlook.com (2603:10a6:102:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:20:49 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 12:20:48 +0000
Message-ID: <bb3c24eb-afc6-4683-83d5-9809b5ea672e@arm.com>
Date: Mon, 28 Sep 2026 14:20:46 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v7 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260807214837.863209-1-sumitg@nvidia.com>
 <20260807214837.863209-3-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260807214837.863209-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB9748:EE_|DB3PEPF0000885C:EE_|PA4PR08MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cc5261-1821-4ce1-e06d-08df1d5b030f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|921020|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 81O32JKk4+dbLE0KqeTRFF4wJUzUcf0aO3UOlQSjhwvHsho4t7oDUFXnofH0Yg01rJvLjZeL3yuKMeWQDJlpJHLC8Lhw2iMRbEBBM04W5pF94+Mp4r9gt8JcXYuw4nfzxruIAROhwV9rbhV95ew/lP+Z56hIxj5ki+dgQKxQADLZ/njT9oOvvfAPtBp9GYXbA6vC3WLwDE6VhnSRLRzeVdVNSeqz4yomyDV54p+9Z8hDBEtC7+1bcqTRit/sI9WlZN87tQcCWqwoHpP9h0BRtEvucUw1V5iK2DyS8aVMh9suDAetAqtR8aVzaCwCIPL5QVSxTNM5HVV3TT4gGjRDNRsmHx2NHGdWFzaZlziKykLJQH6EntJLYfxbz7csodic0IYy6eH89sXCCSShe2W82S/RMO5uzgmXR69W3/4kN9VnO/ZVZWi2b274salRoPT+flNACsNtsM4uupp1Q9Wcqa7mk8FGwV6vKF4q29vX6gA4NAoULp0/On8sA5pWWg40OK5JP4T2xtj9hpjoiNgMODY1PubGerkHq/hx6PEAWtKdl8w3XTTgW6vkUiJjxXu8ruEMUXUEkX417jfOb8gv8fur5abxUV5R2paPagDnTQuyIkMTzdeau/sQ4Fj8rMn5fVpUCJ61Xp7EpBHw5SF8h/Ld0nX3PMZ8k0+QiXrVmxsVGtM9KTIMmmnG41Nk8juyrWPFk6Cwfv/MM8OkWlTisQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(921020)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 eJfCOUNONfpogPSCSaBt0iz8dA4o6cZHY9N2eHP4haq8Bj3AWVVNc6wHKw9n9UEqozsr+/Isi1WymWd7XrhwJWiA1GLNaEb9Ca7TOuG9Y3VfNLHt540GApO7D9oEbZFvMRD7x4Ta3P0v7eEN7TBWN/frrINyNIqyKRUDrN9ePtsfFlaM6a8KZ6gnyWUv8z8chv2p2js8Zgdsoh1iE/CWYo/xo1ThZ/lp3takylmhk4UKYKL7wI8B94GUzexbozkEIEmZ0JgrubKFJ6V05pkpDt5WZcX555kD6wsDeI400m/NFT2fkReISIDVWDkH8dEd1RzjcEJgNY/xdWwGVRODMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9748
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	366428a8-ca8c-4fdf-a6cc-08df1d5aedc2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|35042699022|36860700016|1800799024|14060799003|376014|56012099006|11063799006|10067099003|4143699003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	lLg0lZTLWYhykaJyDmV5docMxOhwYl50X2iKVzjpj4sbokGEKigQmylRlbsRn+kQ0YJPHNgK/gIKAnF9BGGSYIXJmU53OD0jpJJUc8hyJ0/FKbLw+/gKhySckk0MrIprwEfL6eDGg8c/tqGrqYXgnM0a2ZZw14Qtr6IuIwmorsjI/HXxhTQYv8Jh/giWIFyEXbSjiQ2k7b8RyDs7M0aSB81RjvCxLR//y7ldRAieFcICGTzs2V0xDO2QZOTwNwcnfGt2k+9T6IlMbUW2bL8sxClzY6aJIcOagJcXi8IhB4athZewDOI0CcHxDyWbI2/gfvLrxG1uYpq8Rhm6we0GUEXgus/ITJdV6ubnoI/kw55YZZetLSZCGqLkOcxdY37a1yKptqNGVxnEmvTbpNMX23RidDAev999uSlaaxFn1hTYKmW88VI4WzMlDiCCqJEqdQJX3lVGA8f+XqZwZNcUX9UWq5XwNe9+eJqLFJQPLl7ton34++NANZHydWf+lC3VnU1LOEVMAk7kW6+L0sr+TpImGh4uc1yUMaXOAPHHauYGkXi6tlQZIkHhhIhoGQF6gUCVWoHjxT5liSmAXWc6dwwzwVT+ybNDQijpl/cPup1wCFw8Q8t0X4xqkQaOVNnDOcdr8ZzND6K3ht7bm08MHu1DIAUW00WkOPVSmYt8qTvDX/hdnnJa5YWJh8PXEzj2dC/8nTZLJCg6/Tcviv6wTj7IHG3g/4YzKHKyWYm8vEr5SMRhr+SpcF8FUbRJobb9
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(35042699022)(36860700016)(1800799024)(14060799003)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UGqfR5OylrNCnUAv3G2GfYtM4+oWOflPqMaCv1SD2RIhVyuTSxxBBCWLzliLFxcz3+1Iu048oZNcK7Fcoi8iGep1VRqhTY51LNrzFsUC+rRKD9RE9hOwuMeBmzyuem5t9MDSlTIvaLx5e2aJRUo4eZ9H0zVdVq55FOTGjecUOjQ2R0n/vyqQGErLLliZ8pAFqflep2/jNGTgSUvnmMGi1BHyCozi+wn17gohcHzJe5RDmTVCrNVR7/nMWJD1YaatWT91j5Aie641iEH98UqxA7STK7Cnme2sNebko0B4gc/h3Ru6USaEVfO1KJsP35lwO6p6CT7WD5EeOp+uQAxTq/noENL+ajp40aj0/DyUWKFEL/19fvJJIAsQIlOcgVmRqA7qtm3lj2K9SMQBTJP/vxVzjAfaVpTp2cY7geFhCK2HcNX6vihaNWBk6GZ8lmMC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:21:23.9344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cc5261-1821-4ce1-e06d-08df1d5b030f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7545


On 8/7/26 23:48, Sumit Gupta wrote:
> OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
> request a nominal performance level below the platform-reported one. The
> platform treats performance above that level as boosted and below it as
> throttled for its power and thermal decisions. A lower value moves that
> boundary down, so sustained work runs at a lower point while the range
> above it remains available as boost.
>
> Expose it as a per-policy cpufreq attribute in kHz, matching the unit
> convention of the other frequency attributes:
>
>    /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>
> The attribute is write-only as the register cannot be read back. Writes
> are converted with cppc_khz_to_perf() and rejected unless they fall in
> [Lowest Performance, Nominal Performance].
>
> Also track the register in the OSPM-set save/restore table, so a
> requested value survives CPU hotplug and suspend/resume. The store
> handler records the request rather than init() capturing a firmware
> value, and driver unload reverts the register to the platform-reported
> Nominal Performance.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 24 +++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 70 +++++++++++++++++--
>   2 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..59aafcb2af97 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,30 @@ Description:	Performance Limited
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>   
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		August 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz), write-only
> +
> +		OSPM uses this attribute to request a nominal performance level
> +		lower than the platform-reported nominal. The platform treats
> +		performance above this level as boost and below as throttle for
> +		power and thermal decisions.
> +
> +		Write a value in kHz, between the frequencies corresponding to
> +		Lowest Performance and Nominal Performance. The register cannot
> +		be read back, so this attribute has no read side.
> +
> +		Note that tasks may be migrated from one CPU to another by the
> +		scheduler's load-balancing algorithm, and if different OSPM
> +		Nominal Performance values are set for those CPUs (through
> +		different cpufreq policies), that may lead to undesirable
> +		outcomes. To avoid such issues it is better to set the same
> +		value across all policies, or to pin every task potentially
> +		sensitive to it to a specific CPU.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008
>   KernelVersion:	2.6.27
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 32f38b0c492b..fe714e71826a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -33,11 +33,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>    * reapplied from online() across CPU hotplug, and the firmware value is
>    * restored from offline().
>    *
> - * Autonomous Selection (auto_sel) is kept first, as writes to the registers
> - * listed after it only have meaning while autonomous selection is enabled.
> + * Autonomous Selection (auto_sel) splits the list: the registers before it are
> + * independent of it, and those after it have meaning only while autonomous
> + * selection is enabled. Place a new register on the matching side.
>    */
>   enum cppc_saved_reg_id {
> -	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
> +	CPPC_SAVED_AUTO_SEL,	/* Entries below need auto_sel enabled. */
>   	CPPC_SAVED_EPP,
>   	CPPC_SAVED_AUTO_ACT_WINDOW,
>   	CPPC_NR_SAVED_REGS,
> @@ -50,6 +52,11 @@ struct cppc_saved_reg {
>   };
>   
>   static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	/* Write-only: the requested value is tracked in software. */
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		.name = "ospm_nominal_perf",
> +		.set = cppc_set_ospm_nominal_perf,
> +	},
>   	[CPPC_SAVED_AUTO_SEL] = {
>   		.name = "auto_sel",
>   		.get = cppc_get_auto_sel,
> @@ -79,6 +86,9 @@ enum cppc_saved_type {
>    *                   could not be read
>    *   requested_val - value in effect when the policy last went offline,
>    *                   reapplied at online(). U64_MAX if none
> + *
> + * A write-only register cannot be read back, so its store handler sets
> + * firmware_val and requested_val instead of init() and offline().
>    */
>   struct cppc_saved_vals {
>   	u64 firmware_val;
> @@ -135,7 +145,17 @@ static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
>   		st->suspend_regs_handled = false;
>   
>   	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> -		if (cppc_saved_regs[i].get(cpu, &val))
> +		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
> +
> +		/*
> +		 * A write-only register cannot be read back. It has no
> +		 * firmware value to capture, and its requested value comes
> +		 * from the store handler, so do not overwrite it here.
> +		 */
> +		if (!reg->get && saved_type == CPPC_SAVED_REQUESTED)
> +			continue;
> +
> +		if (!reg->get || reg->get(cpu, &val))
>   			val = U64_MAX;
>   
>   		if (saved_type == CPPC_SAVED_FIRMWARE) {
> @@ -197,6 +217,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>   	u64 auto_sel, val;
>   	int i;
>   
> +	/* Registers before auto_sel do not depend on it. */
> +	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
> +		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
> +	}
> +
>   	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
>   						saved_type);
>   
> @@ -1385,11 +1411,46 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>   			 cppc_set_perf_limited)
>   
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_saved_vals *st;
> +	unsigned int freq_khz;
> +	u32 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +	if (perf < cpu_data->perf_caps.lowest_perf ||
> +	    perf > cpu_data->perf_caps.nominal_perf)
> +		return -EINVAL;
> +
> +	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Track the request in software: requested_val is reapplied across
> +	 * hotplug, and firmware_val makes the register revert to the platform
> +	 * Nominal on driver unload, since the value cannot be read back.
> +	 */
> +	st = &cppc_cpufreq_policy_state(policy)->regs[CPPC_SAVED_OSPM_NOMINAL_PERF];
> +	st->requested_val = perf;
Shouldn't we set this value at init and never update it again ?
> +	st->firmware_val = cpu_data->perf_caps.nominal_perf;
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>   cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_wo(ospm_nominal_freq);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
> @@ -1397,6 +1458,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&auto_act_window,
>   	&energy_performance_preference_val,
>   	&perf_limited,
> +	&ospm_nominal_freq,
>   	NULL,
>   };
>   
