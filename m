Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387080;
	b=S36O+lw8Uk+oze5pmmshKYTHX9WNWxUXll1JvaB/3hD5sWVLIf3uqwZiI01b326O5/4R
	 8hXZK19N5KknHvBi+ohPhev6sxnrMZVWgH/HS83SI8tse9piySgLcPSEywOyLpWpK8p1i
	 tQxjRuJAdSZD6Q6N+E1Jk/DB3FfiUNIb4ip7nF/liuoXo+ivu31LcIy2paNI3VtnY/jEH
	 AInRjmrNFx5SUe4Ekbkc37J6Me7cDkFrvbGuADN1E5SEDlFaB3XFwWDDjwcK8CCSH542O
	 1Cp+ONkiVZZ86ZxHkKThmd+H0sRyj65WZKqYXpR9Bm/OAIvk4MkCD0a0RLec9aRSkyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387080;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4FR4MYwSIUv0E3HeQxkRuXJTHYwYwGW3jDUR0WOXudI=;
	b=ilR/gBiTLpry3tpv8tkk3xjVnjn4Os1N1pO+RhBGvrVi1Z9vCrlbdgQzlmJgwV6CwQUC
	 K6JtLqQ/hUo8B2kLvsE9PcNYA0KRP/bFV0qau1bGbMpERMf6lG9Sqp29cCg1dtWipUt6X
	 qb/P0CmMp9nhgk91CIIEtmnvwpaN6Tt4wOzljRgLg/cbjLv6+M88cE9lRkJXvqdaYtkrH
	 QXJWgoIknKx9iwHluZfIRe/Pu9yynOvEOFCf//XaZofvdpWjRRAz5oA3IqVxE5zSEps+0
	 0SF+BE7NDTm+5wqQpbbHVvHEzJq4m4DDdAI8TgpVQ+X0u9YCFUYI/pNnKyTueqm/4ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE6606A324
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AE6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so878958a91.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387079; x=1794991879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FR4MYwSIUv0E3HeQxkRuXJTHYwYwGW3jDUR0WOXudI=;
        b=LGCrli2KFuTiiU+33wEeYhY7VRlAMKG9nVnUpIYy1IWuwHAc0ZN4npUY6rZMh1UpKH
         JMsIHv0IWnOst4CWcFCwgTcZuHXnjQrU2tQbi4cbDfooe7uIp1wDv3/2y5D+QPYNSO5M
         mT9eBCHRWwlLfeDbZdDlc6Mn5iIpl9KQF9qEyljkVstYLGwoS5fpwEAKNjS42CoI5F7X
         m2Xj0TVPJftw2wsd9AcDQmzQbzDlMu4MpTthPvsb4YfN+Xfb9dwG70j2UWCB2iUq7Z7j
         zGjwhVi0A8Ctlv+0jQUPCWNdP7OPzTY2L94ErK1iwn02XzDBFAWECjwHQdnQGye0/i6p
         iZIw==
X-Forwarded-Encrypted: i=1; AL+hErGYmuvDnn5fBu8mf5pOML5Gh2G4b2iaCO/bjOV+KWtfyeRp6m8YJQwxVyZdeo70Xigeqqwb2ivQwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8JbqR4/1ppW46PwW5WTLelKL8DMyFGBjpjGfXVEOjsnhzBFPsa
	FPT9aU6ZKPHAHzhw9uXhBiH6T2fWHo0fM1zbtaikMZDGgMhmsv8TTh9Q
X-Gm-Gg: AYBFou0A3cWVCnDHh9w7vr2/14cMIfxZHixuYbVhaCVK47+Gm7fL2A8qyeVWx17XfaJ
	P5VFh+B4CIvzY5C2m3QzqjRPZ5k+QZsiXC7Awsf3/23rKUQ7WhfM9I5uPYhGkm+myfzZ6Ek54R3
	Mv/BvJqLNJpQDjBeE7MDLr52X5m8ao3YGhlzLrKgLSHxC2TMxi+43gv17phJmSDRXB8VmmLCKgz
	ZyViFr3Ui5EjmXDW7v0kp5zcwh+yH4SwUFPZfkfzIz9bYRLYqkSgNXsPOU1MZRRlpb9hizkAymO
	1GjfMTQcd8KA7rnDREDPi0Q6e34AHPJIHUvEUbCjh+XIbQ64+z1rIHt72agvuSpehebeDXJWef8
	o5VIO4N1pM2534TEsRCPbYgtmL7bvJiDF7NMJG289JWdYVs1QpUPLju8SxearX5uP5hYGQSQesy
	vj+iyPBlzOvTb+mvCC9sHvjgkO7VVBp13sA7k0+xJnettj+JilPWL09UuKNRzw2BsmFqTXVkcQg
	CU3iwXE1hpPS17GNDH9Q3JmPuEhWau3EjCgHR7Cns702cc5J7L4LTlGvz2bqSFXxXB4uKKCnDu2
	DOgbV6VjLR8kGTN+OneniVtEjoGcjd356NEkxQz6KLTCm/jof5Q=
X-Received: by 2002:a17:90b:5107:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3b182e6a221mr1613865a91.16.1794387078688;
        Wed, 11 Nov 2026 00:51:18 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:51:18 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
Date: Wed, 11 Nov 2026 16:50:22 +0800
Message-ID: <20261111085022.1229866-4-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
References: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CPPC Highest Performance register changes at runtime
(e.g. via ACPI Notify(0x85)), the scheduler's view of CPU capacity
and the frequency invariance engine's reference values become stale,
as topology_init_cpu_capacity_cppc() is only called once during boot.

Keep raw_capacity allocated after CPPC init instead of freeing it,
and introduce topology_update_cpu_capacity() to update per-CPU
raw_capacity, capacity_freq_ref, and the normalized CPU capacity
scale at runtime. Skip updates when the value is unchanged and
reject a zero capacity_scale to avoid division by zero.

Call this from cppc_cpufreq_update_limits() for every CPU in the
policy so shared-policy Notify(0x85) targeting a non-policy CPU
still refreshes the correct topology capacity.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/base/arch_topology.c   | 77 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 10 ++++-
 include/linux/arch_topology.h  | 13 ++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e51fc9f5e976..f64f8e61f210 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -229,6 +229,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
 }
 
 static u32 *raw_capacity;
+static DEFINE_MUTEX(raw_capacity_lock);
 
 static int free_raw_capacity(void)
 {
@@ -370,13 +371,89 @@ static inline void topology_init_cpu_capacity_cppc(void)
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
+	if (highest_perf < perf_caps->nominal_perf ||
+	    highest_perf < perf_caps->lowest_perf) {
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
index 7dab6e046b9f..a693ef611caa 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -935,7 +935,7 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 	struct cppc_perf_caps *caps;
 	u64 prev_highest_perf;
 	u64 highest_perf;
-	int ret;
+	int cpu, ret;
 
 	guard(cpufreq_policy_write)(policy);
 
@@ -984,6 +984,14 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	/*
+	 * All CPUs of the policy share perf_caps, and Notify(0x85) may
+	 * target any CPU of a shared policy, so refresh the topology
+	 * capacity for every CPU of the policy, including offline ones.
+	 */
+	for_each_cpu(cpu, policy->related_cpus)
+		topology_update_cpu_capacity(cpu, caps);
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

