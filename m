Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE226F29C
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933443; cv=none; b=PVj1BB2w+OOCMbaBhp5fm3iwbimSQtDk2bf2lGaBNFiOjHtCB11JflfGgYOzB8kXFePEZkRLz4cwunCRIFSRMdHcKli8xul3Vj5Uu3UY+mZZWyxs2/FPxEIEEnxtaEhzFX0aXUH/Gfp3gKk5ZrBcI0i8QlmFYzx+rVkSL09hTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933443; c=relaxed/simple;
	bh=1NSh/swu976NVuzV/HSvczmTa6ufvUbJP4waEsEU9QM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lRU1C0eYxBh11kRVU4ZtEKCT3a2eG7QkEjCXb+EHr+b90wAUrtrQNyCYJt5mBJimDwh/dCeOX2YxmT17bGM0/mBscw6jhlioSuDKRP/MeaGqvO64zHQlNvEHBSKpiCUYCOgUuweNM5LByB58M6OeDXL+NxxDetutOGosi+jWv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsAjKl5o; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsAjKl5o"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c238f1063so2589410a91.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774933441; x=1775538241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EThWSHxuvmimBlMnRXeRebZZ8M9RIPcyPhmfVOOBqeE=;
        b=UsAjKl5oP/gXrf2b53D8GTLJuoqwpvKHIdo6hmHW7uZEk+6u1UZh4jn6dVjKdT923Q
         oR1HS97riR5JWrzbSEuZn9fHEtI1r8SLp01kyvR9zbBB2OkJhdmFlDsusB2EBBGrzpZd
         jBzfrPK2/CN+FvSWtDoANm03T6w7l7gNpa2M3jJDmT9pjMikGJMYys8mJ1v1TyfP/SJn
         v2bOCzoDg1zgxc3wDsrULv/xMD/es2p2MAnuheDo/mFCntE4NLsIeoRABIfPIwgf0yPt
         bjN9HYnYVqmoOG/BnHNPWL+9Vgx2TMDytAXhLuRnVwzZFh1EzhAEd9bmsgo8Uws3RkRB
         ogSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933441; x=1775538241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EThWSHxuvmimBlMnRXeRebZZ8M9RIPcyPhmfVOOBqeE=;
        b=VSnM809ntmpVLXIsBB9pBCfQYqulNEqRTcnj+L0TsjFQVpmOA4EBY3SFonWoQAhpSa
         3FI2Ua2SfRfkt8IPNKszQ6QN30LPuKoI94ozF6HXnZb+TJOmQWlXBlKY8MWDsoA2sq6B
         jo9lwmc+Ua4Uzm27ClWnBpq4YHJ7jgB8bAej8AsBl73T6QnIUd66ZndTrPnVS9YsqqV1
         Pkf/j1jL4smrMa4P9uuvI3he6zvOo2gHIh5/dUoZXAJ+m+lUczpg0Tk1QI2afbA/lx+w
         dKFxegpEOj+TgkGBLlla2uNmPSEYGqRAvnJKtyrx+Ad8V/cfA/TfUuITCsLZuMF8FkOo
         LwmA==
X-Gm-Message-State: AOJu0Yz1kPGqiW6xwOcK64PleRG77nOJl9vcfv7Qwug1n4/oodtm8vyK
	aNOaYVSE1859V+qUprEE+HZA6jDk6E7vXPzUAwpg60r21HJrAVp2W3+EibUFZdLOhlE=
X-Gm-Gg: ATEYQzwL/rBxwiFk0oMnl07rc+6cQljlOk7x0LncoLHnNHQxKXXH3r2s9x9p0V917xn
	7UYEbKI/cxrEIkcXJ4rf4Gi/kyQz62/tnr4yBmLpcymLGSEUdp94hv/qQswzLLiAE9iFIbml9SG
	2C4CJbQ96uv/DZj4bCGHVRqn+3NhgT/pDjFPY7cxnBThvfc+pk5+AVyQ4XvkBhvo8fvCLVVwpt8
	ow4lYuUWmm+mZmk2S5koWM2avYrlqhfft/5/hAz8Fxtsqa2Ade8FaR7PZtPPQqPMn8P1bZK6Cy2
	ARgVq1HuODeujSdaujHQGS9Ai5HDDMgi/cSVc14IvWQ2l6i70YIY7BO6/yFdquEBYjILWRWLU1i
	dwnJrzcPKXguuWKS1ckmmM3KYQv0kI5Puoxm6pFeJxX1NyExvx12jVfiKZhMHePlxjhGtCfWsWX
	5MMA9qfuFR/I5AM/x4y2AdWXsQ
X-Received: by 2002:a17:90b:4d0d:b0:35d:a542:2dbf with SMTP id 98e67ed59e1d1-35da5423441mr5772668a91.20.1774933441300;
        Mon, 30 Mar 2026 22:04:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba33bfb9sm364425a91.0.2026.03.30.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:04:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Allocate QoS freq_req objects with policy
Date: Tue, 31 Mar 2026 10:33:46 +0530
Message-Id: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change exposed a bug in the error path: if
freq_qos_add_request(boost_freq_req) fails, min_freq_req may remain a
valid pointer even though it was never successfully added. During policy
teardown, this leads to an unconditional call to
freq_qos_remove_request(), triggering a WARN.

The current design allocates all three freq_req objects together, making
the lifetime rules unclear and error handling fragile.

Simplify this by allocating the QoS freq_req objects at policy
allocation time. The policy itself is dynamically allocated, and two of
the three requests are always needed anyway. This ensures consistent
lifetime management and eliminates the inconsistent state in failure
paths.

Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Fixes: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 53 +++++++++++----------------------------
 include/linux/cpufreq.h   |  6 ++---
 2 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c0aa970c7a67..f4a949f1e48f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -614,7 +614,7 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 		return ret;
 	}
 
-	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
 	if (ret < 0) {
 		policy->boost_enabled = !policy->boost_enabled;
 		cpufreq_driver->set_boost(policy, policy->boost_enabled);
@@ -769,7 +769,7 @@ static ssize_t store_##file_name					\
 	if (ret)							\
 		return ret;						\
 									\
-	ret = freq_qos_update_request(policy->object##_freq_req, val);\
+	ret = freq_qos_update_request(&policy->object##_freq_req, val);	\
 	return ret >= 0 ? count : ret;					\
 }
 
@@ -1374,7 +1374,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	/* Cancel any pending policy->update work before freeing the policy. */
 	cancel_work_sync(&policy->update);
 
-	if (policy->max_freq_req) {
+	if (freq_qos_request_active(&policy->max_freq_req)) {
 		/*
 		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
 		 * notification, since CPUFREQ_CREATE_POLICY notification was
@@ -1382,12 +1382,13 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
-		freq_qos_remove_request(policy->max_freq_req);
+		freq_qos_remove_request(&policy->max_freq_req);
 	}
 
-	freq_qos_remove_request(policy->min_freq_req);
-	freq_qos_remove_request(policy->boost_freq_req);
-	kfree(policy->min_freq_req);
+	if (freq_qos_request_active(&policy->min_freq_req))
+		freq_qos_remove_request(&policy->min_freq_req);
+	if (freq_qos_request_active(&policy->boost_freq_req))
+		freq_qos_remove_request(&policy->boost_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1452,57 +1453,31 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		unsigned int count;
-
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
 		}
 
-		count = policy->boost_supported ? 3 : 2;
-		policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
-					       GFP_KERNEL);
-		if (!policy->min_freq_req) {
-			ret = -ENOMEM;
-			goto out_destroy_policy;
-		}
-
 		if (policy->boost_supported) {
-			policy->boost_freq_req = policy->min_freq_req + 2;
-
 			ret = freq_qos_add_request(&policy->constraints,
-						   policy->boost_freq_req,
+						   &policy->boost_freq_req,
 						   FREQ_QOS_MAX,
 						   policy->cpuinfo.max_freq);
-			if (ret < 0) {
-				policy->boost_freq_req = NULL;
+			if (ret < 0)
 				goto out_destroy_policy;
-			}
 		}
 
 		ret = freq_qos_add_request(&policy->constraints,
-					   policy->min_freq_req, FREQ_QOS_MIN,
+					   &policy->min_freq_req, FREQ_QOS_MIN,
 					   FREQ_QOS_MIN_DEFAULT_VALUE);
-		if (ret < 0) {
-			kfree(policy->min_freq_req);
-			policy->min_freq_req = NULL;
+		if (ret < 0)
 			goto out_destroy_policy;
-		}
-
-		/*
-		 * This must be initialized right here to avoid calling
-		 * freq_qos_remove_request() on uninitialized request in case
-		 * of errors.
-		 */
-		policy->max_freq_req = policy->min_freq_req + 1;
 
 		ret = freq_qos_add_request(&policy->constraints,
-					   policy->max_freq_req, FREQ_QOS_MAX,
+					   &policy->max_freq_req, FREQ_QOS_MAX,
 					   FREQ_QOS_MAX_DEFAULT_VALUE);
-		if (ret < 0) {
-			policy->max_freq_req = NULL;
+		if (ret < 0)
 			goto out_destroy_policy;
-		}
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b6f6c7d06912..9b10eb486ece 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -79,9 +79,9 @@ struct cpufreq_policy {
 					 * called, but you're in IRQ context */
 
 	struct freq_constraints	constraints;
-	struct freq_qos_request	*min_freq_req;
-	struct freq_qos_request	*max_freq_req;
-	struct freq_qos_request *boost_freq_req;
+	struct freq_qos_request	min_freq_req;
+	struct freq_qos_request	max_freq_req;
+	struct freq_qos_request boost_freq_req;
 
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
-- 
2.31.1.272.g89b43f80a514

