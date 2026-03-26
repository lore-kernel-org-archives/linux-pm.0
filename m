Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018A3F788D;
	Thu, 26 Mar 2026 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525728; cv=fail; b=QqjGxx+helyohI9q6QcA62pBpxldbCmdHAAqjnkHbuxSRP52zRhX6YsaJaw/Nv+RgdJ4gMKfLF1yH2JjGQdHq5UMMhAMHZwT8ZL0HCv7af02cFaLVnaLGU4rqRI+izdBPvlUdFzyPGP52JjTjQVlE9rPFIyyvKQSJlve7tXsKpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525728; c=relaxed/simple;
	bh=hfPbQNBtoB6gv0lmiSZ7CFJ1/xvfTJQ0tThTxnAsQUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIFm/Mnk3KG5hY+ciYMs3bUXETnxO5ALkcS+2K2cWRyr6fxls8ti1YG0nEchDVs6Kpxg0cEdvDM/dZzLwicTx/WNHPuJn52fpLBT/1+EkLsrUqu82B9oH9Fsf66MpQ9pqqRab/KdV5ST3Km7Qgcr776/j6YxIkOShZhxENrxo7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ajvDxSH6; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ajvDxSH6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQGX/XSDupzLL30CswR/91Rjv2LS7vUIsiSWLKguhFy5/379yjyUzD0r5AYastmX6P4xUxUdP69g68DBc82rgbqRmltQzAIYjn6h2b8ADOcxMIPnthaVlYK5yavrI6sWiO8O1nqIRKVUYERePGmefOpboTpD7Rj1Mn0oTa0eVyQwRK+gzneDZSbfZFoL/crsw4EEItejURcC67pJAagVbiXSehhy3hYxaFPrf6Q64IrgDvPt1F1MxdXm0wkHebtoTe3weo1Inqs5B/FAdkBTJ5Vh7guYhUSLA99qWub77wzjmLUDtPjiFdENwma5+kEdLFEV5wGGMKhMFtXfweUzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIYVrDgRerlB3VTxwmJoEaEHtluVDh5az+26rLpT10k=;
 b=cbjgRXYrErw57vXxiVyEDEbxv802dWpKRDZhZWOj8JJ9oGk+1I66M2oHcuclDfBixow/EtGDx44iLHt8DhB3Q/KirjwGwvdwiDi0waXJw0gyiQ2hd4/t1MdXR3oY5XJvT9QiI2GI8FFZEsaxJABg6m8uuZQ+jMGq9A39lXRmpt4u5ER7wFBouLiGFuQTGd+sL+gNGDTB1VCegShPLg1qL9Vozle0YHdgYEr2AIMP8GfjQHhpNGYHSbYyREPdZiCpmx+YA1+oLVnNJeZ8cOyqMi1UDNajnrf/zqgYzv3p3iFKjIM4dLIkGXITNtInkdimZnb+dUYx6qH8K8+YGxvJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIYVrDgRerlB3VTxwmJoEaEHtluVDh5az+26rLpT10k=;
 b=ajvDxSH6ZG901jsf/Dt1d/O9sWLHaW8zW+JDhx5tP5UxJ4qjCh5vDYJfDNVWL0rO2xNKnOCd1bUAqmh9XSp8OH9lFUOLO1xhGn7XANhvejY3TEVkUdubZR6XlfLEutC+8iSLli/UgT2/QBR+1mNd7AxORFFmr7rgYE7UQ72VwIs=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 11:48:37 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::2a) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:37 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:34 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v4 07/12] amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
Date: Thu, 26 Mar 2026 17:17:51 +0530
Message-ID: <20260326114756.20374-8-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: da75086e-d67d-4814-6379-08de8b2d9ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qVf5imGnqyxZ/2KeTr2LaX/xevW8oiEdG5nOngbikMuRH2AKAjGJsAcQc8Lo8T4eaVXaSGK0CM0neTxHS7pVqw8NFwM5JrPqex2fL8gNPGZ8yeIcBHGVyvRDiVio+fYUYlbaCM5N6QubyM1Mxql+7HO49fEF80rlcHhHCcRVpTnuLSRhryvL1akG5LxNdZQZxMGaHLxBr81GeFRRq8zrREh2HB6+gHP23hUoI9aDfpnYuOrJ4Oz91p4sr+Yg54uxx2exl1pV82MdZaFLKPNma05gt5vgOZffwbNGVxUUDkbr7Cp1mLeiAU1TkxGQ4k0qJejr97zH2keDxKn8GvYZ5vjBHmW91G6cE9halV/Cqbg+o67yFO4qx0Ie9Cp3v34j3wMXfJg+OOUckaZyPkD0a5Ujejv7IBN9V+8GR/UvX+G4nOJEdQCuL5hb6gsU/be0lrQV+bo4G1irxVqmwF4WSWA74msM5jp/hF/zuVkE5eRMVQRi/sxzEWc8zq/cBNe8NwCA2W2rL6tWFIUxsTMVgkF4i7sHoDjEGRQIBy1itp/ymha7sDwWIrThqX4ADHyKiK90PYB9uo459WVc1oA0zZOXdfrrWUS2tJ+y7qKNUJVGHeefWUt2Fl9vyb05onAo/ywEAPQ0+ydOcadUdmdepfPDN3YPd6X3TbNCdP6bH2aVfakK2SIwhkYCezPdskK7+rUTmNH9ugfX5U+Ztla5JGgHAP/u8IdIGIU4mRDwHMlYCRhSzXXxDVGPG0cQQwbxJczCVOzqZs9aMKMpEp2Emg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JxVGkARcySNxeuAtMBYWc4EtdEyIkpzcgoD6wG7JdkY+h8SI6XNIiJ6yZVT9rCubUtVThzbTVxF5yVIyPC9qVV5V7NcdArGN+Di9kAofU56VhNRfiYAQeKSgdqYyad6hXcECk/Y+d0Ca2N9uL78gDah2xBCcr7eMoxjd/rBYU3sh+SFcC0i8yNSM8tI2a6a0Un/PElI+ymZdL1LanRce64wEJfKC97Ae4EKh8AXf1xk7OCR9MHJKg86wLyDWcoraS97X6L6AbwB/wuA/DicJYifq13e6IsQTXmLCY+SLbQSrWdcUk7lf4BPly4I3tyguclfvunHDvBlcvH2ncl3Vv2sI8tFOHqtLrHR9NNdX49KMaWtjR6Vj/RBByOYqBUwjO0yssxO2nNpGIR/BI8EzGB61zCQjTfGIdMwWxs4kyUqJFsbEAnjACgWZJRFyuz0T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:37.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da75086e-d67d-4814-6379-08de8b2d9ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

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

