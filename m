Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B73612C5
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998658; cv=none; b=JRzXT6LARU1NyvghGlmIsRIYg2A0LOu25DA3c1FqdbFuV1jjve1MXHxvzq9JUymgki2s3by1pzi/Vfq4CL7RkM8x11ih8/l4uXflUFheHHJ463nY6nC5AIeNJfEn8U6sox3yoh+xx0ReF0Lq8OHj15Qsob+LWwGgHjNLuBTQRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998658; c=relaxed/simple;
	bh=ZldhROcxgvItdW8DHii9xckSpgyKxsjPPISMBoir5E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anenKBlkKn51l5znPkdQo6ISjfGQP4jmhiZSdp7tBA4Gg8+VQ4oeCHUA4ThfKMulQUxOCe8dtRYFwCJifl5YbGP36qjvD7pmSPcgsVe8qGuCyYJX4Nt87vDBeSpGg/L1Vb+u/KK37GFw4hIiUmlPA7mppBMtw7rTelgeUKkVdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kIdQYmM+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIdQYmM+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82418b0178cso975568b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773998656; x=1774603456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTH4enOyPD7ukLVidlBJbbw31EgYfFEascXcBByaReA=;
        b=kIdQYmM+Hhegx8HM34zJWmRJ+AZBdnMwTlprPF4HKonmiyuMJHYNaLZtGhLoA6ccLf
         cOOAVl4zp89b5MIfQRTep6i7g4W2EOsuiRyGaXSY7ndm5KRf6wq903rHTPbxJD4XfAYI
         0EK0+8RKeVIhmS/ydj+za/tj4vcp64287Omwbc5WPhJNivlG762zLWW4Gr9U3/B9q4MP
         Gf+QvCRgCOJ1mz1Km793GL1ZEr9JIXJMW9cN1OBnp46nye//pX8Z2eWIlyB10wqFApp1
         xK3Q7ZNiapT9yn82CmEyeZ95tywe6ta4Zo0+m5SmMgmP0siz+tsBGIRpuvqhsnQygObV
         47lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998656; x=1774603456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTH4enOyPD7ukLVidlBJbbw31EgYfFEascXcBByaReA=;
        b=mTlbH6fpfgVpAzJ/vp1lXvap6aqRPxWat0E9P5lhLpLbxT56NG7HcpsCh3SiNDApvr
         ck8ciMXJ8VrWJlbE3ogcCLFmbX5MiVf+rryBzSJiFp56S0PWaeSPqKskuWJ+ilLSZ3qA
         zsH27rG5yAWaRPDoC8WwbZWHVcz40mltey0b3JljxskmFbZPK+ZfvkC4Fvn+MVPM0vz9
         tfFcbUYp75aNQ/x4sqdJo1v1b46VfLbtO5Wh3stqmflQQOdVfS16qfr6z9hT5IVInaf8
         lqFEJR2EB2p0ykxqwS1am/2Z9MBB1mGA580HmOCGvNn0RR6OXuUcosHAFxqVa7zpfN6L
         Zyig==
X-Gm-Message-State: AOJu0YxO87WwnlwmWUS8snCxP67Ttkk40KOV8FwoZtCG1T1I52GP73F0
	lVQz5kC3Bcq13noH4pSVjtpyajuAKvUEEMAQ5babhCg8/FESRlbHvRo8X1SjTRhvzvA=
X-Gm-Gg: ATEYQzzJT9FGHw74Cb54Ssf2eiMpENTj7xxJVFy1C3aDBgHc8RTJN/jvOYly1SBnpmb
	XbgAkyJkmNkzghZBq8GsZd15PPZHv8k+vz+2ebdRyxWACEdkDQ96h73AmoPUeyh+lF25TmzNcBO
	sCEBgqUId/R/0KyK6px5Ej18nKe9xtg4Z4nHFZtPKsmo3NMiLO4JzEYpOfAgrhkc+wevipOIY2N
	BOijvPTmAOjxg7W7a0fVaV9+gPppV+XWo9NoQuSMvrkBqHfYycn7B1c++iR+OaAE4WdSGNVs3ND
	oCtRizUE8hx2nqeMQQfbABmEIOk55NkkjICa9lvie1N8omNd0RmXAiIu7CQy7CEhmhzRcP+tVrp
	lJF6wE4YUnsIZQ1SsOoUOhd3CuVVQ5MRQ3TBVeSfhuMxdzVybUG3fauIYc/b+eQroZsMZlpXEeY
	Tlbx/nRWshuvVtJKMl75KyPibt
X-Received: by 2002:a05:6a00:1949:b0:829:7b15:848 with SMTP id d2e1a72fcca58-82a8c3948a1mr1923634b3a.48.1773998655055;
        Fri, 20 Mar 2026 02:24:15 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040d7e56sm1505256b3a.40.2026.03.20.02.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:24:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Don't skip cpufreq_frequency_table_cpuinfo()
Date: Fri, 20 Mar 2026 14:54:06 +0530
Message-Id: <65ba5c45749267c82e8a87af3dc788b37a0b3f48.1773998611.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6db0f533d320 ("cpufreq: preserve freq_table_sorted across
suspend/hibernate") unintentionally made a change where
cpufreq_frequency_table_cpuinfo() isn't getting called anymore for old
policies getting re-initialized.

This leads to potentially invalid values of policy->max and
policy->cpuinfo_max_freq.

Fix the issue by reverting the original commit and adding the condition
for just the sorting function.

Fixes: 6db0f533d320 ("cpufreq: preserve freq_table_sorted across suspend/hibernate")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c    | 9 +++------
 drivers/cpufreq/freq_table.c | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913..1f794524a1d9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1427,12 +1427,9 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 		 * If there is a problem with its frequency table, take it
 		 * offline and drop it.
 		 */
-		if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
-		    policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
-			ret = cpufreq_table_validate_and_sort(policy);
-			if (ret)
-				goto out_offline_policy;
-		}
+		ret = cpufreq_table_validate_and_sort(policy);
+		if (ret)
+			goto out_offline_policy;
 
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 7f251daf03ce..5b364d8da4f9 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	if (policy_has_boost_freq(policy))
 		policy->boost_supported = true;
 
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING ||
+	    policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_DESCENDING)
+		return 0;
+
 	return set_freq_table_sorted(policy);
 }
 
-- 
2.31.1.272.g89b43f80a514

