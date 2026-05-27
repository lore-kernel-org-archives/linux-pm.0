Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809430CD82;
	Wed, 27 May 2026 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911253; cv=fail; b=jHzxaq9UP3d//r28JbfgpkEgz0jby+u6UTrXIQHhd2Y+/dP2mRU7qSQzEBoq3NTeXcLoJVUGQRit0JhaSPm7pMvH6SQzof084tO8wdigQmktK8aFsVTqRuHCboL3QKxasaOULwfzVhHI5NDbYl+Ii87l8DYBCE4B4qoxxScu8oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911253; c=relaxed/simple;
	bh=E7xyN1O9I7Y3c7zaBPmDcBA09KHBCzq8NJqLVEs3Ges=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpVnUfbSvKz7Ao3DV/pNHpTbpMi6oMwdl1y1JcKspHh1dkQ0Kw2omljHamFKIGITVkeapnK2NT2IsRNb9jIz716+FKgsXIjtiJkQTXd0mNAnBwbKWbKJRFVjKv7GGX+ukEEbDkEUGxRi+rCoKJuQtglhcwh99/Z8hjqvgFWpQ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rqc34cUS; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqc34cUS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFM7d5X/0hDtgpRBgECyr8W7tj09dmDnoTgpycFygLMLxeXBv76TsHptyM+nuF0ureS+mUfJU+3o/UYTYj2igKw3AahyPU5pxxRfanZs9hDUKIiLyApz8XYIXLZUil2RiDuIoky206Tz6rjEWn5OeFpJQhplJt3ZzSWLreZmshddHtMd3Q1Al3MXGM3nMQYGrQZ528IwVNhpEQaqLOkVtYuGVr5GHNP82nOTCkETRBfnTUlTAs7KPVkyhXLCt4LYYsJAu1RQ4h5Huu+PAPudINjSVaugeED2jrJiRnvml2MEWIbdy92bPqZbVOENNubH+ATPCgqxOCp0ZtXHgAONzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIYuO49/ZFObK/Cw2Ic7N8IRLOR1wXlDKCPkd+bl/6g=;
 b=yhuq11+E+fWMiXnhLJC3c3wl/xVt3yFto0lQBjuf2zFN45msENE3fxVTiSAHZaN/DLTKCGgZEAHVew0v7lPS8Ska1m32zgVMHh9zTn0glFuYs/Fq8gh1wBBISOIzhOjxFpFesezquYma3NF4e2UDvPlGQ17bVNHQCM9IjiFSJO0lMQIJOjd2qtsqXLmwNr5D3s1v2z6fck+e03QpgqfxDVzcmew9aO2TUd5W1kBpx9acvfSQcoI8xZbiFQ+tSul8EOeWtHIgs5TOaS+LwRhHelhw/ApP+lYFmiofGCucNDdTGzmi0zufpuG6WIMNuxMdj967Vc6VofvH6Z+1V5KKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIYuO49/ZFObK/Cw2Ic7N8IRLOR1wXlDKCPkd+bl/6g=;
 b=Rqc34cUSJz4wdEm5To2wSytyZLxpGl90vG4bH5EJdbN7IG3gLKcnZKfwf26BlxRFTHVc/nm5lbcEV7HyLGf4TFpYaHvIhcB+G+oICN213zkwlbYiMduV1wAMfPeUs63GmOQA13rFbviNCNechBCanKsGFWVcwzwYV7Qcc2c5G62r20Rqe9Fin44AwvcvlKPrD3DH56Vu97QTMcfiIGfyvBI9j0jgzuF0NwCybh0mqlw3j6YT2JEpv4GtzknxDioMbYx1eP+yZF1ashe7WHU1fcNU+A7V6IIiNUa6ZEdzG42UXGsvz/RXmQLGUhzPE+TVwZaEJKyhVzvab0XWyy88ig==
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Wed, 27 May 2026 19:47:19 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::a6) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 19:47:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:48 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 12:46:42 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
Date: Thu, 28 May 2026 01:16:26 +0530
Message-ID: <20260527194626.185286-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527194626.185286-1-sumitg@nvidia.com>
References: <20260527194626.185286-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e5d70e-15c5-4bc5-4751-08debc28c2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|56012099006|921020|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wwrJTyBO/ULoadwXd90C4x0aQOLWxz7pZfe/QuvTx8C3CzQBGfIr+pwgUfbzA7X3a9Hccoo8RhoGaXgR/3fLh0vDeSFrwFtExv9PM5mAW72SMzlwOXMZnZesh7CxUBS5QBdeCPE63cDYgHvJhG6kdtdaJBsnZRSakLPHmdWg0Kv/Mj/Gup+u6K6EsS0nEXkqtb+m7upy3NtxOpSShrV+ddPaCUx6awmqz34JN2A/qSm05KS/+5mzkkplSDeF4gsE00NtdYrjxvzBmrIr15L8X1kQLM5/9pPdY9HkwBJPVMO95gW0uGfOLEnDIxF7Du2JCpjjXPWVR1tAKqRie7eAXhfHwd3KB2GJQIrp47n1M4pjXCA99Cgc611dIWKwCuCK7XZBefEVDNxxdAGtraRHbs4lY3CaY1Z4xIpVa5HW0LHftNFqjnxAj1iqA2/4hWKHF1tba5VjHnZRitTj80ws6t23l6kMFwGH1fRU1BacOgr1ASffeWa27Wl5YQM7J0DsePk7Wd0IVEL51uxJXI9xZ1OdNXthXKRHrfgrIPi5hcs6zCzZtQb0TEY2w8qAfwao0pV6iI/4yW3QYED7L+HSMLCQEAT7yLkV+SckC34ilG2JXN0/0ibqkfbrx1/rob45hXoEdui/vrbDoipz/yfuE8L04DBED30ITLTHUqVfwRbr7g60cFLl59qhkdHupM7yTLhxD0RkwZwqcV+7+KrkU2/PQh37StmhXJioh3UpiYwAVaxNcqAFuibDcDrX6bV9lPch4RzE8Wcn2N7pu6yKSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(921020)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qtdkbk4zsia8bvpEq/84JtxKGzdfIMeXPGpzFMzlWELpX7coC4A00yCEPUbTIcxbaqH2STZnN69teX5idgS5RDTVzdYoGcaAocvzWGDl5ZG/2yPCUjdEj05RxTkyaj68pKHNmgXdG9EGPsyMfHgEgZeYy9UogqxIJogCkuS/fQjTOlVvDMTpE7r0oSAPv9yZyVrUaVRfOcFLsXfnrijopGLy7hayf+KaQ704Q8HCwl/6/wo8uqIY2GTPnJJ43fKzohbKPgd4gQmALK7e9Ts0P1r9jxq3jvLbkaUuOGmYccZ0AxJht6yIZFMLRgSDAaCz913FPZq1tEDDdOkPSZy0SCqwvPOmS8rUI8YnaSVK024fu/zkrr971UsRuj8uAzS8faV1unXFwCLYhKhYs8mk8nXM7/lrlGh2xfyAxZgipS/qtAuAkwV230MDpAbBjwDk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:47:18.6925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e5d70e-15c5-4bc5-4751-08debc28c2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653

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
 .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
 drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      | 12 ++++
 4 files changed, 124 insertions(+)

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
index 15a728dea911..5c54af1655b5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1139,11 +1139,70 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
 CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
+static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+
+	if (!cpu_data->ospm_nominal_perf_set)
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
+	bool prev_set = cpu_data->ospm_nominal_perf_set;
+	u32 prev_perf = cpu_data->ospm_nominal_perf;
+	unsigned int sib, freq_khz, failing_cpu = 0;
+	u32 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	for_each_cpu(sib, policy->cpus) {
+		ret = cppc_set_ospm_nominal_perf(sib, perf);
+		if (ret) {
+			failing_cpu = sib;
+			goto rollback;
+		}
+	}
+
+	cpu_data->ospm_nominal_perf = perf;
+	cpu_data->ospm_nominal_perf_set = true;
+	return count;
+
+rollback:
+	/*
+	 * Restore the previous value on siblings already updated.
+	 * for_each_cpu() iterates in CPU-id order, so siblings before
+	 * @failing_cpu were updated successfully. Skip restore when
+	 * there is no prior known-good value (first-ever write failed).
+	 */
+	if (prev_set) {
+		for_each_cpu(sib, policy->cpus) {
+			if (sib == failing_cpu)
+				break;
+			cppc_set_ospm_nominal_perf(sib, prev_perf);
+		}
+	}
+	return ret;
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
@@ -1151,6 +1210,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&auto_act_window,
 	&energy_performance_preference_val,
 	&perf_limited,
+	&ospm_nominal_freq,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 9b18fb9aab7c..14c6d5d0ac12 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -154,6 +154,13 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	/*
+	 * Cached OSPM Nominal Performance value (write-only register).
+	 * ospm_nominal_perf_set is true once userspace has written, so an
+	 * unwritten cache is distinguishable from a valid 0 perf write.
+	 */
+	u32 ospm_nominal_perf;
+	bool ospm_nominal_perf_set;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
@@ -181,6 +188,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -267,6 +275,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
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

