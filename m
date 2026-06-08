Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F663BE659
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913287; cv=none; b=SxKZctaXr6jdo65DzD/aXnJk2IfxJmwNOtAm6FQLsGZogsyHLoejv81vCPKpc/iwQxcKxGP6CRoi/jG1ie4O8U4CTVGxq2UBE7u64gcPaWB4K2PTcPRNp/IuSmpBjN5wzNOonykik43x8SxNUx+5iPZPNv6N0TuWrgZBn451esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913287; c=relaxed/simple;
	bh=0/KOApqABNEV7wcH8Mg00s8dvOA0OiTANlcC3Ua4Fts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqP3OyRZ5L3quMC06kKbjgJTizCKWmbOosBKK8k3RxpXuox9+ZoX/iBcB5iC7gcLt0iPWJUMRTp4AmXJPopEvj7IdQLIgjvP61xA+ZQfdEPASMHgj0VTn3jOvjXafUtLNXkPRq3x8seMiV5olJGQnkFn/ckvtxfJWe3uX08bcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-84230ab8857so1749295b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913286; x=1781518086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OE6TqXmf2pbUoWDnLCFA2nmSGpG6upG2Z62wfNJ5Ups=;
        b=c8SWqMi1gR5q/WPIQ9UIpc81fXG5wiwqb4Zxs/HJ78r6Q/PKwnnGnTW/2/U2CA/t1y
         nhIuf3RkwrpNobdFeXfPSyltjNqKY4hvYz0z13zBsbkswisQOQUomcGcADXopP0QTNrM
         vNr3iO5aDZjhaSvmpewlzHOfEENBPB6nLqWF2fRoMopyaAhUmzGqNBkmLscNE4mue7im
         bjVdOmL0UTYf+VSaRTJZ/u7UjZ7VFOKyZM4yNOoKDSnD0cyp9Y9nf/szSOU9cEhPuxBh
         L2mVrNB0e91ajLg1Zi8QzQrfLJXhlYUpQFY4WqMWgthWj/JlQuLglM2VVwhxw9HD5eHv
         znmg==
X-Forwarded-Encrypted: i=1; AFNElJ/rppe2717akcT+5eAqI0FsTEWGLS+rX7zSKI0OFz0jBjrNZF3zxoGf8LVM94IkDDdee+vuLz/SKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRVnYLP7yp/VImqsLGFu+/KfO92IDC6dtw16TsS61Igz2HfuN
	4dfMuVOBOxhBv+vBJlBvgB/uVeM0gDVPnVRfdF8yLdaQsrWb89Srx/47
X-Gm-Gg: Acq92OHq8b6O9o9bJR/Pqppc74uDy5RrDchkyTreH/AnZis7olTqXWnEEwQtWslUg+m
	lV7ljjr7KjdV8ljpHyuISOCot5BHV9f9ev8v5a+ObWhHVZhZL26Wt4l0pg8jQG9YUHF/3H32lnw
	pV2G/cnm2QKXorB8HOdL7hKyrGEiAqKha1vWShv4sE9yoONTnTqMEDm9qez9nnoqOGI8Wht3xPD
	YAOKrUhtqgHyAmk/fz/xbWnyb/ETSx5auz8aoGQBphx2C/D7EgBtXNDppcy1nZimmDYiLz3prDi
	VBJG22XbyLTUxWA1RzMb9iVvrDtMOq+/5bH62sL1S63dG6x6obrE6b/mPPm7WKd3jCiGvMH6h16
	AFF24b68/PnyKHGXKJrnblgj8OMfLkiCV4/IqpZYmPJkWKAA8tzDK85CZKFqCUhHWEF87g/FeTw
	ChJ8ihogpO5LBmKEhmAPvMDUWLHVXzoVaVVH/ToAs+vTb2w1Kac2nTpvk=
X-Received: by 2002:a05:6a00:2d8c:b0:842:5da3:9b83 with SMTP id d2e1a72fcca58-842b0f8ffdemr15173216b3a.33.1780913285884;
        Mon, 08 Jun 2026 03:08:05 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm20431045b3a.36.2026.06.08.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:08:05 -0700 (PDT)
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
Subject: [PATCH v4 1/3] cpufreq: cppc: Add update_limits support for Highest Performance changes
Date: Mon,  8 Jun 2026 18:07:44 +0800
Message-ID: <20260608100746.372535-2-luoxueqin@kylinos.cn>
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

ACPI CPPC specification requires OSPM to re-evaluate the Highest
Performance register when Notify(0x85) is received for a processor
device.

Implement cppc_cpufreq_update_limits() to refresh the cached
highest_perf capability through cppc_get_highest_perf() and update
policy->cpuinfo.max_freq accordingly. Use refresh_frequency_limits()
to let the cpufreq core update policy->max via the standard
cpufreq_set_policy() path instead of setting it directly.

Re-evaluate policy->boost_supported when highest_perf changes, as
boost capability depends on highest_perf exceeding nominal_perf.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bf5175f7551c..56f13086ccee 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -843,6 +843,44 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 prev_highest_perf;
+	u64 highest_perf;
+	int ret;
+
+	guard(cpufreq_policy_write)(policy);
+
+	prev_highest_perf = cpu_data->perf_caps.highest_perf;
+
+	ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
+	if (ret)
+		return;
+
+	if (highest_perf == prev_highest_perf)
+		return;
+
+	cpu_data->perf_caps.highest_perf = highest_perf;
+
+	/*
+	 * Re-evaluate boost capability based on the updated Highest
+	 * Performance. Boost is supported when highest_perf exceeds
+	 * nominal_perf.
+	 */
+	policy->boost_supported = highest_perf >
+				  cpu_data->perf_caps.nominal_perf;
+
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
+			policy->boost_enabled ?
+			highest_perf : cpu_data->perf_caps.nominal_perf);
+
+	refresh_frequency_limits(policy);
+
+	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
+		 policy->cpu, prev_highest_perf, highest_perf);
+}
+
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1036,6 +1074,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
+	.update_limits = cppc_cpufreq_update_limits,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
-- 
2.43.0

