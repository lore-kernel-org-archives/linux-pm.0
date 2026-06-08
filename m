Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EFEEA8;
	Mon,  8 Jun 2026 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898383; cv=fail; b=EwniyX7F7QXrDJDk+RrnTgHASR/d/KlO2YlLjQDXkfVUatOIfRCNrvAszmA0t/OL3EZSyfi5AS7gGO+wYBNoqJU5R3LkXmiZUdP4Da7UGTjeTFvbc/eITWL3LhSCHJ9pOEXs2zxsn9kO+C0lDrlC6iytPAxVocIy1HWZ6WjETF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898383; c=relaxed/simple;
	bh=mTK1cS/i95OXNIz1NhHB0d5+2CdEk46TsTQPUGLUj1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YznVVmHfNR0vfWhK0iCCHWIIezBtC4I1qCGXz858S/5jLvXtr4Hv9N2u30QF/woHsKwcs6b4axJwfpsqeUj55d9BojbIBJP62L4DYPdbQ+TqqCtf1aMq/gEAm2EzHtWG+XmRE7UEnKVgMCy6cR8IhpfaTzvEWU3pUefZwj1z0F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5EsOoDL; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5EsOoDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K85uI9LYEmNlSGJrxRchX5PyzyQWCqBUoZ5x5N2fNxpAiUzZO7DzJqYRW/lNxaawq2yT1xav3rmSs906szgcTrk1MAmcwSJMQ02/RuNSC3rmOgNCucwo69DcLZtdOK2TBVpEeS+/341MpyD/RpOWXxPIa0HgpgCXB5dsBS7g9R6w1kRv7sk0vQgagysv8rBnlLDJ4K5dGl4IHjQhPzPG785nQtLTvM6ENKPrcopNAeN/F1CUm74uOAe81teI1ds7e9C0AEiwJKFWGo+t8kOoWu9ldbTKt2SCznE1rNu49dO3y8fJsAPstxEkJlaVC1JvAq6qigbqY0Q55lUXL5XKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISm32uXki15YLZWNAgHQK9SeMhqob+4MMMYRaRcMZSk=;
 b=qT6Oi0rkTJOOaRiW1dQ3qeLZQwPKXwBqc9/s2CiVZCHyjHjd8uNYHRhetcmK1v/TqLbwh4c0mfgw5EeFsJRycOVlf+5rNz3sRWziR5skSDCZ4zbOAFRsb9ov7AdtyySE+AeFvCdMODuR+TMl+Z/JJkwSrequVtph1RvX/ps0Z/XCipdNfnN51Hn7dKN9d5az4AOFft/LA3ou4zGOyJbKDgkDUIx5qbf2RToBCVldMWAz0iO+hVC+dldu8o8QY5ECEczMGlScO/HomW1p01o0P+U58SrGorE+P7pcRITGANMUGDjv+e3BxGy8Oqa2X0AAdAsMMvJ8vOG+TExbwyXfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISm32uXki15YLZWNAgHQK9SeMhqob+4MMMYRaRcMZSk=;
 b=j5EsOoDLfFwFUi0Kxxwy+O7R/X1ZgY7VeJmNMLI45aiAWIbCpbHOyeR4yL2J9OV3gjGlUeHE9y3f3vfuNmT31ILcl3vsySf71BKaYS+OblXUu15cbVCJ2jFJSDxTFYIuI7xKWQvKVx3m5pP0D3uf/B8f+ThC4hCIvAy7P1Gmnlo=
Received: from DS7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::14) by
 CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 05:59:36 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::25) by DS7P220CA0084.outlook.office365.com
 (2603:10b6:8:259::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.21 via Frontend Transport; Mon, 8
 Jun 2026 05:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 05:59:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 00:59:17 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 00:59:09 -0500
Message-ID: <36b574d7-2958-4f5e-8cb2-af371c490dc9@amd.com>
Date: Mon, 8 Jun 2026 11:29:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra
	<peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
References: <20260608051741.3207435-1-jgross@suse.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608051741.3207435-1-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fd8164-a7a6-40cb-354d-08dec5231eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dVgnQgkOyR0LZliHS3WL8bDoLSoY9YTKtkBJ4cLK55lPFjuRRe8GiJaES5oJ38barGgm97OzRYmO/YAhhSw7dypZ2gPdUzIkHt57xe5BZNeCiuyXBesQPHklCi4DENSec8YzUttvIHnkF3XYbjNnO9oqfrubRc/FNxD7Hoa90eK3x5GejeftyvNPE+XQ3qlPREWJx1dKepAg7Pmg/wlNcQ053y9559iMxDU40V5TrrF+u0tB0R4DzimM2akN0dLGP7aIfaXZKA+UlFbJFlutVk2IweDaXvXla+/Hg411ljk9FSBDG6j8Ah5l8Om8/KnJ9jYRHPd8H4ni+M/J5hnLO0jFcCq7Ci/C2xXdBEvmVonkyLINm7Q3biDUGETcduPdmTvaS4mf/XCY2qCJjzdqNkO7+A4GWN6B/z1DYBaKYfw8WYnK6EpVzYhwXkzKKBwN/sJ1y9qz1xGlJfhMej1hhpF/7FU9gYPbFZcpKM9T6Lu2CRpNPEb63J7lXfi0rldFh01uT83kL/diMyw4BZ0ssyIPPVfFUiD1ao95rlvpbfEEYCt3kt0h0nC1QTUofqrytVckw3jNOfqC6jTLta/5JFtzU4mfbFQRvs72OWWEEzHmDjfYoJ1vJqDQg6KxUTiQK/60rr0ZgA7TX/nx8grXD7WSHeVzU5VL4yQhVrbOHqNYLEKsSmB6R8uhnM1MZZQhOSIWB+0yyhhF/nhtDkLWXt1kU9SJIahn3QGVqT3WO5I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xp9KISuGy/8/wl23SIkQ5iVLwprLYLOoXhTzM6PYMN5fTM+FITlYYDBEqWRDYyneSs5RKyrH4cMtiAdcxFSL9QPcEIADX6mo8whZUZJkieGrj4Pfy6Fcz9zfP3laGnZJtJ7k9ScLlBfv+xjLkZ6e3EhJ7ePZGxE1r76ID7pJwK/rDaYPAQpqs4iIg+DW2+G7Vv7nj+kZgfsmVBTNR97THvPrL6c4fpkxCfxRE8Dm4ke7mjwYG6ePgcOpsUXqImTX0cP+vTHcl32hOmn082GDlMsw/lLQxWf7/EwMsLeflD/w3z2z+9WNPhlFVYp8/nQdFWma0VRmIorpJMUtHaJbbudfKkULGWMxG65Cf5ZqIQJ6NSy0Z+/y4TPRQdyVcQKn2njcB8gL4VKUDmT8ZxL+bCKZN7S5GplQOerztQmOzRoaK2Dv+bmf/vTA32FdmpzV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 05:59:36.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fd8164-a7a6-40cb-354d-08dec5231eac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741

Hello Juergen,

On 6/8/2026 10:47 AM, Juergen Gross wrote:
> Drop the variants using 2 32-bit values instead of a single 64-bit one
> of the *_on_cpu() MSR access functions.
> 
> Changes in V2:
> - patches 1+2 split out from other patch
> - keep the *q() variants instead of those without suffix
> 
> Changes in V3:
> - V3 patch 7 split out from V2 patch 7

I've taken this series for a spin on top of tip/master and haven't
notices anything unusual on both baremetal and on an i386 QEMU
guest. Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

