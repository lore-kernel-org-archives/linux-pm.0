Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147D55C315
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981858; cv=none; b=lNdO3rqNh7u8X8/dw7GqrrTOfTvG1sE7JLQS4HwDUCJ7htA4MV9KEJG4bBAHd+BM+6/pULT49zUfCDFlig11eBeZ/Rhk0gkY5Q6f00LwM5wD0AxuIx8fs/4lu4JawXiuEb0+wuPEsXLaCDPlds525XsGVJWZmg9I49S6PhW5Y9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981858; c=relaxed/simple;
	bh=nEewE9vNn2GKeus40xjVARF+cnc+CRqiCdYnkkQKlwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrM13w48M76XIKResEn/0ALvF4ROP89JRPmo7lq8bCAJLGLWNGbHKlaDt5fiujPhHomX2PNVopVuVw2QDGO+l4VJhnxIau5dfGkdOj2UB2T63oC0Sk9UA9QRfAmjRpkCmRY8P80CW1WtWg2ttvo1nzlD5Ak0w+lCQbS4/3JNa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGFVHknF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGFVHknF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso53800025e9.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981854; x=1789586654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xU/TVU9R6QqVQBU8DMj4Dr025QCTEz1Y5w5z0voxEUA=;
        b=OGFVHknFhzOw4audTOZBQVJ88n/kzsb7VO/F1kywWGgHZBIpqVu0/YJWXueKYD1AWH
         BPWGb2NvG1jMYxIUw/+X1VFk55QSI8FrD47eVQ8HJ4h4is5Bynrth8DSxuVUMsNKjKp7
         Fip6DyJXIAMP4WTNls8WubPtPl8wpD/+xkf9BkKyGqOf91xeUoQ6wLeyH4fSGuuFzJO6
         n+N1PAlco4ed3PgMEIMEXBewQBAKSsWhrDj/ovzYAH56K6qfbMU8iE1WyoqAZj7na0aY
         7cjeW2NJLcViGXzkDcIet+efWwNOufFo2LC0GroE2R7439d8RoLfYWlaSE32ORWcwWzY
         yGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981854; x=1789586654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xU/TVU9R6QqVQBU8DMj4Dr025QCTEz1Y5w5z0voxEUA=;
        b=E6CuwuXv6zzTzf21FQw92JxOMXe5oQ7teW7GdsNV+b1QOHTD71daKxaOfETI1xRbIN
         bQembS4fHD47wu8GswynsQz23fz31NlB2n5Z0BHscuKnkIauaK0O20f3v5XsXRGJYlTk
         J9RaZyscF/QjABERXZ7ZEJSlv/AueHKnu2E9ndEO7ZZsdWwBxw3G9tg9mkmUtjlichw8
         YLrBVTIosLL+t+NXWTmoiyf6Q0Jdc9SfIY7aTy4qdnq6LFghGrHFOcE82oOtgoK371sL
         qOb1jz7dtNax6KyixfNmtpRZnT6TAJe/Di5EfGZROQXtTa7wYCGE0KR7usIq9V2rerTX
         D8aA==
X-Forwarded-Encrypted: i=1; AKwUvByvmL9uITGyjm6/W9E+DZmmm/xE2+t8YzR94g4Az8Pj7FVHbvmH4l9Cq4epVOxrKki1Lk5JAAo/2A==@vger.kernel.org
X-Gm-Message-State: AFuF++n3gtW3W4+3kHkOZ693wKwFfzq84waP3A2bKYwCuoUB4yEEK0gu
	VEHZ5cKR1ssrbUjPXqH/vC1SnHnppc5NR4TtywRQHe0O8f9QynDLWvd8
X-Gm-Gg: AYBFou39DTySWsRg6s4NdI1/C0SuCwrB4mO0q0p5hivbnC86kVUz3aZJGRIXlUK2CUq
	Amio/PwS0h7HTa8wygBcoze6E9I7tTXkmZofn712zxroeEiENFG9olLN0fEmDjtB+uYVs1CrfDX
	AVC0Fiyqz+oJpD4sxrkR0XeWEvhnEbLof+EMnesU9N/t+huitaK+7LsLguksdfjHknltR78O1Vc
	UoZ1oOqpinRIze1zzeXGsxCrIuA8OL2q44NIBYFGHMLzB4kst51UYmPT2ptzC+aeyt+srOFCQQQ
	LfOkSk9ZPYp6x9hR5aLpx4/wtk65giZN/C0Eq8DTOnPf/8WjcpJo9lfW1SPTIAl8jvcXeo3fRZN
	A2Gf3J/bClN+f0S1Sb5J67ujBchZ3VhUQdBtkgGG8MbstP3xffR/nv1wE06hCzHZR0cnS0wffsM
	dmFNNbdTM6Y4WuhxLjErTN/Tlagp15MIBBZemilFLG44PkqA4JR556SpuinYNmNNDCr/bRpom9c
	Spnvggdp7I7E/MdB+pUxyWSFAgD11hSx4ZeN921crUYhPZlzaJr4Do=
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49cf82a514cmr391436765e9.16.1788981854243;
        Wed, 09 Sep 2026 12:24:14 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26bf9490sm10925625e9.9.2026.09.09.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:24:12 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 2/2] cpufreq: update capacity_freq_ref when the boost state changes
Date: Wed,  9 Sep 2026 21:23:51 +0200
Message-ID: <20260909192351.33910-3-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192351.33910-1-okerixx@gmail.com>
References: <20260909192351.33910-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

capacity_freq_ref is latched from policy->cpuinfo.max_freq by
init_cpu_capacity_callback() on CPUFREQ_CREATE_POLICY, and never
updated afterwards.

cpufreq_frequency_table_cpuinfo() excludes CPUFREQ_BOOST_FREQ entries
while boost is disabled, so on a system that boots with boost off the
latched value is the non-boost maximum.  Enabling boost later raises
policy->cpuinfo.max_freq but leaves capacity_freq_ref behind.

Two things then go wrong on arm64, where the AMU drives frequency
invariance.  amu_scale_freq_tick() caps the computed scale at
SCHED_CAPACITY_SCALE, so a CPU running above capacity_freq_ref
saturates at 1024: the scheduler cannot tell a boosted CPU from one at
the sustained maximum, and utilisation is underestimated.  And
arch_freq_get_on_cpu(), which reverses that computation, cannot report
more than capacity_freq_ref, so cpuinfo_avg_freq is pinned to the
non-boost maximum.

On a Snapdragon X2 Elite (Glymur) laptop with a 4032000 kHz sustained
and a 4723200 kHz boost OPP, cpuinfo_avg_freq reads exactly 4032000
while the CPU runs at 4723200; a fixed workload completes in 1.72 s
rather than the 2.01 s that frequency would imply.

Factor the update out of init_cpu_capacity_callback() into
topology_update_freq_ref() and call it from policy_set_boost(), which
is the common path for the global boost knob, the per-policy one, and
the CPU online path.

Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 19 +++++++++++++------
 drivers/cpufreq/cpufreq.c         |  2 ++
 include/linux/arch_topology.h     |  1 +
 include/linux/cpufreq.h           |  7 +++++++
 7 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index ad36b6570067..a776a79885ee 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -11,6 +11,7 @@
 #ifndef CONFIG_BL_SWITCHER
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_set_freq_scale topology_set_freq_scale
+#define arch_update_freq_ref topology_update_freq_ref
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
 #define arch_scale_freq_ref topology_get_freq_ref
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index b9eaf4ad7085..a4b96a7ee4a5 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -22,6 +22,7 @@ void update_freq_counters_refs(void);
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_tick topology_scale_freq_tick
 #define arch_set_freq_scale topology_set_freq_scale
+#define arch_update_freq_ref topology_update_freq_ref
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
 #define arch_scale_freq_ref topology_get_freq_ref
diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
index fe1a8bf6902d..a363d72c174f 100644
--- a/arch/riscv/include/asm/topology.h
+++ b/arch/riscv/include/asm/topology.h
@@ -11,6 +11,7 @@
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_tick		topology_scale_freq_tick
 #define arch_set_freq_scale		topology_set_freq_scale
+#define arch_update_freq_ref		topology_update_freq_ref
 #define arch_scale_freq_capacity	topology_get_freq_scale
 #define arch_scale_freq_invariant	topology_scale_freq_invariant
 #define arch_scale_freq_ref		topology_get_freq_ref
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..79eb1681065d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -317,6 +317,18 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+void topology_update_freq_ref(const struct cpumask *cpus, unsigned int max_freq)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		per_cpu(capacity_freq_ref, cpu) = max_freq;
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+	}
+}
+EXPORT_SYMBOL_GPL(topology_update_freq_ref);
+
 void __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
 {
 }
@@ -392,7 +404,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 			   void *data)
 {
 	struct cpufreq_policy *policy = data;
-	int cpu;
 
 	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
@@ -403,11 +414,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus) {
-		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
-		freq_inv_set_max_ratio(cpu,
-				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
-	}
+	topology_update_freq_ref(policy->related_cpus, policy->cpuinfo.max_freq);
 
 	if (cpumask_empty(cpus_to_visit)) {
 		if (raw_capacity) {
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96515880b4ac..a70805a1d9d3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -594,6 +594,8 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 		return ret;
 	}
 
+	arch_update_freq_ref(policy->related_cpus, policy->cpuinfo.max_freq);
+
 	return 0;
 }
 
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index ebd7f8935f96..4974f5e1a7fe 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -31,6 +31,7 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq);
+void topology_update_freq_ref(const struct cpumask *cpus, unsigned int max_freq);
 bool topology_scale_freq_invariant(void);
 
 enum scale_freq_source {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35ce665edfd8..5b904e13eb21 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1235,6 +1235,13 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 }
 #endif
 
+#ifndef arch_update_freq_ref
+static __always_inline
+void arch_update_freq_ref(const struct cpumask *cpus, unsigned int max_freq)
+{
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.55.0

