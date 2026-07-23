Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371747FB10;
	Thu, 23 Jul 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837780; cv=fail; b=VDD6LMLxcWoUEkpQxzoaIHh0YpaxPoBgaNS6ZJ6p9ZPIdqCMaQB900GU8VyJznMo1l1Yl6uMF+B5+rva6MDtvUUwunSolzxfrGurH9JQ9302hL1fw9VWXWoF9D1dAux0o0i9iX7e2jAfx1vzZb+iP3Kmai5Ltwdl3XvZ/snuH24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837780; c=relaxed/simple;
	bh=Pw6ADZwvQnILYkXId3yB7OUviJkxl82Js9KlglOLA1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw2uR9Zi1U3zCaBhf1jjle4jTSIePnzgFwX9y4nzLRSCoBvdPVdlUSURO3qwnfXldKMKMBpb4YUFN6s0lLJaKzpMMsahqaykbEogbpFp9LjkNTosdFXy27J1VNPpy9TtQGwsOuCLI2sP4U7VNeyH/BReR3uemUVNThhA1s7lJFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ADT6G8Va; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ADT6G8Va"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVPXES+BOOPbzNprDYoxwk6vCrAQHbVQM7NtXPLevvXx4/dzlNZTrOh2gkfFobVA07kiLvpXpzp0sQy3iCGkS1S0BmXFlmscUWTwvMGrPsUnbbhBKUr6gL4oppg5jLPEAY5H0+TIQ/tyTrKk1HBbK6kH0+4s+auFQefcqyQ5G4B9QqvkAZ8PMUBAxM1tmZ3N2DVZGwvcFUuWcHzKB3bLxJdI+ba8gYGUEMgrivL0HoANJ1B6pJawtOUaZiPBByNtTNSI6toa5fENcESIPYpZ4+/mlXk9gHoA43pTiu1LwTzyBPeq/EyZ716dQyUwNTDQY4h644jPNFFmGZpQd9NXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnnPFB31wMXnaJoeM0agZJZEMIGMA1ePKSl8BlUYV+o=;
 b=AyoR5KgMDFX1sCTMCXnqKXfs0NRtuGTTQF9qWf1VbLU2tTx6dpja68k5GVA+gBUjAGgLt8Xl8rS+P/fLEgozPTQrZDx92IN2Zydt1+Om7rt1rXSt26jo6sP0xSRIuIlb6+YkKwNgma8sPwIEUnQcelgXdYpt2eCLZZwKONZGbmPmBrAvo5jELwTcHq+GRNEHrLYbH6GUiqfkCwDamX3DJPB90L3VpBO8gw7dVtlHqL4JTHX839dIt4W/DNGx0bm9WcuiLnouWG2DeFJT9UbdlOtmIKtyYr55kGFc8e4+gg/0nv1HQ5xlf48FWpyF6wz0z8KSP4QSFEtPWMXbIg2H7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnnPFB31wMXnaJoeM0agZJZEMIGMA1ePKSl8BlUYV+o=;
 b=ADT6G8VarLfl1Q3L62DmHHWNw5Y8W8IOohoRtoAU9nPTUymoe/FHzU9mvn7vXxO9lOFIwdJtGnSHIVNx3RE5SwRATz0rrNhWrum8amK6KEoIi0bBh2OOmuOX2pFJK+j3l5oBmEEct2XTd2ZItWniz6RngA20euqgvLix5uYIUs0=
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:15:37 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:15:33 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:15:28 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Kalpana Shetty <kalpana.shetty@amd.com>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 9/9] cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority
Date: Thu, 23 Jul 2026 20:12:28 +0000
Message-ID: <20260723201228.22584-10-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 09231b54-0492-4c3b-cf3d-08dee8f726f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zWZjyWe2iYq9z6cWmCrGDQV7jvY63LS/wCpkB5AeqiFdJSxPXWbm7vPzlZZJeiXjrTtphqsDigVu8DQ6xlMs+teB5AMk3/YOB/jBHIy3CDz17hYKs03rgvnH5fF2AOgxaCIZn8JH3CsBOWJK3VaNagSU3wriWtkNCki9DT67jxHiI/WCaTp74YhwN2xvfvqk6TFZVq90gyZkeTPd2Moizsm6qRlz5VsqbUPcpKhdOSQcTVqiaCbt2rNn8R4LH59XcFX+CUV+l2HK3hHfMRxZFkQluaKNQ5moMKLWGE8cqm+aFnSDBZ/D0P1N7ZsbPrJ6j22eQwha8m4iXGoGXTuj28T6AfXN8nLY+7Ng9zEpsMnjG+oHKB6NOn+sQgNSHi7hcv4CznmlGAiVWzcq1VpWKTxICDGqylbl699r8hcABnXP2BOLeFSgYtb7N//T2bnBgRGg4Vt6Jmy0aQfqAz/soxVAdXcmNNKpe6yRQk/+q9cH+13FPsIJEi8Gi9OkA+k4ANSb2x6lWgyWR6h5/QgvluoIfEiGeDLIr5WL6VAh4Ml1Brq3IxSeZYIll1i3SNmzEVnv83l24+YXc1RUqkwerKp07k+hgk0TR/QhJf4Z5mhhLzri4w0SW18ySVJptz0yNve5WDdx1OWXo96FjeZ/RdCZ1QCrPCvWYsH5ECNl+phbp/wNqFWYp5C9CuFaaqiH/V5tn6DrA9B3GAlYYBY/bw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZrkLOgs5hx9hNcTSXXwLyJ3VrlJYiZyXhin3GysOD5ehsgePC89+XCEOL3XURczHywQqNZHYIHMC04qBkWW+/2fSoVvGL09D3sqRE4GlGUGAU5zIaR2km1La9vD4C4feiEcZ4JhCf4UiUpVaB0O/3NXEvquXEtrGLGaKoBEzsiEroUz2NS4IY2uIhOLvbm70Dovhjnr7yRdTcGvX+Q7W27oZ1Q8/UF5CRdN7q0Xudj/4CoP2N9JMyf+e5ph3Mhgljaq8hR+uD70DoeIX/5Py+pPe1zzK2Q+9yOEMnC9y1KTGxUNLFO6qfl5sxk9Juz2xwY2g5rmE/n+FgewZ7OeJHeFlQElDgB3Iy4ZJgplrAPJrBZ6y0N80uw140gxwqaP+skrZmUPqjKPm9hR7xQIbKSRBv3sNbrYu/71n68s/HYYUuLykM7G2U2iNAgTWHLbb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:15:33.9975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09231b54-0492-4c3b-cf3d-08dee8f726f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

Add a unit test for CPPC Performance Priority that modifies the floor
perf and confirms if the modification was successful similar to the
energy_performance_preference unit test.

On platforms that do not support X86_FEATURE_CPPC_PERF_PRIO, the test
returns -EOPNOTSUPP and amd_pstate_ut_check_floor_freq is marked as
"skipped".

Suggested-by: Kalpana Shetty <kalpana.shetty@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog rfc v1..v2:

o New patch.
---
 drivers/cpufreq/amd-pstate-ut.c | 83 ++++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.c    |  7 +--
 drivers/cpufreq/amd-pstate.h    |  2 +
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index d1f730e3502b..6a17941380c2 100644
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
@@ -560,6 +562,77 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
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
+	if (!policy || !policy->driver_data)
+		return -ENODEV;
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	guard(rwsem_write)(&policy->rwsem);
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
@@ -578,10 +651,16 @@ static int __init amd_pstate_ut_init(void)
 
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
index b875e92103e1..a42899722a21 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1502,8 +1502,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 }
 EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
-static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
-					   const char *buf, size_t count)
+ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
@@ -1526,13 +1525,15 @@ static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 
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

