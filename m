Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640333E373;
	Tue,  9 Jun 2026 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980445; cv=fail; b=AMRYHMr6wdi3Ofce8zQD7s/5RqFeqSRqkvHysCjlD/L454MUfXJhk7U479k5ipKdQrjyzLHC6DlQUTI+iz6E7ejJaJMx6fDXNZDvcL++SKSgjuEDy0YTyhSI8K2tm34GrCKC2vhjGNXksPcSAWdcKTfHcP+89pdbDFoQCtT3X6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980445; c=relaxed/simple;
	bh=u4eDYYofzp69hBB/O/DCtS0x7NuOT5bWLf96mUbIniI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cvw0xFrQo4W+lNN/p76Q8Xi+A7I9oXzRCrmSMbUKKlLgX5LITC9Rf209dY5HNIyGWrvndeWyXK0baisVLZYhJEfMt19E0nErmeB0iCxCBscuEwyC/4fR7BULwbVHeq5JeQbg5D21+1MZHTJwtoVynUxkcD8SWxqsSV4WPFGYr5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yvZjDFV+; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yvZjDFV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5A7Kcpmr8w2JtirtlhAZEH0f4IiIjPRtx6Mklzem2FW+IPHCQvtCvLOpBefSNRWwgCpA55flds0DuyvfvSndfRXe7eurggUScf72zdNvg4/1cnGJhv9cufR8DuBjmL4EK1zqo2MSIgVgOrRWOw1JuubamL2Btbxgay1FJLv1Cd0m61io40Gja+SeGOnOHG6dGJ51B1An+1F8VBXBNtjhVGNPG197iZH/d0j9iCEPdnq/mD0DBBXF1keBk/6AFr/77AGZa3/sJwsV5ZgJFHdcybLYrIVnmrLfp64eCGF+xeeGQaKS0BZGKKcMJ8uYZMlOqJq/BHqg3T6o37kpIOEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElPBjEFl4+u2H5LHLnpoN3ZbvbWlNATdnRYL/ILUoiM=;
 b=S/1jJTR7EcuXnhovRr/nWeWgE0XiurF5eTcPlkVBBLQJtg9LgyoVJnVOR+xRQ0MV0A2AlI99VJUBDKLsNgj0uCxwNrWgFJq7LJETty3Lr29pRbbPrdpwAQc9yZyls8zPzddqUmm971gze1BrP/rsmWg7xB6+NmPS8sdGRcFNe0I2ss20t0sclIIrVYdxHuPwsB02YL1AQmJU1jLtSs7JKxRlVxEdCv36Z0YOXktfqb+JPnxnwiTSk9mx6SIJaNIcp1Ki+sJdUCA2s/KmycHQulgBiPssKup0MbG/0C8lvWwdGHr1HuaQbdSjWCOnsAYAeThuSuiddmUa54lD3QBZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElPBjEFl4+u2H5LHLnpoN3ZbvbWlNATdnRYL/ILUoiM=;
 b=yvZjDFV+wlH4W5cZhF+0L/eAQ8PrzsczOGIHOsa7QpGiaICIB+yZh73u71RGDCIG4G9treINtfuALMc1s4Uowb9V7+L4gCVi5A/wdHU2PXp5LmscUqUNlTHfqtG7aj6/xvgT1RD2SVl1Dp+iJnw4DQhEaULSXdH6BRHXz3pqZc8=
Received: from DS3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::10) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 04:47:19 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:8:45f:cafe::50) by DS3P220CA0008.outlook.office365.com
 (2603:10b6:8:45f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 04:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 04:47:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:47:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:47:18 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 23:47:16 -0500
Message-ID: <160328b1-bc66-4748-bf5c-870bac6a2d10@amd.com>
Date: Tue, 9 Jun 2026 10:17:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cpufreq/amd-pstate: Toggle auto_sel in active mode
 on shared memory systems
To: Marco Scardovi <scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<ray.huang@amd.com>, <stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
 <20260608073614.5738-1-scardracs@disroot.org>
 <20260608073614.5738-3-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608073614.5738-3-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e372047-5a34-4137-c483-08dec5e22fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Eh7gRELcCd3jSVhOrg9lo44oYYgQSlmkVm0v4jfn8kHctMyT6BFE7cWOyg46wpRQGzfwNGQUqNSGt1cxqBmTpUNt5N7cHxAUE2BA1Oj2hFdOvb6JtbQFunnZMW6nRNDHVB6fdsey1KKnMmIv8jrnP5hPQ37yLhuNZirJ0DjpBrrDxV0szpoyoppF5Cyp5/5UjuWqHHsSzlJdWe9Mugd6tcxd83YhSeiL0yhyfACvQWfTw5bpyxQSC8FXHd66YFQQzM7jrnR0eO+pLybCEYHXx4Ue6GnAkIjIvtxbpj3RR40+ztHkjQb1SkI2WpEuzykv7nN6cVzwVOQepvMKlQeqQXd3S1x/Gx7ym/37xiotRZijLRs+3Y7OEOQ13JZg9p/u1AsRG1y87OnHlXfeLxaydOLnEbVrtzNx9IieCaDFWsu0hNmPxxD3+1iycULEvGL9/r05lty7D6chXk3+6oHcCmlSxYYf7S6FnyNdj4z5jG8W2hrTDA0LBUCHuhV/apkqF1rnrAm/+MUYsiv9izWLd1W/ztIelvrBPF/bxsGZDg1O1BOgeQnJWR8mAppfYfqvo/hzIURLC9tBTA33pL6fu0zt1wPML9DrbdwxH1oVXMBHf2tgrFvWQW94VBxLshxkMUm9+dTxMIrocV6IFbDd05EQGVzhlJe7she8o/GmEOzLfwDWtOIjQI/I9zL8CkuCGgGGYeTlzy3GkG8VBwVCb098zcBZXBuFAEje1RfakiM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	chiz3eCJzc1SSc04JPET0peGVk8q3B3yDts5wxfgXrzrD1GisW7AbCuZ7FHRel/ZmC6EIhCP1cCfF1/ojiczzM58DXzKqcMkENzkMX7dB+WcTkdmxMuA80opVR+Uk//iKQ1i2gg5IQILw71ERCZ2sZfQLgCu1mzEhzOTjk8LABsmqO+QRIZh13NcF0X6ONNJF5YZNTImFuqvxCPIFwc06qkE+2aSVjNY+VtEi7vJBXE5papnPfODK/RR3djtIpbbTXKDO/7h6ndxiHMUaFtHzinBZrAIt4mxYVqdTWyto48z0biG0R3EMkoZO8EixCatM2tsupCayhtX3ttYTn90Lw9BqpiInisgY5AnHRebazCD0TI/dX7/ybbSACM7UgFc52bSoRDsY6c5j587kRxYYiHnu673VNGgUgySVGPNXzgXEy+Tq25T5xhm8rBV1HAh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:47:18.9718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e372047-5a34-4137-c483-08dec5e22fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

Hello Marco,

On 6/8/2026 1:01 PM, Marco Scardovi wrote:
> On shared memory systems, the EPP configuration path (handled via
> cppc_set_epp_perf()) is responsible for toggling on the CPPC autonomous
> selection register (auto_sel).
> 
> Currently, shmem_init_perf() returns early without doing any of the auto_sel
> configuration steps if cppc_state is AMD_PSTATE_ACTIVE. This skips enabling
> auto_sel, leaving the CPU in non-autonomous mode.
> 
> Remove the early return check in shmem_init_perf() when cppc_state is
> AMD_PSTATE_ACTIVE. Toggling auto_sel is necessary for the active mode on
> shared memory systems to function based on the ACPI spec for CPPC v2 and
> below.
> 
> Fixes: 2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.anayk@amd.com>

-- 
Thanks and Regards,
Prateek

