Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB43655CC;
	Fri, 19 Jun 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861476; cv=fail; b=bEx77sHeUNnXFMIVsisYhRLa6qe1hiGNXCcRjqTW+2+cXAXAQyd0kdgLidrlBOr0rl8gVt9u/8Y0NfAtgXA/stlTBBT+4nxJ2cukSrFmoLTSj7BjaIUp6uJSKjaLuYQXd5SN5spgjDbWU6tdzIWLFEosZVW+NIvFeDTKq6+agBg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861476; c=relaxed/simple;
	bh=2spitZ1GBUr0pQ4u9XFWqvkAI9tzx3cOa/+PgShS6gM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6kzy9NVjvhC0fG4GhgzPRYjV53zCw88g+JFRfntYmT9Wj4RlApwxUwa62AHXUyYAkoZgxuozmC3NvzgX4aLjRmBjDUGb64uM9tKafzFrPfJU9PmUdsYVqd3Gz0NX5g9NgVbXAnKgeUviPN7ZoSLqYGkQmz3tKjoQQJB741v30A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AvoWalXh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AvoWalXh; arc=fail smtp.client-ip=52.101.72.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AvoWalXh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AvoWalXh"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mrpIWcwx099LdbgOePsob5LCOYJM2q6ur0Difym1Nze6eSsEchbvlpgWD9iz8u74f/aj0El7LHqdCppXHzo+DZsEtA/owdUYs7k4zSFUl8h5c3JYzu0gQ6uVAw5Wui2beXOyy1+2rZy0lnno5KDCfXkztXNSQbFiqM1MxKSQz8kl+a0Gy+A7zMXCIXCxbqtPaaZ6enNwQqXpZp0MiE34hMnFe5eC90crjhDZ1hUPf+oDHGTqZRlRKyn1HmV2SOWN+qHZp2msHYBuaJjLDuhKI8MJbt9pblp5VOjc51mEBrnLvbpODww0g4Ln1PAUuT25meymkFEmzdSFTvds1ILFgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2spitZ1GBUr0pQ4u9XFWqvkAI9tzx3cOa/+PgShS6gM=;
 b=qV23b0GTom56uPZ1E0jfRUBtcSso748F+dubaoXMyRoynygsx9Jloax7yoEoC+K6U6JoYojn2xSq3lWDZXAaj47lH07BrprRaEAUf6EqQm37WKGoryygyFNhUniWFJZwJIp7sGec26FvaIVwyhSNmIASDHHpairOD8J9MZwl1ZIY91i/j+VjKSuw2ZjJTq0YT9yYASgMGec/K6qg12H3gNxJVJDy6asJvhQMRSPJ9L3nLYpty/S7ysZ4TmXfW6Y1Rv7ELVfPC/Xaixqq8kN25A+0kmFsOn7wV+1wJYZp6QTo5z6BAid3gCRZVC/T+j/6hXk7kSMngb6TFaeA+f13+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2spitZ1GBUr0pQ4u9XFWqvkAI9tzx3cOa/+PgShS6gM=;
 b=AvoWalXhrYMsYbZW+ZL5lKtlpH54Vu4a6KidxDubiYEb7+1t578Nm0QdlPAdw+otpolExFEQcTGtKr1sc+2mxi9jtWV9NUBsrR+8d7q3fmpYJmlkPEtAwL/1ixyxwwvc39BdEY7AweSSSx9Ir1uBJS7l+XFAMMfeYNsAAaBnyIU=
Received: from AS9PR06CA0478.eurprd06.prod.outlook.com (2603:10a6:20b:49a::33)
 by GVXPR08MB11182.eurprd08.prod.outlook.com (2603:10a6:150:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 09:31:02 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:49a:cafe::68) by AS9PR06CA0478.outlook.office365.com
 (2603:10a6:20b:49a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 09:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Fri, 19 Jun 2026 09:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKKThKQTv2S5iBAjAo/HKLqJ9hG+SROsfNsAt8Cxjp0wgzPqWvlRANCRoyXTgY8yXxYUnAgBysPHzq125jHREwWi2XmdshlFtPL44kRvZFzYhmxV5JhEthteU+ggnHvNUNn3/kSpSb8WEDWD3tctivMB9WIbBlwNv3Kvst4oFH4IROCdpcz4rpGwBZ1vIroRqUe2GHOAXBiHgoDrrYpadXxDzwQn96pdHj+ZYfK+ASFsbvCM7gMF8EU7GcqDZ5LPlDsBpXN+5brubdiyHLs7SODpiYSc6ZTQAtsRVxsxrwJb14JfgdFZf4S/nnL6oi3AarYuUlFsea3t4lXUqhkbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2spitZ1GBUr0pQ4u9XFWqvkAI9tzx3cOa/+PgShS6gM=;
 b=FEL+fSPExJKnm7LjGlBd0cmqaTMUCPz2yzLYhDtUGFw6Dbzn5g9x5ud87ZH68odbBCg7oSr/zUdSOcxcDvKwvSz8zoazxzwqQE1Od3ukW2j6TcoWq+E404K8s5x4DswYEeLequLGWoulwUEbbqVRv2DBG6A1cspLxwa1Nu34t85/osXIsO8x0fegjRgVbjKU+T41bEbamBqsN52E3dsU912kxr9FCEvwyr/CLBuxivHh5cR69v0b5utS4iv2bdGYsEi+A5mOdLoOUrMFbks/lWIG74I1vqe7MuXrqpTHxyq2K+F/hFe/JicWMffcnL9O8uwooPgi1EuTEm9I64wMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2spitZ1GBUr0pQ4u9XFWqvkAI9tzx3cOa/+PgShS6gM=;
 b=AvoWalXhrYMsYbZW+ZL5lKtlpH54Vu4a6KidxDubiYEb7+1t578Nm0QdlPAdw+otpolExFEQcTGtKr1sc+2mxi9jtWV9NUBsrR+8d7q3fmpYJmlkPEtAwL/1ixyxwwvc39BdEY7AweSSSx9Ir1uBJS7l+XFAMMfeYNsAAaBnyIU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB8919.eurprd08.prod.outlook.com (2603:10a6:102:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 09:29:55 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 09:29:54 +0000
Message-ID: <35458c15-73b3-45f1-91fe-aa81d85a3efd@arm.com>
Date: Fri, 19 Jun 2026 11:29:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260527202550.206828-1-sumitg@nvidia.com>
 <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>
 <oxw5k2wad4vorehgmrduoxblequy3ynqufwy4sruclnh5d5wrb@awzmfafoucnn>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <oxw5k2wad4vorehgmrduoxblequy3ynqufwy4sruclnh5d5wrb@awzmfafoucnn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::27) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB8919:EE_|AM4PEPF00027A64:EE_|GVXPR08MB11182:EE_
X-MS-Office365-Filtering-Correlation-Id: c7852656-982c-4c08-10a8-08decde57a11
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|10070799003|366016|3023799007|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 lYExSBEyX2yANpIqBahYBnh8MkmeXCI4asb1Jb7cO7r9N0U63LS70Vc2v5CkLbXxVWhZaTH3t4QSQ28CZWE43bytyP3HrzKcRK178VQynXoOp2l21qBZHJ1wbxQEGLv/g9y7HEgciIT/fyCfHqi+EAtg/sgy7plckfUs/hdfGCluejXuAUOm06+zTEQYJxpLDrWmh00aieTpiChHRApWTWVrVXKg1xd3cEoqZ7O151J1JkDctH2nFp89f/FBLF4nDquFDH/5HxOR7UR2NgMJIG0DP+OJmFt5LyeMyMA8lUkAStRU0Cl3+AOZWdEo2tZ4N92+70dn1G2oze67Ey6zOQHqNgc5dF8Qq/gT5I0JxhzS6x58n+mV8B2QGeivII9zALVWHnuKlrGx/q0EPPYTnL5dQbGSMc/EXO+PHfVg9LEGMvAi7a0q/HNC/Y1ILAL0U+W9BMFfofxohITGTCIS5X+rNTwpqN8VBqWR2oun6KNAAo5FJwHuQjgfWGzdhcHZfMqSlq6MXqHIe7uhi3ieoVNiqpnIqb8PWBBaC3pAy1h/KpLZwJtfGad86QACq0C5vW/dOw9x+KVnIvDs8nrjotVhRfY4IB84iNUxOmBiG0JfXj/CZmBySZpL+CRrdRjQPtXhcvZuwNxoySUeYQ9Jp1T2JlwhV82WWY3izoIhH7s=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(10070799003)(366016)(3023799007)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 nE87u5xEUr7JfdTsYEGJ/kwlZVVhdeEjH08k5PiFj2TLpHGGahd9w+q/8p37hrK5tSGdszNgbQUek/CfVnlEa/4hb8TZSSJg/lyuc0AN2P0OPzwCAawj5aH0vSV1rtdW9AtDLfkCIYEw5f8N0XKhbeJgSjluQj8Gkr+hO1OCu/1gG8hh/RwpuL5f1o86RUwYsfxTgrjJt9wfP0iWGqWAe0kN+Sw4aQ3pT8ojCfHY4PkYX6Iw4YhBot1fyrK0VvYOGMd6R7mz1fZoQoMZkWhWpcJTEVFwqpRPBzSNTlq+Kkwr04aNfaem4jLoZEpsc8OceixH09a0KFQevpdxUCSzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8919
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b7b4500d-b17e-4b0a-3a88-08decde55228
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|14060799003|376014|7416014|35042699022|82310400026|36860700016|3023799007|11063799006|4143699003|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jf3BoyRqf0GXBTAXUpKfOsWBfStyob/9U1a40kA5ums+rsTlEzkXQjlWkgOfT5AKw2RxY8Uz3OwQe5P8I+V+M89xj9xLJ8j26fqGBjKZbS+Z0SBjlLPRXcZfvfEjPRy7iwKpW4UarY095dgqydG9e5uiyJyCXC28mMkwZulN0P1IolZWWXV0FyC61lavXkvgybD5GqN1VUf+1YnYM5LkpONVwajQK+HVnCjlKJldgzhXh3mLopSwR5hPAVDeKvq/3mCfUuqIDqRxwSucUtbEyHzlI9nWUAqYJ+uMmamLUy+xW4abTOhXWoWtg6ZvOQeOFcjEgCvy/RVW+uw00sE80PLsECFdfjZ8hn2Esgn57kx7seDGVsvmh8t8YmPdQlOygGyviqenIJDyhq8pAX3LbtBpS3wa8nm2L7N09aiTSUefY8hk44hqtWcamz0rsBMox3/TTGCHYxAtSyGIXA5AdtKWwoYGajDDm+Czbdqir7cYcRsEe3syzB8ti7RFdmmyTu5aVklRZTgW1gXaOx4mkV/mdrcJlPbuts5yQoxMJgD+dl8ZaEKkkQVK1i7sC4ncXr0GxrU0pj05U9wQnK29z6SuGdxYUafmUzoB0H4S44VPGfxHcPutfDCbRxoTSa7CJMBmd8Ha+r3N7eYjxJGtUoWq8Ba/vN5MAPOUMYL0nX3VSTqlncGqzjfVKUO0jx35e2nKF/jH8JBMbSJH2Fhtxg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(14060799003)(376014)(7416014)(35042699022)(82310400026)(36860700016)(3023799007)(11063799006)(4143699003)(56012099006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ffA8RQDcixFOsZ23LMY0nYCYdeNZr57wR3lUcbNk6DiPmH+EMeMYVGarJheyFrZDZVWF2pM+vAaaOupi++m8niZhkgb7ZtKfF6QTfL3Eqweej00KDDTYp7SO1BhS2P7B7R/EWcmHVmdocOT/32dpu7g/jfBPa1U5JTmc7uehUHkxEcjvim7G4Kq3W5iy3eh4kKpuuyvdeSOPDTSCXN3O3/uPaeIVNyC5KeP4/3p9N28j6Vq0aTgRlg3ZQ4vtEjp2Yd+FXXxEY54qLwAJ+K4nWx7Ni6t9gHSaOFKQDMVAXzS5uQyRVWkS6wbHFDGoT2j13ylOthX0lviILHXWcTheXTW4wndJAftx429uSQx/NK6GRipUxTtl6hzykYumfuHsPbkUIxlA+IfhCJAjUE0JVcfyrvWLn8O7YrPGVJreOJWy3vaXcuJS+rFkPRpW1qic
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:31:01.1345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7852656-982c-4c08-10a8-08decde57a11
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11182


On 6/18/26 07:28, Viresh Kumar wrote:
> On 16-06-26, 18:22, Sumit Gupta wrote:
>> The dependency it was waiting on, the "cpufreq: Set policy->min and
>> max as real QoS constraints" series, is now in linux-pm (linux-next).
>> I rebased on top and verified autonomous mode works as expected, and
>> it applies cleanly on the current linux-next.
>>
>> The [1] reference in patch 2/2 points to v2 of that series; the merged
>> version is v3 [2].
>>
>> If there are no further comments, please consider acking and queuing
>> this for the next cycle.
> I was waiting for CPPC reviewers to provide some feedback.i
>
> Jie / Lifeng / Pierre ?
>
I think the patchset has the same issue described at:

https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/

I don't know if this is important to other persons,
but IMO it would be preferable to have a solution to this issue
before adding more functionalities relying on registers that are left
in an unknown state.

If there are any other opinion ?

