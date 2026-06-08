Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E83C1413
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913301; cv=none; b=uM/6unpy+U1zX8IgR1Pj/OnjM9mDCgMPVaOtMiZWPkliCj77+oCpRPqAMbJWX5RnMfEMuJL+7KIyo4lutfQ4T5G2V1CDBGbdUC22ec/Gap3gXY/MAK4+SsBRB6DVyCuHoZE4A+QWVLU8pd8ZwXY9HTD4xonpKQBblSYJU/5lWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913301; c=relaxed/simple;
	bh=QHom6DQvb3qerfbJujSJ+h7UCEEi/UjYiKCob5IRFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llazFNOZRIN7NatSWZiInJMBSIvUoWP+UShW0wW/34G7crEcKfwVxiTuT0ySmQ72cfJLFLNF+YFsxqzPf7efbKQUqwYKM4xa+PJ2nQwh30nBBPPeVrlqhuyn7cQAk9WSZ7yiBhUl4AE9FpmuPfhHNC7df2MivOb4OcvZwD214q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-84234c83142so1608289b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 03:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913299; x=1781518099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXzO+pAA1x56vEHUEe2bZreHvS4ZZVbejiMV5h8V3nM=;
        b=BawHLQVk2goRrRcgR2xMo+AeHejHXFDR9uM/bztXxwngx4PSZCbMh+khAuabRjLKHy
         rO4r36Qd+Az68JtFrMlWT2kRAd5vtRschkugLdMHIKife2I4ipQAThEspt673Ky4yXss
         3ffBiz6kuhlr2EEVuwg3VUebFT601WdiwdmFv/0/ZF7fWepI0pE3FdLdr4K7gLQThL21
         NSDE+M/LCFFu4ARZ+qFSofHkK9jplYFcWLudAro1ZMU+OQfDsxf6/VK04K77ajNJdlOX
         MOiWOuwQ1p0tQjlOWj9iCgWe0deDLCMJP/N1Ycw+p/3t1aH2mbFSNHpnbmXiEJ2y0y8u
         XNMg==
X-Forwarded-Encrypted: i=1; AFNElJ+U/GQY9uDjOfogQgaQ7i5Szrr5F1j/Mvclk0pvRiqWxblDTrCwn+4KKlU5465tMUVNySp4WVj5IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR99IxNk9eFOKYQN67LRN6j7CDKB6ROCvd09BtT4Tuaog4yELM
	/Hjxs3wmXDbngoaCV5IKuh9spWYiyJvX1J79KW/2xnaEzVWfX2DTatY/
X-Gm-Gg: Acq92OFNzxR2d7ICBnXglRrlkRQoh5bzazZEoxZMRePt/rZfX85/RqGvX/B6G3hZDgR
	HUa0lvWjlJnUbYGqRllT+rJxQt/4e2A/Ux3YiaVCNiZsuCj6tS73TCPwyu3Xli2/keHTbUufxi7
	b1Iza3p286V4fMm26ng7gKuowyH1gZC9csu+Eoo2cP/7Pp2jy4vVWbenkyq71emQjgmd538x8bs
	U08X5QVegUL9vqU4cn8ot1x/0YBRwAaOAyEF+M9JKnMZPNW43zAPpeAkHAwMM+5Usb0opJrNG33
	YAEx+lcCaT/nl5mY1zDhu77nz30LA+UQlnqHzuVFYojyKtxCEzhjpVpw5tOJ+z5zM840rGU8JR/
	G69fCOQIrq5f7Ml1jrn/lRcFcuEJXqCLuwYYRjpXXfDpTRVzD6znBz8VV85rjJkH3PSNKaR3T6W
	fftHNd1VQMApWdRbK50MDSIH97bufe/kpoC3B1YFNKx4IVMBbev+5VQlg=
X-Received: by 2002:a05:6a00:808f:b0:838:127d:a167 with SMTP id d2e1a72fcca58-842b0e6bb0bmr14186571b3a.16.1780913299347;
        Mon, 08 Jun 2026 03:08:19 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm20431045b3a.36.2026.06.08.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:08:19 -0700 (PDT)
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
Subject: [PATCH v4 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
Date: Mon,  8 Jun 2026 18:07:46 +0800
Message-ID: <20260608100746.372535-4-luoxueqin@kylinos.cn>
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

When the CPPC Highest Performance register changes at runtime
(e.g. via ACPI Notify(0x85)), the scheduler's view of CPU capacity
and the frequency invariance engine's reference values become stale,
as topology_init_cpu_capacity_cppc() is only called once during boot.

Keep raw_capacity allocated after CPPC init instead of freeing it,
and introduce topology_update_cpu_capacity() to update per-CPU
raw_capacity, capacity_freq_ref, and the normalized CPU capacity
scale at runtime.

Call this new function from cppc_cpufreq_update_limits() so that
highest_perf changes are immediately reflected in the topology
subsystem.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/base/arch_topology.c   | 63 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  7 ++++
 include/linux/arch_topology.h  |  6 ++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..c9594540b6f2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -229,6 +229,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
 }
 
 static u32 *raw_capacity;
+static DEFINE_MUTEX(raw_capacity_lock);
 
 static int free_raw_capacity(void)
 {
@@ -372,13 +373,75 @@ static inline void topology_init_cpu_capacity_cppc(void)
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
+	/*
+	 * Keep raw_capacity for runtime updates via
+	 * topology_update_cpu_capacity().
+	 */
+	return;
+
 exit:
 	free_raw_capacity();
 }
+
 void acpi_processor_init_invariance_cppc(void)
 {
 	topology_init_cpu_capacity_cppc();
 }
+
+/**
+ * topology_update_cpu_capacity - Update CPU capacity after highest_perf change
+ * @cpu: CPU whose highest performance changed
+ * @perf_caps: Updated CPPC performance capabilities for @cpu
+ *
+ * When the CPPC Highest Performance register changes at runtime
+ * (e.g. via Notify(0x85)), the scheduler's view of CPU capacity
+ * and the frequency invariance engine's reference values become
+ * stale. This function updates them.
+ *
+ */
+void topology_update_cpu_capacity(unsigned int cpu,
+				  struct cppc_perf_caps *perf_caps)
+{
+	u64 highest_perf = perf_caps->highest_perf;
+	u64 capacity, capacity_scale = 0;
+	int c;
+
+	if (!raw_capacity || cpu >= num_possible_cpus())
+		return;
+
+	/*
+	 * Serialize concurrent updates from multiple CPUs receiving
+	 * Notify(0x85) simultaneously. The normalization loop reads
+	 * raw_capacity[] for all CPUs, so concurrent writes would
+	 * cause torn reads and inconsistent capacity values.
+	 */
+	guard(mutex)(&raw_capacity_lock);
+
+	pr_debug("cpu_capacity: CPU%d cpu_capacity=%u -> %llu (raw)\n",
+		 cpu, raw_capacity[cpu], highest_perf);
+
+	raw_capacity[cpu] = highest_perf;
+	per_cpu(capacity_freq_ref, cpu) =
+		cppc_perf_to_khz(perf_caps, highest_perf);
+	freq_inv_set_max_ratio(cpu,
+			       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+
+	/* Re-normalize all CPUs: capacity is relative. */
+	for_each_possible_cpu(c)
+		capacity_scale = max_t(u64, capacity_scale, raw_capacity[c]);
+
+	for_each_possible_cpu(c) {
+		capacity = raw_capacity[c];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(c, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			 c, topology_get_cpu_scale(c));
+	}
+
+	schedule_work(&update_topology_flags_work);
+}
+EXPORT_SYMBOL_GPL(topology_update_cpu_capacity);
 #endif
 
 #ifdef CONFIG_CPU_FREQ
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 80a44a9a29fa..9fe96fa44435 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -901,6 +901,13 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 	policy->boost_supported = highest_perf >
 				  cpu_data->perf_caps.nominal_perf;
 
+	/*
+	 * Update the topology capacity to reflect the changed
+	 * highest performance so that the scheduler and the
+	 * frequency invariance engine use up-to-date values.
+	 */
+	topology_update_cpu_capacity(policy->cpu, &cpu_data->perf_caps);
+
 	policy->cpuinfo.max_freq = cppc_perf_to_khz(&cpu_data->perf_caps,
 			policy->boost_enabled ?
 			highest_perf : cpu_data->perf_caps.nominal_perf);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index ebd7f8935f96..fc0dbab76b36 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,6 +11,12 @@
 void topology_normalize_cpu_scale(void);
 int topology_update_cpu_topology(void);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+struct cppc_perf_caps;
+void topology_update_cpu_capacity(unsigned int cpu,
+				  struct cppc_perf_caps *perf_caps);
+#endif
+
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
-- 
2.43.0

