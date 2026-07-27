Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4599175A60;
	Mon, 27 Jul 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137043; cv=fail; b=n8VMHp2J9HnM9mxdYwppVaNLTcrhcPqbHcurowHI8WiQjTqb1B0/AonvUAflChCt/VUCRX5Eh1gtPTSoywgL4TLDQBz5EgjQYsrHfKcJRMJwsLdp5Ato0j+qHqnd3ElDkDWiy5uFofnC/mzOs4QX6WsU2tO8eaNafERbZOvrhi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137043; c=relaxed/simple;
	bh=MzY38HAq5uUjNWPY7njIcDvtbpazgBbY62MSLe2hRfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR/KCGm9G7F+X3T8NqJcBDtCFMdIZjomaehlLGh9UXpcM35OYSp+V7aubx69kbHXOnQO9jSkVvI3pDkv61JconyE540FPWt/7J+pvYCcYyychBH9p1qJI/WDqTSXH1cW7N5PNaaytHN59ahH6TlUp42h97CR6cv28iNQIA0RpMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pMMif0Hg; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pMMif0Hg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXFELqQk8o2nEWv/iEOe9ubB/5YMdsaR4x4O7Z+3XRTIkOXWA9d65lafRMwCBVrFQStgUb0KiLVebG7gHXPWe6P9cpbT3HtkY2+mCbwfIxz+9dGE778v/RPZxa68G9lBJi0YQkFQ+xkrdga+k5d7KeZaTAjvGy3HkZgSFvMuKS1bnMvJUfZZtHXUH1g+ft9yyOh7KvN29sPYTim4wU49lxjkSV5TlOPJ0ppm+FlGHEnlun4/7VkYABqrISDTCqxoPDOyWrhESuAET1ISijU4nsA5FrvuL4sndFN8OSbzX8sGy4GCI1gyE88t1rkM+Swm/v/CFZc6CnzzORobdtU7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUwli7d58sHCzKnnFh/KXAGRCTbj6avJAUBNyYTNn28=;
 b=Zf1QnYBTx7QvGuxKNkGsJKytmf4KaFrIiX7cZ3J/lcMFc9Fp0R9e52ejzo6O+XbmFw170nsWYSJdO25nZZCPQ5+d7BXWiRXOVg0SWh5h7s5ZOUImnP2T4N3ammQj1v7HOpNViUJ13ptBxLyoZ0AkWSrYf4tTXxGotFKbfEgjOU2e5nKQs29/xSCQcIaT38YQZHEoT5Hek5sK3k3iL+NO3VXI817iRWzK520Q4+RrVSsiPBvyGLBv//j4Jds+nr5yoMpkafRM86q1TkW1J4STLgTYg0PIk6N0SI5vQzYgqrm1eilu3yGkf9VdS+3TwSr7euReZfwTt3NDtgOv3ED5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUwli7d58sHCzKnnFh/KXAGRCTbj6avJAUBNyYTNn28=;
 b=pMMif0HgopSR/g6SNYxghUHQ1rF+98yDhLsiUxq0nXzgeiXkMyMfTvBtEsL9SRQJ+VglWNUGIDZzB195UaY7Y0ZMyp6BbDdIw4rpy6iJKwApIXp77+v8pFXBowbHytPnlw3o+SwrLcoacNuklNVlIJtwlgrcRYLf+oGgn6uMTd4=
Received: from BLAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:32b::16)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:23:57 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::66) by BLAPR03CA0011.outlook.office365.com
 (2603:10b6:208:32b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:23:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:23:53 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Kalpana Shetty <kalpana.shetty@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 9/9] cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority
Date: Mon, 27 Jul 2026 07:20:56 +0000
Message-ID: <20260727072056.1248-10-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: ed36a5b5-3adc-4a59-bc20-08deebb005c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	fDqvp2o1skX7LKIuo1QMwQAQ/KibQH9Aoh7BJPGLpXKFqrE7Xsot/8A6ip36U9SJ7Qzd3cK7Sc7QVdITeXqXdklfTNs18I1qIYfALQfzBQUWL+bPmzGTP5rua/Po6+ndygWrAEFv7LoN+KKdKimEqvdJghZFQkCv2KfCuM4pH+sJRuZqFuPumlGMZ+Qmtvon2/ibh3OV64xmZzaArLnSZ8m3+z35kVIIJrLKz4v8ZiwOHVzmSpe3dsD5F4JURGDMXr0H+Uxe0Y1vg3MMbTFnjBdUhOAh4P6MuN0Z41srMM0KzKyEtxP3WsF3juOtvGbgs/tiqKFi0EqcJMFaox3KWMWkdbdx1L3T6BPE7qL2WJl8okvi9+FSMQZR1PUySNdW+1oj90j99dQUQipqPfCR1bzRN3Itni3V6m6YFXvKXnMvIQDqI8Hy+2nq22jar7gPPqsbUbbtGOoz9MU8rM5DyRElaiUp7oxVmSSmuVvjq60GE7eQEbPjTpmH+2640x5eRqsldVrE5LycKcozksYJZvLjmvUJ1g0O99awMsQ0DmWDN/FhiKWI62ga6MaBl7Wyx8JNmHXT1gT7qGiT6XQ5Lg9BTPB1CipUdnw6tkkBSI/owwkd0+hIbb0GdEEKhDXyn+0zxHmY/lSDKiKHu64kPY6YiK30awjbfEk03H85Ib8SuqWxDk401uAnSjtMT2fVwHBvl9e71zZtFJaquwyaOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yysIU+dOECbKGcn+W/rXVVf3BYZORBcMT4jXBefAv1j6jxIQ/IjRM7DQQ4zPX6hSJC3q2dP8oObqaLCvfIuDaA7FDoZk5LqMeskyVTb8g1g0E9WGEx2mCQNADDxBIfy0oI8DvucDI3l8BRE+1kEhpRIQ8EY/mYlWhTH3FkfmE0IOCEUvn4RRN3jQliVYkLRrI/olJFac0U+ukjEwUT0pori8xB11F5U7MLbjJnloosW7UGnrdWyGqdlqgBqPPZZownVjmLlhTGi3oGeaiFfS9vAm18DGJWcWD0mHM5iUYDg/Of1GqXywo+lL+iQuDB4x5Lue/0x51qQaRjk9zWYorhOU6wqTM55OhSgTgSV0bTRu6+Li10Tu4bOoKZDv9x+YLbrJe2IF2kaUFMRuqGEWVZgDBOssyEbWgPmyX9di8Je8C6dadGFzu3ZVEVjt27kY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:23:57.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed36a5b5-3adc-4a59-bc20-08deebb005c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

Add a unit test for CPPC Performance Priority that modifies the floor
perf and confirms if the modification was successful similar to the
energy_performance_preference unit test.

On platforms that do not support X86_FEATURE_CPPC_PERF_PRIO, the test
returns -EOPNOTSUPP and amd_pstate_ut_check_floor_freq is marked as
"skipped".

Suggested-by: Kalpana Shetty <kalpana.shetty@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Collected tag from Mario. (Thanks a ton!)
---
 drivers/cpufreq/amd-pstate-ut.c | 86 ++++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.c    |  7 +--
 drivers/cpufreq/amd-pstate.h    |  2 +
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index b432eae1dd52..e23773680e05 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -59,6 +59,7 @@ static int amd_pstate_ut_check_freq(u32 index);
 static int amd_pstate_ut_epp(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
 static int amd_pstate_ut_check_freq_attrs(u32 index);
+static int amd_pstate_ut_check_floor_freq(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_acpi_cpc_valid",    amd_pstate_ut_acpi_cpc_valid   },
@@ -68,6 +69,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_epp",               amd_pstate_ut_epp              },
 	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
 	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
+	{"amd_pstate_ut_check_floor_freq",  amd_pstate_ut_check_floor_freq },
 };
 
 static bool test_in_list(const char *list, const char *name)
@@ -560,6 +562,80 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
 	return ret;
 }
 
+static int amd_pstate_ut_check_floor_freq(u32 index)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+	char *buf __free(cleanup_page) = NULL;
+	unsigned int orig_floor_freq;
+	unsigned int floor_freq;
+	int ret, cpu = 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
+		return -EOPNOTSUPP;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -ENODEV;
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	guard(rwsem_write)(&policy->rwsem);
+
+	if (!policy->driver_data)
+		return -ENODEV;
+
+	/* Retrieve original floor frequency */
+	memset(buf, 0, PAGE_SIZE);
+	ret = show_amd_pstate_floor_freq(policy, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = kstrtou32(buf, 0, &orig_floor_freq);
+	if (ret)
+		return ret;
+
+	memset(buf, 0, PAGE_SIZE);
+	snprintf(buf, PAGE_SIZE, "%u", policy->cpuinfo.min_freq);
+
+	/* Set floor frequency to cpuinfo.min_freq */
+	ret = store_amd_pstate_floor_freq(policy, buf, strlen(buf));
+	if (ret < 0) {
+		pr_err("Failed to set floor frequency to %s\n", buf);
+		return ret;
+	}
+
+	memset(buf, 0, PAGE_SIZE);
+	ret = show_amd_pstate_floor_freq(policy, buf);
+	if (ret < 0)
+		return ret;
+
+	strreplace(buf, '\n', '\0');
+	ret = kstrtou32(buf, 0, &floor_freq);
+	if (ret)
+		return ret;
+
+	/* Confirm sysfs reflects the change correctly. */
+	if (floor_freq != policy->cpuinfo.min_freq) {
+		pr_err("Floor frequency value mismatch: %u != %u\n",
+		       floor_freq, policy->cpuinfo.min_freq);
+		return -EINVAL;
+	}
+
+	memset(buf, 0, PAGE_SIZE);
+	snprintf(buf, PAGE_SIZE, "%u", orig_floor_freq);
+
+	/* Restore the original value. */
+	ret = store_amd_pstate_floor_freq(policy, buf, strlen(buf));
+	if (ret < 0) {
+		pr_err("Failed to restore floor frequency to %s\n", buf);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init amd_pstate_ut_init(void)
 {
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
@@ -578,10 +654,16 @@ static int __init amd_pstate_ut_init(void)
 
 		ret = amd_pstate_ut_cases[i].func(i);
 
-		if (ret)
+		if (ret) {
+			/* Platform does not support the feature being tested. */
+			if (ret == -EOPNOTSUPP) {
+				pr_err("%-4d %-20s\t skipped!\n", i+1, amd_pstate_ut_cases[i].name);
+				continue;
+			}
 			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
-		else
+		} else {
 			pr_info("%-4d %-20s\t success!\n", i+1, amd_pstate_ut_cases[i].name);
+		}
 	}
 
 	return 0;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 93d275da12c6..ea6cc072121f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1505,8 +1505,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 }
 EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
-static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
-					   const char *buf, size_t count)
+ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
@@ -1529,13 +1528,15 @@ static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 
 	return ret ?: count;
 }
+EXPORT_SYMBOL_FOR_PSTATE_UT(store_amd_pstate_floor_freq);
 
-static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
+ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
 }
+EXPORT_SYMBOL_FOR_PSTATE_UT(show_amd_pstate_floor_freq);
 
 static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
 {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index edd697a5e29f..f8e2f6ba1534 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -160,6 +160,8 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 				    const char *buf, size_t count);
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
 void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
+ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy, const char *buf, size_t count);
+ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf);
 
 struct freq_attr;
 
-- 
2.34.1

