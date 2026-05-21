Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7B3BFE2B
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363603; cv=none; b=hLio9IVTjmi8b0KiwVn7KLbRb8BCuaUf4oMfqSIzHXSLQmr5o1N/hIhCf2A2Xn6mKU3zwrx0uifBYY2obNiHcxgloFR06/BRPjKR0gS4NuLUSYw+tHl7FP6ZuPXmmEGvEzHvfhj7iYV0WKCSkupwLDV3sUSg1wA9MQTzpJUEK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363603; c=relaxed/simple;
	bh=TXozZuxdkl71d2jwFQaTqKLKds22/jErVaDSsm/B4HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1jNRyulwLx0JMT8o6lJHohGh+J53WlHuwuuT2BMVkiKoI9XwfxNUbyIQKU6CgHNhMoYYVtsSbLliCVe+W8ou+EliFpody2o/5Pb+W/fkY3602ABk5b0lzDgTqt3rT1/RLXgkKy96qukZ69J+ZSbANDxKKbkwUZ5UFfQt3FdIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=beEuJYcq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beEuJYcq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bd80b3aa13so38492375ad.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779363597; x=1779968397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs3qowURtJN+gCKL/1rUm7II82alOEYkmlO2Ptzn5OI=;
        b=beEuJYcq1g/mnV2+9BQmazrxQN4u3oT/pQnwu98lwb4tpX7+uFq/8rSDQkisqPUo98
         EpjAl4bdkf0Nj81LARuC1uepOL7v2Ph4Z8LR4gKRhsvdIix2z+TlNQetZYYX6A3Lcr10
         zrBpKcd/PI340uWKpqewOOsaU7EFbgzDGy/VTdRelGOE9w5LzG/InI/FAVvZozylzo+G
         Nn+4y8weDJpkVgwb+/xkDsjzRT55C3+o91YkuSGE1bwMb1+nfFQXny/kmK0nKEeyT1HT
         x+LHYl+C29b3pd8WXH9+MrJvAQdQsQtRPKLd1CkXyykgF38YDxMEG9oyC8TPDbqGwNev
         D2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363597; x=1779968397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs3qowURtJN+gCKL/1rUm7II82alOEYkmlO2Ptzn5OI=;
        b=aNh92TSpM56a35XDThBUOHa9Ei/UlryX0w0scFtdcMdXz6ezdunh2afIZVjtHAswjp
         IIZcCwjBJQ5nqq6AyW+05j0OzMVrpWJv7YFdQq77svDT3j4mWkIK9iTbg1Cepkopc/d6
         vyEboqb8yx5wN5xdZF8OpiRPAIs/1nkNzKXmWNKaMrDh2Pio3ktRJy/AG4B/2XqEg3ev
         Huk7LeS+2FMTS9lwl4PgAwRh3gH1oN/7oYYCm7SibTYVqsV+iPwCCcnkfXK/jiU/pfaX
         TUlHBYpC65naN6zsQwa7CH/n+V3gXVvZxkssng6djW9LXaDvywelXC6CptjJ0MzWAQ7Y
         xolA==
X-Gm-Message-State: AOJu0YyAU4OnpLGt42gae9CMA+xsg222P/xQWnfiunk6zfFXUnnss0od
	jKNfXrlKE7yMjPFS63wfGgKiZbmNN8DSH9kQIwc3wm2WT/cc0iWHVrvQAInpvFVSMX1ASzWvxo1
	FXASK
X-Gm-Gg: Acq92OGbqFtXxMq2BtA4do4gJva+QvC/QzgIWydVI6FFOJofKhsiQHyBZw06EenZCGs
	sSK0+1GBO753ymCoQ1lCVNZIhMXATuKvZPYD80IxIS5ngsjqjnxb1G5KNsOwkvnRWmYLhA8Lsz3
	LD/TYTKHxerPj7sSbx6zEB/V7hK2abFXZaddIVoFHY7TggJlDwEr6EbYglKOC0zxktPW6K1Y13W
	Ua4ZMDmz2PS9hDJcPWtzh/hcGsqpgJrmdzPWfXcJ8kvfGfyrOZLE9ZyPLgxERZHWhe+WOxVFjEb
	lVP76tv85vAorZ9t3UIjGwndlXrQAqPUpnG0nQxjSvbPL15O/Rck9Vg+g7nEQitryRoWJdnOEn2
	9pb9I7qovWGWOFZIOTW3pP1+ZxPg0pFOwe43IOvsXFcG5R645u4Ol7c6VP6YJA6o0X75NP76m9b
	IvwCQ2p56ClQ0OTz7ohJqmmks=
X-Received: by 2002:a17:903:4b2b:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2bea3392b75mr25294995ad.36.1779363597320;
        Thu, 21 May 2026 04:39:57 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fe2d5sm8660145ad.57.2026.05.21.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:39:56 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Thu, 21 May 2026 17:09:44 +0530
Message-Id: <4c0a951bc57b7fd5cacb6211a96770e5791b1fbc.1779360823.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers setting CPUFREQ_NEED_UPDATE_LIMITS expect target() to be
invoked even if the target frequency remains unchanged, so they can
update their internal policy limits state.

Currently the core invokes target() unconditionally whenever the
requested frequency matches policy->cur for such drivers, even if
policy->min and policy->max haven't changed since the previous update.

Track pending policy limit updates explicitly and skip redundant
target() invocations when neither the target frequency nor the
effective limits changed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c      | 31 ++++++++++++++++++++++---------
 drivers/cpufreq/intel_pstate.c |  1 +
 include/linux/cpufreq.h        |  3 +++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1..225228e9f4ed 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2366,9 +2366,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	 * exactly same freq is called again and so we can save on few function
 	 * calls.
 	 */
-	if (target_freq == policy->cur &&
-	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
-		return 0;
+	if (target_freq == policy->cur) {
+		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
+		    !policy->update_limits)
+			return 0;
+
+		policy->update_limits = false;
+	}
 
 	if (cpufreq_driver->target) {
 		/*
@@ -2620,6 +2624,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2652,12 +2657,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * compiler optimizations around them because they may be accessed
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
-					       new_data.min, new_data.max,
-					       CPUFREQ_RELATION_H));
-	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
-				      new_data.max, CPUFREQ_RELATION_L);
-	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_H);
+	if (freq != policy->max) {
+		WRITE_ONCE(policy->max, freq);
+		policy->update_limits = true;
+	}
+
+	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_L);
+	freq = min(freq, policy->max);
+	if (freq != policy->min) {
+		WRITE_ONCE(policy->min, freq);
+		policy->update_limits = true;
+	}
 
 	trace_cpu_frequency_limits(policy);
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..7f19ec6b70ba 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2942,6 +2942,7 @@ static void intel_pstate_adjust_policy_max(struct cpudata *cpu,
 	    policy->max > cpu->pstate.max_freq) {
 		pr_debug("policy->max > max non turbo frequency\n");
 		policy->max = policy->cpuinfo.max_freq;
+		policy->update_limits = true;
 	}
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4d4b4ed24b30..ae9d1ce4f49c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -146,6 +146,9 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
+	/* Pending policy->min/max update for the driver */
+	bool			update_limits;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.31.1.272.g89b43f80a514

