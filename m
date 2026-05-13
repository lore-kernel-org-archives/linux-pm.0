Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2943C074;
	Wed, 13 May 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687060; cv=fail; b=gwb2pUM6teigphvmRx8FHmN+hHsvW2LuhWNUQ0oVKrR2DlJOOH4+Cv4FvkhjKQTpHcXkOMHu3ZsQgltHG/dvNtaYff8j68R7HskMOVrNs2ocAmel8IPacugqluPO3zZmCA+OVVnGwShyv/w1WWPX/FBFkWmS7QRUgYWx5R7H1Cw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687060; c=relaxed/simple;
	bh=iaXUiaQxXgTBnOvCAV7qLBE2tnabR5Ul/2CdfBqHiPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tu9Lkuvlv4ZJPnyVqYyrt4H15z3Wi5Q7JZoj0h5TlO7+1PpgOtJzU5w05yeO2V89aAuL/wDw+h2+BrApv1/voyWByle/wG/S3WEYWTzi2bsMnqe47bIViXSm+pRsqjLsyKE4wkg59kLT/29jB5xfbfsh53IpbalIdmr4BEvZQ5s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kZgu0mQi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kZgu0mQi; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kZgu0mQi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kZgu0mQi"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OFGnT9O37W78O7wih3cpOxSV4CuKz4y0tMWoD2lR6VXWkPUNI6oGdXv5wgm18nZAqMBQQ6FDzThwMyscQN0+HjRKZNk1Tpzmw/4W4bX1Y6sedMMYAnJUylvVIwwPyKb58PMxcMDbtZqieKgVc09PLBgJt409EfJSXunAb1j2NmpWUUgEv3HH4D/nPfglRxU7i8a+wFITlP8G3T9YDkcKf6wo2HIg1FGwXg4XlNZkZc8gwIVqOrcn5/Wm3mxqxirwW3SOq2K7Nyba7re1PepWqIEtsTLVoPnERwZcxo3C1TXQjM6sb/zN4go7Z1HoxFIuboc21s9YxW2G0/Y9RHVdtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exOJ6ieRTWkbULydW1Xfm1CtW8zrDnIv2ZCtNVSDUwk=;
 b=R41sZuRaaJZ8SqUJisam5uA6bxDs3Qu10twmXJdnG2AMwBDMUt9RQbfB9tO/uKUb99+ut7vQ/FFGtBvGb182TcAqaja3VgIj0aAlUwRR7C+W2kFfGaSAJ/xIM1yguE826qRfz6VFFSJXsFpS/4ePXp4SvZYI3TMYI3UyI9pmCpqNZ27mlXofHfFxziIMUm+zyErTQXkb+diMOgZHeIBi1kaoNx0WGX81TyJSZHO/nEt/Kfn/6AH7KU6cGTArk8fGZe7+n7s2odA2AvcGd/89pgu/kUfeq75ES9W8uugb3pClsOfLuQxJ3YuilvQKgjKWSScAixJ6n77auKxfJSAWmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exOJ6ieRTWkbULydW1Xfm1CtW8zrDnIv2ZCtNVSDUwk=;
 b=kZgu0mQiH4Vfbur30ghMoDJupdnVgn/dD6EFGaJ27qMRMird0kbbGYjnl1YrH1hab9+VcZn7CuFysnc2vuScNcAUpSIK7XSoWkG1N/cx9pTB2RoiGRgC/Oa5zzE6yBUdaS3Mw8o7OWwMC0v2Kz6g0D6PfCvgXWzgBlTngVjCYQY=
Received: from AS4P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::9)
 by AS2PR08MB8880.eurprd08.prod.outlook.com (2603:10a6:20b:5f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:44:14 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::42) by AS4P250CA0008.outlook.office365.com
 (2603:10a6:20b:5df::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 15:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 15:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtYB1Qhxn/X1jNNy8aTdqu2xdZXkAPnt2KZISA0i08GgFOpeasmfe/L6JimG/WIkga8/9NeInCFWbg67NtjjhQcOPOEN2YIq+G8NPNHhxtZvK9woCVJR2zryI0Va+q7v0fQaaMiLyzLx3pfzUFMb7gT62qe+y3Ucg7cS10l5gsIjDEnC8Ln/g0H/oSNoJGi2MP6OVZkncNtCQybJc1eAP3cd13eIiD7LUBygzIbygFIe3/oq8RfYzj4brPyE/icgfkCQydUyYrNV67FTkSOZ0r8wLrZa2mBouK+USNupdjaCy5Bcj60uHi9Us3C5ZXEsNNL1CzbT/k5W89jNpi0/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exOJ6ieRTWkbULydW1Xfm1CtW8zrDnIv2ZCtNVSDUwk=;
 b=ZHrjEVJ8ot/PS+9g2KH3QxreoDQeH2xdsrr3WPCDCPjdT/vEGHeXTD7a8NNQ2GfmMfPF5sFyLcmSfYwqZZVmXgZLNdsWdQGwQru4NZAV8gCbp45omvL2FwiokGOy8+J67jQZr1SY24Vu2LLfWkGZMJUVHTYGM93yeIIj+w1x/2OIjgAoUBOj2WpxZsbVnoGy3qH9IhKng5y9R/kZWjkKa16GeFQdO3Vrqq9u/2anLeYO6PhHqiW2lxPhy4BJXHfI5QCsUwwPmiHfdRm0SPUh2fKmA20+EChSVbbMtfYrIEBO23J208GoMgeBoDsVnapMp+2ZrPcWo0d5RSXkBQZwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exOJ6ieRTWkbULydW1Xfm1CtW8zrDnIv2ZCtNVSDUwk=;
 b=kZgu0mQiH4Vfbur30ghMoDJupdnVgn/dD6EFGaJ27qMRMird0kbbGYjnl1YrH1hab9+VcZn7CuFysnc2vuScNcAUpSIK7XSoWkG1N/cx9pTB2RoiGRgC/Oa5zzE6yBUdaS3Mw8o7OWwMC0v2Kz6g0D6PfCvgXWzgBlTngVjCYQY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM0PR08MB11777.eurprd08.prod.outlook.com (2603:10a6:20b:747::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Wed, 13 May
 2026 15:43:11 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:43:10 +0000
Message-ID: <ab6ae808-f953-4147-ae48-419a196c5819@arm.com>
Date: Wed, 13 May 2026 17:43:08 +0200
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
 <8516aeea-f20b-4afa-a737-1dff636f5c2d@arm.com>
 <9c32f75a-294f-4cea-810e-c011c4dd91ab@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <9c32f75a-294f-4cea-810e-c011c4dd91ab@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0156.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM0PR08MB11777:EE_|AMS0EPF000001A2:EE_|AS2PR08MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf4af03-418d-4690-a9c1-08deb1067bfa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|11063799003|921020;
X-Microsoft-Antispam-Message-Info-Original:
 +X2mhzIroAH+cMA0YDhz2t0WvIIU5DxRfcNZjnY+ri+lzf696CAzydcPM6G6GH9vGw3qAo7dBNeKn7Yz/RRiZYYrB3A7ysPDxjjo0bsAhtnQsRYXzxmbYbc4jEdVeVjGw9u0ukGiuqBL59Xk8E1b+Pa3Qti+ek3t9I8fMh0KI3s4jOcesMETqdhtuq9KGljoOx9XEpkwMx6R9II6QQWa5po3eeZgd/3AJrqOVdOwLxL1oTgCiWxxodNzgpK91VJc3WaC2Wa5zt74sX62ew+pYtdhflpfX8EECtGobgqN1F3yqx4jx8wglx3u4Pz+OhkDAMGnGNCOgitRICZOCI9G+JTynE1f3g0JLZ3vElWErVWN5ddVKoOeywIzKNFKkj6PeWr0RbiUAqeCDVxnYKP+1VHTj+5sGFmXGgGnO0Ya43jCMHHbb95VN1c0tV2fYTwXKHGIE51aFssJ+11HqNWvCm5aGo4ucysXVh1mquQVHR3WKfU+9FH4idwd37CPH1911cEEg8n+0ISBK1FCLrX3QSQtfDTK8RrUYtfTlC/TdEdL0V9tCsJgC+5HNaauR07ywkMeg+mgdz2ZP4yPeXLa/cArVuKlfea2LvrR+9UCgf176N64iddfmD73tZv7BnW2ew9OsrM9UYALf3xGqLljArk9ULYWKsMmGvXUHdcFQx+54x47lV0RRbeGcw4Pr0TS4RTj/+e826t+JFdUpPLIEWikW5wlo97ja3WRVCEihxM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003)(921020);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 YgN2SkLPNEmlCliG2zOtU9aibInma/5zk2zT7xeEdHbyLWOntYb6yljNp56dH4QF+aZhGNVv2bpl8p5YIas6sfb7SEfizN78Wg6TZSdgu3wU/mDOw46//14cBedWlvNBThFqJPMvik5c5o9dhdW2+8v6m0O7tMcW1zKYOK8Ep+M9htrxzjLEtIv5tNMnDraQ5/3tjv10uEYslqXV2CGevyKcT3H5SnGl9ITcnDIFH8034JtUSSro1ADyPT4JBeHq1p2sV03MQk0asMXWh5rgckmzEmbID+uRVDE6TMUr/DmmzdwijDZnzuYPzEjDiSvd0c5XslA/862eyuvMyXq2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11777
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3a88d31b-10c4-410c-30fc-08deb10655fe
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|35042699022|14060799003|7416014|376014|82310400026|1800799024|921020|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	XtwNGVYUgVXs3Brb9jh0isYZz1xNgMiDHbwmJCj7YvE2D7pwvCxCh2hlWo1OTO8ORbAPrnnUtE3ele43JXRcL7EIKdCSdwT3/6/E18LghTubRRnNvW0D53RN892pSY5+dgSTKbv+YYTeEM1JCK9PtOcOvVYw2IcLXPzaxyI/wsTTi425zSvvwA+HMuNT78fEd+mO9BdinW+of+1h8WMa3Syuco0u6RoUxTglvGmfIUkjAqcDG0W+5ARNDmuwyckROWWT3ovZi9N+3dPcLURv5jmCjozVx1U1jeTW+b5UWvBMgms0MeCBauEAtNk8onuytkqxDxz3e4t50EV1TBqYv2EJ2RbM9PSjiKnn4xEVLesG57qa+sr3q5+ttzbhiQL/sbnOcrzTlSI8F8vBK/E6k1e3WxLQphBQS51O45tCFfBhtJJJz1xzCJ4n6cflXqP4d8+6XXJ1cbIH1V9QlS+U/i7He5MU3h9xJxpPHduqCB7jFVhnHHyMzZYhw/AR2iHYZxwgszyUi53CfUJ4VHHMOHpZQsoJ4pZS5p69ahrvypaG6aS5pa6KQ6w4MCIOaVRAs274WhNv9FKVW448c/E2ReoSVqtYlaXO1QeFdqwu5AXoqoBiZ78reVt5pWTClE0KQrlN+Y7tmmjGjvFpUoD6HRfqopMu90y1eN4eutBH3CObExeA6fJNpm3o0tNc7c1aHoBquAgGeMmcAKorO8Vz98CQqFk+tADjZpEoL5N3qgcqPi2PIsRjfYrESOnHJ6sN53yTAIFbLJiqJSb7S86D/Q==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(35042699022)(14060799003)(7416014)(376014)(82310400026)(1800799024)(921020)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u5f9RoYDtc8Y6Sc83d6rhkCOrnmUi44sL/pm7KkzUQNrp7QsW9cyYMXj9JBDM3hqzojB/SCI5HNr05QCMd/YhySCQAZ0BUcYhpCOGcxXVTzgkRhV8jBVf72wF0t3s5A7Myoi9dJztxvYvD4EWTQVsqUCM7NS4Fbmh7jkLTE/iL20UpD6GEOfUVEN5mDxdRmT0cwQdkxiD1cCBNLfP8BFhj9i5v1Li2NloBjgZ1R6SOLcQzFIQMXDCeM+ZK2zGIXPEtley2lFtSk5qbqvFe2jhZ/Lo2VURHCKZfyVCrY8RYnCZzNEDx5RPwsBzGkg42E86UqHSzK+Yga7D3ZHOI+zBSarg7waKuJzOecVKH3GS9JRpeGuBhfQ+apohkELTWXT1gUMTE2e3UgGIpC4mcaS7TY/v2BVyLMIbLK/1vR/jjjpALb2RlCWiBUnaoUCmfqG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:44:14.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4af03-418d-4690-a9c1-08deb1067bfa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8880

>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 7e7f9dfb7a24..d06cba963550 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>               goto out;
>>>       }
>>>
>>> +     /*
>>> +      * Initialize OSPM Nominal Performance to inform firmware of
>>> +      * OSPM's nominal level. Performance above this value = boost;
>>> +      * below = throttle. Uses platform nominal by default.
>>> +      */
>>> +     ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
>>> +     if (ret && ret != -EOPNOTSUPP)
>>> +             pr_debug("Failed to set ospm_nominal_perf for CPU%d: 
>>> %d\n",
>>> +                      cpu, ret);
>>> +
>>
>> IIUC, if (ospm_nominal_perf == nominal_perf), the firmware should
>> not behave differently. Is this really useful ?
>>
>
> Right, it's a no-op from the firmware's side. The init was only so that
> sysfs would show a value (platform nominal) before any userspace write.
> Will drop it in v3 and return 0 from sysfs until userspace writes a 
> value.
>
>
>> ------------
>>
>> Also this seems like there will need some synchronization
>> mechanism to keep-up with the boost state.
>>
>> If the ospm_nominal_perf is lowered and boost is disabled,
>> a freq. update should happen. IMO it looks like this could
>> be handled with (another) freq_qos_request.
>>
>> This new freq_qos_request, if we name it ospm_nominal_freq_req,
>> should only be taken into account if boost is disabled.
>> Otherwise, if boost is enabled, ospm_nominal_freq_req
>> should be ignored.
>>
>
> Agreed, will add the new freq_qos_request in a follow-up patch.
>
>> ------------
>>
>> Also, the function seems to set the ospm_nominal_freq for
>> a single CPU when the policy might be common for multiple
>> CPUs right ?
>
> In v3, after dropping the change from cppc_cpufreq_cpu_init,
> the problem won't come in this specific instance.
>
>
>>
>> The issues this field raises seems similar to the auto_sel
>> ones. I.e. :
>>
>> - concurrency accesses + need for a scratch value
>>
>> - what should happen when unloading the driver
>>
>> - the value can be set for single CPUs but we might
>> want to have the same value for the whole policy
>>
>> Maybe a common solution should be found.
>> (I m not suggesting anything right now unfortunately).
>>
>
> One way to address this is to move the sysfs from per-CPU acpi_cppc to
> a per-policy node under cpufreq (ospm_nominal_perf_freq, kHz).

Yes right, would it make sense to also move the "ospm_nominal_perf"
to the cpu_data ?


> In the sysfs callback, we can convert kHz to perf and write the register
> on every CPU in policy->cpus.
> Concurrency is already covered by policy->rwsem at the cpufreq layer.
> This is similar to how we were handling min/max_perf in earlier version.

Yes right. Something I don't really understand is that similarly to 
auto_sel,
the sysfs rwsem protects the state of the cpu_data->auto_sel field,
but we don't really have any guarantee that another driver won't modify
the firmware state right ? (maybe it's just not worth ?)


> Does this approach make sense?

Yes right thanks !


>
> Thank you,
> Sumit Gupta
>
> ....
>
>
