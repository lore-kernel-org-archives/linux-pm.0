Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE740FDA1;
	Thu, 30 Apr 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556549; cv=fail; b=kiX/PXCUCNLNr0WHanx3Q+aQuEb7FdZoLL1by/6ZqL0pbi9PVCaOwSh95FHHOHXMJAXPfyxPtigWZEQaw/MYumOqGDn5PZIO4wQwN2FJWqTr0FNlssClstNqOy4ra0O6cmziNjelo8BU4hgjlevgCM/2wR5CVEfdPiHgKz9UFGw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556549; c=relaxed/simple;
	bh=Fvn/5HObb1wd3lji+HAWX+FdO56NAEJ2RUKgOL3CoRU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCDiBUautP3xcqH5rETqUMhG8nXTNvjw66if5cCZeG0shgIzZWuwbwUZtUiCo3u0vGxgL3BxNsX+ZNwKG1ts7Hk41INOr+o+EYvCUR6sHjA+U0cb0rB4IyeSRBM8rkCjUGFYEi3qYm/T0/lkK6R9Zr8i/8XiZC0GGRnnrpqb/DQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zs2j/1ca; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zs2j/1ca; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zs2j/1ca";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zs2j/1ca"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S47BKsGPKhl3A0Nw4XL7fjaEON21dhi+V52G/q0k/lOV45ndTMKUq/mgqRk3dhtpmtLmezWybnOsu7cqOLVk4mdYQwhGlLW4HqxG6iHhwjj1/rDfM5q+NqrTWF6iPj7iD1L8JXUaisMEMZ3aQjKEviKBhP1x/gOwQbBMO655PPncE9KwSglmo6X9yJ6R85N32JXwyf/DytVnlFkbV6U2XpnjNuLlMNQNjHI6zLGBT74Crs77W7sRJWJEhP2z9t4+RR6Arqtn2ra80SF331sF53oQdtglIAzdE/gB6KOpgPnIFwaSL3OVS/d5GumoLHefkDr6cXt+OLJGYLCfx73BUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kkhcjdi6u6X3emcHVHmBvwS4to7sBOJNHvZdhforDk=;
 b=jiuhYOqdOZlhi/ywIuh0RsqRR/CoTaw98gm0KYVErTQaTnZkQJfS8MirHnd+axKmlMAkcgeYvgd5URh1q2TWyHuot8wWGkK5ISXzo1Wk54vqA659CsbRznp0YtWeeIj7l79+A9bh/222B5OzqbKi7Vfk5RC+ns4jEHNRfJbNuAVKUxMWYn/FynetVLshlt2UDl5r8/2YUuUBnOAu7/vLZnZgYl8ujfatJTPPOBNrgKSYQmWAD44M2EH0sw+ZWiqVTCRSkX9mDdmlXz0Sy0C5IE7eawWSfx4ufLomU3XBLDpf6GizWdLdSsX7o5RkmNtFWxZMJ9ezY6p8RQpe7cRK+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kkhcjdi6u6X3emcHVHmBvwS4to7sBOJNHvZdhforDk=;
 b=Zs2j/1ca+XTPgwngjnG9nZ8TatPTO+9Bs9qZhkNTtquX1rY6i4gt5RDFBk0XYxqTcN9Fhy5aXTI6cc9avfZ5V9w7xRFot6kPpyl3J0WuQsFR4oxNkbpG4r0Wq4yzMdsrtQ1wTBn+Is0TBR6fpAY6t8Q2l1ngLOyJO2JFRQ5cb0g=
Received: from DU2PR04CA0327.eurprd04.prod.outlook.com (2603:10a6:10:2b5::32)
 by AM9PR08MB6082.eurprd08.prod.outlook.com (2603:10a6:20b:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:42:23 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::41) by DU2PR04CA0327.outlook.office365.com
 (2603:10a6:10:2b5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 13:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 13:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMkqmisxZiAvnzFFwhgbRze/Jt/2fp19Ps/Z/P+MXWkZU//021lAtgGhvtzG/BOOKluUoQecGXQmxNpnKEsWg+nT3UjJMXvHQP9abOsaV4IPGqZj4kbTxkMlJ3r7tHefXmo5T+KgOGUlBkUqKVQp2B7DWnuFwY5rVhXE04gKZ3bs9FhUJEgpm6XUgkFtg0kYO74VDCKcjyq6B4EnLT21qPov9Aysc0bNGc2lujQXk5VxPJJtTvCHha4T5rbYkQs/TTxoiFZPILzwSFZxQQoY4hScULp17m7fLb1KBDx9B124tmUmFw3ytwUmmdG80xrv47a5XlKJLTVMr4HuAXa5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kkhcjdi6u6X3emcHVHmBvwS4to7sBOJNHvZdhforDk=;
 b=QcGrXdiwB+ctjfqQzt89DNy3ZUO2AbGo1+zYexNrYfrUIuEhelAhCTZfJKRMADxnlHXs9QBEyYvjySOsiWW/Tqq+CXUoNkPOBzOg21fKZNR9ap96rDkdlD2H1QAQpu1I2rlgqt6jJowP4OL6qbRr1sCVuzp11tB1Y7w3v3+7y+vlf5O4tKg/wE8+DN1xTwXwCI72DRu5yaUoWde2wprhlIpexN4oqnBfsH4xRVVlaM2Yo+qZ0mUJiBJ7cLOqEQKJuBfFVlMVJ6zTkKvQzGRcRX89NRMeMvL72HveWVwUant33F/hNDMv9MHFAxAv2QeAOyPzmqgwZliFX8DW9P65PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kkhcjdi6u6X3emcHVHmBvwS4to7sBOJNHvZdhforDk=;
 b=Zs2j/1ca+XTPgwngjnG9nZ8TatPTO+9Bs9qZhkNTtquX1rY6i4gt5RDFBk0XYxqTcN9Fhy5aXTI6cc9avfZ5V9w7xRFot6kPpyl3J0WuQsFR4oxNkbpG4r0Wq4yzMdsrtQ1wTBn+Is0TBR6fpAY6t8Q2l1ngLOyJO2JFRQ5cb0g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBAPR08MB5592.eurprd08.prod.outlook.com (2603:10a6:10:1a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:41:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:41:17 +0000
Message-ID: <8ba669f2-bd62-4a56-a043-1848b5e45c4e@arm.com>
Date: Thu, 30 Apr 2026 15:41:16 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Jie Zhan <zhanjie9@hisilicon.com>, linux-kernel@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <454ad628-b8c8-4a91-b678-f3338992a1a9@hisilicon.com>
Content-Language: en-US
In-Reply-To: <454ad628-b8c8-4a91-b678-f3338992a1a9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DBAPR08MB5592:EE_|DU2PEPF0001E9C2:EE_|AM9PR08MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cf14be-409c-4c6e-998e-08dea6be4ec0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 c68vIWw60GUVLcGgjlZxwQkqrvv41AYbIZZ/5C10xzYBbjAjjehojOYe56DUX/MN/Tz2W9kgajBOEXGfoCqR505q9Im99Mr6uwWanddbXvD56R/3Rimas1yQoc/5dBgC5R8T3/E7EwFVL3aTgb5tCvvs6siyY8jypMpg4csxzqYUy97L/UULLj17PKi67lSmH0hVzdkyKO9IS9OFnrG7KpJUtnsHbBIQI5pobULQMaFAxoEDfmQrg4+MG5zKIybpx0iVOY8vEp701D9Ybv4gWB2/HBv5F/uFCtDPqeaVmvNveFvghqHguE2/BSrHR989E5ZEE/ccFVjul8eWXGoyEVqaqLDyMhf7/NBRRXnxHZHB3PWSSFTQ6rlgZu0am54pP5JlTfXw0wiCEYiqtHl8wmIV3ZW7SYCHu7EXrOSY/HZGMK7gLJWcYPQbUj0Bib0XulCHv48hAzm28bDSRCRIi5eCdSveFDZcGVkidGDHDTPCzqzX6+Q/3/gP7nc0xJYGdi3N+ZKDv7fx1EBIntVTmha86W7wg3Y6p3tfeYbSFl6bopWdpgWz0JYCM9Mhm0H3DKxDFLTYe6E5CLXHiXqsVacaAGhykfvfJanzXHHXOczDIAG2KTPAVAvu1SkkhTSp6Gq35EksZFXzxrFECAyoyhbsY+zR9Um/re1lmtG8V/NJt32jHe6uDwx/9f/Li1rwPupZfViEWOR3YA64SAqTUmwFs/5zNR4TfGEaNWQBaJU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Q/vFA1Sm5A+fQFns8eCCLLJqlkkCnBkYXisjzMERZVT9z7FQxir4jx8acJDaaaHsDXf6sDg6tcfNf2OrWropIpAjviQprEDxVgWQ2FX0xM3sxrCZpCxgkjwYKAW+lS5ruNvm7AZDsP4kd4kM3dsBRP6lP7TNKq9Dzj2WZBosvxpJ3HcHZVJqnUSocHJ4V96pXKIPtgNWS7HKb7dY2yZurhuK5B9JrtR6HSQ0Vf3hucipQ1E0rxo4FjF6Fxzdp0kqmt3T7o38gmyG3Rb2zHNE0SgVs1nGlWOPnZAt8kz1u78m46EzGHpOTUn3WDChy7+yA7pJNh0vbD2vDcjhjSBadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5592
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6072155-90c1-456d-74cc-08dea6be27a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|7416014|82310400026|35042699022|36860700016|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	eyg60uMCRjzVaF390C9jnIp1GaBqGQTo9vd7DrFR7pobLbpf/lsHnOMPEIQpg+bdbpZXYFJfWQnfB2nkfEC+7vo4njx65J6urHmKHWPzmLQIRiSn9nzkR+r2IQaUNn7TjfIaJoVw2PdcChTBMhmj++JyAH03f2XGXljw1J96JBI8MK963a9SAMDjDwQS5DqYgu5gcV+sy096NAkt41/PVFN4wgmw2XvMVX4wq54wzLaX5VbQH2ra1YKqm0/699zw/hW5KWxtMcHC2zSmPZdqKAhbfJFZ71A1jKQNTcOfM11HcUUOb7XvN30TeGJw7wBohW9mx92iToYfFQadNg3TxIx6KDXLIcHvRjzn7ZZ3kgPPfQkmdrWt9zsvOoGXATadOIs7vS3Bs5Nhf5cpBbafNJiiAnrtCFVMhxBHpCfogaU/ELBqARzBc7sf1QDIpYVbty9tcS8Bw6hJT3L4tWHjt7c2qQ5ynTT2ifgiHS+cEp7BENZxCr3JyEeLYzFHR0zu9FJGTwbSZE5o+zaALt6bPp9CAbEGLGQ7mpcaLuk0lQHkRz02mnvnkqKvuDRHGRShk2F2RsnxEqkMoAE5A1zqFaofMX30tkKRd414hppCULwVpRzUKoeW/qzG7xBIVTP4gAljvCzvTr8z3qci75btC6niRr5B1kSVxrfJzo8P3Ke5pwGpKfc1QjbFtlEVCFK1kYrfXn+N4kGbD8AvUt0m5UkC8tt+oj/rxD765FzGmYGEeLP+ysL7nUEoLbNRPlJJmQTTIytbk6Ga0/Tt13zwDQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(7416014)(82310400026)(35042699022)(36860700016)(18002099003)(56012099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Oy3naKE/g/+pnLotqSk9Rgl/FpL1DNrLq9W0CjBnr3gRscSXESwCMrkrQulFX6NtXqDYvnUKzd7ty7azpJ3qlY1DYnassBg+qm7uQv7Po+oZdkSt8znk+8QvrDnFhuAv8A/34deITOQsmZgxtKyhic+i4fIJs9Rx8K4uyPfeUmcVlKg33R2PAK4TZVSLvIfHRiHcFh7rNn87gmwYpueUtx5+1awVrGcvfaO5Say7wM7aHfyBmmwF2/02ju7pdYuTi9Jp2PeMK2jOgUS1N/Zh80Ob55dYRR9bTFzSKC7gZssucPkNLkQ6+/FajFBWpqL+6a32wCxtDQ5fYiu7ZBVBY/upa/Iy1OProZmalgihhqIjsA00sT0dV6lcpk/4p3or4acfaEc4DYXhQX6Yzd2Y4woF9xP7plbK+m/kLKEsluKQwAZ0nnwBJrKaDBwDpJs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:42:22.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cf14be-409c-4c6e-998e-08dea6be4ec0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6082

Hello Jie,

On 4/27/26 05:08, Jie Zhan wrote:
> Hi Pierre,
>
> Thanks for updating this.
> A few questions inline.
>
> Regards,
> Jie
>
> On 4/23/2026 4:47 PM, Pierre Gondois wrote:
>> cpufreq_set_policy() will ultimately override the policy min/max
>> values written in the .init() callback through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>> Thus the policy min/max values provided are only temporary.
>>
>> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> Just a check, you mean this is the only place that policy->min/max set by
> driver->init() may ever be actually used, right?
I think I meant that this is the only place which might use

policy->min or max between:

- cpufreq_driver->init ();  ## which set policy->min/max

- cpufreq_set_policy(); ## which reset policy->min/max

so the min/max values set by the driver .init() callback
should only be used in the above call stack.

------

This patch sets policy->min/max values with:

/*
If the driver didn't set QoS constraints, policy->min/max still
need to be set as they are used to clamp frequency requests.
*/

So even if there are other users in the meantime, they
should have correct values.


>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-__cpufreq_driver_target()
>>      \-cpufreq_driver->target()
> cpufreq_init_policy() doesn't seem to be involved here?
> It's supposed to be:
> cpufreq_policy_online()
> \-__cpufreq_driver_target() /* CPUFREQ_NEED_INITIAL_FREQ_CHECK branch */
>    \-cpufreq_driver->target()
Yes right indeed, cpufreq_init_policy() should be removed.
>> is called. To avoid any regression, set policy->min/max in cpufreq.c
>> if the values were not initialized.
>>
>> In this patch:
>> - Setting policy->min or max value in driver .init() cb is
>>    interpreted as setting a QoS constraint.
>> - Remove policy->min/max initialization in drivers if the values
>>    are similar to policy->cpuinfo.min_freq/max_freq.
> Why is this necessary?
> Doing this will touch many drivers.
> Is this mainly for cleaning up? or is there any bugs if we directly take
> the existing policy->min/max initialized by drivers (mostly equal to
> cpufreq_min/max_freq) as QoS constraints?
I think I should also mention the following commit in the
message:

521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS 
requests")

Prior to that commit, drivers were setting policy->min/max and
the value was used as a QoS constraint. After that, the value
was only temporarily used. Thus this commit helps coming
back to the first behaviour.

Pengjie Zhang recently wanted to be able to set a default min frequency
for the cppc driver at [1]. So this also helps for his case.

[1] 
https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/ 

>>    The only drivers where these values are different are:
>>    - gx-suspmod.c
>>    - cppc-cpufreq.c
>>    - longrun.c
>> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>>    used as a min QoS constraint as suggested at:
>>    https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>>   drivers/cpufreq/freq_table.c      |  7 +++----
>>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>>   drivers/cpufreq/intel_pstate.c    |  3 ---
>>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>>   11 files changed, 51 insertions(+), 39 deletions(-)
>>
> [...]
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>   
>>   	if (new_policy) {
>> +		unsigned int min, max;
>> +
>> +		/* Use policy->min/max set by the driver as QoS requests. */
>> +		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +		if (policy->max)
>> +			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +		else
>> +			max = FREQ_QOS_MAX_DEFAULT_VALUE;
> Is it practical (free of bugs) to set the default policy->min/max to
> FREQ_QOS_MIN/MAX_DEFAULT_VALUE in cpufreq_policy_alloc(), and keep drivers
> initializing policy->min/max?
>
> Such that we may only need to change the following two lines of
> FREQ_QOS_MIN/MAX_DEFAULT_VALUE to policy->min/max in this function, without
> adding the other two trunks.

One other goal of the patch is to distinguish drivers which:
1. actually requested a QoS min/max limit
2. have set min/max values by default, but don't actually meant it.

Cf. 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency 
QoS requests")
Setting policy->max as a QoS constraint might result in performance
limitations, so we should try to avoid that.

FWIU, removing the default initialization of policy->min/max
must be done to handle case 2., but maybe I missed something.


>>   		for_each_cpu(j, policy->related_cpus) {
>>   			per_cpu(cpufreq_cpu_data, j) = policy;
>>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		ret = freq_qos_add_request(&policy->constraints,
>>   					   &policy->min_freq_req, FREQ_QOS_MIN,
>> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
>> +					   min);
>>   		if (ret < 0)
>>   			goto out_destroy_policy;
>>   
>>   		ret = freq_qos_add_request(&policy->constraints,
>>   					   &policy->max_freq_req, FREQ_QOS_MAX,
>> -					   FREQ_QOS_MAX_DEFAULT_VALUE);
>> +					   max);
>>   		if (ret < 0)
>>   			goto out_destroy_policy;
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> +
>> +		/*
>> +		 * If the driver didn't set QoS constraints, policy->min/max still
>> +		 * need to be set as they are used to clamp frequency requests.
>> +		 */
>> +		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
>> +		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
>>   	}
>>   
>>   	if (cpufreq_driver->get && has_target()) {
> [...]
