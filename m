Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554344;
	b=L0IedckY53Ec/TWjnq08cIB1z0zZ16Ea4NxnzhCY088wuclAnLYSKj5HMqOiDR+Ezw45
	 taAiAdUlWxmo/FcBy6wyxJjjn5zIoLO6Q1Jmiez9F6YkEllWCFKQdmLSF8BxtWmHgSur4
	 27St6gDi/+LAYMVzGN1HzxU5YGso+iUk4HUlWvm1M+e3dXAnl0H2HPmF5cRT+uXfyaoTH
	 Wln4+xj81IpXYnJtENwfzZP2ceNXHE0Qt9iwAKAjtDia1A/CspNPJIOX9lgE8u+eOZsAT
	 xYMxC8GNHcVpNbbkvCsE12039qkre96LQ2UKGfbXfHPDkAjOtsb9E10OgAiVXwipiig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554344;
	h=DMARC-Filter:DKIM-Signature:X-MS-Exchange-Authentication-Results:
	 Received:Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/6Rzcm8DyE1Vwy+itMayKNUQTkKAxIwYut0M4w9+CtE=;
	b=wwatQE67eh193ZkdgfEP0iLmH7gXFkbV3WiYmgDQSTxYytEdkXvqe6Rohkn67wqBQLYg
	 i7jpqP2cDyWp4E7qJw2ht1aJkeVLyEn5CBWsYBVhW1dQlR4MqCc2W23JHPY8MOGLfDS03
	 ynGqft5boymGuc9TGMorKWgc2Qq2FG0g9B4VjR/fyU1xwXTa273Az+tJZ1RXPYd5bzTnT
	 jKMJEhy4IHF3WyXXcZztNcwYvRzu3oOw0kLYEAFr8M+f8Zw5i4uyj4XQmwYlnGj1dx4UD
	 nvHNb/rgppetNAkpdNeeBHYG3SQUZKU2HpOqp8BSd+/THijOyReQTLoJRCmh4SRSklA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AVAjmXl5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.60
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C69606A321;
	Fri, 13 Nov 2026 07:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AVAjmXl5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNF7knBhYIwa4M6JwIYwFHosq6NuuCDL1AP0Ocf4pFv72GzN5IxOvp3/8Esc4EMydswQCSDokLqxViovAXvqgftD9SWXhCNtTnWgxmj3dXIolXV4c/TWQOsDclkfqQkRVn9HywBWkKgb8IDuxmHlWDvN30X0cMYHSYP1I3uslJdVri0ODt45Em2daDjrbJJoVDBe6tdsVtVPuXvvewT/XbxhE41mTBLODJJ9sQAkGdpuVNeCPn/pYU2HEW2vj0wrMbvyPwrR6LA+SwK4gQ2lRm3sNQdbxFcMm6NW/t91rZH2ynh6YDGqG1mGI7s0KqY7YeaXIdFhEPhTb3z7oyr9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6Rzcm8DyE1Vwy+itMayKNUQTkKAxIwYut0M4w9+CtE=;
 b=Pi5Inf1YmQqJl+xBjSHhRPkCuJRBW/I+C3WrohHGPkSts3eXtn8ByX1yzFFb0mrsicDbmmXUcjhIKF6b4R36zV2WKlO5ikINUnYOJDtbFvQEOmX2OSlmg5YJa/JFT0KxJvl6XirAbxkRvT0XzgDYJ2QcRhscOWDxXSII7acKumqL7sWPOZY8LJtkUutX/xf695suZ+YPNXOx6p4cWeIPLQ+9eLOvPfDanIMqpnHKJSiWbL/2fx28F3cuR/NK4ELwspH/GkbokXuM2Mb3iiDGfnvGMQmde5Te4nBKlGkyQRHYHTl3aLrkN2J4nAeSrnUpO48+iRWNShMSUY4dBe9yZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Rzcm8DyE1Vwy+itMayKNUQTkKAxIwYut0M4w9+CtE=;
 b=AVAjmXl5kRO/GE/4ruDw+WxAaJ75uHAzMnowbAI3RXv4gtOhOs3AvRxgxOhT6+p0FyHhrwLm1anj/wKv+4wvO3r99D90akqQ4dKg5QNFEb0cTWXqZtjML+YTwwO7nMtaExodVg9wRYJRxWyLOckuihPoJSr/6E8GIznmyUPjwTc=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::32)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 07:19:01 +0000
Received: from IA0PEPF00000039.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::30) by BL1P223CA0027.outlook.office365.com
 (2603:10b6:208:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Fri,
 13 Nov 2026 07:18:59 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000039.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 07:18:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 01:18:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 01:18:59 -0600
Received: from [10.136.34.22] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 01:18:55 -0600
Message-ID: <43c99fe6-f1b7-4992-b4b7-82a96c9415e1@amd.com>
Date: Fri, 13 Nov 2026 12:48:49 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/x86/amd/hfi: Rank SMT siblings below
 primary cores for ITMT packing
To: Aiden Hecker <heckeraiden@gmail.com>, Huang Rui <ray.huang@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261113022934.13397-1-heckeraiden@gmail.com>
 <20261113022934.13397-3-heckeraiden@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261113022934.13397-3-heckeraiden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000039:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bfccda-2b94-48dc-b0f6-08df41566368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|4143699003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aerixQfzvsuEp4IQ4kruK6HcVRMwmkkB+HRPIY8GDDmoq0jmNCyaJwxQw/7F254t7sIkFuGtEBTG97fZQvdq5ij9FU2rwIBrIUHET75XDGHP2o+MRgzDx4ia7QSnaz8svOGVcY1REXx3yjJEaz24CHQq1fsi82dMkRqlRqUEnVtIG4VPwkbyiqifFEfxWZHONKmfsl/UI8ABg/x7I2kJZgaYdqLvMobzSQRqoajQa7KLmcTtJSDEKQEjal74fCjkq/MkQQeYwwjNHssnCSoWsMLfYJSwcoggWbmuPWZfgG9f2RZm+hZ6ZmUyPxtMY7DgqNFOAQX+KhEbhMlu+UgGcmMIacQZWP6lKDHgB6saaIycv8pM/rmpdraMkHD+HHmGztKjgVhA15SwWElNMLdRusodhng8QZXioSD+3mSdgKS3WxIV7QchC2PWISEkyfD0yKGD9mu4AEfwsJsyaFBaF8K4t1zTAOUARyC9eex4MbCejLtPj/teHn3wBsI6NzsTkj/FLIcqx8jCopkdvLKtS2UnI0NyjxBFYs4F4vy791Ksu4vqVzlkfsSVqpOrm218hkqwHzSNN55r44GWrt53HH1dg3/CDSylTV2f0R4eJ7fPjCZwrdKifODYJgZBg+3aK62HIgd93H0qnqSkHQFldYcONndPm7hw7S/qViYo21s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(4143699003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7pAXk8GNdEUymXhP1FE2+25xN/5l1voMY4ySaovtL21VFFrPVnShYEWUadWmNYkudqxy/YcDeHlxeGt27RhGgzeaXDWgr+zIeF/aJJoGdqaiFU9CH4Z6MnPeyjJn39v+J3B0KGjezrUeu0HbwIxmD41Ws1wy7/AC4b3y7pjNVkBPgX9v0C6WR4ZKeeTwC5orGYB1qOPzDkElu7vr1+cvpQqWRfzvCNWjcIqlkVPsdWtQHmhu7MSFBomS01f6i71T65NH6VMGh8HeI8qraS1wEEIzhDZx2NAnFoIlbsQRo02wt0IyUz4QncuNB7OdX2Jn3dK9xdj2GioIRGC5JOyqE243x4395MuEBTM00j/jGThgpBdJzHOZFCJfE/2BQdl/5zi1TpfYJbVNq3WADDs7x8ju5CQ8FAyRmfMUFy704e6IamRDcdFFevScltVuV0VK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 07:18:59.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bfccda-2b94-48dc-b0f6-08df41566368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Hello Aiden,

On 11/13/2026 7:59 AM, Aiden Hecker wrote:
> Tested-by: Aiden Hecker <heckeraiden@gmail.com>

We assume you've tested the changes you are signing off on :-)

> Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>

[..snip..]

> +	/*
> +	 * Rank secondary SMT siblings slightly below primary threads so
> +	 * SD_ASYM_PACKING fills idle physical cores first while still keeping
> +	 * classic Zen 5 SMT siblings ordered ahead of dense Zen 5c cores.
> +	 */
> +	prio = hfi_cpuinfo->ipcc_scores[0];
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
> +		sib_mask = topology_sibling_cpumask(cpu);
> +		if (!cpumask_empty(sib_mask) && cpumask_first(sib_mask) != cpu)
> +			prio = (prio * 7) / 8;
> +	}
> +
> +	sched_set_itmt_core_prio(prio, cpu);

If asym capacity is enabled, we should not use the IPCC information.
The scheduler is smart enough to go find an idle core if it exists
that fits the task capacity.

>  
>  	return 0;
>  }

-- 
Thanks and Regards,
Prateek

