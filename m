Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D43C4174
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363607; cv=none; b=ZcmAwpz+0dfnFPAzXfZmIQwAKJheNjelICmflmvDa3NJNmXCN8a0sAPKNYrooNmDSGb57yg3UuTLxz+UKGjEgyB3V1OvDB+zdHf8adBE++Fk5QV8AwqXlPjYSZe5EEwYE1XAfpdmnqYWrW5oMBcXWDZexj/tH6FwvjWbq4uwVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363607; c=relaxed/simple;
	bh=pQ4lKOSky+okKyJJ38rg3764H9i9HXIvSDcXp8fVbOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kh12HIWaQRonyClX4o0uMFqvzgpETMdmj9q7eyngGIIeyhUeoRy3KhbuygQXdq6lEQYl+npluUB/9nU4Fg4uj8wdhqC8EF2aSjYcfF6MiE+30kFltlj+Ngq0kUizQrrtAqtu8x9fOfDLaEYBLOZQGPYW9hjjZl1e7JkHrf/YEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UAzuv2Ej; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAzuv2Ej"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c112cb61so4934283a12.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779363602; x=1779968402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alcEF9IOSOVztoeL/QUCwmXMUi5tZUGASBUQ3N7h7S4=;
        b=UAzuv2EjcepiNMTl9hG8NECcu3KYcR/1fT2jnYCjxnPq7vP8X0muH7l4ke5p+GqAte
         F2KMP2iM/sV3qcY7k3QqmTCcrNRB3HPiKnqx7IxyU2CccjwT/mVMaWm3o6ZtXNTEYqbM
         /EopWZJuCwbYvD6eCW+/w3eRccuKqRZEDkSveFBhTWGmvdomGp31VtMtpVCru93s/rn7
         Yn91PTEnyeafOYdNtJSiA0FsO1uipHFRsbr+bk80t2D9KkBAefqYlkmnK/YJ2gvXYADt
         LqqX9COMwvqbHTWxcL2OyE3hDfGclhIut79zGTi07b70fB8aZZHGph9visjUW5Y/XimA
         5CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363602; x=1779968402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alcEF9IOSOVztoeL/QUCwmXMUi5tZUGASBUQ3N7h7S4=;
        b=D+APuCqn0bI/1/E7/EwgqLkFBCFH6iwYJCx21F1q69oRsM7FgekhyAv9BkvmnQ8RZW
         s+weKrVdzkXu9PTj1F/iJsMRFxAJfmp5fvtwaJbaiz6rnvLF7ZiUKh0vYtEXhnsuFR2A
         PKDTKaIooo8+mtBzYPe+42m7kbYGaS6SUmQ21Dvhk1gHWuFz3P88m1/gHyrfu8Ofcqxr
         ahTTSTgeWeg3RvepaNE1k9AdNhc1hC+GoZ5Cu04NuJZ0/yAXsfoeCjs5ml3W3ZnxWHhK
         piegtjfuKYQ++YvFlDgEdQDMIax3Es/mdKk0o+G/T5mFW2ZqHDbNX03Unn4Q1+7YQ23Z
         ZSKw==
X-Gm-Message-State: AOJu0Yw5sOtyPk12CmtbhfkwZMaWBpdlUVrJ2bKStdvKL8byROLzXnPJ
	Xmt7VoKKHXc0EVovHud7OT5rD1pOM6xGQr+e0+i0j+jxKXq8I+bBEODRTTXJWXztihM=
X-Gm-Gg: Acq92OEQkZf8G2M3wl7IYnkd/2o44yHhtQ4C2Dk3FGDFwWAtuiIgTHLSJ2kEIoXoa/5
	WkoIBkQydRDNc2EZpNHUZ1lVq2baQiYpXr8fI32hQulD9gF1ZQNZ63fFX9TfoHRhT6sidfr/xJA
	JNOlXLJVdNA65zbTZzvhwzOsqIb1JVVYHN1umhvKO6NBY6BfbuajhOXEvyNqLkNSsDE9sin9ox9
	77j0XtchFbHpbuP5MuYuDEiVs7LS5Na7tmDjgFf/eNCe6bGzB8M6HnlF8HosGp1vAHeAsC/atOl
	wjVkuE3WY7LjOCYxvbhJGWmb4O4Y+oG8su6miCem+rfNKGN2ZxADiB7rzMIMO+5QOJQ3pRlzU8M
	MNks6Cp6Gn0GGDHza20feN7R2aHiXVKU3Xk4VrGpkoGuoVBMuxboINxCcidW2NmRMyZWlboWmPf
	9zQNmcxXZE5JQ596KQES7n3so=
X-Received: by 2002:a17:902:e74f:b0:2bd:6e1c:3ce with SMTP id d9443c01a7336-2bea33862cfmr27833855ad.20.1779363602247;
        Thu, 21 May 2026 04:40:02 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98ecc48sm8929655ad.50.2026.05.21.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:40:01 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stratos Karafotis <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] cpufreq: conservative: Simplify frequency limit handling
Date: Thu, 21 May 2026 17:09:45 +0530
Message-Id: <6547f3ab5278e46ec5f4482fab013b9c62fbe512.1779360823.git.viresh.kumar@linaro.org>
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

From: Lifeng Zheng <zhenglifeng1@huawei.com>

cs_dbs_update() performs explicit checks against policy->min/max
before updating the target frequency. These checks are redundant as
__cpufreq_driver_target() already clamps the requested frequency to
the valid policy limits.

Remove the unnecessary boundary checks and simplify the update logic.

This also fixes an issue introduced by commit 00bfe05889e9 ("cpufreq:
conservative: Decrease frequency faster for deferred updates"), where
stale target comparisons could cause frequency updates to be skipped
entirely after deferred adjustments.

Closes: https://lore.kernel.org/all/20260421123545.1745998-1-zhenglifeng1@huawei.com/
Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- This fixes the issue raised by Lifeng in a completely different way.

 drivers/cpufreq/cpufreq_conservative.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index df01d33993d8..0b32ae28ec85 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 	if (load > dbs_data->up_threshold) {
 		dbs_info->down_skip = 0;
 
-		/* if we are already at full speed then break out early */
-		if (requested_freq == policy->max)
-			goto out;
-
 		requested_freq += freq_step;
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;
@@ -124,13 +120,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 
 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
-		/*
-		 * if we cannot reduce the frequency anymore, break out early
-		 */
-		if (requested_freq == policy->min)
-			goto out;
-
-		if (requested_freq > freq_step)
+		if (requested_freq > policy->min + freq_step)
 			requested_freq -= freq_step;
 		else
 			requested_freq = policy->min;
-- 
2.31.1.272.g89b43f80a514

