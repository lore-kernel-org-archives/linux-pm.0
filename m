Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EE39FCD6;
	Fri, 13 Mar 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412158; cv=fail; b=uEQ3V3zI5b7EE4KZO9jmUSQslUmKLjhCHfAI+ev8rAymRqSLNn6DNWsJzICmz0ajbGtQ869L5ja3N6XsfSWflgznItjz0E0bS5d+HR+c0qe2ik+eMRzxkd+QwuR+N1XnoEJlEv/Htm7xG6Fvd9J5MH9JD9/flDn9IkloD16RTYU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412158; c=relaxed/simple;
	bh=SwuRs4gKXSplFXABEf+ockGbf37rMELgucE8W4tWEFE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxblk7hADD6ylwJiaHzBB9hUKa2pEchcPlE8vokswWUwcfr0efGyKD3Lm91vsCU7M+F3SxkMDBUGXkUaYuyeRutSbBJiFVjseaQ5QwNsGIBZKJjXidLbOY46QEdzw5peRoR8KGgQbCrV1K7rBTZrhvwlm8LW6+N9sCUExIyhVyA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oCNszxDw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oCNszxDw; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oCNszxDw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oCNszxDw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dMOgzzBx8YjtO+MQ8+iB2MwRPK7DDLT8gLBgJhRlc4SV0al2OoMXNC0QyrhNbaA+6wNFLGvM8eJf5Px8v8eTgPq6XeeRXl6EbRoxY7ztNnwiAsw06guzIyMTA8Yl6UYp7P5lzkTynmE4R3B1W2Ja/+mgteJ5t4vgG4b06FpLWqeYfTL7T/6dmkemClw8AbzVeev5Ac54F5NE4krU+eRaEYgvANAGELnWYdwv70E4TaKxzL9QktVH7c6+0V0LcFSSyEVQrWTHHZuQtTLI6rXjjl3tvPrv4gn96wi7dso1s79ulNMVgIgfUnmEJhVIAjDfBM1qW8gC58ValoRqyLmFDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItRnIUgBnVNyjMUDHpApmid10EDOl/lyICoTQnlxQns=;
 b=p2y+syAfiM9d8WaUS7yjLZ1BM9oLFUPkTl11WpbINdAEszPMf6AN+gbbBEcGmjmjJwvyVyGpCzUQlNg5mynJ/3u+220CrccXSfGjiv46nTYcat93sQM3o10tWzyrHfYEfcUw/PSkVY/3J2B4/OlSPvcWCgrLmDbSmEjzDV0ai20vLSDlbcG1+Nyu5RxtLHDg+4zEiw+9EuB7fldriWdGBFdS0C7/NKj++b4SSYhTi3tn2ol7HuvRVcCFDLmbzI4KQRSfdiX9JDwzwwccRvnf/HaNJ0TgsIoNPemFuI/q8lYGCSTa07M3Q1/fQcJdHKBrMo6vTd/TChftYWDn2ikteQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItRnIUgBnVNyjMUDHpApmid10EDOl/lyICoTQnlxQns=;
 b=oCNszxDwNUhvaePs0shfNMxM5DJZtsFCKnoghU61T/vDNtYczb/gu2WfhV28ao9hdKk8i0zUZhuQigYzUzuXwbrckKBJvdCzZ+NdhThknYd+un+pUAePS31t5me5DTB9MFagpf5yD0fA70yvZm/1YjT8mm3/X+n0Rpf5Pwisu5I=
Received: from AS9PR06CA0553.eurprd06.prod.outlook.com (2603:10a6:20b:485::26)
 by PAWPR08MB9544.eurprd08.prod.outlook.com (2603:10a6:102:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 14:29:11 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:485:cafe::aa) by AS9PR06CA0553.outlook.office365.com
 (2603:10a6:20b:485::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 14:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXSiWwPPVmgyXr8W7Y0V/I63pubiEzms5XUA9r5AI9HvMCreMWSmEAmj/vacc9qhiWtLyp0GsYqizaHNiTcZdaFQxxMpuxEEdNI9nPdVedxcd2EgnX2NvWtCs2xb0+SDHjf/LWO/3XjmXYrNS17Ee1b1s8NyY2ss9wx+Hs7p90vvq+VCYlprJuvipZFb0wDeSnMPy6aGHWzomKLTKIaWbbq1+8h+SskVJKIO1g1S/Axq1JEtzDpvna0e7lHa1Jbk5fmhM3WJtNsnIdsZ7uuogtaXPmrf6OyAtiMZFChwzmo2VsSUFcfy5rdwbupKqNPyY1APZqIIztZXJLUr77vBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItRnIUgBnVNyjMUDHpApmid10EDOl/lyICoTQnlxQns=;
 b=n/hSIGn5uiyfSSCEn99H0qBdTd4AVd99XP7YUjRalLb96eNXfhctHPKW08BxkRBbeYXlakBObjVnv1Wk2y1lfdHCw8KC/MSsKyvLrRdeaECLgza5Hy3NiOm31RE7rAxTPi5fZx86RTzVqEtveLw5S39CkldwppB0J02LHuI4qJWq7cuBCDLruzC1MFle/ZLTYSrTCvYDpdz1HhYmrSpprr5lupqwdFh6ygaMiDWs0orvK2EKe3MequxuZowKtpwx+cWDZECXGbF7YF0R2QA+DLF4CMddD8p1jZsvTlKqbTlJ068lMp7GA6Witk+TxIOo8tHKpJQb1FT8Xf/x9NUbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItRnIUgBnVNyjMUDHpApmid10EDOl/lyICoTQnlxQns=;
 b=oCNszxDwNUhvaePs0shfNMxM5DJZtsFCKnoghU61T/vDNtYczb/gu2WfhV28ao9hdKk8i0zUZhuQigYzUzuXwbrckKBJvdCzZ+NdhThknYd+un+pUAePS31t5me5DTB9MFagpf5yD0fA70yvZm/1YjT8mm3/X+n0Rpf5Pwisu5I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:28:08 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:28:07 +0000
Message-ID: <50ae753d-89b3-4922-8282-0b9b0c4ed1d1@arm.com>
Date: Fri, 13 Mar 2026 15:28:06 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 4/6] cpufreq: Update .set_boost() callbacks to rely on
 boost_freq_req
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-5-pierre.gondois@arm.com>
 <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>
 <kz2xmjoq6ckf6hykougeimo2fdo5tbjhmffsgk4yfgfwkd43yg@uiixgymot7uw>
 <CAJZ5v0iiPsuyL=6wqwn_zqTAhVjrazUrQQVHR6d_qPNvP-gM0g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0iiPsuyL=6wqwn_zqTAhVjrazUrQQVHR6d_qPNvP-gM0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|AM2PEPF0001C711:EE_|PAWPR08MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: df22ecd6-9ea5-4d98-b888-08de810ce538
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 DnZyfmGriRVj0nGoRt3FXLNvndDGmCEpB9NtUqGgv1aYJkxSc5kPY3z7Jop3SQtR5ZDnTwOuiqC5jXW3FdS9cU1Il4hFBpnnSmPcvMgTAIk0A+yp51SPnLMSDk+nNjOCi09zHROgq96gI5io1r76rxdJdx/skuOxdGMoVBb4T/vkccPFDarTO2+lv5PAgQsmZBzGTUp63vKoSVuf/q9zkoPLdzndkwhMkPtcc/xueu/HeTSdGYR5Mgvrp2bU/hPk7JhbDbCU85KM3w4xl2gvyHXRXTm/U7STQ/wHyHW3Pd7vYYL6gIy+h7a/iUDambhQxtbHNeCLIyrcn9b5guyUbJFuxEeZUXPNM2MTrqklzbsxq7AaFhW9xSivWLwHZrSJV36FPtXcy/F9kfUK9xAetPn6+C+Ri2F0d+qKwktsPSpSjEfkqpKIyf1MrrtScwKiyQD84wEGvA1+szhbbaKWOxnvJ3vQTUgZ5ynsTZxvkZWLj5FnMZQS7q1nUF0TIYyjYT9MFirI+LfUbc8g7yt5hnB7i39bInAvzoh5UcWlk/p2XZXxAJoPA6xUu68G6s+Prb9x1w9tHEoPHoHpA93K7J3Jfcog1WLfdgVfK5Wgv+yrMrieP0PAPOIVCYNWfNdW3wBoNkmDc7EE4h6GxzSnhw7+sxTNJ01FErvz1ADJZqBMyIlDcGvN4fFclF8VkB4N+F34chbhBzHlVjPM5JxzE+jXDuF6DisHfzDV6sPZqgI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 VH3W9vjuuQ8RG5aO81/wlmy2IWh+VVNLdCxAbBKfhBID7dbssWbTU1yZqqYJw2ZQTYsHhJ3d8rn8z9qRuikryGyOu2eLL13xU87xkF+15h1YxLbe1D41oux4o0ij1XPBxOXiVS57X6EorMhmtBuONZTyCzxPqicHzdjQ4e8eA3iqf9Kk1G/m8Wp75boZbq//vNQBDyCljL9Dcw9eFbELYUEvtTqEj1E7ikpRhaL9gOLQ2VkQgoSs9LBKdFPTh3TNk7CfSosd7++9+K/9IlBaUR9EqEqCfs1Caa0LvbLri1SMJd98gNVmtkuAzeY1PI1eJVz2inTFhi+d8BjoExN4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	acbf59e0-c9e2-4818-7683-08de810cbef0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|14060799003|7416014|376014|35042699022|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	irNNCkWuOhJWtoGat1hSr7l82nTnjOUFdU8USpenL3vqLK6stCsro8q288j98zw9KoBvU08BF+krrTf6RYl+ojwmpFQjoUr28XSg8/BUZUEnKSDS3j775ux+NucsZhj14KGiFbSBOEYwU5Kwnt6xVs5RPAJqaP1qAUeDjsxyS3YWcRXnjjpmDNoVWTwT18MGOQQ4A6qInGGlaDyIYwF2T+Q7RE9gCV22uideRS2j2J4Wvvo7jet5MRo9pN7aNwQFy1MWlc8s2RafwUH17swxaxFEV2SvO+Fr674W4UqEfsyPh3q+jWv5ozMa0jmbXh81tLxoTfVFOyjwxXw/l7ZOcscGHV+FQtHFgYVU0U8pVkwqMRuQYm3ToK2D3WyFIJ6JK+adZuJanoMim10Dhu/FF9sb9jxZ/RGoaLP/vjIa4GYv5nAsJ8h+PI+1D/TA2gen7vMi1vjHA/mPyFJYVlq8HKlfuhOLIUwIjRed29qoybHalhD/JKDe5gEQ3rZFY/B5B+YhpPmICKDLWDGpdh8L3DxYvZJvrw8kRL141toUHXY6/lOfPlCt2NNo8vPrYW4pU1MoNyUwOQzFflhNXnpMaolCQTVWSlDlaheGaHqqEUFTwIkgNZFAbsNfqlIWBQxtWCQCrl0v8TonvmbBe+rSK7RGuMMXo6Q+ivuso8NVfsfkaOlLtGthcq6XROp+nQcveT3msMsHdUZk9zYMIa9BBTK6mQgSfHf3w6biN/bnKjCcGqU0kjjfL9TXRAwyKBK6Np01QLqb7C8AczrgzXCvCw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(14060799003)(7416014)(376014)(35042699022)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NaQnkK0Glx87W4CKT+TQDaf36SkNBPayxjp7VpMBr6tqKR4j3QnSGqG/bSeuZRMYbI065CiBdXxGw268C3KiGtKGIjxVAj+50+0TpBeo5JztSNEVi/R4hCaTfAEkt5nIdWyV0fKCD2DUajtFJ+NQJu/Q3RKbipVJ2I9uzg0QH08EttoRwQnPNU5WQEOIB7WKMiTvi2TrmNSN9fKl0C90DBHPsWeVsffqnjYqTaKKMcY8a30JLLFH4HDlNmzlseECLhWVsdi2jnj+oLLKFvzxmE23sJHYw8Vyk1wTdbuRnkBjy1DwRrz654FwxhZu8GcMKTvu4FEX7SM8CBB41EAQQRlgQvhX+nFygY8pBTOm/fM5AZxU+w3Ko7+Sm3ds5a2Awjy4pOwLv2JXihIyxB5kPK2UsUz2Ubl0YvozOcKCfpjf4tqN1VtUhg6zUO8P7fh0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:11.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df22ecd6-9ea5-4d98-b888-08de810ce538
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9544


On 3/13/26 12:43, Rafael J. Wysocki wrote:
> On Fri, Mar 13, 2026 at 10:38 AM Viresh Kumar<viresh.kumar@linaro.org> wrote:
>> On 11-03-26, 17:19, Rafael J. Wysocki wrote:
>>> On Wed, Feb 25, 2026 at 9:50 AM Pierre Gondois<pierre.gondois@arm.com> wrote:
>>>> In the existing .set_boost() callbacks:
>>>> - Don't update policy->max as this is done through the qos notifier
>>>>    cpufreq_notifier_max() which calls cpufreq_set_policy().
>>>> - Remove freq_qos_update_request() calls as the qos request is now
>>>>    done in policy_set_boost() and updates the new boost_freq_req
>>>>
>>>> Note:
>>>> cpufreq_frequency_table_cpuinfo() is also called through:
>>>> cpufreq_policy_online()
>>>> \-cpufreq_table_validate_and_sort()
>>>>    \-cpufreq_frequency_table_cpuinfo()
>>>> which relies on cpufreq_frequency_table_cpuinfo() to set
>>>> policy->min and max initizalization at driver init. This
>>>> regression is solved in the next patch.
>>>>
>>>> Note2:
>>>> acpi-cpufreq.c seems to be the only cpufreq driver not
>>>> setting cpuinfo.max_freq. Populate it the nominal frequency at
>>>> driver init.
>>>>
>>>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>>>> ---
>>>>   drivers/cpufreq/acpi-cpufreq.c |  1 +
>>>>   drivers/cpufreq/amd-pstate.c   |  2 --
>>>>   drivers/cpufreq/cppc_cpufreq.c | 10 ++--------
>>>>   drivers/cpufreq/cpufreq.c      | 16 +++++++---------
>>>>   drivers/cpufreq/freq_table.c   |  7 +++----
>>>>   5 files changed, 13 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>>>> index e73a66785d69d..6a6e26e1be14a 100644
>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>>>> @@ -857,6 +857,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>                   * governor from selecting inadequate CPU frequencies.
>>>>                   */
>>>>                  arch_set_max_freq_ratio(true);
>>>> +               policy->cpuinfo.max_freq = nominal_freq;
>>>>          }
>>>>
>>>>          policy->freq_table = freq_table;
>>> This looks like a fix for acpi_cpufreq that should be sent separately.
>> cpufreq_frequency_table_cpuinfo() (called before this) should always end up
>> setting cpuinfo.max_freq properly and so this never broke earlier.
> So is this change needed?

Yes right indeed, this should be removed.


>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index c45bc98721d24..310d5938cbdf6 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>>>          else if (policy->cpuinfo.max_freq > nominal_freq)
>>>>                  policy->cpuinfo.max_freq = nominal_freq;
>>>>
>>>> -       policy->max = policy->cpuinfo.max_freq;
>>>> -
>>>>          if (cppc_state == AMD_PSTATE_PASSIVE) {
>>>>                  ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>>>>                  if (ret < 0)
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 9eac77c4f2944..4c46c7ea318eb 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>>>   {
>>>>          struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>          struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>>> -       int ret;
>>>>
>>>>          if (state)
>>>> -               policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>>>> +               policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>          else
>>>> -               policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>>>> -       policy->cpuinfo.max_freq = policy->max;
>>>> -
>>>> -       ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>>> -       if (ret < 0)
>>>> -               return ret;
>>>> +               policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>>>>
>>>>          return 0;
>>>>   }
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index 42de32488f422..20266fb42d18d 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -1500,10 +1500,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>>                                  goto out_destroy_policy;
>>>>                          }
>>>>
>>>> +                       /*
>>>> +                        * If boost is supported,
>>>> +                        * init the constraint with cpuinfo.max_freq.
>>>> +                        */
>>>>                          ret = freq_qos_add_request(&policy->constraints,
>>>>                                                     policy->boost_freq_req,
>>>>                                                     FREQ_QOS_MAX,
>>>> -                                                  FREQ_QOS_MAX_DEFAULT_VALUE);
>>>> +                                                  policy->cpuinfo.max_freq);
>>>>                          if (ret < 0) {
>>>>                                  /*
>>>>                                   * So we don't call freq_qos_remove_request() for an
>>> Why do you need to update stuff introduced in the previous patch?
>>>
>>> Is that because policy->cpuinfo.max_freq is not set consistently
>>> before the changes made here?  In which case, wouldn't it be better to
>>> make all drivers set cpuinfo.max_freq consistently before making the
>>> changes in the second patch and fold the chunk above into the latter?
>> Since cpuinfo.max_freq is set correctly earlier, I think this can be done
>> earlier only.
> I'm not sure what you mean.
>
> To clarify my point, the question really is what prevents patch [2/6]
> from passing policy->cpuinfo.max_freq to freq_qos_add_request() as the
> last argument right away.

Nothing should prevent from doing that I think.

The first patchset was only intending to add a boost QoS hook,
then additional modifications have been added at the end of the
serie. I will modify the order to make it easier to follow.

