Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794668627;
	b=vhwn9oR3bYlOGHzNIJOuhvAZe0a6peHq7xUTXLELtVr0A9TycgRVJoH/L7PP6x1EbPc6
	 An0fBajaAV6MhP4yyeetjyFagiI67NRaVDX6I2YAO6sv9VGiqBbu2snm2cd10T02S4NFb
	 Mf+Kj3QuMnirIcBgVI/EMW+A2QfOh8zUlQvGR91EjCIdcoLB+jDK1JAlmpAAli/Lj3whg
	 lXd6XhV7CS87Fxd+MOpzNtm4eSJfEmlPDfcf81j4ALxZgXPVb906gA/2oBXh00sXZZLis
	 7MzmplbfIwB2OUccWKO3T1IV0VKr47Gaxqolxb+BvZE7K3l6mF63zVZEF5cGppp60iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668627;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=AlklyVtpu5Zd3xICdxA3Wf1XBRG36JoDlBlNWzG/4ag=;
	b=cyxrRCSuHIT9RUkR0mQdBOLtHHm0aL3T4TtNWmEcEeL5bhuzaHZ/kImUj5PjdX8rfN+J
	 8j7WxOIRUa2RBrkSUParkYhDbqwCKD1gkSF4odNi+P9O8NXkmx3Y7wcGEc1Xax9Eont0q
	 QKZTyEAzIA4oTCVBIcppfmrQAzEgGo0fKJmGWMaVY24YiW8+5lFb9sQoEO363La8cQ4Mb
	 O0D5s28VYqheeursjPqreEtf5KJcBE7p6cQtelpTdw0AaIOUgBrr0Mp/HNGSEqxVTa6kD
	 FwsZvy2ydGLMmKuhoD51aa5SajwCgPGFJ7myzRfEOuGL/s69zIaeSs7C3LD2SzYTefQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="l6WfO8x/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.33
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF3606A8AA;
	Sat, 14 Nov 2026 15:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2AF3606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l6WfO8x/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICXicFh6yZ++9eiJtycYQ84LjwZy7fdXLVqIWdcHqPDFzUdd/TmtH9SB04F9pYAmnSzZaSimbATolBMLYxLnsRwjky4rIXatRIukSdrPkqmM0MzbP5nlZ4slDEx205pYe502zGi3bJjmCCl5PNP1/p36lZrCoKIyeTC+e2PLHBJ6/GqmZHquHAzjlDPzB4FqchY/OOYzvmrnXKiJRF3x44MsS7OfcFKBmkIEUD4SmDLtS/XdnFFVMI96vogVHRXWdbPoJQQWvSOhlrgp3D96eM5F1HpsZlsMl5HioGroFyFBZQ3DsOfFbWF3g+FNlpMW89aeoBoYNZvMRAMFEn5Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlklyVtpu5Zd3xICdxA3Wf1XBRG36JoDlBlNWzG/4ag=;
 b=PdlzYLSrzkA+z7T4wk7eKQlJzjoP3BujNIbrsRG6S0m9srAE+F4J79n36ANiDa9yaOxVhAAbJLOCW12J4oIAYALR/5PVD0C7XyNJ9F8acDh26IuTj9MtugmOT3jdiRdwGQJzRiac2JjJ8EM3QsITgDowY1mUQ/pxMdZBxm4Zsnqei920ifG95v/dHy82sKYgiDVYii2TdeisK2bg+z3IL4As5IrqivpfFprJ7baLhh+Ecl67ciAOmpdOMPMs7rxULCHR/PxHBsW+hSlLH6mGKBosaDODu8v8AmDM/GS+SFOX/JEzEnpOPVVOwN+vVbjjYay/1vzr356p/KF2DVTE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlklyVtpu5Zd3xICdxA3Wf1XBRG36JoDlBlNWzG/4ag=;
 b=l6WfO8x/GUKFnSFU6G2K7No22sD16g45rGTAY2mXlIksOL8DvvWYaJNtRcL7Kdw1cMhZHHl3DLEeX4+sUwIyc3HofOWfpp5Xjm0oMgAUfg/4YIZbhhuKY5oLLfCnPXJ2KIUrEkc4Cv30/dh1mMaYkzje3yvSfcrhtcxQje4rVVY=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by DS0PR12MB999105.namprd12.prod.outlook.com (2603:10b6:8:301::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 15:03:41 +0000
Received: from SJ1PEPF000037A4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::89) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Sat, 14
 Nov 2026 15:03:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A4.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 14 Nov 2026 15:03:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 14 Nov
 2026 09:03:37 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [PATCH 2/2] platform/x86/amd: hfi: Stand down when amd-pstate CAS is active
Date: Sat, 14 Nov 2026 20:33:10 +0530
Message-ID: <20261114150310.1377654-3-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114150310.1377654-1-Vishal.Badole@amd.com>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A4:EE_|DS0PR12MB999105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4590dd11-22a4-442a-582f-08df4260786a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|921020|10067099003|11063799006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|56012099006|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BjVFgzwoJcIJT2WdV/TEblhCsch7xXy8xpyZVJ3jxNzbIL7+nRos1o5WvTAvODp+1vXcAUp3jvYYjlRFMzfYHOnUX0InLHdEQONpoEPJqvhEebr/UbwWeqrNLC6u/Bi0FL+MMQJFULmHEwGZyju9ne6B+WtCGOglp7dsEgTtwUk+u8kci49HcOBNp2qoBBJTeAXjUT2YtPU/7/kP1q86mfwJ8/iJNPIgkNWbrwEKq0T9bR1VNYTfiYMpL27aItFP3QARfY78DVX1rZseRIRZuBSLUcZ5QXITzaevXbjs8Iyyss3ytg14k47dokSYiyQFYB+LRBQMWbcIg2d4fSXXSutNkjF15AxpTSAnL9kPNDyQG6rkPePtUEAMpbcgbtBePA13KkRSgv8GY7Q6bnaadtgEuP7XZa8o//GsfX+nO7iDchpCyOV3t1Rxy4dVLz6hMyvSvgEKabAKmseCH674NRUgnJKeKeBNeRXtN1Vj5QwA8ZqIz0oFlC+LcS+QC67sx4m0inUh0TFxQS3kTLqKBYIPMPElqujnB3wtkXwk01Yo6B7VfZYRjuC94r8aTRAf4x5ip8Zjz3Ow5Zudt+EDiDHuFjZIpHgSpQBiDCESk8Bme4O0qNlAxA78eetlzRqE1pouE2SKctLqnftyuSYvzGIPGjGMsmRuPYglknVtdvuMv0iaHFUODvmMzEMNsVHjscsbWq1sDeZO14vGu0GEDZLDA4dKZm6EenMnq388zFKD+1o9+HT0p7LnHFhK7a+K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(921020)(10067099003)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L0FZC9FuhLXe4UQcEOAfAklsiLYD0T22qhctfu5/xJ44TvxHhkqX7mzU4DXwrq6E/9gXejQC64drly7FnBebg+elnQsG4EL1gVvA4LiQgxbUjGrmlVhuCzsEHjhIn2oNr/5szM0l72Q5m/GD9g8o/54KjK1iuFGMK97MdHshRLqsqlc01ddGVLhN17dWTeJ5NkIYc02WGPEsKHXSObyPx9KEv6vrL8PRKKsn/DXytjQfQUfDuBEnpP5V5e/dH114eXMPCbbbWLNBf6sGqFOwvn/tFnQiRTlh/Fq5l/QD83aHunduuoSr1GCdn3MswMfrFUUJe2BiSOuNxB7VfSUl+sTyYQwrQ4K24DnTbe0jWox2cCDF44+pa0lOJ9JbAQZkWOYe4kT8aigy9i1YJXDVuDsr3zAKdl1Tl5nt/qfp87ZsX22qTttLNrVTvCrQ5uGd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 15:03:41.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4590dd11-22a4-442a-582f-08df4260786a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999105

From: Krishnamoorthi M <krishnamoorthi.m@amd.com>

When amd-pstate CAS is active, it takes ownership of per-CPU capacity
values that the scheduler uses to distinguish performance and efficiency
cores. amd-hfi manages the same scheduler state through its ranking
mechanism. Running both simultaneously would cause them to overwrite
each other's settings, leading to unpredictable task placement on hybrid
platforms.

Avoid loading amd-hfi if CAS is enabled.

Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 86a7f4332c35..b6878614e2bc 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -29,6 +29,8 @@
 
 #include <asm/cpu_device_id.h>
 
+#include <linux/amd-pstate.h>
+
 #include <acpi/pcc.h>
 #include <acpi/cppc_acpi.h>
 
@@ -536,6 +538,12 @@ static int __init amd_hfi_init(void)
 	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
 		return -ENODEV;
 
+	/* amd-pstate CAS owns heterogeneous core scheduling when enabled. */
+	if (amd_pstate_cas_active()) {
+		pr_debug("amd-pstate CAS is active, not loading amd-hfi\n");
+		return -ENODEV;
+	}
+
 	ret = platform_driver_register(&amd_hfi_driver);
 	if (ret)
 		pr_err("failed to register HFI driver\n");
-- 
2.34.1

