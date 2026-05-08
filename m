Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3837186E
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236022; cv=none; b=sn2Oibx8+uhRQbWJzje3uL3SrO51DkadH/RHvSfn7qfN3bxQxvnzS+oHzI5L21a1pyACnkxiGofYHtvW1nLtfjfsyg0la8ZB4rTZfQCPrE1RIJhIF//oeM+BZ3Job+CCDOmNAL8lfUeNCi0l9Apk5Bwgd83+sxNtqqU1D/yO80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236022; c=relaxed/simple;
	bh=9n1RvP17fserjXZKFvAHvgL52IYHi10a5qX7cWdWDpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB2jXCQ4538XT/mqR2Bc4V8xIN9Sj7zUoJMvzH+/8oGs0F80/1dCPJxzCIIkIvLAf9kxS3KE33saIITuJK/nXqUhN5TlZIiHNWUjndSr0gf+z1frzl31ZD6RdOlsvktrKTPhRBXL4q369blAYoUjS67T+CKbnRMCLt5Eyt/O9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-835b78c3797so808364b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236021; x=1778840821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUkFwkajaVekOiCVKQrl4E7oDyn2kxG0GWVyrnxa15I=;
        b=aMeLd1GY9OTBbYgHeXJ0dmjozFtTlMkbE0L9om1jC9x50hcwhgkbKpAQo8kyG2fYDD
         xEVIn/loG7s6i2WWRBU4sZW3BvlTRoyNxmEjhgTeSlpmqE0nRSLh3LOH4eNnhTwBEXtC
         No1CIGYiNY8RDGDpMG7rsr02mVfMabRkpOrmIkj9LNd8EGQktAPpOMG/pvvOHLNQ5hnl
         XkWvWXxnR8WFmxKZjapcvnPWKPGioAZPiAeUys+xkBqvgWJ04syRgVTGK4EoRi+Ji3re
         xq/5d6U3T2JJIvwuANPSbLT8GV1WzVC2gvCD7m8G2fw8U4w2DtdXpAbBB0sYyIa1bvL2
         jo1w==
X-Forwarded-Encrypted: i=1; AFNElJ8d/Zrx1WLhFwzWWTSGed81EC45/enAtuftsy6x5CejkCzHEGc+Jc8vXV290I8pF44yHYD3coyNAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BJhXKC0pZMbsVnSptyo1QNei01oLmFGTero4FlhqbmgfL/iO
	moasSjkTzOSq2DFPXBkVmzia9M38zy9+Tr1lK87yOO5admAiGRu8us+p
X-Gm-Gg: Acq92OGjRAFu9dZFFzGHpYXQTqJ+IUGblPkZFTmF/LW92sebj9rb1mknwmRJRK5fn5C
	NILWhemYLaPsp+PXLbe+1wg1ImEGbOHdo++1FHjGUxrWK9ofW4JW47Y3kmdnpLIS3ygb4TLCt38
	UFSShwXln/jOz79T95Bn04E21NYK9ryWVatchnETmZL8p6Zcqq5iO/2VycxOGsF57bDhH38uw7x
	6Ol4GhEiqoJIyZYKKc0KcqOkQVZpsbC8pm93492ibVQNtQzk62C/U3PUHPSqcOvNxHd3JDPxf83
	Z6SC/x+PZH9m0CLNDyz6UBMctpQexO2P8wtrrZCRUefw5bmSt5ZzsVwLwAe9kMX4HJv8HF9iu7G
	rg3PQy0OA/WSbNvHTHYee8SetgRnEp4joz5cTKoH5YVCkUAmrj3ANfF/6BoFzRZojB0wPEHtun1
	xrmt3gzg4K6IY0sm684wLYe0LfgLrZYFYYs+o7kLpLzzvbwg==
X-Received: by 2002:a05:6a00:4ac8:b0:83b:40c8:6de4 with SMTP id d2e1a72fcca58-83cf6a39c5bmr2472379b3a.28.1778236020509;
        Fri, 08 May 2026 03:27:00 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c00sm11021319b3a.32.2026.05.08.03.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:27:00 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH 1/2] cpufreq: cppc: Refactor autonomous perf limit programming
Date: Fri,  8 May 2026 18:26:47 +0800
Message-ID: <20260508102648.142688-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the autonomous performance limit update logic into
cppc_cpufreq_set_autonomous_perf().

There should be no functional change as a result of this patch.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..7ddf4296c474 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -843,6 +843,36 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+/**
+ * cppc_cpufreq_set_autonomous_perf - Configure performance bounds for
+ *                                     autonomous mode
+ * @policy: cpufreq policy structure
+ *
+ * When enabling autonomous selection, program MIN_PERF and MAX_PERF from
+ * current policy limits so that the platform uses the correct performance
+ * bounds immediately.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
+	u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+	int ret;
+
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		cpu_data->perf_ctrls.min_perf = old_min_perf;
+		cpu_data->perf_ctrls.max_perf = old_max_perf;
+		return ret;
+	}
+
+	return 0;
+}
+
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -885,20 +915,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
-		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
-		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
-
-		/*
-		 * When enabling autonomous selection, program MIN_PERF and
-		 * MAX_PERF from current policy limits so that the platform
-		 * uses the correct performance bounds immediately.
-		 */
-		cppc_cpufreq_update_perf_limits(cpu_data, policy);
-
-		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
 		if (ret) {
-			cpu_data->perf_ctrls.min_perf = old_min_perf;
-			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, false);
 			cpu_data->perf_ctrls.auto_sel = false;
 			return ret;
-- 
2.43.0

