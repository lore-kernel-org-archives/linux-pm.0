Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022081.outbound.protection.outlook.com [40.107.75.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E2374E7F
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221926; cv=fail; b=dBm4jBrPMIrtfUXO9KBFrpNKgLiGkrwxEQdjCBsIpa5oyGz/2t+JM6OSwcnpN+hacrVyOcnmgs+1H2uXPobGjyNlNsAe56/RNxl2A4KDpw/uvu0z+DYD5G949rprP50asYrz+1Mzetk05O/HiYJld4eySeS5iUBk2RCLtfsl7Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221926; c=relaxed/simple;
	bh=e/C5rLPgztHLsJFSZeyOhZRZVkM+lH5AkrpqxC3ybJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lETJnfU5S5DzVHL2tqcRlYnrpl8JPLouConsW2zSYCG1coqX99AarC8Mz3TAvNSmCugH/gNw3inardYlpmIuviisZkulC/vTsI6HRzpjAHEzIjeT7KCQ0YIKJ8+PhithH/wIkg0mGb8+UCpntv4j2uHAXy3tfLyaMp9pJmNBUdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=dVjDr5If; arc=fail smtp.client-ip=40.107.75.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="dVjDr5If"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDaxSZrEAg2rseadI7YrxtgQyqhgjabj5yVKORTkgowncFehPoaNkVTQxSqCP0N5hvAhER53LbkV0K/Tqm44IA7SNvkEBZdJXefwqcKYqIFOuGGIm3JsXv4Hd165Z9FG6P9nSQiONO5XnikqipGiUX/tM6WJpgIg+i50KudrTlmM0ezfbJ625Q5jysRmMovVZeGT8QskiinWZL76gxalwDPTo2ll5FraR4zsNcywfi5s/bKtXaYy43rIovV/u0BfaePEQVrnyRRo2xTYeuYk/GHIwCDxNXb0SmjcZLmWhSDBhF+qA7JwL891H8ZhYAxhAMGCsIEYFaw/AghQgKfLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK+XLqCcQcC2byg88+nfcn+wehDjpFL5CZb6iCUKd9M=;
 b=qQi4S25UuVpO1hX0SYbiosxZYjxh5uDXRqowbuztM3p/m83Lm2pMyVKGgRAbnNs5BKmGNKJyi8fJdC3sMuxN2VaZPKqFHBvhr7kzYT8GA+wFYYU1saOa0x2ZeVr1yn43SqrcRXq43xoi629feo/qZ9Ozoq4P2Qyg4ypa6CvH7dXLANyjGQSyhvTljbgelhGlNw9CN+Fjp8v9h3CEPocPaBSStpa2rPhEin7Uguv0By4TB04/DY4qyo2yGECDV+im2mTO7jgKi1dPiimphbpZjhnZs+u1V1+FN6X6Qe0/Sqjrl8oooO8cSzt7gpi39XG+vkkhruDphNgc54CFP8MQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK+XLqCcQcC2byg88+nfcn+wehDjpFL5CZb6iCUKd9M=;
 b=dVjDr5IfagCm9rlVpdBjVGU18De1RgzBnxopWQw0aLjXTnzL+tKKEftuYVbuYojAIXs97Q52gWUOfpelILdNyKpQtT2zRJW5oCT2OrxCC6HzoGwbjDhr/cxVjddmaBRSzQjRIJRf8QbvxslE9gweTCLZBH0XHldx3afkMp7N9V9DR1sx5l9EilMLwy3ucA4WfwcXuLfvtJnwbvopMbB7bRX/0Dddyeo7mJfOOpMKysH7yTcHKf3dPQrHmwC5RDRhPpUpOF14rSyUT9Utn/PeVVeBwFaTDIUxVZVI6/4KhWpQapuTDkq5/y/R8binFG+TbDlY09lpCbmSMrP7CO+9IA==
Received: from TYCP286CA0227.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c7::14)
 by SI2PR04MB6099.apcprd04.prod.outlook.com (2603:1096:4:1fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 06:31:51 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:3c7:cafe::ea) by TYCP286CA0227.outlook.office365.com
 (2603:1096:400:3c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 06:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Fri, 8 May 2026 06:31:50 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id BEC543A2;
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
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for Bartlett Lake
Date: Fri,  8 May 2026 14:30:32 +0800
Message-ID: <20260508063032.3248602-3-henrytseng@qnap.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|SI2PR04MB6099:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b587339-6da1-4a05-766d-08deaccb7cba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L11fzOr0ho1EQASfNyEuUYy7axkhJlSf43J6g3CwOnAW4J3XmY8SCR2VHT7ILUrTqRN1fl7pYF8qnZMuHOQtP2HwgvnQ4SCbNIvlY7PmplSu+ZU6FxyUpZZqbCOLhmJNPGaC1YTuRJAB47V5hq+nfvCjFcaw5PJUl168RrS8H0Bm+9jN5HgtJeFE65KQNQFbybvvof3C5dhbjgD5KR6CQaZeJ8eoRknKp/iIZsoT+HSu3Yn+jjuvsqe32lrxmP98DqVW2C3fhoecVgyrmdx9aM6R47YJzAFDLsw5uwNdHOXnYGuRVkXVFsdKjzxFW8aNuK7ZyrIL7Bc/MCFYGfoT45NSKsbbHhT4qOmeXXuEo8h2WJkbTEVvOQrzpCd9OYzZpcJgvknmcr6DxzAewVXlIjHuNbv94i1wAaSlq6x/ltQ4SO26Ga3qS3CDGztw0mpxpu9Al4jGal3/fcji7BHLE6N8aEvAtJE+bhA8s0zLGG8yAa3xifZbUB98XXCQkKjDc5kpLLFZGvhS/ixXcw+AeXGPOBRDsRh2JouUMoQdBVYJwzERXtEO+kaJELLkpqSnGSaA7WNVWR0QvvH9saVxJ7PQI08H7rPkGbxMguItYudvLa4NVg4lKFYGNS1goLKpzTmK96cU+9vjmegt5uMVH7ops0IyPkd6Q273/sKpXkhTNw462ZAJk8k+icN6X7hjemn64AgZVQdWuNLbV0dGhxDufg7Yebkt8tSc77r+oSU=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mYgzXQlEhkJi7WaCCUXlSEO7a/4wsHGvbXE2cffBlNpsjx2Yk1fQYP4cUuMnZaWfoHnkT1ZCS8tbgngAPOagRuO9b5t9U2kWlrSmsEhI5Qun8McPQvUb2F5/cmsfm9lwDuTsYBmvePDOIADjgA3oOoHJOPYOHYQDbfGb86Nl97oby+QdatD5PcPaYaDCY5oa/sxhmMOzBiIPTvjX9g/2UUksR+PMP1Fz72b6llqCUbbC7Roz5T5wQWhTN39feAeobu0buRfSFUln7IlrL2LsXpTPFahQycKytuwVl7Mnawuxop8K3kY5jdt56zyYXmWp/IUfvlYFdYkgY5+MDga2dlqMQAHudAi/ZVWNzY8MCpDZAZkSaD14E1bnIPlQ+JW2WP7xspunziAsOXUqbU7YaITQNyeCMaAf9B9S8HUJdCL1kHgxTjV6E0dobg+Phbs7
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:31:50.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b587339-6da1-4a05-766d-08deaccb7cba
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6099

Bartlett Lake shares the same HWP-to-PERF_CTL scaling factor as Alder
Lake / Raptor Lake P-cores.  Add Bartlett Lake to
intel_hybrid_scaling_factor[] with HYBRID_SCALING_FACTOR_ADL so HWP
performance levels map to the correct CPU frequencies.

Per the Intel datasheet [1], the Intel Core 9 273PE specifies:

  Performance-cores:                                 12
  Efficient-cores:                                   0
  Max Turbo Frequency:                               5.7 GHz
  Intel Thermal Velocity Boost Frequency:            5.7 GHz
  Intel Turbo Boost Max Technology 3.0 Frequency:    5.6 GHz
  Performance-core Max Turbo Frequency:              5.4 GHz
  Performance-core Base Frequency:                   2.3 GHz

Because this CPU has no E-cores and does not report
X86_FEATURE_HYBRID_CPU, hwp_get_cpu_scaling() returns 100000 (the
default core scaling).  In intel_pstate_get_cpu_pstates(), the
condition cpu->pstate.scaling == perf_ctl_scaling then takes the
early path that simply multiplies HWP performance levels by 100000,
producing cpuinfo_max_freq values that exceed the documented Max
Turbo Frequency:

  intel_pstate: CPU0: PERF_CTL turbo = 57
  intel_pstate: CPU0: HWP_CAP guaranteed = 30
  intel_pstate: CPU0: HWP_CAP highest = 70
  intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
  ...
  intel_pstate: CPU12: HWP_CAP highest = 73
  intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000

With this patch, the registered HYBRID_SCALING_FACTOR_ADL (78741) is
used:

  intel_pstate: hybrid scaling factor: 78741
  intel_pstate: CPU0: PERF_CTL turbo = 57
  intel_pstate: CPU0: HWP_CAP guaranteed = 30
  intel_pstate: CPU0: HWP_CAP highest = 70
  intel_pstate: CPU0: HWP-to-frequency scaling factor: 78741
  intel_pstate: set_policy cpuinfo.max 5500000 policy->max 5500000
  ...
  intel_pstate: CPU12: HWP_CAP highest = 73
  intel_pstate: CPU12: HWP-to-frequency scaling factor: 78741
  intel_pstate: set_policy cpuinfo.max 5700000 policy->max 5700000

The reported cpuinfo_max_freq (5.5/5.7 GHz) now matches the
datasheet's Max Turbo Frequency.

[1] https://www.intel.com/content/www/us/en/products/sku/245717/intel-core-9-processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d39592e86570..82e82a70cacb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3737,6 +3737,7 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
 	{}
-- 
2.43.0

