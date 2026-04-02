Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037271A681B;
	Thu,  2 Apr 2026 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106156; cv=none; b=TH2V8rH9gYs5Qj4gcJJLcpfw04Y2LhPGPsTaGZLRwMIWKfCoQyhGPY3+eBxvsBq+PozwuzzyiQFlfk5cvOwTOVEllxx6IDoNyJVGPVNZSS3uUj3Vso1oK/7hSwAvAA5uyr7ixCsnjxx0P9I7S8+jsaq5+T25kE3BCU6aLpJe2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106156; c=relaxed/simple;
	bh=bt7RgKQ/2yBxnjD7n52CyzlsthXmcVM5tT5cOoXeowU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRgoqNSeXeKvFK7E8jVnVs2kcndduPJQgz1vUgvnBhKtPaNMoblfuqNYgYor3h9dloH2kW8BKuvVY5UbIzAzQtXpQUdGjbVe92OsI8RsIulAmVAwmBeJVQrJs7DywmoPZOoZHfMwY0Y1u6INjQDAz7NSa7KoYdZhdIdj2RBBVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duV5jS4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duV5jS4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F4CC2BCAF;
	Thu,  2 Apr 2026 05:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775106155;
	bh=bt7RgKQ/2yBxnjD7n52CyzlsthXmcVM5tT5cOoXeowU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duV5jS4jQEZUsPlQXSFaF5Z+FNMKCHucTffhGhpQL1OOe4tCg2zWoF12m8mKWJ+ez
	 HpzyhFM8ObOhII45YAFlEzCUAbJb05HK1zXmUvO/ICwjm7UHl4gjp9GDY8ThV381ya
	 f2uXpzRgK6bnnLl4vDmoBsZNnPBK6rKMIExQiGULC2dR78v+dksF9uWp4xmoOT0SQh
	 n1qty0P+Z5Po0sqXqvFvxY34vbuuvWjGNkNfxOdGZYGoFmyaF4YUWa/FnN2PvtirbQ
	 RqG1k701g3V1jPy/rOHVDB3FOUMyc5vvYRW5oLskX9W7tTLQITNsCmSFSjuAHZMyj0
	 gATNFsOS/XCmg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Date: Thu,  2 Apr 2026 00:02:14 -0500
Message-ID: <20260402050214.1238624-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402050214.1238624-1-superm1@kernel.org>
References: <20260402050214.1238624-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that all supported raw EPP values work properly.

Export the driver helpers used by the test module so the test can drive
raw EPP writes and temporarily disable dynamic EPP while it runs.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 109 ++++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c    |  11 ++--
 drivers/cpufreq/amd-pstate.h    |   4 ++
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 1f62ab6438b4e..aa8a464fab47a 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/cleanup.h>
 
@@ -41,6 +42,7 @@ static char *test_list;
 module_param(test_list, charp, 0444);
 MODULE_PARM_DESC(test_list,
 	"Comma-delimited list of tests to run (empty means run all tests)");
+DEFINE_FREE(cleanup_page, void *, if (_T) free_page((unsigned long)_T))
 
 struct amd_pstate_ut_struct {
 	const char *name;
@@ -54,6 +56,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
 static int amd_pstate_ut_check_enabled(u32 index);
 static int amd_pstate_ut_check_perf(u32 index);
 static int amd_pstate_ut_check_freq(u32 index);
+static int amd_pstate_ut_epp(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
 static int amd_pstate_ut_check_freq_attrs(u32 index);
 
@@ -62,6 +65,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
 	{"amd_pstate_ut_check_enabled",     amd_pstate_ut_check_enabled    },
 	{"amd_pstate_ut_check_perf",        amd_pstate_ut_check_perf       },
 	{"amd_pstate_ut_check_freq",        amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_epp",               amd_pstate_ut_epp              },
 	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
 	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
 };
@@ -268,6 +272,111 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 	return amd_pstate_update_status(mode_str, strlen(mode_str));
 }
 
+static int amd_pstate_ut_epp(u32 index)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+	char *buf __free(cleanup_page) = NULL;
+	static const char * const epp_strings[] = {
+		"performance",
+		"balance_performance",
+		"balance_power",
+		"power",
+	};
+	struct amd_cpudata *cpudata;
+	enum amd_pstate_mode orig_mode;
+	bool orig_dynamic_epp;
+	int ret, cpu = 0;
+	int i;
+	u16 epp;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -ENODEV;
+
+	cpudata = policy->driver_data;
+	orig_mode = amd_pstate_get_status();
+	orig_dynamic_epp = cpudata->dynamic_epp;
+
+	/* disable dynamic EPP before running test */
+	if (cpudata->dynamic_epp) {
+		pr_debug("Dynamic EPP is enabled, disabling it\n");
+		amd_pstate_clear_dynamic_epp(policy);
+	}
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);
+	if (ret)
+		goto out;
+
+	for (epp = 0; epp <= U8_MAX; epp++) {
+		u8 val;
+
+		/* write all EPP values */
+		memset(buf, 0, PAGE_SIZE);
+		snprintf(buf, PAGE_SIZE, "%d", epp);
+		ret = store_energy_performance_preference(policy, buf, strlen(buf));
+		if (ret < 0)
+			goto out;
+
+		/* check if the EPP value reads back correctly for raw numbers */
+		memset(buf, 0, PAGE_SIZE);
+		ret = show_energy_performance_preference(policy, buf);
+		if (ret < 0)
+			goto out;
+		strreplace(buf, '\n', '\0');
+		ret = kstrtou8(buf, 0, &val);
+		if (!ret && epp != val) {
+			pr_err("Raw EPP value mismatch: %d != %d\n", epp, val);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
+		memset(buf, 0, PAGE_SIZE);
+		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
+		ret = store_energy_performance_preference(policy, buf, strlen(buf));
+		if (ret < 0)
+			goto out;
+
+		memset(buf, 0, PAGE_SIZE);
+		ret = show_energy_performance_preference(policy, buf);
+		if (ret < 0)
+			goto out;
+		strreplace(buf, '\n', '\0');
+
+		if (strcmp(buf, epp_strings[i])) {
+			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	if (orig_dynamic_epp) {
+		int ret2;
+
+		ret2 = amd_pstate_set_mode(AMD_PSTATE_DISABLE);
+		if (!ret && ret2)
+			ret = ret2;
+	}
+
+	if (orig_mode != amd_pstate_get_status()) {
+		int ret2;
+
+		ret2 = amd_pstate_set_mode(orig_mode);
+		if (!ret && ret2)
+			ret = ret2;
+	}
+
+	return ret;
+}
+
 static int amd_pstate_ut_check_driver(u32 index)
 {
 	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 40340b5d1278b..d0bba84158e6b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1257,7 +1257,7 @@ static const struct platform_profile_ops amd_pstate_profile_ops = {
 	.profile_get = amd_pstate_profile_get,
 };
 
-static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
+void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
@@ -1270,6 +1270,7 @@ static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
+EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
 
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
@@ -1406,8 +1407,8 @@ static ssize_t show_energy_performance_available_preferences(
 	return offset;
 }
 
-static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
-					   const char *buf, size_t count)
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+				    const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	ssize_t ret;
@@ -1448,8 +1449,9 @@ static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy
 
 	return count;
 }
+EXPORT_SYMBOL_GPL(store_energy_performance_preference);
 
-static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 preference, epp;
@@ -1478,6 +1480,7 @@ static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy,
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
+EXPORT_SYMBOL_GPL(show_energy_performance_preference);
 
 static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
 					   const char *buf, size_t count)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index f7461d1b6bf3c..e4722e54387b0 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -150,6 +150,10 @@ enum amd_pstate_mode {
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);
+ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+				    const char *buf, size_t count);
+ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
+void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
 
 struct freq_attr;
 
-- 
2.43.0

