Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930637;
	b=OIQvs/MIaUlQMsEcIbD24HoMxM6DYZqk8+Vz6VjfYig1EV3fP8xbzKaoH0c5GNPitnB8
	 /Zcg4TxpTUw/rLkO2DTj3tzzcoK43pqvea2nTiWAZGErll4ckJOqjmSNiMiFkAWnxholh
	 v/ty0TySxrnf9D+6LV/PqQE2mP9IzwaT9OzoAz6KelnyxvMJdbCcW3NqvLFqIbaA2AMjO
	 xq0YD4/GYaQ2LSiS7Ki1E0ST0R3SxS9EQVFFjCTHRKk/iVZt6m5v8EK01A9yUWQ8ke6Oq
	 26O4+8gIMicW/DSrurksoOSGHf8uFOhbrDX2RHgDzBmlzolD1B8aHX2KVDqUWxd7IPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930637;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=yx+GyU3hUbt0zRdMTHoTKm/VRLX7PWXd/tDYTlSxb3E=;
	b=fDwuPfCcdyCmtt6w1g7UMbCVamH1ba5hXWZg8fgJ8QJj7QpuvsFVM9a0cSMzJDeAv8Ew
	 XvjEfEjrwKAmvk5bthxcDiB4YmOPtQhBfBCPqO6B+SGJB3SN1hGyrPGQs9zkqpeAREylI
	 UXL0q3bUSHyH7rhRKAbVfHCsFIvxLe/hRRDS+WEPKSoNYP97StAvxJEUPAtg/S2Oq8hI1
	 zIff7+TTD7OVTe83fFfOzf7NsrtYI7iBy/2GI90Hvj2ah1rATnR4ZJbVqwjlvVjZwHt7A
	 90i+F8CYHVvNWJWjlUeY3gOL8d+Tb3IUwNkOMB820wyCppmaig5TV+aB5ZEqc6CCycQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GIZwLFhU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.34
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5D606A32F;
	Tue, 17 Nov 2026 15:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E5D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GIZwLFhU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEzFZ+9BDgFtzdmlEU76RsC9i34y/hh6mqc9wAtbX2bfdYh6d+cRKorcXdE1V9R+dGE2VSJZ16Kbb0NTXpNeHMYeS3my623ulEl/KUMwnZBmM3OjkrIjieQA1uG2vFlzal3/2Us+HJVt5eU2h4EuuDZKwSMCw/Knm2QS0Yf5/zKZQ7ehYNI1XWqxd0ia+HQp9gUhwU80gm3JuEVzURqjbE3ssaBryEz1FrSh99SMopcfhO9eWgAx1r3CfURWmraVvCuB44DNjBXDhe7Ab3fFBpSnjaw4zeUoRJyyR1Nc9uqRguyQAQ2EB38SL+f4a7YeUg/nqr8nXTOBEbTZ21YGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx+GyU3hUbt0zRdMTHoTKm/VRLX7PWXd/tDYTlSxb3E=;
 b=SeMXClQ4N/l57XTIoW34A8N5Np1oXCZj2ApYxMKV6YAe+Lk6CxYcB1mwcm3OOwllzqqCBfjkQWKOkMYp6PuXikSUSAG+nbj9GUOnFwHXlgd+QdgbXJgFkUj2LJ3Sj8D9nHRLNKHTD/Q8ts1tkDSEbz2j7b19gIos/EkWgvwP0mL0KtjA7RUlnj0oG0bBbDPobObBW/YUyrooBuHPZjgBNdwyo4SBK7DJw40qLQ+0V9W4Qpn6R9UCjxKh2HaqJzMow2w3lUhFlwQoP0eGFR4tEiJ5uhGe0sG3Rf1QRi7qs6EsHVZ+BIP59C+a9snDbLLc8V+d3q4tT5zR/IcnV82NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx+GyU3hUbt0zRdMTHoTKm/VRLX7PWXd/tDYTlSxb3E=;
 b=GIZwLFhUQupI8oZgDpqKG768s7ASNuD48bYnkbJgH+xHJ/6gTNumuqDQminqi+F441TTu8OPCP+buR59PnE2BMNuN8+zPDx+Ft5tZHC7xmtVY6XCRTxumIPuaWxtFAZGv6vk8w55txafqc7ftlNGuSHZDwzqJPloxUohKdLG7hy7b8rVuVWq8xbwzjps+n6+x4yTf2q6qZqiXYa1hPQFhCZc7uJmAXotj46tedH0kViQPpLF87Mp4+Kr4l/jl/xWxzTxJN8M2mcSf0TKjNJj1oBDlb56O5nC5c0MVgxeWyDFKi5kCE00kTkeNmNHf1/d2q0xv925W6ann0fgdLK/pw==
Received: from MW4PR04CA0292.namprd04.prod.outlook.com (2603:10b6:303:89::27)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:50:27 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::1a) by MW4PR04CA0292.outlook.office365.com
 (2603:10b6:303:89::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 15:50:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:50:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:06 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:02 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 1/9] cpufreq: tegra194: move MPIDR read to CPU hotplug callback
Date: Tue, 17 Nov 2026 21:19:46 +0530
Message-ID: <20261117154954.625126-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117154954.625126-1-sumitg@nvidia.com>
References: <20261117154954.625126-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 135a3d63-415c-47dc-0049-08df44c2801d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|18002099003|22082099003|261009221227099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MXe1VNz4fF4RzlWJNbYd4XaBsxZMSf4naUzd4vKD5aSWMaSZQUzUs8OpxIfGxIlNdsP0sxkuwXM+NtLLLjLStgEoL3MMG/5mMQACSJOUfHDR3rJJSNvQX+7XPHvZn0OtPJHSvIpe8LQsKSPNoUegb0PtwFIaupuZEOyQMcEiPpbK3a4pXBTxBLEF+B5Gu+JMUxxllfALIp6REuTtGgE6WjoyTYaOzgiF3Pucj0K/lThbQb4vNUytMsr8V9vshqLrpks3TeUHylvvOBLu8uxPZdNPeycFy0uWDei2sxGnyrKSwsnQijDrPRhWD4MOpijuY2DNty+7AR6/YuAPhZzMkQ5/Qhm2ywWfJ/YrmEzGhTB66nK0/AfQAbOK/OEBz3OlOFoYsesamX+hitCM+stdUt8+01wl6lC4IV2ggcAyImn4hVMYESWtB4jHcVhwW0C8q3ZHSc9inf2Mxl0EkxDOxlGD4KUpbCEtTpq8gO6w3kYNGRFxOOQQWmUelXhVCD75OwbAYw9solKzgX8T46ku2KZCt+0mKo1+UGcacvidJD4ns9Qg1E4G3PATQzYaoz25yTcf1lRFhAzcVfLNuah9kYDuPkKlNpQq92nwfmCO50X8bcxMkerqlGSVLqbiEXw0zQOvVfMtbT8mcrjlJSn584VXqHU++WZOfCDk2uZ6DKF3F1gw46M8eelNw++BfYfAwjtLMNTlLXNwhqz8TYIKKDEDJ8uDdvH57QHbrICQmZAxQohFg0nbSdYOuLdEfQ2+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OzsxM4jPhcNP8Bg+jErQPK06hIEc0VYR8GAozZVXHxCygDbINo800LNNdY5fSVrcLP7MiyJX1Kd5S4x6WRdEEUjpu1HjbW3rXqodXSlfH5vJqa/Kv8Apg5xm9AhGe5gowP43UVfgVNefvIc67TnRdt9vGjENlR67MygV3R/xE7kBviNdECUiyG1aqL4rLtWVnPu2IkKOLJuA+t42NYcKB8/jRqVYcPw3T2rH0qlcg0OgErNsW3xz/6W1HgqYGXdTf/e0M7gFPLmWBtHjL4dZycbykB64xGCfSwKBVyxKbOPOTuDlMbuk7qaPr1CrFgQqKT/jnrjnhRgpslJGgA5eUp39zGb+k4et/Dn16xbeqxCXiQnZoQQ4YdAaHjd1RVrtfCpJs9GZwQmfNcI7UzxKd49Z4oKlAyWG2ESrzenOyGW3++iDZS5JNliCmEzPyfLw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:50:27.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135a3d63-415c-47dc-0049-08df44c2801d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

At probe the driver reads the MPIDR of every possible CPU with
smp_call_function_single(). For a CPU that is offline at boot, the call
fails and the error is ignored. The CPU's core and cluster IDs then come
from an uninitialised variable, and the driver later uses them to pick
the CPU's registers.

Read MPIDR from a CPU hotplug online callback instead. The callback runs
on the target CPU and caches its core and cluster IDs and scratch
register address. This covers CPUs online at probe and CPUs onlined
later. get_cpu_cluster_id() then needs no CPU argument.

Probe now checks nr_cpu_ids against the SoC data, instead of checking
each CPU. A CPU whose MPIDR does not fit the SoC data gets a warning and
no scratch register address. The driver reports no frequency for it.

Fixes: 6b121b4cf7e1 ("cpufreq: tegra194: save CPU data to avoid repeated SMP calls")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 128 ++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 8599914f2194..8d47fa746142 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -5,6 +5,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -13,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
-#include <asm/smp_plat.h>
+#include <asm/cputype.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -59,7 +60,7 @@ struct read_counters_work {
 struct tegra_cpufreq_ops {
 	void (*read_counters)(struct tegra_cpu_ctr *c);
 	void (*set_cpu_ndiv)(struct cpufreq_policy *policy, u64 ndiv);
-	void (*get_cpu_cluster_id)(u32 cpu, u32 *cpuid, u32 *clusterid);
+	void (*get_cpu_cluster_id)(u32 *cpuid, u32 *clusterid);
 	int (*get_cpu_ndiv)(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv);
 };
 
@@ -77,6 +78,8 @@ struct tegra194_cpufreq_data {
 	const struct tegra_cpufreq_soc *soc;
 	bool icc_dram_bw_scaling;
 	struct tegra_cpu_data *cpu_data;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node cpuhp_node;
 };
 
 static struct workqueue_struct *read_counters_wq;
@@ -109,11 +112,11 @@ static void tegra_get_cpu_mpidr(void *mpidr)
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 }
 
-static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+static void tegra234_get_cpu_cluster_id(u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
@@ -121,11 +124,45 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 }
 
+static int tegra_cpufreq_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct tegra194_cpufreq_data *data;
+	u32 cpuid, clusterid;
+
+	data = hlist_entry(node, struct tegra194_cpufreq_data, cpuhp_node);
+
+	data->soc->ops->get_cpu_cluster_id(&cpuid, &clusterid);
+
+	data->cpu_data[cpu].cpuid = cpuid;
+	data->cpu_data[cpu].clusterid = clusterid;
+
+	if (clusterid >= data->soc->num_clusters ||
+	    cpuid >= data->soc->maxcpus_per_cluster) {
+		pr_warn_once("cpufreq: cpu%u: bad MPIDR (cluster %u, core %u)\n",
+			     cpu, clusterid, cpuid);
+		return 0;
+	}
+
+	/* Derive per-core register address only when ccplex MMIO is mapped. */
+	if (data->regs) {
+		u32 index = clusterid * data->soc->maxcpus_per_cluster + cpuid;
+
+		data->cpu_data[cpu].freq_core_reg =
+			SCRATCH_FREQ_CORE_REG(data, index);
+	}
+
+	return 0;
+}
+
 static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
+
+	if (!reg)
+		return -EINVAL;
 
-	*ndiv = readl(data->cpu_data[cpu].freq_core_reg) & NDIV_MASK;
+	*ndiv = readl(reg) & NDIV_MASK;
 
 	return 0;
 }
@@ -135,8 +172,12 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	u32 cpu;
 
-	for_each_cpu(cpu, policy->cpus)
-		writel(ndiv, data->cpu_data[cpu].freq_core_reg);
+	for_each_cpu(cpu, policy->cpus) {
+		void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
+
+		if (reg)
+			writel(ndiv, reg);
+	}
 }
 
 /*
@@ -204,11 +245,11 @@ static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.refclk_delta_min = 16000,
 };
 
-static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+static void tegra194_get_cpu_cluster_id(u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
@@ -386,16 +427,21 @@ static unsigned int tegra194_get_speed(u32 cpu)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	u32 clusterid = data->cpu_data[cpu].clusterid;
+	u32 cpuid = data->cpu_data[cpu].cpuid;
 	struct cpufreq_frequency_table *pos;
 	unsigned int rate;
 	u64 ndiv;
 	int ret;
 
+	if (clusterid >= data->soc->num_clusters ||
+	    cpuid >= data->soc->maxcpus_per_cluster)
+		return 0;
+
 	/* reconstruct actual cpu freq using counters */
 	rate = tegra194_calculate_speed(cpu);
 
 	/* get last written ndiv value */
-	ret = data->soc->ops->get_cpu_ndiv(cpu, data->cpu_data[cpu].cpuid, clusterid, &ndiv);
+	ret = data->soc->ops->get_cpu_ndiv(cpu, cpuid, clusterid, &ndiv);
 	if (WARN_ON_ONCE(ret))
 		return rate;
 
@@ -681,28 +727,6 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
 	return freq_table;
 }
 
-static int tegra194_cpufreq_store_physids(unsigned int cpu, struct tegra194_cpufreq_data *data)
-{
-	int num_cpus = data->soc->maxcpus_per_cluster * data->soc->num_clusters;
-	u32 cpuid, clusterid;
-	u64 mpidr_id;
-
-	if (cpu > (num_cpus - 1)) {
-		pr_err("cpufreq: wrong num of cpus or clusters in soc data\n");
-		return -EINVAL;
-	}
-
-	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
-
-	mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
-
-	data->cpu_data[cpu].cpuid = cpuid;
-	data->cpu_data[cpu].clusterid = clusterid;
-	data->cpu_data[cpu].freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
-
-	return 0;
-}
-
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
 	const struct tegra_cpufreq_soc *soc;
@@ -710,7 +734,6 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	struct tegra_bpmp *bpmp;
 	struct device *cpu_dev;
 	int err, i;
-	u32 cpu;
 
 	data = devm_kzalloc_obj(&pdev->dev, *data);
 	if (!data)
@@ -737,6 +760,12 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 			return PTR_ERR(data->regs);
 	}
 
+	if (nr_cpu_ids > data->soc->num_clusters *
+			 data->soc->maxcpus_per_cluster) {
+		dev_err(&pdev->dev, "wrong num of cpus or clusters in soc data\n");
+		return -EINVAL;
+	}
+
 	data->cpu_data = devm_kzalloc_objs(&pdev->dev, *data->cpu_data,
 					   data->soc->num_clusters * data->soc->maxcpus_per_cluster);
 	if (!data->cpu_data)
@@ -764,11 +793,24 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		err = tegra194_cpufreq_store_physids(cpu, data);
-		if (err)
-			goto err_free_res;
-	}
+	/*
+	 * Install the hotplug state before cpufreq_register_driver(), so that
+	 * cpu_data is filled in before cpufreq uses a CPU. This covers the
+	 * CPUs online now and those onlined later.
+	 *
+	 * cpufreq_get_driver_data() returns NULL until the driver is
+	 * registered. The _multi variant passes the callback its data
+	 * through cpuhp_node instead.
+	 */
+	err = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "cpufreq/tegra194:online",
+				      tegra_cpufreq_cpu_online, NULL);
+	if (err < 0)
+		goto err_free_res;
+	data->cpuhp_state = err;
+
+	err = cpuhp_state_add_instance(data->cpuhp_state, &data->cpuhp_node);
+	if (err)
+		goto remove_cpuhp_state;
 
 	tegra194_cpufreq_driver.driver_data = data;
 
@@ -776,7 +818,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
 		err = -EPROBE_DEFER;
-		goto err_free_res;
+		goto remove_cpuhp_instance;
 	}
 
 	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
@@ -789,6 +831,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!err)
 		goto put_bpmp;
 
+remove_cpuhp_instance:
+	cpuhp_state_remove_instance(data->cpuhp_state, &data->cpuhp_node);
+remove_cpuhp_state:
+	cpuhp_remove_multi_state(data->cpuhp_state);
 err_free_res:
 	tegra194_cpufreq_free_resources();
 put_bpmp:
@@ -798,7 +844,11 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 static void tegra194_cpufreq_remove(struct platform_device *pdev)
 {
+	struct tegra194_cpufreq_data *data = platform_get_drvdata(pdev);
+
 	cpufreq_unregister_driver(&tegra194_cpufreq_driver);
+	cpuhp_state_remove_instance(data->cpuhp_state, &data->cpuhp_node);
+	cpuhp_remove_multi_state(data->cpuhp_state);
 	tegra194_cpufreq_free_resources();
 }
 
-- 
2.34.1

