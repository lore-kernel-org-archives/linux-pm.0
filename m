Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C53806CD
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083145; cv=none; b=DgKevoksEeY7TDShBFqN6s71MgxgTfhcAJIFjbRGeruZD6w9QMUTew66ZbRDiXqDxtDDs0lpjiSra11nzQGQhLiV86vNtF8PnXQJFscJiVgZvJ/8cezwuZf5+1oEjn0PYEECHwM3LIwdsYNdK60Jnwd1yZAXHQAq0fEeXsUVCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083145; c=relaxed/simple;
	bh=mBdQuOd2+orI7EhARk3z3raKkDlXH+X/4B3FrZzB/fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaTttjDJljFkWWFUHMPyO1537R6n3L1owWpVgefFqNS2pzHw1IPwdJA8zekUryo+UaFROAKAVvw+JjbXqNxS596R86EsrGS4+OOtFvQYS17y0HdR7eK52uFKFYOOm74M0yjHSi4uBJIRyRyVLQFWbQ8gTf9fTXA2ZDwage7VoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso1045352a91.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 23:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083142; x=1786687942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2XI3tymrAXIanNBdwarSxOFR4nQgsGCTq88+6vG+F8=;
        b=Wbo1MdAxaqACIaqsvCi8We4/C/HWfsNGXzJMGEc3vF872Oe6gGXM83vSB5xCqb6wOh
         x9yHpzhDmjfPC8HgxOvddXejIrsjiCopSt7MCM82Urj8tmWiy2R1jva0Y9SpcBMvSULc
         noOHm7vdeya1xYiBGhFUyinECi5OUq/PWNOLylE08nkux3QHPsTl4VaXeA6SAV7dgh5Q
         zRO7iXiX14iF1ph8ijCDFTBhfKJf7CFVfpAhqOxcr5ZhghAb5wrW2G5+7c9hv53i9t0s
         gC2LU6LFJyPVFIvUgHHS7EtzoxJFKv4v8Tq5Cllm9siwpT4izoo3u36mo1vcsatPVunr
         Gjqw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7lsIlNdSo6eto0zADeV7ZC6B+7IR9b6bDu2W/iOxVdBbpA2i3z7WVNPWuzKJoPVxPe0dyN3t2BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySdmpgbE+EiF25RtgskO+cqlXF45tSXyoWyUHtLSm1BU/zp/Vz
	jen3/a0YnPxuPOOYPrsfJAcWVDW1GuxKLq/WtWaLOhohwIRtV7+yoIDn
X-Gm-Gg: AR+sD10EGymbLQV5kUf3FbdzOLi7dTTLCnCgpqGi7/GNY/+OAVzBxUMmGvXJjaGmTMb
	lOzMRrYePWHi8Wdqps+1wllFMzpKemv6i4nXsFBg0/ZWUU5eRTOU6qHbenzOgMmvc0NBR2hchEe
	G3AnG1REBQo5syj1tjTrvWy2AkAsyH5wSYqcZpwa6RcP+fJFZ8wBsMl8+Nnewz0BN5wJOFgnXKV
	x58AJgHQH36aYA94CkWtN0ANCs4XOeVbG7SBtbf6MXpHr1XMQ6p9j2hZEIqHCddoTEFM/qBEWz+
	b++0XJTkhwIieXMwUTCQhCHQrOeCDNBtUrdHfooPpfby44uBvwwI7QHLIcBpVnNISHVq6yd8NqZ
	r5z/E5u6+f3RTpp6z862KeOpk5M/YG930iL9tTC92gdNCT6L1vgbAgFkEdayABGeKFgmnl7cBfj
	z5WOqgt8086M9H16Ej018SiphiTPTsCluuaGNrbYUTpSzAu/aNV9TBzYQDlNoctsfMZSHpntX+k
	5Uiy73KiA==
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-3903c58bdd2mr20324647a91.11.1786083142215;
        Thu, 06 Aug 2026 23:12:22 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbe349sm3434375a91.4.2026.08.06.23.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:12:21 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
Date: Fri,  7 Aug 2026 14:08:48 +0800
Message-ID: <20260807060848.832929-4-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807060848.832929-1-luoxueqin@kylinos.cn>
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
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
scale at runtime. Provide a no-op stub when GENERIC_ARCH_TOPOLOGY
is disabled so cppc_cpufreq can link on those configs. Skip updates
when the value is unchanged and reject a zero capacity_scale to
avoid division by zero.

Call this from cppc_cpufreq_update_limits() for every CPU in the
policy so shared-policy Notify(0x85) targeting a non-policy CPU
still refreshes the correct topology capacity.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/base/arch_topology.c   | 76 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  2 +
 include/linux/arch_topology.h  | 13 ++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..27f2bfa9f326 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -229,6 +229,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
 }
 
 static u32 *raw_capacity;
+static DEFINE_MUTEX(raw_capacity_lock);
 
 static int free_raw_capacity(void)
 {
@@ -372,13 +373,88 @@ static inline void topology_init_cpu_capacity_cppc(void)
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
+ * stale. This function updates the per-CPU raw_capacity,
+ * capacity_freq_ref and freq_inv max ratio, then re-normalizes the
+ * CPU capacity scale for all possible CPUs and triggers a sched
+ * domain rebuild. If the value is unchanged, everything is skipped.
+ */
+void topology_update_cpu_capacity(unsigned int cpu,
+				  struct cppc_perf_caps *perf_caps)
+{
+	u32 highest_perf = perf_caps->highest_perf;
+	u64 capacity, capacity_scale = 0;
+	int c;
+
+	guard(mutex)(&raw_capacity_lock);
+
+	if (!raw_capacity || cpu >= num_possible_cpus())
+		return;
+
+	/*
+	 * Validate: highest_perf must be >= nominal_perf and >= lowest_perf,
+	 * consistent with the boot-time check in topology_init_cpu_capacity_cppc().
+	 */
+	if (highest_perf < perf_caps->lowest_perf) {
+		pr_warn("cpu_capacity: CPU%d invalid highest_perf=%u (nominal=%u, lowest=%u), skipping\n",
+			cpu, highest_perf, perf_caps->nominal_perf,
+			perf_caps->lowest_perf);
+		return;
+	}
+
+	if (raw_capacity[cpu] == highest_perf)
+		return;
+
+	pr_debug("cpu_capacity: CPU%d cpu_capacity=%u -> %u (raw)\n",
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
+	if (!capacity_scale)
+		return;
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
index 09d7745a609f..1480be537eaa 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -979,6 +979,8 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	topology_update_cpu_capacity(policy->cpu, caps);
+
 	/*
 	 * Autonomous selection mode uses MIN/MAX performance as runtime
 	 * hardware control bounds. Re-program them when highest_perf
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index ebd7f8935f96..9415cb6a6c2b 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,6 +11,19 @@
 void topology_normalize_cpu_scale(void);
 int topology_update_cpu_topology(void);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+struct cppc_perf_caps;
+#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+void topology_update_cpu_capacity(unsigned int cpu,
+				  struct cppc_perf_caps *perf_caps);
+#else
+static inline void
+topology_update_cpu_capacity(unsigned int cpu, struct cppc_perf_caps *perf_caps)
+{
+}
+#endif
+#endif
+
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
-- 
2.43.0

