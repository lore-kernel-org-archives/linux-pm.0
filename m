Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA3395254
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239194; cv=none; b=lf5IRiIhcGhT1GJVvVvKf61R4WJ60yh6oOCUWZgic1tKsYtbv7r0ORvQgbUhY6XbcOMVlwONrkU4GvDSgnrmyqh8y6QNyGJnd8cnziLsw+Br9kZGac3CoREPk/m33rvqXSZo3p7+cINAi2xPMIYCiO2fU+58tSMEQi3J4GlbCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239194; c=relaxed/simple;
	bh=9n1RvP17fserjXZKFvAHvgL52IYHi10a5qX7cWdWDpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnNKSNJ4HAxZS/wxSZ4GXQ67nPT//G8gssW7qhL31v+abMSD1sVZvvQXKvkwJvRCE5pl4V/QYb9+reNfomOYr3MOlGnQsizQdGGlGN84JQtpa8JZtAdreVB0jWs5YNVAQYMTjPrHVWQs1uib5qgU9W+K5qY9x3CXAWMnSY43hGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1365722b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 04:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239192; x=1778843992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUkFwkajaVekOiCVKQrl4E7oDyn2kxG0GWVyrnxa15I=;
        b=DVJ+VJwjfXozy7JqXALEe3rvIK+f8GZzPTPg8lgoiVksky+IBvlAyd1Kpa6dbsnjZn
         CHopY/tFZE2MxlwDItHQ0KO3J+Uj2xfYc+GcgKX4Q4o8XcfIPqr4e3hCj7QP+UGMViP6
         7YXdLVIQm+sF5F9iC1UcjUipgEhSRAqxtJ9eKpe7BUcxaLij9IyUQdixzTLIOSjUMYFP
         YV7e4eF/70r7CpCbhtOOzDqHasn0G7NQg9Vdpvt1k9pGYqtaSr5eraBMus1XxHAYl+hi
         yKxSwBofZWwjeYFCLewNX+swyEfIdgCz2E0MZ9Uf933nz1X71eWXip+4w3HNCaR1Fwn3
         3RHg==
X-Forwarded-Encrypted: i=1; AFNElJ8M8hij+2i7aV7iO0ZbepQEWBqLfJjUQY45+wN5IDl3zIf6oZf+sUml0nBs3FvimSqTKmFIlxBHJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeISGf8TW3bjTW2BM4C+8N0Gnz0zlkCgbQNwOzKXYQDnKXG66n
	4Hw9mV1mQUhC/N7pwaVBaPEG4ZsEsBPZ/4AXGobX8vdeKRtxkN7heNAl
X-Gm-Gg: AeBDievGCrJ7aM+CnGVfA50SkXu5tHMI1+QZxvOf4Od/EdlZ/tyvDXXjfhezgpeQtnK
	R3RWMxVIv9lpGZ7BRMzDArH5pxbd9bb8u99rs3wKsdjxJSIifbHyC5+UHVZ8zFqKmj14WcHeJ7t
	pFbmi5nBt0ZVojJgi5liT8roRcYoeDAiVsrj1Oc01DtVVMozRJNkBATMb8JOPkbqbaX0tpS+x4Q
	+8UbtIcI0Y0APy0lvEPRgBkDm2lk7YWfOmAkuy2JhDL+eQyUbCfEd86Y2Bx5JgkkokdKVsDGtf0
	fVzDIcmeogKpaB1+z+EiFF/ikRJZEh90xnO0M28grBRkn1aTl9TtGOMkHfLLI2P159Qb28hZmFO
	OGaclGKqAhluEXyyPOubFawHrIt9qui/diLCaV9ImXgf1C8LzrUu6yL/ntUW4E1b6Vay8GE+K6E
	mQuH5Ughfczpbzx8w70DsRCATQMHjCBi9P2M1H6918okLWYiupzyY9FerU6IHTExtvgaw=
X-Received: by 2002:a05:6a00:4b05:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-83a5dd5c926mr12311141b3a.32.1778239192025;
        Fri, 08 May 2026 04:19:52 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839683a088fsm11947041b3a.58.2026.05.08.04.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:19:51 -0700 (PDT)
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
Subject: [PATCH v2 1/2] cpufreq: cppc: Refactor autonomous perf limit programming
Date: Fri,  8 May 2026 19:19:31 +0800
Message-ID: <20260508111932.185886-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508111932.185886-1-luoxueqin@kylinos.cn>
References: <20260508111932.185886-1-luoxueqin@kylinos.cn>
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

