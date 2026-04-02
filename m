Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400F1DE2D3;
	Thu,  2 Apr 2026 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109668; cv=fail; b=ilT3j4zBrOMk5qhFuXFzRRiFHuQ0o47aHABi1FIKSZULMKP9/Co4wmtuf8LVx2MDFzQn1dQeZH6ak47w9rryyMSEO25MIsWC/UpMXktn+1soIuQxiU4FFbABebTJXAy1lqNNzV3WJryGp1qgtwQ6bkP/+z4ww3R1c/L61YjX/Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109668; c=relaxed/simple;
	bh=mnJPPxvqTr4sVAsE2zOpyB7BjoUcelHMf4De2ylPze0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oK4bvx0pNn+wQDSZK4GXyiO0VvfZwbFWLhVISStH3LCGRikp5UbrI0V5a01BjvS6fEG13iGO85+ZpsWJmJc0o5ZJ4Z1wc87W6kBW8nhb1Jx/fbScOYVOpTfIRmsyniH+MS8RDe5F/AxNq3BLdL5T5rGkEZlpp5El5U0tF8PIDEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSrFsjUA; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSrFsjUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXxbXAW82tlHLlDFF//GJKBIWSwWNL/sfHAw3s1U3nBrWG1qzCMct6xr5MI0fcanpexWNMJjDcCz0CXvTvPw6RuW2lxAsvq3u1QuQTzhcedw+Nib2Qj0GLsVG7im0oCb8RcOA+mBV69Y4s/qCoHb3LL1+9r2jzDbqw0Dk+3adjtVSIoeeNXrzBU6bt5xhjYU9iSASP8NrXVDNM4pgLTBYmrMJbqL3Ijl4u5tzMQTGfuomlNOkfSL1h7Mubiey2vZGK+1ffKmO+6GyMpTd+/jszsSMur+6JVLt7k9wtO0LB4RzTmlOtnzaoPAFLG+O+n3inccvpPRSypN8rlqFEsZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzNTWdtd161NmuHqyeLYksgO0och32rI8KHeaHlpb1w=;
 b=U/qDMy42/DSHbSMhTrvA9vgcHrnQb50lds3uB1xgMXuJtU/8O7tet5MShQP+2/Y7KnVIFG420rRkN9nK+DiffXE2CafIJ7xNo3Xq7FCAQNr7yYSwc+oAEBRbw06JHNQIpK+qcKgYClJiBJSr5+t8aKFtP+Ujp3Mhccu+Yoi/L6dukO//nj/bbgTZ1wk9TGLm9jLa7wYbsUSjPf9KRzSBLZNE7Anr4QMCj65BPhT3QcunIRONHA1HLqsqIW5MwD82Ju9fHk5SaRnHfD3plpwnqWrRKB+u1sdJa5JaZw2mrWsJqjSxdjdIYuB421KV8y51dIdOtCXsRBLZOVeIfMOzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzNTWdtd161NmuHqyeLYksgO0och32rI8KHeaHlpb1w=;
 b=uSrFsjUAo+2Mnxc5xTmLIDdNbiG7K539EAh1gni7KBXVylCt2G6EQvJKIzZt7uTFQzTOn0zpO+h41u5yda0GzGbF07uJzDGscdGH2XlprAQULzbmRJK0YMOLoP4VgRH9An+JwSgz8b47mWPf1Ok39/ytavqWGafjdj1bI3+sZWo=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 06:00:57 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::59) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Thu,
 2 Apr 2026 06:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 06:00:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 01:00:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 01:00:55 -0500
Received: from [10.136.42.52] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 01:00:48 -0500
Message-ID: <dc8af5fc-61cf-4560-8f6e-5ba81f371054@amd.com>
Date: Thu, 2 Apr 2026 11:30:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq/amd-pstate: Prevent scheduling when atomic
 on PREEMPT_RT
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Miguel Ojeda <ojeda@kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Boqun Feng
	<boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260316081849.19368-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3471fa-620b-4fce-7a54-08de907d351d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|56012099003|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	0QWDOziNoHM2SiijkmQdH93NmDd4m/w+5fgjimd+RRlU/K0oPVArdgmnJLZvND9Y4yZYpqp58pBYB+hSL+miGDKA7P6QD+41HIjC7SN3AfC+kt+bb3xOlE+zuZQvUJCQzYF/26P1LJOpqYvNQMmWZObjSvS+QMkFCJcJ1C0O6G7lYS5C84fMeWeq8T9ZS7EfuXYmPJEdQm3i+ea5Py18PKBxRucINvwJ5Aoedp0udtmaDdI7h2zGTNixfTa1eksAxS+N/ZMNQmXPeRQiQ2k9Uj/4IRoevvQpkYwJsKo+xMV6tlGurz9Rmbx2pK9nrgF4h9JLmt6/hibR05nAQnbVV4iATb/LXc6hj5vGeL3DJRI8HPYUbuGrLZ/52j8OcPsayIRFd/e1ix4rqgjavCOU7ukgBZejShUyVdstlivDM/fTp5cxo/1aIVcdm5OGR4kXpkF4V+OMTK0io2vi64+mvZ24sgxTnu/hUrDkBEBcAgIJK7RwYMWwnkInlcebtUz1CJxTsfa/oS0nnIgWQa6EAStd1kWlaalTL+6Mb+dED+PCy4zLNJ8UYeYLpMuPeRfy26749SIN40JfSN8T2Oty9mV7wELWrE1myTGD0NCRB4zj0rySd/MTWq/jEa4HqMhmviK+CqwBil9FIpOO3WFVNh/h131Bh8kl8YK+pVEzu1NGkyOBX1QlgkJwa8Pz7NmReaDWE0ZsSKyFPueWhIJbFzd+2KOuUDlJy2gYputxLsjuSateW23hH6HgB89GX+pKinicr88qjXE//0EERW8VFXlDRlN2AoyCXZFnhBg2Wt9TrgZobdQeD/aWGnhKWNmr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(56012099003)(22082099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wpbe/eZZryBBe4jmxQZEaUrxaQqvn5XVuQzO7XV/i9UbCFPYlBiH5h3VTeZDK5XZji2dBji91S+aSWEXEgD7g7Lvul101WgcnjJ9G81lImVcz2OByP6n0OKDgYrSmUG6IxUKF86n50JlXOHkI2LfZGHvzB7PRtYAmFg05xdJ/yQltphxbwJXeP8uUl58gwXCplascQKl5PCU2eIK7H9et8FvSFVN9TDxOHsIXCF3zpLqaIoE4jRG6WrRByjkAcYjAGSTvMrKrkOkYG3P+cARIIjqef6Ug3DiddodSzq4AVURej3NXDBY2oAzNCm+ObeNsJ81/Wklrc2Z3LRe01POgNtyFi7OhvhdadPMD+TMGWq3tBUJh/LI132W/wDtLEJTC3Wc9oqR2mpS6QzhJ/OpGy2Ff413yPPt1NT0ENjLXDEaacg4tzQ9e+SYN7uLCN2P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 06:00:56.8293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3471fa-620b-4fce-7a54-08de907d351d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

Hello Rafael, Viresh,

On 3/16/2026 1:48 PM, K Prateek Nayak wrote:
> Patches are based on:
> 
>   git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> 
> at commit 18ca40891b83 ("Merge branch 'pm-cpuidle-fixes' into
> bleeding-edge") (14-03-2026).

Gentle ping!

They still apply cleanly on top of bleeding-edge at commit 8afc50268253
("Merge branch 'experimental/acpi-driver-conversion' into
bleeding-edge")

If you are looking for specific Acks from other maintainers, please let
me know and I'll try to coax them into taking a look at the series :-)

-- 
Thanks and Regards,
Prateek

