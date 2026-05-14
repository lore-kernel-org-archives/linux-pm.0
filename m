Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9B3B5835;
	Thu, 14 May 2026 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788171; cv=fail; b=lxtx7Sc4UlxHkkiwOdmWT0WcwzlSRFu34i8umAekd0FhKnvnqp0FK4TNkV8aJ0wNEJkChORv/euldJTMYYGVstG2LccMEvxb01WYnopI+nOe5AeaJkYblrwHrALZDbAcdCSmy9PitRzxktfqWdqSbQxyUVe/Yj1a1UulKI6zcyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788171; c=relaxed/simple;
	bh=S+iD3u6OI5HcGrsCJ3bol/RiwTtfUVu7a9x21vEcDQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jj6vjLelc7mVI+t52weQrx7XBPg3h70xOF89Vu6lyMCOTg9KwVWEGwbmS4GYKi+UrGLihCbaNL5a7bU9Bit0NVVRj1x52XBxJ/bDrJF2y8ED8Ln63xnEoO4I/e85jwySRNwVW0B5uadiiMCvQp2H9Ycs9UExiQOxeQVyqPZ2z+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2RnrQGw; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2RnrQGw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwnPJoF1RXB7yZekXYzGr9z6qokM23PRpr2aG/SxMK7uvK//D4KsPn78Usie6Do48NgNX/XQT7CQ47P1ux3olPF+NiWspNC9VXgIjB5So8OF1S8O+N7mHiExdRiQyNpgUUBcMhFKW/4aj+yQlG2Du/ZF/LQ1OrnyxHM77IC03Nrjb8J3CHjMR0MuYk9RQN8uhJuF3VQrBJDzC1aZ8Tnq7WvjYzBBgheG3FTnQ0gZGwPWCOLbwF8sLJ1QO+XYHXljqM5Xqar0djelS6dJaF3FbaIY+fJC9h/5MyoNzWXUnuVu/aMb1jtUzcVw0oTNupcZ17SrxT7/hQ1CY7UcXKaXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAoB+z00nmrryyLLCAyI78pvXpkSiXwRZOYizsMqqJU=;
 b=Gn+MSUUgWH1OvmIUFoqYIrpbCG+4rGuulm3F8iozqj+1e9n8tt6aKHchShPCu2vO3p8gb7hqOQsIWbmNauMOD6qmLQcqLcxoBI5svK592tuLe9zbToDGc/f2wiQv/C80SBCrdhj+cM98KtvyNQU8pavdjuBlpb817H4L6Eyc5hhsApVqeWuvFSK2LG1yC8XCEg7jIs7W8jgvjRvVvApKPzyYtgmcDG+p8NXqeXJg5Fi7vieab5LNcXKNISBQzN8dYcfSThZ7mubnoJ4NTa5M0V4/lUMGUjyfabf1wYXvnH+G+7djXgMlYwVLpy28MnjFnfu1Hzt+6nepI2G8lMmxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAoB+z00nmrryyLLCAyI78pvXpkSiXwRZOYizsMqqJU=;
 b=a2RnrQGwUT1D8XX2UKeEZOsZUAgg3mQWynHyGPfII/XsL+2MG5Y6xB1nuAnSujxbPv1uI5nqOX/J1n+ZfTp8d+nloEcS4biCuCY9qA7EqBxmNv8528sYfkjlC6Mg9M9OJK1xdnFf9n0CHiuECUjY8uny2G9EMoPgQkvxWo4MMxPto3xl+Zzl9JcUq7COaCMd4IIMXuItIm6DFjqtUu3WlODjb27BuukAyHrbZlpGdtWCeuqiNWeteVsnPeec9ahsfhsJgMcR+iu/ymToIB6Zn6r6Jec9HqrBfP/WDwsGIpOukxJtP0ikHOHj/GzBOR8fjb1yClJugEBiooeXygjgIg==
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 19:49:20 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::b) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 19:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 19:49:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 12:48:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 12:48:54 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 12:48:49 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
Date: Fri, 15 May 2026 01:18:22 +0530
Message-ID: <20260514194822.1841748-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194822.1841748-1-sumitg@nvidia.com>
References: <20260514194822.1841748-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: c960c173-1d23-4ed0-4bb2-08deb1f1e3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QWkg+hckPbQ8xRNMw1/gRgtnyOWcCoaxex3S2vcF81ygJOaHcGcMUbeFZKPRgGuFvGUiM/4DUARw0QwuF9GrBarvHxW0Y1qX210tWvuiR25DAPN0/3dv6qEn+qvG6qzts+UIRiwXg5kuPWuySMYacfLlDJKrvia5/WdmKeKrBTXgxAbNzns6LCQGkoTdxzQMDtdDnO1g5V2Do2qBC9Mofu9ZlXE5RWQ15mtTi24wftCYhL1vjUmzg2pZg+8JtJFxmVsqm+/19Lk8Uf+hC5rcZ1dDCSf6Idxan84FXCipxLIivT4LOxV32D2MC6bci8ySfYTHOIji33HiLzuwoMlMk/9hi3lcRWJNXWUK/N2gXh/GrfvRPddLjhwC7C7mcCiwtelS6HJmENjqj0G8X61DLA7EHRCmu++XHd9fIXUGK0vyjzM2G5NeS9NBsVOvqkVo2RX8tHsyUiKSJe/0MALmDMQg138sjG1IfPVMtUcvILxmdkVXNgcjryTdGvV7WsVJqX99ITNZ9P1trYptYOBOU6gqyxQNTEN3704/gQd0rslsrR1s5VGpl+Euhd6SpxXX6TwqoEyzqdE29v5PVjsKUsBY0PWVxsiVFFLRA6mBkUF/qV+HJQxefDuRdnmJcChpLYWSxtcbtyQ3QGd03ErJAnrBJHVVj84oxJqhVxu855au2sIYUN21g/cQR9Fdse4H2UcaY52YWna/X5dSKiPF3oLApoOMnh+ggE+gGROQ1inj1hykz7oGx9K7EdKA6RfY
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YoyUtLXRnOE9Cz2yp/sGa0bj/GHiqw4LYvOvekqKKbhvQ0IeLSX42Uk/N4I0pA7mr1i16RoaJ4Wo4ICDKCvxLbJllbzea0Jt8+T8j9b4vrYEfnrh0BE0Ik+7SkO81rY+cnrUPamVC171ZJuwbjPLYw4SgOnXhs/KSRs4R42fOOoxpyBbMkVzp2sJILEQBzW5V/VRsq9qwgza3udG/UG9TEYhFGNeQFkIEOM261YQ3HKOb2ZqWJkoBItKgrOQKTMkV+lvcjYaXG4hdgbxIxAJH6EbWHXWMazfvca5E01WisniYDqHu6NqFk5F9/+TNWJENIO5DJOwQsH7P8qifHKnVxAgiOeVQGZyOG62/J2+kXPO7jjcnD2gYdh06kPHSf6tlRjaya3Nj+aO1acdC8MmBigHcick7aITiR4JBQ8/JHQsxVlEH113luf2wM/kOyWm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:49:20.0456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c960c173-1d23-4ed0-4bb2-08deb1f1e3ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the desired nominal performance level
at which the platform may run. Unlike the existing read-only
Nominal Performance register, it is writable and lets OSPM
request a lower nominal level than the platform-reported nominal.
The platform classifies performance above this level as boosted
and below as throttled for its power/thermal decisions.

It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
match the cpufreq sysfs unit convention:

  /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq

The attribute is documented in
Documentation/ABI/testing/sysfs-devices-system-cpu.

Writes are converted to perf via cppc_khz_to_perf(), validated
against [Lowest Performance, Nominal Performance], and applied to
every CPU in policy->cpus.

The register is write-only; the kernel caches the last written
value in struct cppc_cpudata for sysfs readback (returns 0 until
userspace writes a value).

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++++
 drivers/acpi/cppc_acpi.c                      | 35 ++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      |  7 ++++
 4 files changed, 99 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..ac1bf1b89ac4 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -346,6 +346,23 @@ Description:	Performance Limited
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
+Date:		May 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	OSPM Nominal Performance (kHz)
+
+		OSPM uses this attribute to request a nominal performance
+		level lower than the platform-reported nominal. The
+		platform treats performance above this level as boost
+		and below as throttle for power and thermal decisions.
+
+		Read returns the last written value in kHz, or 0 if no
+		value has been written. Write a kHz value in the range
+		[lowest_freq, nominal_freq].
+
+		This file is only present if the cppc-cpufreq driver is
+		in use.
+
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
 KernelVersion:	2.6.27
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c76cfafa3589..ad6ece16c30d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
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
+ * set independently of Minimum, Maximum and Desired performance.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_perf_caps caps;
+	int ret;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = cppc_get_perf_caps(cpu, &caps);
+	if (ret)
+		return ret;
+
+	if (ospm_nominal_perf < caps.lowest_perf ||
+	    ospm_nominal_perf > caps.nominal_perf)
+		return -EINVAL;
+
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..6379b7ceee34 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -985,11 +985,50 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
 			 cppc_set_perf_limited)
 
+static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+
+	if (!cpu_data->ospm_nominal_perf)
+		return sysfs_emit(buf, "0\n");
+
+	freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
+				    cpu_data->ospm_nominal_perf);
+	return sysfs_emit(buf, "%u\n", freq_khz);
+}
+
+static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
+				       const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int sib;
+	u64 freq_khz;
+	u32 perf;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	for_each_cpu(sib, policy->cpus) {
+		ret = cppc_set_ospm_nominal_perf(sib, perf);
+		if (ret)
+			return ret;
+	}
+
+	cpu_data->ospm_nominal_perf = perf;
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(perf_limited);
+cpufreq_freq_attr_rw(ospm_nominal_freq);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -997,6 +1036,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..0b1dcdbea10a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -153,6 +153,8 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	/* Cached OSPM Nominal Performance value (write-only register). */
+	u32 ospm_nominal_perf;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
@@ -180,6 +182,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -266,6 +269,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

