Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504323B9DA9
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913294; cv=none; b=SQxdhXa9uEWgb3ksXhV1CaGGcEq9dsk6fIPldsR4xSVedyOWZ+o2WcPy/ji++cBXegvhcS99KYOXzRIu34zC4oBJmEB4RN6ruR6MTyzB0iS/mJXqxa3G7ha5rhm1LB4KSgkYFUtmbRARnAbI/+IlI/Aa2biCl3hWxQDwNF8XUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913294; c=relaxed/simple;
	bh=knC1iLcmb2hGYfNTc5+XPgSkUcd7yVDNve5fuQsDrQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfPIEF2V0e0q6lXk4lMUtWMugXdKuR/rvm5JzZzIzEkaxhI6/mjGn6NNFGnY4BxVWB0DHegLhCz4qIr5qSvW3g0LGmS3Ks62o916C4/VeqZOWfLpM6zvjyLmESZVe424T+i2Q3eKpLf9uLbQ4BZTxORPGM/P5S6As5HgHqk3a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so2532768a12.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 03:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913293; x=1781518093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4An1q01rPObVQlERNHoxg891xhTY5PU7L2NrPuilBo=;
        b=NtbN4FHFN3ZKvg4tRVJn1QL/vOCdfWXLgG68ij2g+/T4680ndeo2swGhogEZF/vQrz
         qmMr8r1btwO9Jka7tV8/2HeC8rzixILkGibKQhDRrDBjbKAfXdt2kohNLX3bTVJiu0ss
         7sWg/UPzMLvNVuZde7Ll9d4s8wuXSwjeGHA9Ft8RKKYaDWingPWgk0k6TlKmPS+naUPS
         gFV4v833E3MzNyvmEzfxv2sw3yYNl963LFR5nDtRIHIjEAbgJCjwJt9ZpRV9YMly5R3Y
         Jnacg7xbVM/LFyFAb94siYJFVEhAcUixrg2kqfmZFyKJ0WVca8W7f/RCVZ5FGl8obigo
         f6sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hk5mVIXvCQASyuzV9XYelP2+W4CahG5hLWaRKP4IRvPdTPg28pwWu5Rh3KaQbsbsD5IQGDUxdXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIIfjdBap/e3nHHnnnBMw942OW0ZSr/UtIiUKLlNrdQdrAETt
	fJS5N/fXxpJDzVTBOwA12LJ2v8cgMtT+aH2GLGCU75CMgGM2WC6x5ksF
X-Gm-Gg: Acq92OFDF2bNbVt7yTNvTdfdrsBQycW0klrPYoYSnITP+hacYPUPedWRJrnuGjO99w/
	Hf3WdxB6k3XTD5ziLgIIkgiTgLDn3EFhBnfG/bqB2i845hHS/Dp8/nkhy8fBownbYKowUZeJtYO
	UqPiFV5a6v/6rGBK09X72OBXwwMa/16+pSoW7Ome2yS6bUOapOWHgzafozsHZjI5zCWMlF+nnTX
	hSbw2mt2b8SnDqmBu5ZBYG97FAAiyw2pb2LfCYZiTuAKZBBOyfAFf+5XgWhWGZrWCfolLzONm8v
	C1+VnmKB4TO9UEGY/MUnUVcEskG23+6f5HfOjEDXvUA/KfstPtEyJnrA4QLrRvkd2cXb64zSQLv
	n1187JI38ahhP0xvB8/j6wvlIM0lWobFiy6IMv3GGvhPmJvj6vdMlCboGi2Bxnenfw/FkofdPmt
	uy/pTNVWBasJfBN0Lf4ZiHLNi5hwzGqWlDhuXFJ3wxt/Vnvr8FbaxglrA=
X-Received: by 2002:a05:6a00:400a:b0:842:4387:34b7 with SMTP id d2e1a72fcca58-842b0c06b07mr14497614b3a.10.1780913292683;
        Mon, 08 Jun 2026 03:08:12 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm20431045b3a.36.2026.06.08.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:08:12 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: sudeep.holla@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 2/3] cpufreq: cppc: Refactor autonomous perf bounds into helper
Date: Mon,  8 Jun 2026 18:07:45 +0800
Message-ID: <20260608100746.372535-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608100746.372535-1-luoxueqin@kylinos.cn>
References: <20260608100746.372535-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the autonomous selection performance bounds programming from
store_auto_select() into a reusable cppc_cpufreq_set_autonomous_perf()
helper. The helper saves and restores MIN/MAX performance on failure,
keeping the rollback logic co-located with the programming sequence.

Reuse the helper in cppc_cpufreq_update_limits() so that when
Highest Performance changes at runtime, the autonomous MIN/MAX
envelope is re-programmed against the updated capability. Add a
pr_debug message on failure for diagnostics.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 56 ++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 56f13086ccee..80a44a9a29fa 100644
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
+ * When autonomous selection is enabled, program MIN_PERF and MAX_PERF
+ * from current policy limits so that the platform uses the correct
+ * performance bounds immediately.
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
 static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -877,6 +907,18 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	/*
+	 * Autonomous selection mode uses MIN/MAX performance as runtime
+	 * hardware control bounds. Re-program them when highest_perf
+	 * changes so that the platform uses the updated bounds.
+	 */
+	if (cpu_data->perf_ctrls.auto_sel) {
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
+		if (ret)
+			pr_debug("CPU%d: failed to update autonomous perf: %d\n",
+				 policy->cpu, ret);
+	}
+
 	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
 		 policy->cpu, prev_highest_perf, highest_perf);
 }
@@ -923,20 +965,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
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

