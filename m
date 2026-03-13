Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAF39890A;
	Fri, 13 Mar 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412201; cv=fail; b=cJP3AFqOEEC0Y9TmFj1GhFBPzNQ2xNitrEX3A4rRt1ZGVg/vmWLFC6hT6Spj+oTStyaNGYhWDUyOFeOBbTNteXFcCBfJZSWmwcWP9opW6MOzeWknfLdlR+cLe9V47m82L8RrI1RB9PJ71CQJG4gsZ3gQdBgIZEpaU2oHUyMUow8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412201; c=relaxed/simple;
	bh=ZMBhTR9UOGTqlvzfFAdiPBQtYBwCpYoASh26KAV50cc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pTa3++Y/uf1eBzTg7mjzbqfaS8oi6bLK2LBU18iuwLHcnDml7Of1m4e8ZFOYyUGdoLkUZiP/UfgU40r8qFI1wj2jPCWuRNbcBxGjeYfu0VQ+YtlJNsjNKkAkEY8SmpxEga2tVQfDqg153gXGJXPjjCl+/1j8VtO5TncNxQz9eSI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lUmVs8RY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lUmVs8RY; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lUmVs8RY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lUmVs8RY"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e6ZS6SIjFqJrGwwC7yK+Is+wnMchhgEKgN4FruhJYctt8jKcxrxsSDc2Xa/sreqzi1Ndsz5MRkRCd1t/A7po7gx5dT7LQkAaOftCmKdSrQn7yrFpf7p3hwvx+i/zCFDzRNHMUU6uiGJdKTGTx4L8X4xfPGyRlnWP1CEqpP0W3kuet7dKeWPzGs+GzzAOOGczw8l3XtLMT4tUupbbpRjllfAThsc0tLB3J/83dWSiOYaJs9N7mJb0hFSUOkyzIKsjN/AhZxdjwbiMcgWiZsgPYetlKfBagM0HliH6Oz5kvNJM28jbpTogNWAJ5oFaHHqIU0nKpOq6++nt6pBS8o6PFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PTLuIX2HQVLvm2C1g0WX7oF4yoKTdF7efOm8Vbf6Vo=;
 b=cFk+jNdjoJ69xs1e49+Oi+qMAMKOXhpdWGTgBkxY1h/Az+SDu12ftaG6ffLky0nYAtOj02hou+K0NyaGruhFftDbRuPytgyfryQEV9uPkyK/sREHXH7JiyF7RJ4axfMjMXBsocoe1/cq4LVjZFjj7K+tt3Rjc+JEI4nPteXVS11JHpqUsMEBEyjHotJt1VihNQ+PudYooJ0PLbbvqmqB3MRMq7zYPghpoJkTPEdUiKBiIKj0jkLjGIzLqhGGtgueypfHqcrzc3hVYWoR5rBsIVYOxN+fopGoLHOh1KibXvHLuItX0hDZUFLMG8z3uUMnR7XKheqps1tO72AJOcku+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PTLuIX2HQVLvm2C1g0WX7oF4yoKTdF7efOm8Vbf6Vo=;
 b=lUmVs8RY6O/39/kTXj1CO9+mlkpypjwebh+IaAMWiVNYoFa6j3q4MiE5uiGn9sBuShd0ZPbx5j6P7GESydZ1Cv5k6NKrc1DyZDaQ04UEkm75MYKHMpHsurlx9IBdPQmsJ/NVfMGyfRoohtMcWfylsx9KedMbWAFKSxSAAm6v5Bw=
Received: from PA7P264CA0421.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::22)
 by DU5PR08MB10821.eurprd08.prod.outlook.com (2603:10a6:10:527::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 14:29:50 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:102:37d:cafe::b3) by PA7P264CA0421.outlook.office365.com
 (2603:10a6:102:37d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 14:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.1 via
 Frontend Transport; Fri, 13 Mar 2026 14:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIsKf3pLOCCISH9SbcM2Uox6N/l5H/o2rOkKug/aYRTkVQuhixmWFTiXFz8gvvYBbwqVOGWbhoCjxjcoAwoRTmeXxvprzLtb1E3IC2CruEfG/O1R7vRRkhfphvdiJKgkg3cNADnXin0+zM4BBqtZuLR7HOZifSjusjC3GKFB747Ym26ZF5cPv7BFaegqN1utbbvdMHaIrfmnAd+FD+P+JprXm8ddfLxDWHU2+dyUr6dCTUyyE66Q0BzT8wqnG7N6bkUm0gOqHVwV3v+f8yN3CM86FFlD8slN4HPoyhaVpYfGJGoTf9r6g8JPIN8hUyIByIuzbjcEsf2lbURfjR2tCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PTLuIX2HQVLvm2C1g0WX7oF4yoKTdF7efOm8Vbf6Vo=;
 b=HIWV5siY9D7stcazBkyEHzSMxQcTtqAUxl5Xt/gh2v0FO242HQ+Agft/nlOYTblEmimc2OO36IdUwydAHBu1aj88fdLVOV/0a8BKlPUu6+KTV3/yIPiTv6dIev/yQp6daIpWBp/khz7PrtWrH21ySUcYzfMecSSI1sSxFK1A0I/zsa8++4+KVMwLY8MmSi7+eXDEdA1d7zRwqyp+19RaMMI2dJBWAZw4D4KFHhoV5lca1Avmcs3vD5meOKx7bKn/8jdj38PkBCkOxBiMrZBb8EAnEVOpZtk4/MJwx6O25FytqYk8oNYTPZekcVXcOR70c1nExuRsxgLr4PLPQpnfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PTLuIX2HQVLvm2C1g0WX7oF4yoKTdF7efOm8Vbf6Vo=;
 b=lUmVs8RY6O/39/kTXj1CO9+mlkpypjwebh+IaAMWiVNYoFa6j3q4MiE5uiGn9sBuShd0ZPbx5j6P7GESydZ1Cv5k6NKrc1DyZDaQ04UEkm75MYKHMpHsurlx9IBdPQmsJ/NVfMGyfRoohtMcWfylsx9KedMbWAFKSxSAAm6v5Bw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:28:47 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:28:46 +0000
Message-ID: <b740cefd-cbfa-4b98-b3ee-8fefdaf8e322@arm.com>
Date: Fri, 13 Mar 2026 15:28:45 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-3-pierre.gondois@arm.com>
 <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
 <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P193CA0024.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::29) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|AM4PEPF00025F98:EE_|DU5PR08MB10821:EE_
X-MS-Office365-Filtering-Correlation-Id: d484ff70-530e-4d87-73bd-08de810cfba2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 gnv/39qPQsHmFwhAn1DU8EkE62h00Dh1QKHzcTkzsZ/2KoA9V0FYGuRYddhU5mGUssbdJlutF9yr3rCdIvYJiD03RmeZ2qzu6RY5yQypQYHXjfEKlmYqY1Cc6o3pxdK3osz0c9MBDtErxCtmHaYX4ZCFe3iS1SUFKC+DkcM07hhlCARt2bMSlp3D28aJQpNFKFoI0pcYoEmncHRt/D096bj4azwn6AXDYjLIEdbHiWsDkaAAnA12AQroWkuGiJzA1CH3fOBFgxunxiEdl1DMlrvY+jCCS7XAAX7xfu7s2kvBPjhvFDLmilSc+eJ+oHhdTzROH/NgFqtG5vEENZLoNWnqtapUgSqwtwlp0iiZxkuo/1iIaVkpMGuSrxys2JBfyXqGST/n2DD5+mYe4lP0NX0gK8Aj4rJ+5YlSxmioZt+3dO7x4uydSvmwkCq8rcbFcSWR3N5kzyXFg75ZLr0Rgfr91leZ1JrxfbfMWnibq3eIEdOBwjCz4U3zriy7Re5ZvjXz/mJ93gcuExWXMWrXtXIdYV48zrgtNtcwHk/wRQRaspm1EEeI34V+xQNNpHJTDkOYcWT3FJ3AiShYEUY9HZidZOujvpo7oSyhAbNg8w6MzNcjC0Qu2nbQVAp9a4giBT+LF0giShSLq8pzwsyD7d1O9mKR8WRLmjvQq0gMN/e8PqVFKI0kN368cNFyXEvFscLCcfW+Rh+CQ8zSYtEMnr07Hikj2b1ciZUPkM9+ITk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 kG04qyPrPsS7P+Na7GXeMylTCIdHJaCgmM5XPslrmKH/zjrXtJwLsaEUamarrZRvETfgdJiL18+bZxMQAfKiZJ/HfHlmwsBasq7/sC/zffbYuUzLtGbPKpyAsMrSN8pdHQbd0GP55FHw9RaTA3yd1aedBdAosZPpoUmWVQXbJWpqs+ZMvDHqZsLjywXVHCMLVbvhRD+eN0mCWSRx6NHVGUs+qq1WgDeFA84f+vCb4QsexVEPwADZWiYy9ZVuKKZ5leDIEeU5hnEZgjAmcHQG5xj1f1TzDTPCiOj+mx6mGEuNMjMNQHV4Jd7WibtNLTBt0y373J5Uogz8haV93ui3pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e125fc91-a7f2-4bbe-5e70-08de810cd630
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|14060799003|1800799024|36860700016|35042699022|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NrXbr3WA9m8jsld8rUuse/Bhlc2IMUTsqMp380mSYCacAfkxUZKnCg8wcriYzKZ28wsL7S/kviFae8mXw3e6WFZGzSgqs2ZtcTznzAXRpw1KoViSNIkT1SEUIzpL97Gd0DeyeqrNvGBTGHxkTs8N9geYonBbSYL7/2UNvzI1ayXIkXomcvWrPihA+Muf6NNN8dHvOXnt4w+OXIgG3L1nnhMrkTtdf4KVfllSTXkX4YZt994DxmmnifZyASfqLR8bpjSZG3uVLkddUpGGeKeNsNZPXFNou7hD+bcNpFBUs55LW/B5CjBmO4Y4ubk7u+PjHdM9Amg6kKk7UfTQXb4qM/3fxF60viBpfSBoz+W74c/ugJPHQRAGiHY8ZDULadsPHso4xVKpl48TB+Yrlr3ZGLD+egXNDkwpnXxeaZdChUIEqfUjHQYk6d9lmC/e2ADPzLXjeB06EBuEjvWaZVsNvi7bTi/nWduwcc9vD1ba3ShRwDPSGrbgW6W/ugdl0lDNVi9x+phhjM+UBfzoBbTsLavqX3NVhBHB3mD9qUiwfy0tDSW9IUmdKFpyr0RIZ9q7Ez7OVCjrqnRV+Ke1H57Kk/kPghKE8Q3s2GNujDeft1vEt0lBcbFo7goUn898d8k9yrmCUNIwyKnZCTCfaO0dZFCpOF5KoWoblcnPjbUAeZwIOhZjfJIRvYb971BqCdKgp82o4d/ljYUVryuIia9X7Z0kzXfAbx/IT2czK0LqJF1qJ4+DvzZioOVHXXTOgtbVsDIPVRPWOfyshY4K0hgcWg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(14060799003)(1800799024)(36860700016)(35042699022)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NQifT2i/w/hB7V1aAWftbTT/J6uIarWPWLcjEyNlInKbBkkYXc6QbbW7hHeWTzSSb1lcDXj7BabfhLmgq3FycqNdeHYCxFIqdAU4j5RKfo1pAz7JeOfE4B3kknVtzkaVWEstHd1Zhxttt6pHHI1Kv0cjFlU/kC9ZVMs9ZyOVytdOpZsWM9SeEdaZAnul47kUA3dnXZgqHAAYNK+HtFtReTWhxxd09/h+q/QAnkNZHo2sqffMC8QamppN4gPIaF+KnjWPoHGoIApN4LTJqC1Z35xmms0YT5ZYgjwt9yVvrF3rrkQgKrNDVUV/c43/YFOA/6TRMiCNGqvLrhoqx4BoZIyYSwP4gsSNQcUvpOjGB30PnGz94uVF9vyzMFGlTKb37Q5+6Nwxp+cmCm2TXXfsdXDxg00jDlcD9CGZfhVwET4CxPtFmB9PJSvWJqc4psPB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:49.3434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d484ff70-530e-4d87-73bd-08de810cfba2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10821


On 3/11/26 14:57, Rafael J. Wysocki wrote:
> On Wed, Mar 11, 2026 at 2:52 PM Rafael J. Wysocki<rafael@kernel.org> wrote:
>> On Wed, Feb 25, 2026 at 9:49 AM Pierre Gondois<pierre.gondois@arm.com> wrote:
>>> The Power Management Quality of Service (PM QoS) allows to
>>> aggregate constraints from multiple entities. It is currently
>>> used to manage the min/max frequency of a given policy.
>>>
>>> Frequency constraints can come for instance from:
>>> - Thermal framework: acpi_thermal_cpufreq_init()
>>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>>> - User: by setting policyX/scaling_[min|max]_freq
>>> The minimum of the max frequency constraints is used to compute
>>> the resulting maximum allowed frequency.
>>>
>>> When enabling boost frequencies, the same frequency request object
>>> (policy->max_freq_req) as to handle requests from users is used.
>>> As a result, when setting:
>>> - scaling_max_freq
>>> - boost
>>> The last sysfs file used overwrites the request from the other
>>> sysfs file.
>>>
>>> To avoid this, create a per-policy boost_freq_req to save the boost
>>> constraints instead of overwriting the last scaling_max_freq
>>> constraint.
>>>
>>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>>> ---
>>>   drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++++++++++++++++-----
>>>   include/linux/cpufreq.h   |  1 +
>>>   2 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index db414c052658b..50467b938668a 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1359,17 +1359,21 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>          /* Cancel any pending policy->update work before freeing the policy. */
>>>          cancel_work_sync(&policy->update);
>>>
>>> -       if (policy->max_freq_req) {
>>> +       if ((policy->max_freq_req && !policy->boost_supported) ||
>>> +           policy->boost_freq_req) {
>> Are you sure?
>>
>>>                  /*
>>> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
>>> -                * notification, since CPUFREQ_CREATE_POLICY notification was
>>> -                * sent after adding max_freq_req earlier.
>>> +                * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
>>> +                * notification, since CPUFREQ_CREATE_POLICY notification was sent
>>> +                * after adding max/boost _freq_req earlier.
>>>                   */
>>>                  blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                                               CPUFREQ_REMOVE_POLICY, policy);
>>> -               freq_qos_remove_request(policy->max_freq_req);
>>>          }
>>>
>>> +       freq_qos_remove_request(policy->boost_freq_req);
>>> +       kfree(policy->boost_freq_req);
>>> +
>>> +       freq_qos_remove_request(policy->max_freq_req);
>>>          freq_qos_remove_request(policy->min_freq_req);
>>>          kfree(policy->min_freq_req);
>>>
>>> @@ -1479,6 +1483,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>                          goto out_destroy_policy;
>>>                  }
>>>
>>> +               if (policy->boost_supported) {
>>> +                       policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
>>> +                                                        GFP_KERNEL);
>> Instead of doing this, why don't you add 1 to the policy->min_freq_req
>> allocation size when boost is supported?  You'll destroy the policy if
>> the allocation fails anyway.


Yes right,
this would make the error handling much simpler to follow.

On the other hand Viresh seems to have acknowledged the logic,
so whatever seems is better to both of you.


>>> +                       if (!policy->boost_freq_req) {
>>> +                               ret = -ENOMEM;
>>> +                               goto out_destroy_policy;
>>> +                       }
>>> +
>>> +                       ret = freq_qos_add_request(&policy->constraints,
>>> +                                                  policy->boost_freq_req,
>>> +                                                  FREQ_QOS_MAX,
>>> +                                                  FREQ_QOS_MAX_DEFAULT_VALUE);
>>> +                       if (ret < 0) {
>>> +                               /*
>>> +                                * So we don't call freq_qos_remove_request() for an
>>> +                                * uninitialized request.
>>> +                                */
>>> +                               kfree(policy->boost_freq_req);
>>> +                               policy->boost_freq_req = NULL;
>>> +                               goto out_destroy_policy;
>>> +                       }
>>> +               }
>> Then you can put this block before the policy->min_freq_req addition
>> and the corresponding update of cpufreq_policy_free() will be more
>> straightforward.
>>
>> BTW, if I'm not mistaken, there is a bug in the current
>> cpufreq_policy_free() because it may attempt to remove a NULL freq QoS
>> request for policy->min_freq_req.  I'll send a patch for that later if
>> I can confirm it.
> Fortunately, freq_qos_remove_request() checks its argument against
> NULL, never mind.
>
> Of course, this means that
> freq_qos_remove_request(policy->max_freq_req) need not be there under
> the if (policy->max_freq_req) in cpufreq_policy_free() which you have
> noticed.
