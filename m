Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0E36CDE9;
	Wed,  1 Jul 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923128; cv=fail; b=WXQlffdbCHFIGLqlTzwNikdPGOtWFc0utiUnqjXol1nB5ub87oCTcBHWQ13/a3uBpRKdtteQD00ilt/WBoFfvzUGb89A0qPInznRZ/+PzfLzB7VZn7/8/HTAwGm12ot4lK++Z8bnekEntMQCU3qdex+Yu9P5/1KxvyCoYRg6Qlc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923128; c=relaxed/simple;
	bh=uxtbCKUXHWl5YwaC/nPWpmvSl0fB/lbn86a6xLKzhNw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGppAulLETjjj7yVCEoSbGY9UM5SYYMzky59cYMN7hHubLdQDXhKO+cm99mSbZGbCaBsPyRcd/08zlV9vCNhavArQeBZdhzCZ+pa+3eXEZnPJ66onxVEx1HMn+MWzkUCqSwlRZb++E0sEF3rY312qmcRzFgi+qIugcI7QHm1SxE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rL6VBJKp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rL6VBJKp; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rL6VBJKp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rL6VBJKp"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sd1+37TncO29JMD02k9OI8imdP7RgTPG+xqjpGf7t28n62tDlouWLGE4HnJapODT18ANczkNEy3zYH3Xs9qrmKnl5sYks7CAT9yKW0mst0aO1P3aVPA+LpfKjdamcQnRXWNhl2jGo9W4iVFnCkBkM7GpQyTZU5jdfP6A6mG5oLPYXElNng8IJ8fvSxBPrSVLrrcC8ces06E0lhiYUaAez6Cyd8J3Dw18Vv3tId2o7u5NQAqMx6svLpJ5A3nqaEznBo+kYxpWBWpkIyvfe9XFWDus0zSd3XqYYIGJdrHEcqjXd3sfVExXoG4/q60tJ0gc2kXLb2h1nggtdvDDlSHqRA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd/pBYmbHLj6dAH3PuiX/jY21wvAucUzlr5tFrAMnYk=;
 b=fDTD+yKzC/17/sUJqddj/4yVFRqwBTnSd/9fgMKSnnWuB0035FXYf42yUN2N7tPAHqWhBDjLIYqQf0LY+2cqjGLBmSmQN6B/uFM2VJbJ/aaRu5Y27UQGld8zgxluoSdPHPKxcOBG4eXbgazPIv6MphxWf6xQC41/pScZfkLPrsFQFzuuWGjeXmy4C4JBkBGKn9vsvWWweea/CninKTM7RE+ey+MeCHjV1prrgCwgfIKdBqLY2jKXtGTgqrqpIDwaDPxEv127d9zKzDdM3jaLh/NRPLrpIA2pIDl+nULSU4sLZ2BU2yNQdnSUoUiCnv0Z8rNcwPKEzwEhsVtCzm6SWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd/pBYmbHLj6dAH3PuiX/jY21wvAucUzlr5tFrAMnYk=;
 b=rL6VBJKpXsYC6JtLxDnHSYIxyx2GaZa5CIFkG8z3ZfpXnkSwYQaUM/RaZA6xJeK+0rshgCohMEUnjuuyB63gF5z90T+u7EPnQ3FNmH4WYPlkKXVB7faLipJbiKR0z+/AGZBFv68TsL5VofhHXyKNsTmnWSiENfNDiE+h5NidSBA=
Received: from AS4P190CA0047.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::11)
 by GVXPR08MB11033.eurprd08.prod.outlook.com (2603:10a6:150:1ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:25:19 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::42) by AS4P190CA0047.outlook.office365.com
 (2603:10a6:20b:656::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 16:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 1 Jul 2026 16:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5n1F4z++ZW0SFSwSVnJIRzHE3V855UuBNVybRVTfPd/LFRXajHZTIT4rSLzYJX7yOgo4C3BGBS61B+DSHMZHjdA/51+IzdA7d4GfTggRPw9fLqyib8jR/J/CPUF2PM+XPMJE/cfp+ZaAjhqNSj821feLHbwdtEWVaf8fDPMNX3YtvENba9y4KSkqzebpCFUTlZhca3cnO4O15TNymEfLf5MjnIC5bvM6AcOfqaFmp3U770WJ+cZ+qhjycdnGb6sGUmhQ0l0SmVIqnnHmjxUKSS/2pIQLl4nk62rJzGaINcDLZEkkdceFJOy97Q9bg7KqWh5iSujy0kztFaVSW2fZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd/pBYmbHLj6dAH3PuiX/jY21wvAucUzlr5tFrAMnYk=;
 b=iOXZhajFaoYQYaizI1oG+cjZ6bHo+mxg0Uga1Efe+OgHkIP2l4h/NaW86Kd25hmC0J4ny2W4GutMRhcVYmLHQDLdfxYGZUNw/eeUmB7jZFoYXgxpucsg5B4arHlLVLKIYoh8wMDZsDnakRGRswGeT/0xtyAHKI4P5ej/PWknqdEHP0Ao386ZGNjKqGJIdOFI6/4pN+/38ZFnblpF80Ecya+4j/JVtxLe++HObwWkp/wTXJe3KNuXkEGw2f9qqi9HCjsw92WhcAUtuqOJLtZ9ObrisyNDnU5jYb5J3PMxldDLXZRTeeTIJ17Mgtn2lYr88hfo20qn8h1xygPWKpXvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd/pBYmbHLj6dAH3PuiX/jY21wvAucUzlr5tFrAMnYk=;
 b=rL6VBJKpXsYC6JtLxDnHSYIxyx2GaZa5CIFkG8z3ZfpXnkSwYQaUM/RaZA6xJeK+0rshgCohMEUnjuuyB63gF5z90T+u7EPnQ3FNmH4WYPlkKXVB7faLipJbiKR0z+/AGZBFv68TsL5VofhHXyKNsTmnWSiENfNDiE+h5NidSBA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VE1PR08MB5646.eurprd08.prod.outlook.com (2603:10a6:800:1a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:24:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 16:24:17 +0000
Message-ID: <15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com>
Date: Wed, 1 Jul 2026 18:24:16 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260623095403.3407436-1-sumitg@nvidia.com>
 <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
 <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com>
 <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VE1PR08MB5646:EE_|AMS0EPF00000196:EE_|GVXPR08MB11033:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c4532b-a25d-4493-ee75-08ded78d57bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 IWm+7bZ1Ul2nJnapE93w3sX5f2OU57EVdbqR4dDSFt2+D2gDMnNnM9TjWh2e/zJG+J0XI3r2BJr9Pkz64feXojFA649JN1c+pz5goIiTUDan6g1Lii8rJgZZBEbiz1Dl4D2pfc6iWVi6UDwoyRUkIHr+pUms28TFLAcB+BO5qEt0b30JdJXmC/oWFNb5CQOWIaysBI+S0fi1tZu9FdUcIcbs6NhxbpN31CWYWnNVe7wagh6SjhP7KCpTWjQZMOZ27NutiYAGyOcld0+E8IZBvGeuufcZbKs2az/hqc9U0UonB2UhbbQsdOnvKo3M1EFP3ZLnJ/g/kxd9NbpUBjzw1mkhwhsjmXXy/f5EbakV9Yfu9oK0O5GZ5ClG5lsksAkCRHcBeLEEBt4vJoh6ze3wPi8lWKOx3wE9cGLqr2XN3Goj1bRc85G44uwjNJru6wg97mXt1Q3AYVfEUzd7cJMLs+YRu7HENsmTtb+HG/nhCgRC8EcG4mvqbEUVxoXMP7XaAYfnluHQVfD+ReH2E2ay3uybIKMEZ/sT+AVDjpU8kzGF1AVecwIGLrMDK5Dkjwk1E81MvQsmEpjDth7n81zoSTwab9R0Sr9SyWWTYSYQh5ohxRCkScg8d4YWfK2cbFibRoWoJuKbmtmEaZcIB8HSO0ZL9JUNGXEdgYPbDXMsqPQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pvlhDsMhmjsh91pWFR5C0/ipa54tU206O64DrodabeJmpldiHzXr919lopkNo1dBnjCbziilCkAXmg1KJkvnx1manf8KE9z7OHHgMHnUJ7XDuJAnfj0YNs3SRVoDErNqGcJTB/tV2HYdJe/0UaBYqqK9dD48w4SClwvRYLhUokBVsuTOMzXTL2iA0pS2UAcgCrP/P2dkrXy8sTEaEzJP1F8vMfcmp1jIqYjMhnCmCfwob0R+z4/T19M2PNwWCtWErexvmoXPedb7zOGMP88kBULHJNdJKE0uA4tZtM10nHSn3/e9ajt/7G5jUFSJOy7fDghNdagjjVJ5fosV2T+bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1c4d64d8-8a99-4039-de1a-08ded78d3277
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|35042699022|14060799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mFOHUv3D9BKeebmMCf+dGA/7hO6w2I/gdbeuNfNOjm9b/y1bZAYJjCgwiQjEag0+G0hmwqXpyMu5HnfpNIWq9xaL+oKXWAi8r2cnARmyQD9V9MIHc5aKib8Pit92J5FHO1T7pNai6grzyQqTeSmc/rAJtqLyL/8YueVt5xjfq8uKT3GqAuchT/OuA2XtvcZ0yhnvHvEO8ZxRzsBjhLlyPgofX0EKpMIbox6N9vxsRK8SWngRxeYZIE/DSe2FC/kYKTGc3g8M8gS4UuMri95DPZdLYcV3khKYpnNlirCJiKAZtUQm4irGoEA6VGOfBFxssWl5wRtVkkeb0k9E4u86h/c0B+xfGlJgNUardiqTW/ZJOLWYDTK9XIyW/yrUKdMcVzUI4HioIRzO5CQlv842RAtA2kEI7Mx+MYj74EZ2es8CYUaBUG1mipB+ts6VBFyoG0wqYu23F34P+97Gh5IzOAjoGx7ab42VatPB9RvpqNX6nHJ9TfZbC/EDMbOIB5wlHqaQxJTpTU6Oug6ezyPyRYgDB6RIlvRv646KZsR76tPKBGNZQTZolsuO55jmfKFs3I4muj2WNBv4iZ5DTR4ow2LLOed1BeAninJdhdpaaFHSjb0Qv/rUtQdP2T00PehZJUUFKYcZrDn/ZFss/y8QKRoRJ0kNAwLg+CqEq8wu9oZU5E/CpEUTcUEgNzxSfZU0upJOz5gMDcRLe9ip3HydhA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(35042699022)(14060799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dJ8JMCIdJb5xK0OMul0jXKic+tM8UDooT191oIaLEs9zRzc8jfewzV69J9Ret3s15heDnNGe0FrZJG4+Fgq/YklmBRsKgHvS3hVKem9CUcUc96tj/gpIz8Z/saTZ3w2J2qPO8i92DPm9sYju4S/qfNLzWmvFMsSYuAXmryF4XDI6OeyHSlm3ln5F6b8tvjIoQWNeWe0b5skDQhvs7DiIDXSTx+FnsAX1vPu6VbCKuNHiQpgJWXYFEJDkP8iNquZ3odVmeFeZ0sPAPHj4fboNo6n6r9VDp+tj+G8GJ+qSwklC5zc3AC0pljuz6NEMX9WFqzmvcLDY/6xnEUoFg6VmSaQEnuY1iwKPJR9zL+V7RePc3es0QK+hbf6JtnW3FL3W18ROyi8Ste5RyD9SOr/JaUEBknj/6LWG3DFCEeJZjq0T2vOVayOr5WaiYKF57JkW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:25:19.4583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c4532b-a25d-4493-ee75-08ded78d57bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11033

Hello Rafael, Sumit,

On 6/24/26 15:20, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2026 at 2:56 PM Sumit Gupta<sumitg@nvidia.com> wrote:
>> Hi Rafael,
>>
>>
>> On 23/06/26 16:30, Rafael J. Wysocki wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jun 23, 2026 at 11:54 AM Sumit Gupta<sumitg@nvidia.com> wrote:
>>>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>>>> boot parameter) can be lost in two ways:
>>>>
>>>>     - Across CPU hotplug: the platform may reset a CPU's registers when it
>>>>       is offlined.
>>>>     - On driver unload: the value the driver wrote is left in the register
>>>>       instead of returning to its pre-driver state.
>>>>
>>>> Add a small table-driven mechanism that handles both:
>>>>
>>>>     - Capture each register's firmware value when a CPU is first seen and
>>>>       restore it on driver unload.
>>>>     - Record the last value the driver set and reapply it from ->init()
>>>>       when the policy is reactivated after CPU hotplug.
>>> I'm not sure if this is a good idea TBH.
>>>
>>> The overall system state when the CPU goes online may be completely
>>> different from the system state when the CPU was online last time, so
>>> there is no reason to restore its settings from before offline, at
>>> least in principle.
>> These are values userspace deliberately set, more like a frequency QoS
>> request that persists until userspace changes it than transient state.
>> It's platform dependent though, as the platform I test on preserves them
>> across hotplug, but where the platform resets the register on offline
>> the value is silently lost. Should the kernel re-apply it on online,
>> or is that better left to userspace? If so, I will drop the hotplug reapply
>> and keep only the restore on driver unload.
>>
>> intel_pstate and amd-pstate already re-sync these on CPU online, as they
>> keep the policy across hotplug via ->online()/->offline(). So for them
>> it's re-syncing the hardware, not restoring state from before offline.
>>
>> cppc_cpufreq has no ->online()/->offline() today, so it fully tears the
>> policy down and rebuilds it, which is why this reads as "restoring
>> settings from before offline".
>> Would adding ->online()/->offline() be acceptable, with policy preserved
>> and ->online() just re-syncing the registers the platform reset?
> That would be a better approach IMV.
Just an example to be sure I understand correctly.

1. on a platform, auto_sel=0 by default
2. cppc_cpufreq driver is loaded + we set auto_sel=1
3. all the CPUs of a policy are unplugged
4. cppc_cpufreq driver is unloaded

To be sure we let the platform in the default state,
we should set auto_sel=0 in step A.3, i.e. in the
.offline() callback.
Doing it at A.4 (i.e. in the .exit()) would not be possible:
the CPU's registers might not be available anymore once offline.

IoW, we should only need:
.init()
\-cppc_cpufreq_save_firmware_regs()
firmware_captured=0, save the firmware regs.

.online()
\-cppc_cpufreq_save_firmware_regs()
firmware_captured=1, restore the user (or previous)
values that were saved in the previous .offline() call
(as .online() is not called for new policies).

.offline()
\-cppc_cpufreq_restore_firmware_regs()
Save the user/current regs values
+ Restore the firmware registers.

And it should be ok to remove:
- cppc_cpufreq_reapply_requested_regs()
- the firmware_captured field.
If during .init(), we init requested_val to the firmware
values aswell, firmware_captured should be useless
