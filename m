Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317F4C7522;
	Mon, 28 Sep 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602437; cv=fail; b=UBsT+J5xd5gq2iGlIBh2rYnxWfcUMuoeTQUYbxY4wMqqw000w/5L1a9ie/a/am5BhZsMs8OE44+Nz/woCCRmK0lU2+U/Xhof4HeRQ8loIO5S0CzLb8Ch04SgHTXWT7QfSPnJRtvHl9XHQPGruDsJX7w3B0q4mjVlikH9uMgSm0g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602437; c=relaxed/simple;
	bh=qoOyeisugPgV0x/Ez/POdc36YAKQXr5Cn964t1DHwwQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u70mgjVJrPwZLN6CeqlGXH4YWg+ClXKmMfuRVTX3Bo9BJM++kdfppolWmopCHsrdYftGZJsI4Atzm2xcbRJHLw7XamnYizWTkxbSgLlxFtfRrccw0+JTd0gxOwGZ1zJIAEnqzL7gTM/Z2nLKAwuJP5cBN5z7Z0LECq8BnCtQibs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Aq8baAao; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Aq8baAao; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Aq8baAao";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Aq8baAao"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WvwkkBVoK5JoFjjixRpLYGF0zIRMmDk4RMOth8fPiGklGzjtw4hGsORP3egNn2fpCoC2QNYMMfAj5sWkeTH6ZF7ZD8fN4nKSJYGFbNlm9T/Wj0MZjoxXs+sxQmCfc8u5KGJTvnM1QhVKfmjHdCfIov/4k0fGH415HRGk7sh1Vj/TEYanR7mHMUBEoGkXxWekTfk9LOlL4TojMTK8kt3c9cistNtfTLDOK2h08c8QXdo1PRpwy4cOgiLJjWsnXu6gtROBAfhZ4l9SF4Ea95S7L7BwbUq6+M3WyoHmSh8olFGJKJbGL8+7/OOmXJAjqhbgCrVhN1qojEy8LIL41dSSag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhJiPmC05vbAFa3iBHhvre5DBnGDrHpdgu0wj867Zd4=;
 b=Qk76iFoXH8iZd5cmdv0lIw7Kqso/6zTvajWB4k8edUzcIVkR0waKF78+TJwrS9FSJkvmxCBNZSgnrCMbFKq2y4dFl4gR/r6btsJmZyEQ/1+D11YdAsCqx9CQRpWYkc9m1qFQ9M44MS2dMEvgHrlvUfDlLpBLJ3e2Hp/iDLqOnKnAHf71J+ooN/TumJ9AsSCXpmTKpOa4uI/ynRIO8Z37cRBoxro+td94wWRJ1vRs3Z4WZ3c27dtjVgrZzLG6ng9fBznEIFH+sp5gAPay9yHVbwT9+tMHwrDzNoxQsueZ/LMmNeOpKNjN5FylROgMjY4KQc89hTJC4JI97LiqrQt47g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJiPmC05vbAFa3iBHhvre5DBnGDrHpdgu0wj867Zd4=;
 b=Aq8baAaoHdQOMPHkBdX5D+FzkZ4MuFmwIBJ04wtAGE3ifFB4AT7KfmNic7RsPTgXTrLx7NjHmCgQ7xANmMUnG0V39BvKaw326xH8do9zcNk53mcsfmOHRLk3WshykCtPC0i7vCDpjGZRSciIGL2CqL90pjqQTHckcXfzUAxPPL0=
Received: from OS6P279CA0168.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::7) by
 PA4PR08MB6158.eurprd08.prod.outlook.com (2603:10a6:102:e2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Mon, 28 Sep 2026 13:33:43 +0000
Received: from CPH1EPF00000522.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::9f) by OS6P279CA0168.outlook.office365.com
 (2603:10a6:e10:38::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 13:33:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000522.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 13:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH8vifZMlV/X7FOGuPF5vdBl9HfECwcUG2bZlTyyKw/t6I1Q0Sek8b8tUNWXu7H/2+anZUSiSCZu37yHJUcJL4st03rkv211WkbFtssnLU774OHWJVkdDLcZtSXxdHyZywxarH+DQCtfPviNCn1PSGi+eUskpxGwlmrs8AC7GVxyFGUMcyR0YiQGLkVp2zGCIeJ/EFcUgeAbvCU1mnztzRtucrOgwQeG/stN/T1q80uC648pqgHVgft9/w/B09InG4T8bKerBvZ1DeoRgYhKWTbOVG4SROPWwHrUwPCWfKaTM2LYDHs9Z7/xrHwu9nPH5OV+Z3zWdCi7kyrI88lTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhJiPmC05vbAFa3iBHhvre5DBnGDrHpdgu0wj867Zd4=;
 b=g0PU0BttSNcSrMWsuEGLL5aCDsSEjZppr7GjHDtfMWbBEqWe2I1qXlD0yvYbR0QtHrXnxLa0xpLx9mbIz1r3Vgsf391+jH+5u9qe33FNXrzkkAjOKyPATbIlLalSIP6kd446kNh+kjs4kkQDpRmHB8i+snqFaB5LpgGGLpp4DIFwdhYrMZAeMu5vT5M09V+d2LdJvZjbdtqNHfWQXtxOJEVcccPGg+PUSQvi0lxZX8X2HhmIFh1IkxslK/awWzvlh4OO6/YRYHp542uSl/wdXmL91gWH3rc452na6agzv/tNoyEZYWjoe/4D25WLhLLrh+inbhzCJz8s83MLJdGSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJiPmC05vbAFa3iBHhvre5DBnGDrHpdgu0wj867Zd4=;
 b=Aq8baAaoHdQOMPHkBdX5D+FzkZ4MuFmwIBJ04wtAGE3ifFB4AT7KfmNic7RsPTgXTrLx7NjHmCgQ7xANmMUnG0V39BvKaw326xH8do9zcNk53mcsfmOHRLk3WshykCtPC0i7vCDpjGZRSciIGL2CqL90pjqQTHckcXfzUAxPPL0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBBPR08MB6201.eurprd08.prod.outlook.com (2603:10a6:10:20a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 12:21:02 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 12:21:02 +0000
Message-ID: <9ffb913f-87cf-48da-b08e-544cfbda785f@arm.com>
Date: Mon, 28 Sep 2026 14:21:00 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 3/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260916103820.1760297-1-sumitg@nvidia.com>
 <20260916103820.1760297-4-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260916103820.1760297-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	VI0PR08MB10391:EE_|DBBPR08MB6201:EE_|CPH1EPF00000522:EE_|PA4PR08MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: da38112a-b525-46d1-f669-08df1d651d4e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 zAaiTqqjkGHxWSoKbru552KxjW4HgY7E//6Ckt6XcHtyyHeqEzIRLqKHC126dciV6AJluo7HySxdC6i3BaZgTGlu4DSnqYOK3+0iCV1eEI8DuXfXKYdjQAnLLihEBEtqr1/uPl0wJMrMkanjfoPciN09TQuKsi1klTThbe2Kk8yRZ9pbdjOOljZlZ6UPbHv5sRCnkXYb+fW9UWv0LGFLp7Pf5wXNPLyqwDd6ohVDumobKUkeN8Xwf0EU+97PKpiDid7rwGy50c84CTgQshYPzI/8PwJvEXNydgeF71NAIGbsi/EZm4Wt2rC/ijmlu2XxA8s47ugHZfyqPO9DS+j3yS5wlD49Emyh9eyaMl+o2KieHPVl+Bf3RSdEU6DFVE4gAh4tjyi7FDHN0gAOLXciBosmkzzYRJEQzsJXJ14xDuAStjOgSzZpAl/KZJi7inIM1dbTqJenVssbnlzeLWEn7a4Y3Sr17qV2GM93hNkmmNKx1oclqmFm2qnNrNHpMcyYkYT7HbQVTCq51kZjrAGSlfW76ytxBAKijtNwgkuKiTbc+K1S35YOz6NK7czsDfDNxjqx18nWsOcGs6b28X92S4V+BjG4WO0Vlt1q856u6OI4XzJ9zoFYpwW+qbgzVFH4ZWK3j1/J/ENmZsgNcVYTmBjs1OGdWsGbdcZMpsrcIDc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pCYnEonxJbPA+UVlEvmDGyoHGZnqw+wQzha3/rt9mVOLZt2eyffXYONaakg6QtAadHqXHXtPvSRnqziiCE8bz6Xg7OrxvkFu77UrkjjAlcyb8E1H68swOun94odTW+N2vNFqzPxw7oby29jckHSFWj1K3w9e2R1jTZdd/TdepnmLk1eMBNKmeBm7sAACPe4FnyzsgQ5at2Ui4iBVos9Z9zJaUfHD78qM6OLIihellopk0Dne3jHva2kf02jICXLpylW7+mZkeDTuGlo0ym93Ez6EkM8bayswPxttyZ2iYk+ftqw6uC3nyugQnzLiLoVn4O+MA0oqynvVJhcb8RPxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6201
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4bee810e-cd1a-449c-edf9-08df1d5af5dd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|376014|7416014|35042699022|23010399003|82310400026|1800799024|921020|4143699003|6133799003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X5Mme5NIkKRkQBc/vse03yMX5QK19eAIUGmuVGKTSMvpiJtoR/VuxdUyC1w+us5iddfz5C0F4Mxl4hUGPMXrzz01mpEV1JPM7UQMW9dWvVDMR2wup9EKyer9yoC7Y22iEcDqkVhtdPS2Ee4MMZ+D05IzFlRMeyb6mvEFeF8+cOfi6hOvy6/jdThTpGf1sD6FIhSQl0WE8y/UvMx2zsVY4QI3Ovn1exeUtGw+XQkbTCyQYCGUFpbiPI7Dwqf+GONnWsvcx9tjizc83FNPbE2maLsPgLBh5+qgszfA/XV4numOymK5bVEfPRuEU591VXM9ri938GpEJBTUoQS1MxGzS7SvP4Ld7KdQpNNWzlOj0pEKlihUbUno/p05CGMtqgZj9ogWsIibcH43aTQGWbReee0K7CLqR/zNF47m83e0AHymHwtoKTWjjQMI29RAJITStDSjHuAVKiWaY2Ywdeyqkj1hGGlwTJICOU0ohmHYMx8FBaYvlS5J3+geTyy7gABigWKO+r+UtZSP/j50I1Bcbm4momkhiLeXQXsrDh6HHIsXgykKdwH1H1gqliDhwdkW+xHfjvFWBO31AXXPq97mPwxCCNvy4wsJMvBvbGOISw8c3dWsCZf5vwwR+BhV0F/9RLhiOnXH5Zhy3HosXhLf+TtHAFxloJVLqjAzpFpAj1Mmps09c79S04tmyXtA6Ya6gTi06wFrAnpt+uccPlD23w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(376014)(7416014)(35042699022)(23010399003)(82310400026)(1800799024)(921020)(4143699003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HeTsh58B9wNEnrcaupTUbwrhBbTobNT+rQ951poRQ2csvwyw4jy+3UgC9qF6ODIvgrMHY73JkX1OrXs79sE407sDwehMbJzDhC4g9R0mZCmblZ3AJ+qMBNoq1FW7vh3efezgtxZ+3A2LArIvbf+XIbdqbo8r3NYhhd/KGGlWAc7MIXmMCpYIpOS5nSJDKYoyi0qBTss3CL14eA0Es/ritdpwsgwA1W5JXwZveH2SxscWr0wDhtucdf5dj5gY2PQ4KwQTcwDs082FtWFiXJP4b8EhTgeE2wwcus4qgzP+IRJAe5gKzg0YnieP+TR7nca6ilLaUGgs89VaxXnpyMYsTwRHC/0Ul0aVGolrX/PznPrKzKFjvWmmyJxJjyTgnO9PMPrCdJOA7S7sEXakv4gc6sRWVjZoiTG75aM4BFACqGtPXIHGtTPXoyki5E7ysdeR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:33:42.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da38112a-b525-46d1-f669-08df1d651d4e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6158


On 9/16/26 12:38, Sumit Gupta wrote:
> Values written to OSPM-set CPPC registers via sysfs can be lost in two
> ways:
>
>    - Across CPU hotplug: the platform may reset a CPU's registers while it
>      is offline.
>    - On driver unload: the value the driver wrote is left in the register
>      instead of returning to its pre-driver state.
>
> Add a small table-driven mechanism that handles both:
>
>    - On init(), capture each register's firmware value before the
>      driver programs anything.
>    - On offline(), read back each register's current value (whatever was
>      last set via sysfs) so it can be reapplied, then restore the firmware
>      value.
>    - On online(), reapply the value captured at offline() after
>      reprogramming the performance controls. A failed write to the controls
>      does not skip the reapply, as no other path restores these registers.
>    - On exit(), nothing is needed, as the core calls offline() first, which
>      already restored the firmware values.
>
> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
> (EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
> to EPP and auto_act_window only have meaning while auto_sel is enabled,
> so write auto_sel before them when enabling it and after them when
> disabling it. While autonomous selection stays disabled, the platform may
> ignore those writes.
>
> Suggested-by: Pierre Gondois<pierre.gondois@arm.com>
> Link:https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 193 ++++++++++++++++++++++++++++++++-
>   1 file changed, 190 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d7d96fe0da1b..ac315071a979 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,183 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
> + * reapplied from online() across CPU hotplug, and the firmware value is
> + * restored from offline().
> + *
> + * Autonomous Selection (auto_sel) is kept first, as the registers after it
> + * only have meaning while it is enabled.
> + */
> +enum cppc_saved_reg_id {
> +	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_EPP,
> +	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_NR_SAVED_REGS,
> +};
> +
> +struct cppc_saved_reg {
> +	const char *name;
> +	int (*get)(int cpu, u64 *val);
> +	int (*set)(int cpu, u64 val);
> +};
> +
> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	[CPPC_SAVED_AUTO_SEL] = {
> +		.name = "auto_sel",
> +		.get = cppc_get_auto_sel,
> +		.set = cppc_set_auto_sel,
> +	},
> +	[CPPC_SAVED_EPP] = {
> +		.name = "epp",
> +		.get = cppc_get_epp_perf,
> +		.set = cppc_set_epp,
> +	},
> +	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
> +		.name = "auto_act_window",
> +		.get = cppc_get_auto_act_window,
> +		.set = cppc_set_auto_act_window,
> +	},
> +};
> +
> +enum cppc_saved_type {
> +	CPPC_SAVED_FIRMWARE,
> +	CPPC_SAVED_REQUESTED,
> +};
> +
> +/*
> + * Per-policy values saved for each register in cppc_saved_regs[]:
> + *   firmware_val  - value before the driver touched it, captured at init()
> + *                   and written back when the policy goes offline. U64_MAX
> + *                   if it could not be read
> + *   requested_val - value in effect when the policy last went offline,
> + *                   reapplied at online(). U64_MAX if none
> + */
> +struct cppc_saved_vals {
> +	u64 firmware_val;
> +	u64 requested_val;
> +};
> +
> +struct cppc_policy_state {

With:

enum cppc_saved_type {
     CPPC_SAVED_FIRMWARE,
     CPPC_SAVED_REQUESTED,
     CPPC_SAVED_MAX
};

This could be changed to:
struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS][CPPC_SAVED_MAX];
this would simplify cppc_cpufreq_saved_reg_value() and 
cppc_cpufreq_save_regs()

> +	struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS];
> +};
> +
> +static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
> +
> +/*
> + * Per-policy state is kept in the per-CPU variable of the first CPU the policy
> + * manages. related_cpus (the policy's full set of CPUs) never changes while the
> + * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
> + * hotplug, and every callback reaches the same copy.
> + */
> +static struct cppc_policy_state *
> +cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
> +{
> +	const struct cpumask *policy_cpus = policy->related_cpus;
> +
> +	/*
> +	 * related_cpus is empty until the core fills it in after init(), so
> +	 * fall back to policy->cpus, which has the same first CPU.
> +	 */
> +	if (cpumask_empty(policy_cpus))
> +		policy_cpus = policy->cpus;
> +
> +	return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
> +}
> +
> +/*
> + * Save each register's current value, either as the firmware value, captured
> + * before the driver programs anything, or as the requested value, to reapply
> + * at online().
> + */
> +static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
> +				   enum cppc_saved_type saved_type)
> +{
> +	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	u64 val;
> +	int i;
> +
> +	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +		if (cppc_saved_regs[i].get(cpu, &val))
> +			val = U64_MAX;
> +
> +		if (saved_type == CPPC_SAVED_FIRMWARE) {
> +			st->regs[i].firmware_val = val;
> +			st->regs[i].requested_val = U64_MAX;
> +		} else {
> +			st->regs[i].requested_val = val;
> +		}
> +	}
> +}
> +
> +static u64 cppc_cpufreq_saved_reg_value(const struct cppc_saved_vals *st,
> +					enum cppc_saved_reg_id reg,
> +					enum cppc_saved_type saved_type)
> +{
> +	if (saved_type == CPPC_SAVED_FIRMWARE)
> +		return st[reg].firmware_val;
> +
> +	return st[reg].requested_val;
> +}
> +
> +/*
> + * Write one tracked register, skipping it when there is no saved value.
> + * A register the platform does not allow writing is not an error.
> + */
> +static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
> +					 enum cppc_saved_reg_id reg, u64 val,
> +					 enum cppc_saved_type saved_type)
> +{
> +	const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
> +			 "restore firmware" : "reapply saved";
> +	int ret;
> +
> +	if (val == U64_MAX)
> +		return;
> +
> +	ret = cppc_saved_regs[reg].set(cpu, val);
> +	if (ret == -EOPNOTSUPP)
> +		return;
> +	if (ret)
> +		pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
> +			 cppc_saved_regs[reg].name, val, cpu, ret);
> +}
> +
> +/*
> + * Apply the saved firmware or requested value to each tracked register.
> + *
> + * Write auto_sel first when the value being applied enables autonomous
> + * selection and last when it disables it, so the writes to the dependent
> + * registers can still take effect. While autonomous selection stays disabled,
> + * the platform may ignore those writes. Do not enable it temporarily to force
> + * them through.

The spec says:

`Writes to this register only have meaning when Autonomous Selection is 
enabled.`

which is subject to interpretation. I'm not sure this should be taken 
care of,

IMO the firmware should still store these values, but this is a personal 
interpretation

so what you did might be safer.

If someone else has an opinion this might be useful

> + */
> +static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
> +					  enum cppc_saved_type saved_type)
> +{
> +	const struct cppc_saved_vals *st = cppc_cpufreq_policy_state(policy)->regs;
> +	unsigned int cpu = policy->cpu;
> +	u64 auto_sel, val;
> +	int i;
> +
> +	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
> +						saved_type);
> +
> +	if (auto_sel)
> +		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
> +					     saved_type);
> +
> +	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
> +		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
> +	}
> +
> +	if (!auto_sel)
> +		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
> +					     saved_type);
> +}
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -718,6 +895,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> +	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
> +
>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>   	if (ret) {
>   		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> @@ -791,12 +970,14 @@ cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>    *
>    * The platform may have disabled CPPC and reset the performance controls
>    * (desired, min and max performance) while the CPU was offline, so re-enable
> - * CPPC and reprogram them.
> + * CPPC and reprogram them. Also reapply the OSPM-set registers that offline()
> + * reset to firmware values.
>    *
>    * Report failures without returning them, or the core would free the policy and
>    * leave the CPU without cpufreq. A failed write to the performance controls is
> - * not fatal, as the governor's next request programs them again. A failed CPPC
> - * enable stops the restore, as the writes that follow may not reach the
> + * not fatal, as the governor's next request programs them again. The OSPM-set
> + * registers are reapplied even then, as no other path restores them. A failed
> + * CPPC enable skips both restores, as the writes that follow may not reach the
>    * platform.
>    */
>   static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> @@ -832,6 +1013,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>   		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
>   			 cpu, ret);
>   
> +	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
> +
>   out_fie:
>   	/* Restart what offline() stopped, with a new counter snapshot. */
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -851,6 +1034,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>   	unsigned int cpu = policy->cpu;
>   	int ret;
>   
> +	/* Save what the OS set, and leave the platform in its pre-driver state. */
> +	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
> +	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
> +
>   	/*
>   	 * Stop the frequency invariance updates and cancel the pending work, so
>   	 * that no sample spans the offline window. online() restarts them with
