Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9D40314F;
	Wed,  3 Jun 2026 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472993; cv=fail; b=Ydty7AE+BMubcK9syH5VLya9zwAI+GS47agRt3avEwLffz4tlafn1p/eYXBTPZwq82LzYduUuytFJOJXbwS+YT8f3KygTzCrKTA+z9bv/krBqrWX17hBmetYmuqFeXou+LTl5xA99PbyOQ12KpVkyL/8KeZEpa8mTwG8P73VGUA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472993; c=relaxed/simple;
	bh=IhsQxwC0gYrJkoKSpoJS9ElElqkHX6ZLrOUmFffbNxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqzCICFsORpsOealxcMJyLK7tBdUg15nIyElpFkiRMajtGCRQDP77kTtQ+rzdYm3OOJj1OYrGmhviBkRQ2e9b3YsugF0rTuxS4JcVaSDarcj++lCNSTpUF82IlSjkN5/rOMb74DgKMlVELVBkuGCiDnH4AmgdDtR6LIQVn7dyps=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K9YQXA6j; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K9YQXA6j; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K9YQXA6j";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K9YQXA6j"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HeOZL1Eo+be+5NSDLt8BsznLRFCkC+RmOxMvCd+sV4xuxed1bAcDXw7ov6kUkSIyJxtZJzbIut8bokotYTGHFBx4t+r8SpBeP1qviHmZT58fATFQRI5JFstJ7fRIHxrzMHr2HcjDej7mGy191uE36sFOfF+cVq+u1vQdU1leAdFDDNHE9m11X7TnB/OFQsPULw/wjd85tiLrfgAqV+ZQpbk9B4za+4E7FBHt8649VI/O+D8dHYOfbn3G9nKtfAEn78FGAaZcvY3bkX/14VRPRYeUXxZoTn1fIkwHyBUImesSty9W3EXIeNJ8UZHqgtxedY/4s8uOHRlS/yA13vh1Zg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5MrEpveW9p8pD4yk/AjJrDDJMS6XupIS53Rb1eCsUE=;
 b=zT5ih3Igp9VaP+6tAd3xCfFkzb9hLX0m2UNF9894CsCw4Hc0+V1D3aZQY/w5JfZm9kxJrVzMuphaUxXBC+9vi+4NVWsFJVKmp3KW3Ezi+8Zln07TNz0SounVsUCk1D1w822nL93HeTQ6cAUD8/pjnkXn6PDJscxRZ30VVimNTbGQZ0VEa8YeUfdg2DwhX0MhAC94gzrRZBQgVuD112hOKOL8txN3t/72uhv/V9tSsIYIFu2uiEkwAqYjlAm3Mb1Iws8N9PUK+mFcTYoJtIEPnLMA3HO6cUSVW/JSYz6AKmDCkpVWcI1+qWFlFMEwyvks0Lz0m1f/DDWPpe0hv4t9pw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5MrEpveW9p8pD4yk/AjJrDDJMS6XupIS53Rb1eCsUE=;
 b=K9YQXA6jnHKnUuBvm7USekFi0lzen7lEvnOku6nD96ZyJZ8D1/KruZb6Gw0V6eX7VkX/0LWCwWFviwsBnvwrqs0VgehVsqrKps5udmyZPsxQjiYwJby/AGOD5z3XCR5yEnxJJyc8QlNg1up40K5Qa7a5qNgXHqutlreBpabih0M=
Received: from AS9PR06CA0341.eurprd06.prod.outlook.com (2603:10a6:20b:466::14)
 by AM9PR08MB6643.eurprd08.prod.outlook.com (2603:10a6:20b:30d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:49:40 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::68) by AS9PR06CA0341.outlook.office365.com
 (2603:10a6:20b:466::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIidLfvlTefPvhzvp6hZVBzpT9I6Yiyxs+CoMHvLi8vtsdVbfP0GhDX7/ZebqXQXjoo8M1cBHcTvaK66EtDGdgCJXIUdJBWClkqz6UeMB/DWTPVZHwOcR+pudu4GHoFf2fj4LHGk/mqgRiwumB+0g54WJanPbg4GR0Pp2lM8wStbBfJrGEBot440sYp0+PKybguKc8tDwZyVOfuhTdbpD8eDUeNxygPUvWH8v1wJEX07r1gAD0sQ3NTw7UIxXhcExrWpM+TDIFBgogUGTBPw7hBdIPg2psojVZvCM2DZ8DA/brIQm33EhtUJrROsgMFXCpcKl19NHTs+b8YMUdBdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5MrEpveW9p8pD4yk/AjJrDDJMS6XupIS53Rb1eCsUE=;
 b=lfV5hPEnihkyRafjN/QnUnrlOID5Nmn9XWk48WvQL5W1m/pgp6IoRUNp3X8Heii0DA4eCmxdOAD/of5dGVQT6WvjhmWffdgEsQ+fqc38xrmDGe13pPEVDmAb4yeIW64J8w2+qWcTEz1JIil8DE7buHF1dmyZ0KHvM07gpN/mhdHKNiO4hlQAuDijsfVWfMvmpmYfZFXVdat0iQOe3/6r8D7MY/D6oClXapDOsdqgLybjem8Tbc7hldsyp5s4EcEf3rBQ6NGECDy708CX7v4Ad9quyT2rjFCbfvEC+W8yidKpFgZdrKRi6r8ccLDyMsftVXqZt+wj3rJWkYMqF94Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5MrEpveW9p8pD4yk/AjJrDDJMS6XupIS53Rb1eCsUE=;
 b=K9YQXA6jnHKnUuBvm7USekFi0lzen7lEvnOku6nD96ZyJZ8D1/KruZb6Gw0V6eX7VkX/0LWCwWFviwsBnvwrqs0VgehVsqrKps5udmyZPsxQjiYwJby/AGOD5z3XCR5yEnxJJyc8QlNg1up40K5Qa7a5qNgXHqutlreBpabih0M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GV2PR08MB9927.eurprd08.prod.outlook.com (2603:10a6:150:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:48:29 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:48:28 +0000
Message-ID: <6447f46d-5a60-45a2-b585-9835c9c26893@arm.com>
Date: Wed, 3 Jun 2026 09:48:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: Remove driver default policy->min/max
 init
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260528090913.2759118-1-pierre.gondois@arm.com>
 <20260528090913.2759118-4-pierre.gondois@arm.com>
 <CAJZ5v0hwYcvYZJ1jCSo_5vpynOLBciW-4-KeracQTyUCw7fSGw@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0hwYcvYZJ1jCSo_5vpynOLBciW-4-KeracQTyUCw7fSGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::8) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GV2PR08MB9927:EE_|AM3PEPF0000A79A:EE_|AM9PR08MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4cfaed-9d76-4835-b7e9-08dec144ab3b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 rLUmZfW/4LMycqux5h6b8uqxT9tIzp8cYP7GcraYvFz/Dhdk0BxV8hE36xG3YnCtCwK8/DmkQTjY+tjQ28XzB6qn01wMNYPrazJyKftVB323K+Gm/9pkVKCaR3Va8gCMcYLYwMt5kc7WBJtB3MP1LHp3fFiwi0tIZM4aL0hDLTqclWwnIsgT1R1ZuDTpTfc+M+cM/fofZV3q8nsWy1gI2q4BWmRtz8tVZIsm1rvdl3cSynudiJK47toNlX12PTjKeYOK0IbeLaQz//Hm928LUngLt1KHIur/QDevwMoiYQuMcN4xI42udpECHVW7wsRlINQIuhGs+YbnDA8WOPhoKNJNTcztqzpP8NPKnPA5PI5t+Sc+5L1bu3/sBiRmRN0VxXnQOpE7sHmpmm4DLAviNq5pKHcy0euURH8dhOpdhmYlvyxLEOuBxcZVhzEQfvygcJhGEo0laaYGSaSsk5ncluO/WqojFMhSfe7Dvl21qipbOSXF1fVfJwZIH8Fo3UYDlhBIV/RrYecXAu/ekHE95ZR514JfJ6FNFwVqydTPGz7B3j/6zbF7qMa/ygQ8Bh5wPKt8shzy8FJQSwBMEMthRJRRPou+SaZXM2oA3Ye8kwldvOIEfXoRx69P1EJsbjks4oB8y+AfLSWH8XLTTtWb+A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 cqnnY/Z54mpU+64MAqSNyMJYXpzSQ1fAu68j0VSXn6fU6cTr4e5fFNUJJI/z3h8uq2yKF5yWCjP4Go9u10kJMUigLhZYlAQFkIx2iXf9WWab1LIxbINUuazvNCOxh6uaEzbW20nFavFBMiOWh/ttozcDAmzkVHYlMwQFSdiJmar4dwtC0xxXmKBtF60uA9c6hxSMbnDuo9vpLL1L/pVXfEAQzMPuMPJ3DcZYLZiioJn57XdVPeRrNxpKesXhn77/FenNEE4dY+43pQrdmVIbrGI7iD/Eil3tI8LvDN78dhVv/Z7tZ0LuwdvK9onlXBcDVNJfOc+CpCVp6jol3CoHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9927
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	92f9da5f-f9b9-4225-9d5d-08dec144802e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|14060799003|1800799024|35042699022|13003099007|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	EF/Mxyqd3fDJoLeZfZklS2ts/YikxtJfN+9UcXhQLAmFbLe789lf7xmMphJXi88hIMrg/6wcjboGxGPPlFMzpBdhMC8zsS7Fz5OALty9/HmlkXeCG5AbFD8Xvr51O10vQdoLbigC4ioOgy4XbigDpGu8+2sY0wgEObqV8tXiJmDkfEGwT8GIW0QfD/R4c42AKd3tC5k/UrCqto6Iy2l2SRQRr+FaEsk8UijHAtP7SzrcCRn2fALZu889vvlWqvNfZzat5HavIJkQ/qF+lW6WfJXmu+VMuKXaG2i6cIV3+DxOvoZvELgUd3Cba4G8AhDIMSXFMxFwqmUPVrjMnWAQp5AYXtsDBRUOrZz1bmy71/5VusgL/dvbRcVHDW7zO+N0hPTKh+MupMHKGgA1hbHS4IdK7ozQHGa+luW5h7aozer0tI0Yu7l+pW2A37+MazXNDXW5X/oB4H3dQg++KLd4scGz/2oZA3m+55EL5UWFUHSyeWy1l8f874v+HKT8DZAubqbGDP8IE0b8Q8w6l0w0vKFnJfq7jcLG6RCNv7S6BcPJ5spJdQCpscHPmia0nICVOCfqVHhbGTWZDSlayrvqJRyC+mPBVYkb4AWf4DPaSwUE8Ol1PvxZ9FLxI8s8PNQewcJ+L5Z4SLN8n+Hl0n8JTtA7KH+3ACNZow6SwCJCbYpTE55KDR7jAc8lQZ0lnS5O
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(14060799003)(1800799024)(35042699022)(13003099007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yAvi2kBe5E9tTmYYZE5FfE/4ZrsjbpswSEnT1Vv7ZBtHxtszv9QdOz4kwifbzmAyIEHVDBWp8YWMxS71l7PB2Q4dD31XnlIttXQ14aTbQubWK8e5LjZHnrQtMeXFzvLlJHLwHbetEkJfjJ7aNegi2EyHejquzsxEtTsQCJhzbbhIyGD9nCDmfp1Hzre+b24veKBC7wQ5Zk7gJrYoktNyDVXGwAFac2u3EomfrfsRsicYPZ1P3kDYg38Wwg/NVTLsxAoqHgTtUO1DfaUBf/JKQBFFmavRIGpd9d67mrd0l/tGu3YJq+oqRlZOMjhXXx83bjGhymHLXLZI6YsEs7S/Sqwz6Yr3ssHXVdBPDpYSmNDf6rmy54gAsGA8+UT5KjI5QsbJ0+vakkGnJ2w3rGt/FU1vlvnP6g1kg0rNyLE1Q71uWd81VfFTyxvog+O/xazo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:49:40.7052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4cfaed-9d76-4835-b7e9-08dec144ab3b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6643

Hello Rafael,

On 6/1/26 20:08, Rafael J. Wysocki wrote:
> On Thu, May 28, 2026 at 11:10 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>> Prior to [1], drivers were setting policy->min/max and
>> the value was used as a QoS constraint. After that change,
>> the values were only temporarily used: cpufreq_set_policy()
>> ultimately overriding them through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>>
>> This patch reinstate the initial behaviour. This will allow
>> drivers to request min/max QoS frequencies if desired.
>> For instance, the cppc driver advertises a lowest non-linear
>> frequency, which should be used as a min QoS value.
>>
>> To avoid having drivers setting policy->min/max to default
>> values which are considered as QoS values (i.e. the reason
>> why [1] was introduced), remove the initialization of
>> policy->min/max in .init() callbacks wherever the
>> policy->min/max values are identical to the
>> policy->cpuinfo.min/max_freq.
>>
>> Indeed, the previous patch ("cpufreq: Set default
>> policy->min/max values for all drivers") makes this initialization
>> redundant.
>>
>> The only drivers where these values are different are:
>> - gx-suspmod.c (min)
>> - cppc-cpufreq.c (min)
>> - longrun.c
>>
>> [1]
>> commit 521223d8b3ec ("cpufreq: Fix initialization of min and
>> max frequency QoS requests")
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
> sashiko.dev has some feedback on this patch and appears to have a point:
>
> https://sashiko.dev/#/patchset/20260528090913.2759118-1-pierre.gondois%40arm.com
>
> Can you have a look at it please?
>
[sashiko]

 > Does removing the policy->max = max_freq assignment here break UAPI
 > expectations by exposing the unlisted boost frequency in 
scaling_max_freq?
 >
 > Commit 538b0188da4653 intentionally allowed drivers like acpi-cpufreq 
to set
 > policy->cpuinfo.max_freq to a higher boost frequency while relying on
 > cpufreq_frequency_table_cpuinfo() to clamp policy->max to the frequency
 > table's nominal maximum (max_freq). This ensured that user-space 
tools saw
 > the nominal maximum in scaling_max_freq.
 >
 > Although commit 521223d8b3ec temporarily disrupted this by defaulting 
the QoS
 > max to -1, a subsequent patch in this series changes the core to 
initialize
 > the QoS request using policy->max.

Effectively PATCH [4/4] cpufreq: Use policy->min/max init as QoS request
now uses the policy->max value set by the .init() callback to set
the max_freq_req QoS constraint.

 >
 > If the policy->max = max_freq assignment were preserved, the subsequent
 > patch would successfully use the nominal frequency as the QoS max 
request,
 > restoring the correct clamping behavior.

IIUC this suggests to use the nominal freq. as the QoS max request.
This was behaving like that prior to 521223d8b3ec. However doing
that would mean that if boost is enabled and the max_freq_req sysfs
is not updated, then the frequency would still be clamped by
the max_freq_req. 521223d8b3ec intended to correct that.

Sashiko seems to suggest modifications to come back to the
pre-521223d8b3ec behaviour, but I think 521223d8b3ec is correct
and we should conserve this behaviour.

 >
 > However, since this patch explicitly deletes the policy->max = max_freq
 > assignment, policy->max remains 0, causing the subsequent patch to 
fall back
 > to the default -1. The core then resolves -1 to cpuinfo.max_freq (the 
boost
 > frequency) and permanently overwrites policy->max.
