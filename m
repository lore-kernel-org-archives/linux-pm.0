Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022105.outbound.protection.outlook.com [52.101.126.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13437105A
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221928; cv=fail; b=ducf5aHIeQqDEMG31lab52B2eyU4RgioUCk/aA7bQhlDI/7fT1iwc6QiXb3a8oesm8lVlbSRl6jjFgJt1bxeKr2ileYo6C7af0xDn9ByQm54UVuUDS5GIzF4swMAaW4O6TXqU2kkEWRvEzt5QjtPzHjqWMndADd7dGOE27+sAwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221928; c=relaxed/simple;
	bh=hxUwV5UNMhiMJyl7o2H6AADtjrsOZt/rg6Cyhuj6TVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFu3x7UJMzGxpVixP6BXbAlnFI/6M2qSBa7RasVcI/rLfuNSPji/R4kx+2Nxk525W0rSGv7n6QDsN3aRf5Ld1AAkcLYmUpIxFfq7SqYsw4fdzVoHoC0JxRYKVzxKDKXI+oQCWdTlZMFCxhyPBg621f5Mrib6CDYcL5SAz2dCPuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=pHKDWk00; arc=fail smtp.client-ip=52.101.126.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="pHKDWk00"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4jbazyOiPZpaYuW58W3HlFudYND4MW13KpFPAUnzhY90y0EZVXPIVQ++4vz4y/euTAwjbPa43T1+ZKzhewmVdhLfnWM+u/VWLUgAPRvRy1DFORUmYzSG/3Tbs9jYW3iOiFn+bkbPm957YftMlKs1t8WRcEYbM7vzqJTensQaifQgwZD0A66KwanGqlHlA5GpdfR9OzPfKap1PJ9SybLM4ER7gk0f7GD8htpYotbPg0qkCPlJRlFccQ21AEFaCbHYE3zK8ghmilqpdiIaOhmy+xRFlEIzwpVgIRkbR8JuBuN3z/myTvMmIJAlmjwjO8FagZxjBjlEtI7ZylYdkkHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es6cct218TgjUZmie3HEDdffneXiqKYhXYIT6JHyme4=;
 b=Q2CEmhofO+wywpITggU9Eeq+SEyKt3duzRhdiBhL1Ld21PsP+6IF8Ov9WAqn/gA3ZatPgBt7plnEedGaTJ6HFVor4LCZsVZdY3hsymZ1mve8q1eKOAgNM5KRiJlJzwE1YobYSV7IuTadAmY/VsrCTcAngzMKB6VqGmpr73XZAKlg2mUJd/3fFoMT4Wyq9HkynnNmO7PhdH0kNWBXTubbdsrLbbjJgvwsGhPOqvMXAALxaBsP9APk/lRqLiW3CyYNdQ5ldLYzal8hfwljRT0gDE877wXAS7O0t94Qb5BVMXYqkqA9E2ecAROriLqg2jfACnpZoc2VCOaEUCoAFn7+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es6cct218TgjUZmie3HEDdffneXiqKYhXYIT6JHyme4=;
 b=pHKDWk00Enjc05B6murEmdJTREuT7JMvSn94VwTsLK/m6J5ts1AkdKSMjZjqlnTtygepU7S34oesb5Tetcpr+xRk82yPJnvhc7DtgViLojw5E/no/s+MQfffRE9ruovLaWWik8GWnL5AS+U+LAELrS1/tgPT7Fvp0wbTRmzRVz4SJOILJVN7RN9jrLOc8ZpueLRznnWUKiyWNcaZBtN+eOdc3gdSt9bTOtcI9v05hOvJLGw+0Cn1XnKUUJBcx0EN0B40c1pCBP9Gj2E+vsABL2zt/X/u0TLWvcfQJUBgxQnsZf1e7zBWJNM76bO30CPepKinY0wB9UWZvOCz2deuLg==
Received: from SI2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:4:186::14)
 by TYQPR04MB9205.apcprd04.prod.outlook.com (2603:1096:405:374::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:31:51 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::5c) by SI2PR06CA0003.outlook.office365.com
 (2603:1096:4:186::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 06:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Fri, 8 May 2026 06:31:50 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id B184935F;
	Fri,  8 May 2026 14:31:49 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH v2 1/2] cpufreq: intel_pstate: Fix scaling for hybrid-capable CPUs not reporting hybrid
Date: Fri,  8 May 2026 14:30:31 +0800
Message-ID: <20260508063032.3248602-2-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508063032.3248602-1-henrytseng@qnap.com>
References: <20260508063032.3248602-1-henrytseng@qnap.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYQPR04MB9205:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd3135e4-bfc3-4c61-0f8d-08deaccb7cc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003|55112099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	Kn1LpKCpz4RSRH0CMFqR2yB32q1YfWR+nvdOukT2n7XEwq8M1RZJ7atrjrKdmZJ/cNum5xlTpw8+KojkK8Bem4rm9M2j7H7FeshPvBqJUkdvowIWg5K5iOieWCd9PphBSiXhqp/r9JIL6cmNDat9gPgitM6W/epwBbWYvFgAaIrv1d8E5S9OW/6lXuJLRtBhXny+/tb95qRnI4J34M+2oajCHd1AKqhD0HlHPshjvQZKhbY/G1c4+Vp4qvNsrnFUBs92X4Tpt6ZjgtBFN6+EF1SbTVeKxukJVwxNhm+CEECRRj1dv1Rr4gAmxE4Xv8zakavUFsmOldZJklwNaBhmJj8QM24atH36HRsDWhgptb3T6d+QMSvd3a5r9AT0SKJP+ijrJRTbcuDeaDooO8AhVcEreIhxK7SVXR8rRXHuVPVihH+guUJAY4/TllFzio98kJeqs8MSuqS/LjfKJnzocxk+efznItSjLb4Q/MEMmjfzpgFaL180RpfESAl75Jpb8dq8Xw2qNSZSHZdsNi+CFQznJItltLWzQjIGjeui4c7oXjY+BrKieYAKmT6JlzR5joHjMFpixfprcHUnyrk5Gfbhp0Jog9tbgGCUkJ/GbuAsBj51NeElV/U+UjswPC3VF41E6tkZ1q6gfQROGn9AuF2A9+2VSobzoKShQWNTUbJxCUpzvTtZohtYeikuufcojY1IalYf2LOzeKahLKoSrc1pwWJi7bxahUsgo006ZVo=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003)(55112099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I3RYLnam1oFzh/8KBC5Ts2FJZq/UzfXlogIOQMu7c2gjZxer8LCr58uqNkHnmeJpXBFqNzWkJY82cocgPTl0/exY/iG3+tubVHMCD72oewKPqXH5gDXN+W4bLgPyVuvXtE0UMKENFMDNhcxiI+dF7wUvL1oWmF2ZgldqDCdxEec1fguzZWzYKWpU4GJhVux3EuWmEEoDE64QrudbiASb7cVml6yDFbPtv0gtSvaONbMJ8T+6U+NRMsCDlKCDNrpsCtisXYSo/dHIqbLSTJrxksu0Gv8zKWsFBmoWVmRV2sS0SIE1xd5gxWn27gzfOrTyU7Mmv8pJOeRnv0JmZpnPg1IZovjOf8YGjm8G8coUDybPY370RozRz3jNvWxw3WO1PlPLsCKLLlbqfDgBsGaytlzFBRQRlCiWyjgB/2C8ftXE7xDWJ35opAt+RV1T9hLT
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:31:50.3550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3135e4-bfc3-4c61-0f8d-08deaccb7cc6
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR04MB9205

Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling
factors") restructured hwp_get_cpu_scaling() so that, when the CPU
model is registered in intel_hybrid_scaling_factor[] and
hybrid_get_cpu_type() does not return INTEL_CPU_TYPE_CORE, the
function early-returns core_get_scaling() (100000) instead of
falling through to intel_pstate_cppc_get_scaling().

This regresses the behavior previously addressed by
commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
hybrid-capable systems with disabled E-cores").  On hybrid-capable
processors not reporting X86_FEATURE_HYBRID_CPU (no E-cores
enumerated), hybrid_get_cpu_type() returns 0.  Before 9b18d536b124,
such CPUs fell through to intel_pstate_cppc_get_scaling(), which
returned the registered hybrid_scaling_factor.  After 9b18d536b124,
for models registered in the table the early return takes
core_get_scaling() before reaching that fallback, so the registered
factor is not used.

Fix this by returning hybrid_scaling_factor directly for CPU models
registered in intel_hybrid_scaling_factor[] that do not report
X86_FEATURE_HYBRID_CPU, before checking hybrid_get_cpu_type().

With that fix, non-hybrid CPUs in the table now reach
intel_pstate_hybrid_hwp_adjust() with scaling != perf_ctl_scaling.
Since commit 5313ec4a215a ("cpufreq: intel_pstate: Improve printing of
debug messages") sets hwp_is_hybrid = true unconditionally inside that
function, set hwp_is_hybrid based on X86_FEATURE_HYBRID_CPU instead,
so the flag is not set on non-hybrid systems.

Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling factors")
Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..d39592e86570 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -585,7 +585,7 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	if (scaling == perf_ctl_scaling)
 		return;
 
-	hwp_is_hybrid = true;
+	hwp_is_hybrid = cpu_feature_enabled(X86_FEATURE_HYBRID_CPU);
 
 	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
 					   perf_ctl_scaling);
@@ -2275,6 +2275,9 @@ static int knl_get_turbo_pstate(int cpu)
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
+		if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+			return hybrid_scaling_factor;
+
 		/*
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
-- 
2.43.0

