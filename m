Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8C2F7462;
	Tue,  9 Jun 2026 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988008; cv=fail; b=KNRwnU+SKbmHDtUK3XMv3GW1lAWGij1frfEBxMVceed31FL1aOWxd2hWpBaVQlqNC4oRdrBZBYfusBe/NWd6c4DjGUcsTxdDeTK9d5r60NxThBgMGwI5HvHEUn5nVtZ8cStui1qDnTtH4uFpXy1jo24lHVV5C61UmPGXq9OSWMg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988008; c=relaxed/simple;
	bh=1O5GMcLg5UPcw1zqzAJVCm+OwcSUVJzTLFx4uFQQhz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5NfKoJ3ypAVDaKV2080oZscngt5csraw8Xzvuf3VDGrTliVWEN+xEocRqFPSbHWmkmD8QMyxA4ia8CczdSRmn6cL5FgUoEUEdJfjKEm8MFDzuUU9dXLtTa/+gdgPGc8TS5Z1gfTDt8oP+5kVVO/UT+Rn1ANkPtFA4pepgM2YTQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X74zCroc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X74zCroc; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X74zCroc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X74zCroc"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OoYNbdG7zYvV9bjY8mFEcddokEfNTNQrGwXpG7fuBJG8ivXQBJGPOhViJFtN041Zmy3Vhysf2qynou3Lp2vTI42r5gjJG+zLfSb3EvRgPWL2nYAQHN4cJp1jq4M1Lig5WmQmT3pVaSdqdQDkcgIg/9OzY4I99tZQGMVO2UnOAYrrXbsPOQ3fEnqodakcz7NBK82OQtzrtLCpv/Y6j7J5uIt3PUYsX1XAsZ9UWyhS5Qt+hH27wt+q2rqEwo7Qnnr0vbA34d0GXseTQkLgWbLT/s5Nh+WrW6JKV3E2zdd22XxbQJFSYp2XUdeMjg5VE2xJx26Lf45Ty6GeyPl/hLRvUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWBkBdV68EUyHC5r/fGOslrfPNEBJzokRE9P04jIW9Y=;
 b=YrZVj4QysBaQWB2kA6wE27t/6TneATq3NIVkvRbVmMbEe+Ce/hPmqffkF5E4laqXlA4f78yKjhodg1jCUTNd/f8Ild0v0sU/Iz9gCHv2JmDngUyVN8mko/n42lOlL9/2Lb2bAixDfQXacey3JPL0avadHwLy7GG/4nhCxHft2QergSAX6500NTOh2k80tJHHK7tkSs8JxhbuWF/eWB5qIfGNCK7pamHKZdo3OMZ7T/bzxrhWDAzDs8J2BQLayqHaht5q/NolixQiMdHeqThP2tkz2m/U/KYDCbUtyo9W/P3ZqXOAlN95ROL6kW4sYPcO5n6KaTR4n5Hg02gHDlkH2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWBkBdV68EUyHC5r/fGOslrfPNEBJzokRE9P04jIW9Y=;
 b=X74zCrocWQR6Q/acyi+CpkaB6K7wbIQF1wHhIKxx39PbEcyxBbC80vLWXDSjN57/hd+pFZDUndktDMAK6G222HvuAi1uHGqMpd0nZpTiY+mEzIUasrzXLLHOB6MRjME38UY3HAWH+fRj4hfekg1i9v6o9HUZ2eCQuKrK28mS2kk=
Received: from DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) by AS2PR08MB8926.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 06:53:16 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::b) by DUZPR01CA0149.outlook.office365.com
 (2603:10a6:10:4bd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 06:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Tue, 9 Jun 2026 06:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6pWKDV9hqBftfpd/VnRjpWNXCaw7qtwzOo6hRhNRqMe37pZ6qhfYGKqCva7ygp++UeRXkoRaqd/AdwOasBdhC+Hw/7vhOGSi6AUbE1M2H5ECgHgCcMv2wJoNIMa+u2sOd6mw57YyzfZTvlO3vMYsblxtNgQ5X3SlaxZ/K3UjcyH9xwawyqaOYhwlv7b9hU+lu94ZwLGqhGMVX2heXs+CJwiRf50rULwyxFdnINkvPdPDBh/vX3AzzGcspxN/SDiR1r2mT8FBruZYTmF69RuEfNgfMwhTntdk5+oRNO6sXU8rcZ0wti4Q4Q/WEwb2pK77hsD65LyGb1atZVAJX0PmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWBkBdV68EUyHC5r/fGOslrfPNEBJzokRE9P04jIW9Y=;
 b=jl1OY4A3N+xofV+PerhqO5iABWU7Lh4LVIWbDswEt85XqbqNEJksEjfUpXfo3YF5S2fKeJNsPULAlAGe+ybKHf48JlAAyUygpqPh+8nkZd+1jtBGViZdpwFnJTBVD/7di3bKRW1hSP7a/orQvD1NwM9PdTyS2ptEBLKThg5U7p6RfTJve31g2loL/GV653mFeCYMkf2PrfYfAzfm4wpzX6hV190p1TlEHAbLgfPHRIqZsddcyIh0v32Q1Syk26nyu6mUzf2Z7CBHD2AYOHnb5VoXl6JbMeNMVLFBVD6iLiPd1tXjN1p/P2/A/owOEsYUbRl0jQgvvXIh0injjBnawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWBkBdV68EUyHC5r/fGOslrfPNEBJzokRE9P04jIW9Y=;
 b=X74zCrocWQR6Q/acyi+CpkaB6K7wbIQF1wHhIKxx39PbEcyxBbC80vLWXDSjN57/hd+pFZDUndktDMAK6G222HvuAi1uHGqMpd0nZpTiY+mEzIUasrzXLLHOB6MRjME38UY3HAWH+fRj4hfekg1i9v6o9HUZ2eCQuKrK28mS2kk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB9690.eurprd08.prod.outlook.com (2603:10a6:20b:606::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:52:04 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:52:03 +0000
Message-ID: <a9b432d9-c79f-4ece-8416-6bb2d17261c4@arm.com>
Date: Tue, 9 Jun 2026 08:52:00 +0200
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
 <6447f46d-5a60-45a2-b585-9835c9c26893@arm.com>
 <CAJZ5v0hqjdd79J-Hi=mSLMm2Fxhia+xa6iguJwZy2-pRBSJ6gA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0hqjdd79J-Hi=mSLMm2Fxhia+xa6iguJwZy2-pRBSJ6gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB9690:EE_|DU6PEPF0000B61D:EE_|AS2PR08MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 764db73f-4b56-4c0d-f9bf-08dec5f3c871
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|3023799007|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Mn+HPRcNnQw/Oe5BxuzP/PyWPiJW71BSoxyg7CRHAgHWBgHwSBGppZC86AUcpKt/uYNaY+i3yX2tN3s7NI6rLQwiVNFkVG7tJzRQplNUoQEmoScjK2xrhk3sVFGqqUrM1XfwwvcUhzOilDQtgQUitEmf64dpH5O9zKiyKBvFuPUgPVQhjRPu4KQyzh66VRvaC7oHFdYNa4wikZ92yjHohqUx3SY85lk4lVQOPGHE4fqcLoySXsOt5ehjnfx+/XzpC6/9eaqTqYd+VZ5vrSlWLYwWX4V+gmTqPOvT5VZ0XFAKwi4P365yHd5Q7CvsQld5gszXg3oCKNztYbGVTTtACjGMRhmzRz/y+SgAnncIqDr/DvocT5Wm5fNI2RjPjeONSihEvGNleUnPQYhAzsn9ymdXOzDHXVsSCNaX6z3MUZQu1YdNbjC0m1O8ZheFnPFlBJV+syOqVsDv72BFY8Gv09u4JFEP+wgu6LbnE2hntooOwHHvNwzTjWLaRGEqm7pSqE65j5DWjaXxBgKynKhhzcpKq51QsTbeUdDiEIZX11qHoewN9szEbvdty9UIDG52j61Xq7NXiLlQNc/hFILQMwCOvfyTCmayjwjnWc/PCf3E878kW2wvHO3DLPmKXa0LXrsEzExF1ythuGAjUo6iAQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(3023799007)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 WMJVh4iRfaBqyObvvaTiCxJ5ILhizo+xIPbO/Fq4L7kQEpCCq16jUGAgGMD2Z8y6a/E3gDxTvOFDQBUDcspUQwHfqHttbsCHnscfrOHbgXi9VzwNrExXId6YzT3hgCN/8nl2bNvjA//yMDRbfx1HPHUlCWk3wr8fK3Of8KBNnNcFMw5gvUDolSKth2tIcV9//u/4d9TKgm/4kLf4oO0CVuAQTn9gygEM/vmGf5CT3vLkOa8Js6r0vSoT8hDEnvT/6RWWYsLDqd0aIS/LJHvSdznC34yC74jX8tJfqTcC5x4Es18BVRbYfzyV7B3RJta1pHfYh0saoOdsWammPVCG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9690
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b421b909-fea3-4859-e699-08dec5f39ce3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|35042699022|36860700016|376014|7416014|82310400026|22082099003|18002099003|11063799006|6133799003|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	4Wah1/ZarxFNva+g+qoExgAVeatUjzQF159esPoIlvGjD8+HPlWhvK12NogRlrvUxesVUMwWo2rTU3krrYmzEU4BGBf2n3dnG0DC1s7Mbw4x6dvBXNwGJ4in6l4Ny/wkQnKpsqP7DUqCDX4sfSmKc4so6e9PEYx5X26m8gaj41BSjEaPeM3XooRdusDPWp5VZdTDNFIOL3rpkmKY0eHoE3dWgqMOiHz5iM/VDvFMiizMhk1NSiw0Y+/mO/w4vq0ZaITnb5J4jhIie39gPtpuIk7u0uPg9/xFoKmUjV0j0KAvsOJ+KL3OIHSE/eIpLzSqT2sbKDAeRuQx49sfdq1R+ew/ly9VQE/E9OwxRICW9yClcNCSVWu6nUWPdiBXI35kGw+/+cneRmcfln6PVixUZwWwOntNKOXWVjzb6kgMeybXi1ui+Vx8de4upLx4Uh47jRWjlCjZNsrWNAg7xG8cc0Ayi7HcRHQ3c1KWivvmPjELJgKeKi7B7V0ZLHzAqi6YUaQaKv8+jnywo9BMEcq+edjoK1JuMwGMpuNJ7qeMsPqADkmajZAIN1Iq9ZpkgPQYqgqI9+lG4YkskD6QGl+RSYhBlXAKQ0a4T6I4/R4ApSd0q7p6Wq8s4TfQ3KBCcgxE+xn6v3/Si2dvFG4nohgmMmfnL1HziuWqxv9R2yGHuKtHUhSPCPH1rh4Vqh9RgNW8
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(35042699022)(36860700016)(376014)(7416014)(82310400026)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+lLgZ4use8ij45aT0ExS6G3TssXauTj2x2JoWjTObpFjZ9SkIbXwGBPA2HgbG1quVxGq4EV8BXJwfqo7KnG8tZ8C5kkcJne7iqtGyq5u5E0c7WqBqjDCO3ul1AhqceE1J/EoxQOlYNouQtS7Vew4105atgQlRFKrdJHobUV6JN7DvvM4vkY81V8JmkehittB+0T1tB2pY44l0WYTSRI/E+buiD3xxzQq+1/PMyH0Dcf69aw+G9hOvMDUR7zAowBhE2MO4xH3P8cHn54dZ19W4xiYdISd1rjmh4LACClRktVqZ1MgStl8zyiuIVbXStX4/JsQBjeX/LMYMVzlUCr/ZZB+eLfnYJ3T5booE9WUzb4rBX6q2e1gtuc8iUn5KjmbqjvdvddZ2WrhVBo62navEoUBzyU+nmtN6e74Id4uk2jKH2xEId0arnL2PKfFw1z0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:53:16.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764db73f-4b56-4c0d-f9bf-08dec5f3c871
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926

Hello Rafael,

On 6/8/26 18:50, Rafael J. Wysocki wrote:
> Hi,
>
> On Wed, Jun 3, 2026 at 9:49 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>> Hello Rafael,
>>
>> On 6/1/26 20:08, Rafael J. Wysocki wrote:
>>> On Thu, May 28, 2026 at 11:10 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>> Prior to [1], drivers were setting policy->min/max and
>>>> the value was used as a QoS constraint. After that change,
>>>> the values were only temporarily used: cpufreq_set_policy()
>>>> ultimately overriding them through:
>>>> cpufreq_policy_online()
>>>> \-cpufreq_init_policy()
>>>>     \-cpufreq_set_policy()
>>>>       \-/* Set policy->min/max */
>>>>
>>>> This patch reinstate the initial behaviour. This will allow
>>>> drivers to request min/max QoS frequencies if desired.
>>>> For instance, the cppc driver advertises a lowest non-linear
>>>> frequency, which should be used as a min QoS value.
>>>>
>>>> To avoid having drivers setting policy->min/max to default
>>>> values which are considered as QoS values (i.e. the reason
>>>> why [1] was introduced), remove the initialization of
>>>> policy->min/max in .init() callbacks wherever the
>>>> policy->min/max values are identical to the
>>>> policy->cpuinfo.min/max_freq.
>>>>
>>>> Indeed, the previous patch ("cpufreq: Set default
>>>> policy->min/max values for all drivers") makes this initialization
>>>> redundant.
>>>>
>>>> The only drivers where these values are different are:
>>>> - gx-suspmod.c (min)
>>>> - cppc-cpufreq.c (min)
>>>> - longrun.c
>>>>
>>>> [1]
>>>> commit 521223d8b3ec ("cpufreq: Fix initialization of min and
>>>> max frequency QoS requests")
>>>>
>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>> Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> sashiko.dev has some feedback on this patch and appears to have a point:
>>>
>>> https://sashiko.dev/#/patchset/20260528090913.2759118-1-pierre.gondois%40arm.com
>>>
>>> Can you have a look at it please?
>>>
>> [sashiko]
>>
>>   > Does removing the policy->max = max_freq assignment here break UAPI
>>   > expectations by exposing the unlisted boost frequency in
>> scaling_max_freq?
>>   >
>>   > Commit 538b0188da4653 intentionally allowed drivers like acpi-cpufreq
>> to set
>>   > policy->cpuinfo.max_freq to a higher boost frequency while relying on
>>   > cpufreq_frequency_table_cpuinfo() to clamp policy->max to the frequency
>>   > table's nominal maximum (max_freq). This ensured that user-space
>> tools saw
>>   > the nominal maximum in scaling_max_freq.
>>   >
>>   > Although commit 521223d8b3ec temporarily disrupted this by defaulting
>> the QoS
>>   > max to -1, a subsequent patch in this series changes the core to
>> initialize
>>   > the QoS request using policy->max.
>>
>> Effectively PATCH [4/4] cpufreq: Use policy->min/max init as QoS request
>> now uses the policy->max value set by the .init() callback to set
>> the max_freq_req QoS constraint.
>>
>>   >
>>   > If the policy->max = max_freq assignment were preserved, the subsequent
>>   > patch would successfully use the nominal frequency as the QoS max
>> request,
>>   > restoring the correct clamping behavior.
>>
>> IIUC this suggests to use the nominal freq. as the QoS max request.
>> This was behaving like that prior to 521223d8b3ec. However doing
>> that would mean that if boost is enabled and the max_freq_req sysfs
>> is not updated, then the frequency would still be clamped by
>> the max_freq_req. 521223d8b3ec intended to correct that.
>>
>> Sashiko seems to suggest modifications to come back to the
>> pre-521223d8b3ec behaviour, but I think 521223d8b3ec is correct
>> and we should conserve this behaviour.
> So there is some confusion in the patch changelogs of this series, but
> not in the code, regarding the role of the last argument of
> freq_qos_add_request().  Namely, that argument is the initial request
> value for the given request object which is subsequently managed by
> user space.  User space may in fact change it to whatever value it
> wants (either lower or higher) and it is only taken into account along
> with the other requests in the given chain.  IMV it is better to
> clarify that, so I have updated the changelogs when applying the
> patches.
>
> Please see
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=8c83947c5dbbd49b36d08bb99e344327c6278781
>
> and its ancestors and let me know if there's anything missing in the
> changelogs thereof.

The new commit message is indeed clearer.
Thanks for the update.

Regards,

Pierre


> Thanks!
