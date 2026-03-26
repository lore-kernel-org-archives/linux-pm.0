Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB652FD1B6;
	Thu, 26 Mar 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512691; cv=fail; b=E4gzSKTauPfPAF3HXkUvT2mG9IpmB0zdSyTqrRnd+hmZrF6whfcnDI8Zc231yBRE/NSG3mDYNB0CFaU4QYBcuvTiyn5KG466O8CmXcDavcg5Ajz06fornnwEK9SWMPNYYyWhPLt9CF+DojljLoRGAMKXKJkf/O7QShmVZMbHct4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512691; c=relaxed/simple;
	bh=+OsNMq7Wx/4NmGzEWH2IsMrlio6H38JSySzz2JwMTIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPmscvhF3ngmHJBNrRuyjMMvbZ3xdu0k+KntpzjEnM1AeTcfwKXWwSLZ1FNiX+kLghY/U28z5aQeqmGTCrq4h3FDfF2nJ7ZpHYXb8eUY/LuPnWVUhoPLPbOuSA6fyoTZ0n/6Eq/u52MzLZOH7UO1GaeidP85Lg/Q8ZISYHImrTE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XV9g5SCR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XV9g5SCR; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XV9g5SCR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XV9g5SCR"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vX+BL8ZxtREC7RlH8Rfo7niPxvmBhlNZPcwybyZRLvTdJTS9c0+ywOUHlTy5194VjwaChdU1CW1zFzHZuPx1wz3keO1J35qCWNzYvE+46Q5BXiYNMxrlsiaCvF7XykquTIMhbVvXyEBj3jqN9ZZWJWjT9jQkFIQDDp2vV+Hqkz7Nn+32Ee50Y+TryZgAv/JWl5J+7RLd66FoeyAJkC37cF4qpZzbHGMHpSOC5nAf+wVEY39QhEadphJOzQJGtuRiFPJWOYLAq3poQyuOsn8UYbJFC9E+Pbs61Gk/wiQOq6ASzSgnwXkikfCOnBFxcaK5gsbt5XqmNLAaLy7sN5xCHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk8zk/Gpv9pmp0serbXekGSDowHpMZduHOA4lkt37Z0=;
 b=hfTRtHl9iE+H4cvDWdE3H+XfBk1hK0nvHZ1Lu+oo6OyVk67TsrkX9evHW5114NfrcHRXweL9Jvx/daKwy7mdsYmgxcxAxhweyTOZ/YoLQMJbnsGTE/lJiSfAVdCn3HHA84rc1/4b/a7jp0c3g8zy7oXLO0dzrRHEz4PKXi671UlSTJSxcG5dr6hCBkJm7PwGa5vV6BndPxFPEIuH2tMv0DvlDpLEPEpKmisiWJSIXUfKoJoTkn8K4E823swoGUaFv8m60fauiHwLyn6ByLW+8jsQeIVmS78b91Ksl0sKyvh9LJbua6hOOzgBJdEzcpjfUdbTfolq0TJATim9QfCjfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk8zk/Gpv9pmp0serbXekGSDowHpMZduHOA4lkt37Z0=;
 b=XV9g5SCR1KO03kcgIFvuZQAXlbjMbZ7XHGre5Q25OdyStX8i0giOAXkcaNXsKVlR3MfSzSkNmqn+y+vA7fJzmBtLbUr6hfZivZooILIzPpSWFFoqwIXs7pC/rh5aSOWomP0DLOLxQFak6v0Sy8nZatfl27guA8DHOSmm86xrr+s=
Received: from DU6P191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::22)
 by AS2PR08MB9762.eurprd08.prod.outlook.com (2603:10a6:20b:605::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 08:11:23 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::96) by DU6P191CA0038.outlook.office365.com
 (2603:10a6:10:53f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 08:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 08:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpQHfMgI+qEXT4oO5jKvwKcf55XHe2aMYrjKchP0i//5pCCCUTdpH5GO2tECheVctl020IP7OpWHpmr/xJyC1WERov7u3vDw68QWiMepuLOscdHuU7NUWtLv5Sg7LHL6qTei7illVNmnW8Lw/h+Nq1rHubVjMaE9N9DjFsfpYxiqMdn9cohxJD6ZuqS9Sm/TfvQ8B92YHfLgywz5jPiYQ3LxDgdEiSyO44InJzERuYCz0vfkr7k3Lfx5Ts5s0svTcqc0AAv9gRptQDguLHcgderrGz2jaD2dLo3dVDpp1LM3yVrqMsBwce7NOIattK154mYrNq26/fmtKCxCumBB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk8zk/Gpv9pmp0serbXekGSDowHpMZduHOA4lkt37Z0=;
 b=o7igihVeto8XdMrdcl1R00O3GM3iSIvJjE8qcu9an5BMvVB7tkTnyvIM9D8iMQqCVTvDBRqZCTbyveiKLN2gmpURICFIa6F8BlrKhElw9IAUBVo8B3sHYE4deDLmbdVrnJdHLqbbxlvS3WGiKvIWezR4G0LFjdJ1rjdhdDKj4c5tivUeoX7JjuGL7MJVOtVdYj9fxlJsANQr3y/stwV/RsRDZrNc87oByCDSht2DrQXeEzutELkQ9r8L6+NO/wfvJgD2HPwQFY+rUvixr9uoYB7HNu3/02vWaS8PethicO3Pbhd3DQADb/doRo77QhlActajDB3RMqNKEA+wHDeVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk8zk/Gpv9pmp0serbXekGSDowHpMZduHOA4lkt37Z0=;
 b=XV9g5SCR1KO03kcgIFvuZQAXlbjMbZ7XHGre5Q25OdyStX8i0giOAXkcaNXsKVlR3MfSzSkNmqn+y+vA7fJzmBtLbUr6hfZivZooILIzPpSWFFoqwIXs7pC/rh5aSOWomP0DLOLxQFak6v0Sy8nZatfl27guA8DHOSmm86xrr+s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB8574.eurprd08.prod.outlook.com (2603:10a6:20b:55d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:10:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:10:15 +0000
Message-ID: <b9029378-7c8e-4700-9ded-5fd80aa73fd8@arm.com>
Date: Thu, 26 Mar 2026 09:10:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
 <6vfexdrwtftix7k4zcyftxxdzbxyrcisegrcuukyy4cbuuioo4@zi6qlmloj4kg>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <6vfexdrwtftix7k4zcyftxxdzbxyrcisegrcuukyy4cbuuioo4@zi6qlmloj4kg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB8574:EE_|DB5PEPF00014B8D:EE_|AS2PR08MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: eb92327f-7d6f-41fd-46af-08de8b0f4415
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 jonmrIs/YXzpdQOoBOPRz6U/GkT9p2RmjvUTwFE5Sa/Ash0yupSm0JEKMrFXpni6SIxAkgzpLtxBvt/SIEOirnMul6OJUQSEKnYZnIQ47hefpC5Hm96OtphePPBPUeKCZOUYDoT5P5o7yNiBO9BF/ijsp68Q0CEPkbJgzvtUz0IvWMEGB2IkwJhn/8FUysGGwtnacBp8OAzHJQbD9YE/aeYinKLCDHHys37Gjpar+CCIzKE2rcgTzBxD7GondYgz9hOSokb3YilRzkaNbgtdq9TdK03hjXSOZktUR2PShlxPuls+8fmBWOnaONTOLKE4PmVrO0ToAOZxOXfENJavL4eANZ+s00L7qMbunu085V9o0ArUmwg5F0rfAI/YjQel+WRujPfCOeqnYQSUvBpMueK2+6oF/c5kY7rRNjq/Kc6s5maDpW0WkZqmrUNt866CRnfIRJNtIMDsiYzWegLp1pg0xeyW8jjhX1wTshmkjnGZxk3zJSYVTFZvDn9+T0yLi4Q9iyXdCxa7Ystl9WC3rRcWgm8j3mem8aCFl5YDmvgytXTTbyVV/tqcxR2psTNzzY3iuEq5wBxGImibO3/yg0j0QpdCFOBu8rZ5kQ3geHX+MLX5unSb1bvRf8molgIP2ZPsf3HNKf1voe9E/ip6J3EEIY6W7gKygxusSpmz9AV/a3q9JvLeyx1aYAXhHJHhONdTiffYfhQbfkZg2et51Vry/eFSM22JRwjDF6iMqTrfg55YSku8RTRSt9lfSE25
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 n0TjgYQn0wNXTJd+FOHBZ28zXhF4AoEr6ps17El/6cvGa0a33SElVa27quQTrEVAro4plYXiiF4fyw8hruywl0LywOOUStld/tua+O5h6iO1WJCUSVJLZmZ7dEakP7/Hshn9Rk8QO6YHRL03IG4CRAQmhQ97/alv5TRKMoi/XycfPUsQNXLQgkNXbETztbB1tWnq7QHekwQbPNdePpFt1bmgMwhM009Wp+CIcLibH3fsDrZaxd5gleqDrZvyd70YaOD2dbOUpIxOm/ev9zlyrAPj9b1BDhwYmFsBJnhjg5aHmynTBu94sJqku+1vZGjx0YbzKKz2nMfsNzQMEnYBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8574
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0d0abe2f-f38a-472f-e4fa-08de8b0f1c75
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|82310400026|1800799024|35042699022|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RdNsR0uCcxkM/b7A7RbxppLYt7F4C8loctH3Ac+ndioh+G1TphBAXE5bMetkh85rZD9mPx2X1Q5mExmtePtYPZWzJvjgVScIvy64bg35CyHYo38e/QZ/2MyX8OtIT19svzRY5DltwmKb3Ho34YiKLEBXK/EIgbjBZwtUH0C6tvxw9SxkQavLm+paslrbPDU+eA0wOL2DL+3JasHLePfbYep+gYYKpX1b4BQow54dIjct2Wt/I5yUlAfM+2y5kgxh5cVpv2QsTR5zOhE6aS4xADagB+3LeXU2JY0QLxLOLvB8gxGwWyMeOjv4Lq/hEtlwo1w+EaaiT/TZhP+iiV1BmByHfxSHONITr1j0iKXF3466WB+Lkk4gTxWwgsVWe9cgK9IynHgvBoc7HLgAhG2yr5NXsZvcWVb4UJBgopsUH2lyJFFw52mCP4Q4pJhPEpq2PB4DKUZ7SHD0RRufS2AGxn50SuN+QrQ7tVKYd/RclKr4HQIbgjWZ4nr1QcMOvxOB1wSqSncwKFoF3nBfvq1iNKxL58hPGSqts5FZZK1bUcFysMP+eJTwfi/jueXn10gNsJ54ofOThLB7n/j0cXmUauJFxIlfj90FU64P6EYlFfgzcBKwMlxBWTdMlZJrLy86AbQX6BmGTMEWVs4/7RlcNxdUkQmDIcsFeUVeV8FgTRxFxFF91cpXqMKDQ+7I+WnWBkcQqKJNTGNOA1ScfKh4wK7VwnNMjllbPNyNc/KtW53X0lu2icgIWdyAENPIjZmdfd1BaRXVT8hKtOTu4ZfcMGqeQXiw/IHlXzW0h9arGJw=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(82310400026)(1800799024)(35042699022)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NJNwqilz7OqH6x4cN3iv0Ligp+FFrWSXv8vQdrwfn6SQOzDxEwLDSFb0eObt3hJLPARq56O+Y1Fpss1jdtLfJ8LZbDgfLF/b5ueFDT/m22BnAhhXoaGCxSf98BL12MlfYE7sc5Tzdc8J3U7O9VmsRqdd5v1ElDzlyIYwMlp6+V5YZIH+R5Mg96xviIDHa73ILO9Qpdxfzu017c33xygMmF8Znw7Y8OCdqsqH6h3S9dUWxwl5+4ma+w1bqA0t0Ys9s4cH9Xk6v7nwbJ8gGj3DuMl2DQ4xSovlpetK9UlVKDcFUWae06UA+uKVjw8RCfDiM8RenUyazmXcJwg56tcn0HgQ7MQpcLXQ+DdMCyiycEXFGINaTFFnz1NH9LgEb0XWW9YfYp4JaBwocM2U2ZK0pjiSO1a90HCb+kdVjaZAMfsEm8euCgMbJw/kLR/6YovW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:11:21.5180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb92327f-7d6f-41fd-46af-08de8b0f4415
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9762


On 3/26/26 06:03, Viresh Kumar wrote:
> On 25-03-26, 17:52, Pierre Gondois wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> @@ -1445,18 +1456,42 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>   
>>   	if (new_policy) {
>> +		unsigned int req_nr;
> Maybe rename to `count` ?
Ok
>
>>   		for_each_cpu(j, policy->related_cpus) {
>>   			per_cpu(cpufreq_cpu_data, j) = policy;
>>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>   		}
>>   
>> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>> +		req_nr = policy->boost_supported ? 3 : 2;
>> +		policy->min_freq_req = kzalloc(req_nr * sizeof(*policy->min_freq_req),
>>   					       GFP_KERNEL);
>>   		if (!policy->min_freq_req) {
>>   			ret = -ENOMEM;
>>   			goto out_destroy_policy;
>>   		}
>>   
>> +		if (policy->boost_supported) {
> I would rather add this last: min -> max -> boost.
>
> And change the code in free as:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 58e3839a2140..7f5d18da78c6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1358,17 +1358,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>          /* Cancel any pending policy->update work before freeing the policy. */
>          cancel_work_sync(&policy->update);
>
> -       if (policy->max_freq_req) {
> +       if (policy->boost_freq_req) {
>                  /*
> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> +                * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
>                   * notification, since CPUFREQ_CREATE_POLICY notification was
> -                * sent after adding max_freq_req earlier.
> +                * sent after adding boost_freq_req earlier.
>                   */
>                  blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>                                               CPUFREQ_REMOVE_POLICY, policy);
> -               freq_qos_remove_request(policy->max_freq_req);
> +               freq_qos_remove_request(policy->boost_freq_req);
>          }
>
> +       freq_qos_remove_request(policy->max_freq_req);
>          freq_qos_remove_request(policy->min_freq_req);
>          kfree(policy->min_freq_req);
>
>
I thought there was an issue by adding boost last:
not all policies support boost frequencies (and thus requests).

So blocking_notifier_call_chain() should be called if:

+ if ((policy->max_freq_req && !policy->boost_supported) || + 
policy->boost_freq_req) {

This was in an earlier version, but Rafael and Lifeng suggested
to add boost_freq_req first to simplify the logic:

https://lore.kernel.org/all/20260225084930.1692228-3-pierre.gondois@arm.com/


>> +			policy->boost_freq_req = policy->min_freq_req + 2;
>> +
>> +			/*
>> +			 * If boost is supported,
>> +			 * init the constraint with cpuinfo.max_freq.
>> +			 */
> Don't need a comment for obvious code ?
Ok
>
>> +			ret = freq_qos_add_request(&policy->constraints,
>> +						   policy->boost_freq_req,
>> +						   FREQ_QOS_MAX,
>> +						   policy->cpuinfo.max_freq);
>> +			if (ret < 0) {
>> +				/*
>> +				 * So we don't call freq_qos_remove_request() for an
>> +				 * uninitialized request.
>> +				 */
> Actually we are calling freq_qos_remove_request() for NULL values. This comment
> and other exiting ones like this can be removed I guess. They aren't adding much
> value.
>
Ok
