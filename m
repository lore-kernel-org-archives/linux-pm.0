Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041018DB01;
	Fri,  3 Apr 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189214; cv=fail; b=PRNU+9vbrpehncCvmADnXzs9RmrECFd7BYfM7LpjELe6pta0YzfGycp/IPfPmDFF4TFw0GKiM24GkFb0tOqhyfM2NEqJXYteTgJICaR/QGMPe4BI7BdMrb8nOm+eYmCcxnkZADsFiYunMu3Vvtk2r/btmmiFvocw2pLpYZndSsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189214; c=relaxed/simple;
	bh=lFSv7eU9fytQZFfjeZNpxlobwvF4xRTrQcba848GqJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gtKpDpkCvLy7tLUVMCv9lmgHox276/aMyhB1aklH6gW8kmfDMtYq7GCzzRIUHaewbBV+h5xuxwGTPFsbqLG0UVI79LpPQkELQZ1DliX/0qsm4rSJK1zcb1N2McGiIKh5S+QiAwO3nrsgQETtSZUu1DQX00FqDsm+h7APWh+EU/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1INBAVSE; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1INBAVSE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmOk2VYru8HXufWMb2LRR3pUe646xksOtXapMQDUE2xlTnBVlaa6NgMgeWUvU+e0669dUZzgjly1oBVTsioWiCNig/g/rjb541yFACOIQ1ICeCwNnrGIZb99Wruw926/iRwxFHyp3wF3AoxvHoSEAYHGeSSE8cfxHZWhCugp8wAhY5GbB1jQx6AvAV7sUELmLOdxT1QDrSJ87J/+oHkTfVivWqlhSZ55F8WKVNtHzIj4P+Eb5m4uC/oSyO9ScCAXuRfzOUR8kw/3B4mbL1n81psKdk68pMtArLEBvGj0RsHZGRAs0yTrkuiCQQqryDzkzitw5kQ1DDgPdD7vd6TAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeXFO56QbdM80DVxu+LWJM5ECN/s36RDTfFNMv+WcGw=;
 b=BlvFTsI+NIMy5ZVOIuqESmnPIpRDF0hSZUQW8CvkHeHoBOARShi2Lemra3GvzOp3uso/h+YH74xs8eG4z3pJw8pw/VSV7n/pFbfuFUhkYU4eCZEbzhjl+ozPYBgcTY6emR+XMvXd2EM1SnwFVnoucmjQseD5q3ueRNmEvcQ35Mec7d16Lt1J+60Fkht/cTaSmlCrJWxBhhUwK9Y+gm2EL+6ukTV1knrt3pH4slFSNyC3YtKCQnSARtovciBCDdQQkEdqtpDx7atwsKdtXBrIk+A0NfJ9ziFhnZG+2TwfFXjMmSS0klJ/Tfz8m7tNsISGHkyXuqUMZqsamBOvHH8vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeXFO56QbdM80DVxu+LWJM5ECN/s36RDTfFNMv+WcGw=;
 b=1INBAVSEJyM4ukEIgz3zslx0RFVQqJ7NnriSnEdys3lMW9Ic9dfnVSbePvJYJLv0Z+7iPi9B9FyHHnPS8ak43uyrlWNGIZwqedsReJhZtm//YV/S0s0Nu6MSz2JWY0X23H0bgjFBDQlWLxyc7tZ2rJTj9NgGtnVV818VNshcC1k=
Received: from BL0PR0102CA0057.prod.exchangelabs.com (2603:10b6:208:25::34) by
 CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Fri, 3 Apr 2026 04:06:47 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::64) by BL0PR0102CA0057.outlook.office365.com
 (2603:10b6:208:25::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 04:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 04:06:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 23:06:45 -0500
Received: from [10.136.42.52] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 23:06:41 -0500
Message-ID: <ece06f79-60a7-4f90-840c-c2b05faa9dc3@amd.com>
Date: Fri, 3 Apr 2026 09:36:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
To: Mario Limonciello <mario.limonciello@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Perry Yuan <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Mario
 Limonciello" <superm1@kernel.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
 <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
 <4bwfgnjiywkm4dyslhzmk6lvar3a6rhvtcyyruc7okybckuwuf@mkdc5dlconx4>
 <178f3a55-6faf-4070-9e38-85c547b27a03@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <178f3a55-6faf-4070-9e38-85c547b27a03@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 04da6de2-37cc-46c4-3280-08de91366c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DXpFqnSJdGn4BMX6oQUH1dnHyJSv2dfVl1tsLX1Ufr5aR6i10/o+YUs7pvQY0jyX2PnOTF3MdbsAy+5/LBv3R9OlLlFc9EMhVoQEW2J0H6o93CiOSdvzrLaBagx46QtqOTdPf7AGND4fk5PwUh1I3DQVS4FRGrfZ1kgY7AaErMfTgSAEU3NEAIqAZVAh6/KOkEHL6w4vZYLCPoKLbBk1zOb0TCBjIY4yO0dDG/4JKN4zly+aZJzY4eG4/GYdAAXkKJaJCpQgRQkEaa+kjtsqjhXFfmOJeKuUB0NHQE07kBCfcehDn+JOsdfQeCgclvqrLGITAnAfZ4VwCdWOqcnmpBkhoNvf9vIy9lmOdv3OnxyAjrRwh6b/F3C10QDlf77c6iAHGczW7deojAcqlg9sTcHx+MlmBfs/5K3Z5E6xwil99YwVJ6iJvA1D0qqHG/1ok3eaiB+IEtJU/T4WQUQxXKW/rCrgicpFCuzjIjh4aDhTFmoFIX63SSPpsk883Vuc9W+nDstdh7aeOvzbVVboo05CRLmcrkt2wpA8d8wlCcTCKR/F9U0RI3KkgGvOWAsoBFryN9CsLRxnQw2YZD1Rl17fAm1R15F8Q6foX1YedaOFo8Y7TCYz9J4+DJW6IsgPTBPViNhQFlKZildnKgKcqU3LWIDobSiJpZThutGi3/Tga2Xt+XN82NnUMfXalX89FyVNKFcCVOIdrEeo3QoK1wry3zMlsSdEwt5U04G62wEEZzS12tRnVZw2EUc8ie5npt+dDEngJ3wxw6JlylukzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BrByf7mH6fdur8CqIH9wSiCIXhD7JtPFxvhuf2ssE1psthpxmn9O6RJdZcMpRB9Bd4shE9y9s8Tf6xwt9CECzj7EcdwD7TU2nxyAb9KQwGsHa8h3flUYuGFLLfNxBWgZeDzq020viu0qE/aD6Wh6hUb8CcaQHvTafJIDf+Wbxx1/9iO+OwCvypQZeV15CxMeCI4VCzANQwBpi6B/1RO9EhgrEXMAZxg/Wmnzwt+LYE5cOCGpU8777NAK9Yh7j3KDwgV1MG/H+27uZ0T8BAq24AwWnJcBdcfGFCBvobCJF62vKSmSyP0AjPj3AVwWEQFh8ldTXG6mDxC/jNuzYVkA/VSDhFRHfUCS/KBEakguPH0/bGCJqV4EPYKdhQj/nOY90+dPYRqt8JjOF8WNuf9HA63VnY7BbkPs7jEeLNqxG8InG5TpUK/Kys5poGHi4BWQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 04:06:46.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04da6de2-37cc-46c4-3280-08de91366c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629

Hello Mario,

On 4/2/2026 7:22 PM, Mario Limonciello wrote:
> On 4/2/26 01:39, Viresh Kumar wrote:
>> It is ready for Rafael to pick now.
>>
> 
> I'm sending an amd-pstate PR later today after some more testing.
> 
> I'll pick this up in my PR that goes to Rafael.

Thanks a ton! Much appreciated.

I'll send a separate follow up cleanup to remove the "!policy" check in
amd_pstate_adjust_perf() based on Zhongqiu suggestion after some testing
if all goes well :-)

-- 
Thanks and Regards,
Prateek

