Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023143.outbound.protection.outlook.com [40.107.44.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD23C063E
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146007; cv=fail; b=SoJIyYMo9hlXXHxicBvBFotJV4rp7d3lpJxkZIz5DL05ACH2x3x9RE8+08UeOws5TVzcyBaSlt+MH1vcJqIbvdZFbURYM75FjDgS0zHIngik5+7pEZjMov6zH4C2hK8/6NoNxQRgd0ohWWDM7qhZUW8z1C3WBE+UOThqbe/p2jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146007; c=relaxed/simple;
	bh=7jv6p0ADWQ+wDeWco7/Z+kQ0BrDllOeMkkdp1yyWlpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpleZScuOT1m0nMgXDIyOGkiYiR+kAZDcKCsV0C7tj02Hm7ozlqX3txtCA3OcDHopz4NWT25Gj1iB9PiCmPsAHGjN02bi+RrkelnHc0pwOfPFFEhDGU8tVKuM00BeDbsjNPu1pafMVtVllSvrBSGtLODg8sGj/7VeB9rqkHKLwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=PUNZoB+t; arc=fail smtp.client-ip=40.107.44.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="PUNZoB+t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAKCFQ+Di8cmWLQWrogibkIIc3PY1SsAmXjqYcj6Qp5NU5kRdocxvilRtvqRdYnVPFq4SdZB0d7eMjqnpwkx9z51V9RWbevms+vaJDVfLXjkV/ndk++8z9LHVcEVoEXmBI0jN2p9vtSFZscYyDMoKcwovpbRncaBpWZ64e4X1cro+si/XfjZhcHvF9uOGncUwZrlgFH5JxVyUZ/OyYf4uDA3RptoiKR5mCq8TBsa96clv+9zLDEAvGSQo1lo/ImbiaVjBS5FQeZK4GIwy/tkSg6jNzTCg24wyki4X4XMYyjYVnB7yqRcg+T+KfdN2PFgdeOUNQJ1ykon4L54UQpXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71SX1jt08e7tM/bGcSsasBi6EFDpYk3S/ZvwcXrx5Po=;
 b=v/rEVG9sVd5RnCkq5PDTBkUtfoZOxcRpNRYibX5Cuoev7NMlAilwI4HfVx7WUJhe9P9OLmP/B68nymk9AX9l6HDFWRQwymDTRcz4tGoxRAOzBuc4Z1UU+VfjGWed/PVkdUo+rn+8CPgC9fHzMc/OGNSbHfT64Rjb/ZAEKI2C3U5n+L7xNbdqj9ZxXB6azXEl2paKQA9t9+B2x68Xeg+G+hlIFxM4nvw0vaUMkqtrsw0Ofpgfn+CbbSOLTsi1LfqWLHPjwS/uYEog56QNKQkNcC7j2eeJECqGZQRotHndoQ0JIPI6Sg8e0Kw9+ZhZdmNjUmjGRlBC3xqZa4sld93KVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71SX1jt08e7tM/bGcSsasBi6EFDpYk3S/ZvwcXrx5Po=;
 b=PUNZoB+tMVDbQuxoWywUs0LmHs+3x2s96sTlFtNC1UGhyYkxuXMkADpBykNpsvbpg+gST4WiHfMcc/00F03QASINqCIQse9ln8a2zZJsAdXwrLQkP3qauQmIR2LpsbcYnXmlmxbVp7bqetaDbvNTek93prhAfgMOkuD2w86B86Em3rG/HeIDnZQKDh2dBQWKd5i4XU4yTkzYnI0AS86XI4W32G+X5RoJQ1TTorfTLUR450RQMKNOo3nalKkZY2tjbLoeo0JZpXKAoOQyr0V9/wKuTJOxBewSh/7FFpSA1nKC7GrEPuMpBocNehPo61NyN6OTsxV6vz/KTSJnYjB6DQ==
Received: from SI2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:194::22)
 by SI2PR04MB6618.apcprd04.prod.outlook.com (2603:1096:4:1fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:26:37 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:194:cafe::3c) by SI2PR02CA0002.outlook.office365.com
 (2603:1096:4:194::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 09:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Thu, 7 May 2026 09:26:37 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id E5535244;
	Thu,  7 May 2026 17:26:36 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use CPPC to get scaling factor for Bartlett Lake
Date: Thu,  7 May 2026 17:25:54 +0800
Message-ID: <20260507092554.2631883-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7d47a806110c750c47c4b473f45eff6d7f3ebc18.camel@linux.intel.com>
References: <20260506095157.1591221-1-henrytseng@qnap.com> <7d47a806110c750c47c4b473f45eff6d7f3ebc18.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SI2PR04MB6618:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f203e152-5292-4fdb-5da3-08deac1abd33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lvg0SXSrfuUD70nap2y8esHbLzPHysl6cxo6cLb06pLRFAo6xf6hlP1jhe9o0BRuxMN1R0NOdVf9xca4B+cnDK7aOFyv//PcMMw33ea5OBxU1z6SMkAGJomIV0CaTS2n93a7nd3oGDLZ1+smmSFFccAToRaZBbqX1P+3BLcfX/JYLuctZa4Izp/TKQzU1qr85D01W4gZb1jpcrUsuHWc03pjRHzq35R188Ei9I/+R2K1E+Jw2IF4t4+ufZIpkuE/ZL2i9R0tH9hkhl0wV/YWJwOEJNkYwOPIz4e8ojlv0F4QAALq5tJPo+zHrZg55tuYS7SoBsn15xOaNqsf7aOLuSc2i8TWjZKh6IwSFuKUA0S0EM89lUCH1fVJ4bEm6qZfL1u6pmfmVUI1PQ/2LdVtQgrRShUcdt1RklwigTfwFRSjASowA8SuIZbBB87YFkSwqHyUAyt4wpGuLfjEQ/VBYwwHDOHCXLP4TZKzr7oOIeLpSLvdF6GT11JDpKQV2jI0eIUJraSlhpcSn46ryJP8zh0iXDvYhk+uPAPbxtLNnDq9fyDpxauHCnFrjYBtN/0HoMJd6kyCSwIBEV0N5R6sBGqTcWz1zGJWhCZ1MFwx4lJBLx2b26SmeLpHGjmLv2iy9gQ9gdOsg45H+giP5ZT5FBztHEOhMuy2W3ciB6u22NtbdbIMPVErPthSVeW62LwQ1QjFdzf2gJzyOpvMyn6HUFZQ2DyJqU8Y/jG2nLCa3tc=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	czGeuUHZAOOZwnatakdNm9uhTeOIAQk90CaSF5t6hCDJ3FsbLe/EiYjhV+n5xnxoYAHwhUDeUVelCfww9rBfRuKtI3fGapZ/J4dBdue0/m3rf1bGf/gPrqYn8GRYbQY14itxhyPNlxBRUrmI4vuiuFaYb2GJNU9nhhUSDypou4/eFVnKaW6Bz80mWCOrn29inhU1rTVPQ3y8ODWKmcwmuVb+P3plDC3KAukm2kXn+dc722NKfmFk98Sw17UeQgr3z7Z1ZCR/hGO5oStrkFoknnEpUzY7xSSmO6nJECsla1N1SAUJVBpEXqkwEW4ehqbv2xOSUwHHeldMMWNUja36mxjbGDNkU6gfC69nM2dgp6SNbHm/moeTkNIergwnqAHFX1Ifbzh97Oa3rhF895qScyLyCRn6o2QlA+YV86GZPv659hE91mn0Q8Yjbs7qvkNp
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:26:37.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f203e152-5292-4fdb-5da3-08deac1abd33
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6618

On Wed, 06 May 2026 05:15:49 -0700, Srinivas Pandruvada wrote:
> This is a special embedded processor, so to reduce enabling effort by 
> in BIOS, why not just add
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index ec4abe374573..763598ca13cd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3732,6 +3732,7 @@ static const struct x86_cpu_id
> intel_hybrid_scaling_factor[] = {
>         X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
> +       X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
>         X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
>         {}
> 
> CPPC scaling introduces rounding issues for some frequency. This will
> avoid introducing another CPU model list.

Thanks for the review, the static table is definitely simpler. I had
referenced commit 9b18d536b124 and went with CPPC, but I take your point
about the rounding issues.

After adding INTEL_BARTLETTLAKE to intel_hybrid_scaling_factor[], I
noticed hwp_get_cpu_scaling() still falls back to core_get_scaling() on
273PE, because hybrid_get_cpu_type() returns 0 (not INTEL_CPU_TYPE_CORE)
on a non-hybrid CPU, so the table value doesn't get picked up. I added a
check for X86_FEATURE_HYBRID_CPU there to let non-hybrid CPUs in the table
use hybrid_scaling_factor.

I also kept hwp_is_hybrid = 0 on 273PE to match the current mainline
behavior on non-hybrid CPUs.

Draft below, based on v7.1-rc2 (7fd2df204f34), tested on Intel Core 9
273PE:

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..b66455252745 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -585,7 +585,7 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	if (scaling == perf_ctl_scaling)
 		return;
 
-	hwp_is_hybrid = true;
+	hwp_is_hybrid = cpu_feature_enabled(X86_FEATURE_HYBRID_CPU);
 
 	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
 					   perf_ctl_scaling);
@@ -2279,7 +2279,8 @@ static int hwp_get_cpu_scaling(int cpu)
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE ||
+		    !cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
 			return hybrid_scaling_factor;
 
 		return core_get_scaling();
@@ -3734,6 +3735,7 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
 	{}

Result on 273PE:

  intel_pstate: CPU0:  HWP_CAP highest = 70, scaling = 78741, cpuinfo.max = 5500000
  intel_pstate: CPU12: HWP_CAP highest = 73, scaling = 78741, cpuinfo.max = 5700000

If this direction looks OK, I'll send a v2 with a proper commit message.

Thanks,
Henry
