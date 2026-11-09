Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91B60A2611;
	Mon,  9 Nov 2026 19:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D91B60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nam3Uigm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3V+BP8DhhWgrowF2folOvHyVKqrUnTab+ezcV/UpixjvPkiSGYpiBTfKf0ZszWio0O+VDNLmh4m8kaGdhURzRouvDbO5qRnOHll/gjlcwVa1sFNKZzGTgSs/4QCcojX5gQvjcoHLzT/A7bWvTS36+lcXZBguSaCVaEMcZvsfk01AxzNe44+oDPy5eWd9bN8naiDl0Yv6nyx3/V1pGvL1iMin6/OP7bqkzNIztJO39c/sTIhQWMyP8d1Ixd6Di0eC0BewoGg7G8/539KsS6DEnjn+vITLgjN6MPCiS8wPMQrHbTAyCIRiXJArbsD++Rr1k2hEzteN566Ace+F1x6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j4CyZCFeSqK+rjLOhAIJaMjeCiDp9cx9LbMBfSl8Zk=;
 b=VIKh0R/XAx10V/xR0dd7ojKkZSMGC6dBVQjjjhnFV5JBC60/lqthw7ZOku3lh0dsm16AYQUFrPWbgXwcEnK5M2IYfOjC/0BfzEUYw+GFIqtbLWwPMwO0+52enxHEbSdiaIsSFifaxamHLrzOEmvDqurgNAER2SUGmDrE3uApJNYW5T1oxK5rZLLXN8VdfN2UAJ4Z1qqIqH+Lh6S56molMMjGfwXYbwjEUUfOnuhAMwqhrFx2AOTa1erA5NwwCw9QA9qD4RET7YDWcm8R2/Stn4YnvKknJLmhDvece173OKinE42WIvGyYR3+d3iU8JGgZAmemHtHR2coBiCWTtAVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j4CyZCFeSqK+rjLOhAIJaMjeCiDp9cx9LbMBfSl8Zk=;
 b=nam3UigmhjjDCnVjwW2eVEAAXNMq7K14Hh2cTzNfF9sVut9VuyJudB6C0kXjHaCnUeFhmaBoryfaQDFkyr9bWctr8ewEDMWCl8eWpazWKXfI1JtiiqHdNByjCBRWT/EPYHp2F7ZvU89R+wTuEhMppd1DPemtBuALrUK9oMzD9VXtCC9aQniOXBgtCUPEhxpTrvN58VR2qGUnsbAgHKwt2ku7nhdEcfSWeym1bjSKiOWZfTeCs/3KcUMTCoczo8qqdsF15qRU+mDiUbWYW7Um9dcOi45YBcurxdn+BAUnhbUE4Bm1nfbeUhAjwcL6/0LKicy75Xfl6PFL+uqRZrHTkA==
Received: from PH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:5::22)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 19:54:57 +0000
Received: from CY7PEPF000000EC.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::97) by PH0PR07CA0017.outlook.office365.com
 (2603:10b6:510:5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 19:54:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY7PEPF000000EC.mail.protection.outlook.com (10.167.247.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 19:54:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:54:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:54:40 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 11:54:33 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v10 1/3] ACPI: CPPC: Add ospm_nominal_perf support
Date: Tue, 10 Nov 2026 01:23:58 +0530
Message-ID: <20261109195400.3600561-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109195400.3600561-1-sumitg@nvidia.com>
References: <20261109195400.3600561-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EC:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cf8f8b-2267-4600-1a34-08df3e9b54d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|921020|11063799006|56012099006|261102130727099003|261102123227099003|261022113327099003|261022075727099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	BfKFCN9v6h0APSeJac40gu+4RvJrBinScGqwxikkeRLlZwptv3KZY6X9Wc84mVRJhj7o85z8risX7DoXCWekGTJNvkO343u4ERZFVjjOzQsMZ42Y7qkJRL0qDH2Am3779BaioENM7UNNBAmNaVqFXdo7kvWyuf8SAHd/n8ETOCHCrKLHoMwWnJvruO1Hyl/XJF0StYO/WCnXkX5dpn9Sma9zNjclL9aFaf75VJ3R4KGsdZTtZT9n+AUNEHp6ebIIbuS/6Y+1Bb2dOC1mBXzZ/mJVBCbN2BzhZ29vdUwyxyNSPURZzvMre0tsQKYiTWFtzUjxvEvu3gqT0Gs0R5DZxVpJZO3OUwRxWvzKcu3EHRReFcz5pm/HffaBdlH+9+i5EpvvH6DHUOPVaJh8cbJX8bbcVjLy9cI2GAL8xMVcpkfbrIGhcQWSmm4WYtFAgfPHAXpGACsP5IXCQmfDB+C8X3eMAsFyqrdayZuHbd0yBX6C56HResOPTHgNnO/Y1Du96dbl6y979U041M7F7HWBGa1BTkn2caLIVcy6Ajbh5oXRW1PS3tX6r15pChSYVHeWeYyl4E3eErCMkNtRcq+OUyXja0m7DDThS3vHakOorvzMiN/ezY6weApZl7JXBs4Yj/csqFuoNXL+c+7dB9Yx9PLgTEtDDarBHwAe35D10cMy15pyuN1+iveOm8iXSNwjl7aj1eI0o9S62mc0lYpPt0BmGRWAUFMJRDdh3UTEfX9KscR6+YGueeSsS3G3fMY5
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261022113327099003)(261022075727099003)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lP+4JIBlZi5+V7sbDDgmNhq/RO9jJkn9eu5wWYjqCJvf02+jOhVUAR7iPjtJYrqvM4TZanUTcDYCB9EeYQc6Gd5eE/zuqfnSgDLdwBoVwEV1vVX5YVjlWvatqu++tjqktJ3/8ZqiJKAqKjwystUrQoIV914VM2uKaWIXKr8lYWnZuKcZJ0NbfMFhojsWbagBlG8tpLMQUH9L1yFFmJJw/xS6hVTncKUBEyIyOQ8SCK/xRN4w91Dry7aUk7KluZt6Q2KrY/BJBhsQKN41pT10r/HfBuS5jnJjOI0TWRjOfICM3NBjY/MSflckvsaEVwZr5B9WqYO3FQwermbsNfbZpNdMNkXb/jz5OMOWwfkyR5zHtYLYJZHWiRj3stkxZNW5oE1XbqKL6br3W5pJbzZBJv9Mn4DqFEjdQy1HR6lWvoh/TuyARuk1YHZOWuuvFXbA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:54:57.2348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf8f8b-2267-4600-1a34-08df3e9b54d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000EC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the nominal performance level at which the
platform may run. Unlike the read-only Nominal Performance register, it
is writable, so OSPM can ask for a nominal level below the
platform-reported one, which then becomes the boundary between boosted
and throttled operation.

Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
the value must lie in [Lowest Performance, Nominal Performance], which
the caller is responsible for validating.

Add cppc_ospm_nominal_perf_supported() to report whether the platform
implements the register as writable, since a write-only register cannot
be probed by reading it. It uses the same cpc_is_writable() test as the
setter, so support is never reported for a register that a write would
reject, and takes cpc_desc_lock while looking the descriptor up.

Add the register to the writable set that the SystemMemory overlap
validation uses, as the driver now writes it and can compete with
another control sharing an access unit.

If the register shares an access unit with Performance Limited, it is
not used, since a write could overwrite the status bits. The register
is write-only and its readback is undefined, so keep its range reserved
rather than dropping it. The validation then still rejects another
field that reads or rewrites these bits.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 56 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 10 +++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b7937aa565ba..11a9f9eb6b4a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
 	case AUTO_SEL_ENABLE:
 	case AUTO_ACT_WINDOW:
 	case ENERGY_PERF:
+	case OSPM_NOMINAL_PERF:
 		return true;
 	default:
 		return false;
@@ -1192,7 +1193,19 @@ static bool cpc_disable_new_sysmem_writer(struct cpc_desc *cpc_desc,
 
 	pr_warn_once("CPU%d: ignoring optional _CPC register %u sharing CPU%d Performance Limited access unit\n",
 		     cpc_desc->cpu_id, reg_idx, status_cpu);
+
+	/*
+	 * Keep a write-only range reserved. Its readback is undefined, so the
+	 * overlap checks must still reject another field that reads these bits
+	 * or writes them back through read-modify-write.
+	 */
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx)) {
+		reg->cpc_entry.read_unsupported = true;
+		reg->cpc_entry.write_unsupported = true;
+		return false;
+	}
 	cpc_disable_reg(cpc_desc, reg_idx);
+
 	return true;
 }
 
@@ -3229,6 +3242,49 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance conveys the desired nominal performance level
+ * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
+ * must lie within [Lowest Performance, Nominal Performance] and may be
+ * set independently of Minimum, Maximum and Desired performance. The
+ * caller is responsible for validating the range.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the platform does not implement the
+ * register as writable, or another negative error code.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
+/**
+ * cppc_ospm_nominal_perf_supported() - Check OSPM Nominal Performance support.
+ * @cpu: CPU to query.
+ *
+ * The OSPM Nominal Performance register is write-only, so its value
+ * cannot be read back. This only reports whether the platform implements
+ * it as a writable register.
+ *
+ * Context: Process context.
+ * Return: true if the register is supported, false otherwise.
+ */
+bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	struct cpc_desc *cpc_desc;
+
+	guard(mutex)(&cpc_desc_lock);
+	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return cpc_desc &&
+	       cpc_is_writable(&cpc_desc->cpc_regs[OSPM_NOMINAL_PERF]);
+}
+EXPORT_SYMBOL_GPL(cppc_ospm_nominal_perf_supported);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a5545fd3f8bd..2cec54b4d2e2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -195,6 +195,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
+extern bool cppc_ospm_nominal_perf_supported(int cpu);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, u64 *enable);
@@ -290,6 +292,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	return false;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

