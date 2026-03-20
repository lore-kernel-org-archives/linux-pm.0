Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366C3CA4B7;
	Fri, 20 Mar 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017861; cv=fail; b=VbkMivj69aDGvBQzlw0atE+VbVHe6ShZAgGKODA9CUmJL1TSKUif3PxntSDlWnIZ/PDgEKF/jE6pOdv5PhnIuJnqYTV5+LDgpmgWQ07gERS7WcZU4iV+pRgh+q5Kzok2CnKfcmYIdPbZ/ha1JRLi8RZ7uL1maGQX8OEPDevadLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017861; c=relaxed/simple;
	bh=hfPbQNBtoB6gv0lmiSZ7CFJ1/xvfTJQ0tThTxnAsQUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXHajuDhnIgfiCOsPNtz9TKw5iSymvcYXBcH0u2CypxP+i9KRAgWdY0H9gQimrssoXM87ADNj/P57xeXCkcK8hP0wDNqXYuvOdOMrmbV/lAfXf/LME3wJxFOOCb03Bunptwt2IK2jPjcLghRGBuvPHJsi0PIBY18Vc+6XcAqYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HEffFtyj; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HEffFtyj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgW0G/8By96n+MFnO+EpvpNotpm8kJ07bLjxgGSdG14YrE3f++weWPGzj6lkreYJpVEma/ffLxM9dwOTb1YA9I8NbnFjjc8XCwsXXoGfmz4GsnY2AcgdYzIS25coNkxmnxXjEJIluQmfkpSGTLFZDl2Ksxa/Zo+gPSzCIpAuIVYpP/CWdjvhTt6Zn8RN73VZSTESGvCVjscTv7M5g/5LqaHgp2N5PlwS2nla664g/fuJeDG3cwyCISXDiCtY3qnKnNPyJK+G5omvkTn4Cswqu+SIHhc4ALUMhhBAYtKsB4IUDvWLtn7oQou7Ze2y4Lw2LofdyndgRLOZstQe+3iR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIYVrDgRerlB3VTxwmJoEaEHtluVDh5az+26rLpT10k=;
 b=TlNfW4DywNXWjRcH4NPDDH53VwfwsYM5rDA0fO/s7coTSAfAkQZU5r/AA615J5vZh3M1sp+fGKd/+GqetLDTx34NcbCDeJncdFjGCDol/v6Z7mHN4w2cIsxfLLi3uIhqJwBr9R7RxHB8GtvZb5ti8q4tloR+RAqeNqU/iQIRaUEBK2Dt5JAXG69HU6tDvwCZgce4XjT5+si+BIkb4rNj2AX3Z4UkIof9FNw6YY2sZLeLleQjQoyAeRSV6YgC8zbAru64j/3N65LArDVHTSceQYJW7GIgoxBn+YkXo6rOYQNoq+rR0qxYY0ziWQi8hKFfDktEXRFS/oDIIX7LpkdzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIYVrDgRerlB3VTxwmJoEaEHtluVDh5az+26rLpT10k=;
 b=HEffFtyjFGPFfNgC/O5DRPYYyCrt8NLvy1GB6+6YabgOgx/n0rKp/9v43Legd5kanOybWWxFi6FmVTa6I0L5YfdKmRQRk0aogUxv8SrE0U0XnzxFX2W8Thd2a4rXt61swVLU/lLSDilRvlpn1iJaIpsrh0xOrOANfAqh7+KMkJc=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 14:44:13 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::5c) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:13 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:11 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 07/12] amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
Date: Fri, 20 Mar 2026 20:13:16 +0530
Message-ID: <20260320144321.18543-8-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a5006c-f58e-401f-98e3-08de868f27a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7+7faulgAjND0Dku6QTHcsx0S3hMX/1Nlyoxv/1Xl8Ca28SoXIEci92CIRFltayxm31j1SIM5nrcoDBZbeQ2c7g+7Ks3w27TWA6RTpRqcIe4S8pOIdID4VY4tXn0p7BsmW53iOUTeq/CBW2uO7NjSjLzSVjE4ngiIMvBDXXwLXbXQNKf04lWjdlvope+BC8WoJIKhhXP+NtPiUTlJJUlMC/AUs4dC7knFg0xWGSJFqCz9pUXH5TTbWjUXg1I4MWktg5e424tpvxhn586LAB+5/FTFvTyYcJ1vgpGAHzXVxYGqXBTVf7FgBwUUDGaWeHxu47HQxNIQwlOudYik/GHdbFVffUdywxz8rRa1N2d9DW7HY67+MtXbzyovnaPHJzdFbye/RfcEYacVjGRxDtQI4lyfnNf+ffJ5mPVFLQrGBgDvvuJ5mnxf2vbatN6EVxGILg3gYna8Ues+63fjJXvmUk1pB8RmOcDtquwTNzIgCoDSktTUt5WGlEMp7P5Aw9RMWQMDN9AgCfmVu7ylDy9R1RMawNJhFofjuTjtocVUxRv/SduiJqe0wgfmfEjdGI8mBxRm7LUJ2zX4TUz3xtu62fW+sj8iLJUrQz9bm4VSalYFFrTXkq/rc4nVqHTA7KzsPxHOu24NwEhdYceY1fOmj4IAM3C9H/BpG53wX8OQI4TJ0I4GBKLMnXTv94bTGpcMjHSMX5E0aoHiICFQgSBx/aWCoTwuT2LeaSJUFlQX98pDitnpiGU0GQF4vRoqWTy17YwfjUdTnC/VfHqGGbDCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9GPj6D7l09ONdoZrUVZWbH9jzxBYxecHKOfmKP2PwAhRi/ES/YBqi+vrQEtH2sqfryT1qBzi5l624xZ7pTNI7viuosy9Vf+K0nNwvboYsJpg1Lwi4ooJwcTG39sGKxYd4SlQJU/LFdPl2DFZJnCpDpE1ILrFDiVzk8R8YRqRzJkgt/byWAK19Z69Bqm6nhLjg/0p+WBKj5+NdmUi2O8OmCzAKcqAsokI6YqGLILGlHsS6Bq43/kjkjf+JXU98uBQ5ywi5+ngBDbi1vC0VZZmYMJycOSbzz26cCLJBe0fjo6QA/K1JiCOkiQ5QN8De0yFrfElkyhzIg9vHN9yFa0pmIjuSttAkRHH/U1HLfHtfBPKK5gT8iBlNUsCEWGtlHYkAY59KwDXD/bviZGhyIvOfnWpTm7fgaX3zMu8hiCu5b2S74Nj0aqLhn7hA00Uu55t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:13.6351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a5006c-f58e-401f-98e3-08de868f27a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

Introduce a new tracepoint trace_amd_pstate_cppc_req2() to track
updates to MSR_AMD_CPPC_REQ2.

Invoke this while changing the Floor Perf.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h | 35 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       | 14 +++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 32e1bdc588c5..91fa073b2be4 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -133,6 +133,41 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		 )
 );
 
+TRACE_EVENT(amd_pstate_cppc_req2,
+
+	TP_PROTO(unsigned int cpu_id,
+		 u8 floor_perf,
+		 bool changed,
+		 int err_code
+		 ),
+
+	TP_ARGS(cpu_id,
+		floor_perf,
+		changed,
+		err_code),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu_id)
+		__field(u8, floor_perf)
+		__field(bool, changed)
+		__field(int, err_code)
+		),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->floor_perf = floor_perf;
+		__entry->changed = changed;
+		__entry->err_code = err_code;
+		),
+
+	TP_printk("cpu%u: floor_perf=%u, changed=%u (error = %d)",
+		  __entry->cpu_id,
+		  __entry->floor_perf,
+		  __entry->changed,
+		  __entry->err_code
+		 )
+);
+
 #endif /* _AMD_PSTATE_TRACE_H */
 
 /* This part must be outside protection */
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a068c4457a8f..5eae74a67aeb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -333,6 +333,7 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value, prev;
+	bool changed;
 	int ret;
 
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
@@ -341,17 +342,24 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
 	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
 
-	if (value == prev)
-		return 0;
+	changed = value != prev;
+	if (!changed) {
+		ret = 0;
+		goto out_trace;
+	}
 
 	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
 	if (ret) {
+		changed = false;
 		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
-		return ret;
+		goto out_trace;
 	}
 
 	WRITE_ONCE(cpudata->cppc_req2_cached, value);
 
+out_trace:
+	if (trace_amd_pstate_cppc_req2_enabled())
+		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
 	return ret;
 }
 
-- 
2.34.1

