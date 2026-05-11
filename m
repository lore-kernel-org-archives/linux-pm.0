Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AD37D11A
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487315; cv=none; b=tYTnLy9MphZcJujmJyorfp2Sn39wBNLtBw0NlTI5IRqZ+qVe0jFwCAyKL75EvYZ01sskqAWdodyzVLVCiJMjtScHGNrZdPfY78glhOo+uA4obWm4DRPjMdj8vz3h8L2ksa9c/5vNgVAlLCM70Ey0SR2zK7uJgRaZ98CQbw+IW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487315; c=relaxed/simple;
	bh=wkfiffLi52YIzZgjn8/lfOs6K6OA7Q9OlhRyWbZa7TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORWPiTS0BPh8cL/wdfhN6Ezqm2KCJrZAdZHD5rYnW5LCGjNHRAiU0jq8dkQ/w8Wgeqx0GFRMx7uvMk46rSEiR1t+9dsTpHahaqWXFFZVZR0JXuVsb9EbU87reu4gmfiXsOd5bmY+KWifDzdonSWz6fS8neL7BdbUEtCCzRDsmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrrdUqry; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrrdUqry"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso46422435e9.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778487301; x=1779092101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cpOYK/PWnBE5Ev+XOjugs5UodjEu5rWKkqqtc/AIb0=;
        b=NrrdUqryh3HhSUyj3XMKRxQQLk7VYDSLMQ3bQlsK/UspvW/CgaBY+wDcT5k8gVVdTk
         80OuTEQfQk8pJQL6MQokEsnjFNLS+nNRlCYJA1HBAmiP+d/3IeX0go2ajA9XHXhhu/o8
         Ej0lLNxjhRp1RtEgfDXotzzrPd0rO7SOmBaaNT9KuBhjuv+n1uiv9IXUe68nvGPFezNM
         fN0vNiUlBWxzmtnUGiR+hp7FGkCiNO4iRaSx3Q72FpFkuVtoPOWq4ARmaX1epWejXwjE
         PL5/hSVryMiPXRQUz8EGugb7FBXvo21ATTLhYvsSXzbeob5SuEJcVN7RiLVZb0UenOSd
         VApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778487301; x=1779092101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cpOYK/PWnBE5Ev+XOjugs5UodjEu5rWKkqqtc/AIb0=;
        b=rKnP6/NA046bkyfe6VgHC5fMqlu+mHisql0tBrfaFkqlYU/4luCHZtytJVfEn6E13B
         jdFQ9cRA+pAL2EO8iBekHwMnGgUv5roNSIC1VkyEyJWvHma6GjUQruH0wPRwUss8YPmV
         aZV8cSWbLTXjxkiWm0go+tSvyLYQ9eNApxDM9iBrMzfGA+xtwwTpOwGK+l5U6oFl3+33
         3yIds2BAD3VbZgRFY6udLwtEEA8fP00fMr2B1Qs3a4WHe7ciawJ7PInPrYr8XzVXX0yJ
         5zIgQHuYx2J/6R/Uk9gXeMBqR7GFeTlqbWkIN5JxMWG+RUmc6iaoNeIw46dpBXxoi9bH
         I5AA==
X-Gm-Message-State: AOJu0YythpKzybh1OMCvthOxPltTzwqjDFU/MOu+70t4KQJVdGLbEZfr
	oV1sE7EVXLxeGNjXCueN7RLH24dq1/YQ229swIDqzg9CzTv/xXHaPYHT
X-Gm-Gg: Acq92OH+IfCpNySh89Qmpo4tyNv3FTBRfT9HpRi5Rvc3/0JC2tcEeS8RaN+UG87IzML
	FeDTSkBFIRhXGUfjdbjD5wM9NNGC6AxKX7PXaKnvPEwm6aShor04vpTUhHznZxX387vqk6QVriW
	hAxUpZemNUWY0tu7MM7XHoPCBKIOuFttqbSWai94E/3M4lPsS/CMAFguAFRZu5bRsHDc6jw0eO9
	VR6lBxVh0AhRUCTreeSgLHDgpXnU+1N0AUKB6QrGEF0iQUFqJrdHOG7ishHDKzhxNtbQ+el/3xO
	UdchbjFAyZWbckjCVKAjDP0TGp2uqsReSB2RdjvpXAw47GRd863IP/XW44EzEfK8jsoxhu5y1oO
	2C1uwAVpShegzUxAXlsBl97bm/7tRfwxMkb5ms+KH1RMoV26TrdjszA//fhUuDmnzH032Yi/e4o
	YOH9k/vCwwNlx/P9d5KDlKQA==
X-Received: by 2002:a05:600c:34c8:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48e51f2ed22mr399104145e9.15.1778487300716;
        Mon, 11 May 2026 01:15:00 -0700 (PDT)
Received: from user ([104.28.162.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm102472635e9.0.2026.05.11.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:15:00 -0700 (PDT)
From: yoy95104 <yahia.a.abdrabou@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	yoy95104 <yahia.a.abdrabou@gmail.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: Add better support for amd zen
Date: Mon, 11 May 2026 11:14:56 +0300
Message-ID: <20260511081456.306174-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On certain Amd Zen Laptops, Collaborative Processor
Performance Control (CPPC) is disabled by the OEM.
This forces to use of acpi-cpufreq, which uses a limited number of
fixed ACPI P-states. This can lead to worse frequency scaling
and higher temperatures during light tasks.

I aim to fix this by using a virtual P-state table.
By using direct MSR writes to MSR_AMD_PSTATE_DEF0, the driver can
provide better frequency granularity without the need of
the ACPI tables. This allows governors to scale frequencies more
precisely.

Signed-off-by: yoy95104 <yahia.a.abdrabou@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 136 +++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..a488a2e2f914 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,6 +50,13 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
+#define MSR_AMD_PSTATE_DEF0 0xc0010064
+
+#ifndef rdmsrl_safe_on_cpu
+#define rdmsrl_safe_on_cpu(cpu, reg, val) rdmsrq_safe_on_cpu(cpu, reg, val)
+#define wrmsrl_safe_on_cpu(cpu, reg, val) wrmsrq_safe_on_cpu(cpu, reg, val)
+#endif
+
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
@@ -57,6 +64,8 @@ struct acpi_cpufreq_data {
 	cpumask_var_t freqdomain_cpus;
 	void (*cpu_freq_write)(struct acpi_pct_register *reg, u32 val);
 	u32 (*cpu_freq_read)(struct acpi_pct_register *reg);
+	int is_amd_zen;
+	int on_ac;
 };
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -454,35 +463,50 @@ static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
-	struct acpi_processor_performance *perf;
-	struct cpufreq_frequency_table *entry;
-	unsigned int next_perf_state, next_freq, index;
-
-	/*
-	 * Find the closest frequency above target_freq.
-	 */
-	if (policy->cached_target_freq == target_freq)
-		index = policy->cached_resolved_idx;
-	else
-		index = cpufreq_table_find_index_dl(policy, target_freq,
-						    false);
+	if (!data->is_amd_zen) {
+		struct acpi_processor_performance *perf;
+		struct cpufreq_frequency_table *entry;
+		unsigned int next_perf_state, next_freq, index;
 
-	entry = &policy->freq_table[index];
-	next_freq = entry->frequency;
-	next_perf_state = entry->driver_data;
-
-	perf = to_perf_data(data);
-	if (perf->state == next_perf_state) {
-		if (unlikely(data->resume))
-			data->resume = 0;
+		/*
+		 * Find the closest frequency above target_freq.
+		 */
+		if (policy->cached_target_freq == target_freq)
+			index = policy->cached_resolved_idx;
 		else
-			return next_freq;
-	}
+			index = cpufreq_table_find_index_dl(policy, target_freq,
+							    false);
+
+		entry = &policy->freq_table[index];
+		next_freq = entry->frequency;
+		next_perf_state = entry->driver_data;
+
+		perf = to_perf_data(data);
+		if (perf->state == next_perf_state) {
+			if (unlikely(data->resume))
+				data->resume = 0;
+			else
+				return next_freq;
+		}
 
-	data->cpu_freq_write(&perf->control_register,
-			     perf->states[next_perf_state].control);
-	perf->state = next_perf_state;
-	return next_freq;
+		data->cpu_freq_write(&perf->control_register,
+				     perf->states[next_perf_state].control);
+		perf->state = next_perf_state;
+		return next_freq;
+	} else {
+		u64 val;
+		u8 fid = (u8)((target_freq / 1000 * 8) / 200);
+
+		if (target_freq > policy->cpuinfo.max_freq)
+			target_freq = policy->cpuinfo.max_freq * 7 / 10;
+
+		if (rdmsrl_safe_on_cpu(policy->cpu, MSR_AMD_PSTATE_DEF0, &val))
+			return policy->cur;
+		val &= ~0xFFULL;
+		val |= fid;
+		wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_PSTATE_DEF0, val);
+		return target_freq;
+	}
 }
 
 static unsigned long
@@ -675,14 +699,25 @@ static inline u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 }
 #endif
 
+static unsigned int get_max_freq(unsigned int cpu)
+{
+	u64 cap1;
+	u32 highest_perf;
+
+	if (rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1))
+		return 0;
+	highest_perf = (cap1 >> 24) & 0xFF;
+	return highest_perf * 100 * 1000;
+}
+
 static void acpi_cpufreq_resolve_max_freq(struct cpufreq_policy *policy,
 					  unsigned int pss_max_freq)
 {
 #ifdef CONFIG_ACPI_CPPC_LIB
-	u64 max_speed = cppc_get_dmi_max_khz();
+	u64 max_speed = get_max_freq(policy->cpu);
 	/*
-	 * Use DMI "Max Speed" if it looks plausible: must be
-	 * above _PSS P0 frequency and within 2x of it.
+	  Use DMI "Max Speed" if it looks plausible: must be
+	  above _PSS P0 frequency and within 2x of it.
 	 */
 	if (max_speed > pss_max_freq && max_speed < pss_max_freq * 2) {
 		policy->cpuinfo.max_freq = max_speed;
@@ -698,6 +733,21 @@ static void acpi_cpufreq_resolve_max_freq(struct cpufreq_policy *policy,
 	arch_set_max_freq_ratio(true);
 }
 
+static unsigned int get_current_freq(unsigned int cpu)
+{
+	u64 val;
+	u8 fid, did;
+
+	if (rdmsrl_safe_on_cpu(cpu, MSR_AMD_PSTATE_DEF0, &val))
+		return 0;
+	fid = val & 0xFF;
+	did = (val >> 8) & 0x3F;
+
+	if (!did)
+		return 0;
+	return (200 * fid / did) * 1000;
+}
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -735,7 +785,31 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	perf = per_cpu_ptr(acpi_perf_data, cpu);
 	data->acpi_perf_cpu = cpu;
 	policy->driver_data = data;
-
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17 && c->x86_model >= 0x30) {
+		data->is_amd_zen = 1;
+		policy->cur = get_current_freq(cpu);
+		policy->shared_type = CPUFREQ_SHARED_TYPE_NONE;
+		unsigned int max_boost = get_max_freq(cpu);
+		u8 virtual_pstates = 16;
+		unsigned int max_freq = get_max_freq(policy->cpu);
+		unsigned int min_freq = perf->states[perf->state_count - 1].core_frequency * 1000;
+		unsigned int step = (max_freq - min_freq) / (virtual_pstates - 1);
+		freq_table = kcalloc(virtual_pstates + 1, sizeof(*freq_table), GFP_KERNEL);
+		for (int i = 0; i < virtual_pstates; i++) {
+			freq_table[i].driver_data = i;
+			freq_table[i].frequency = max_freq - (i * step);
+		}
+		freq_table[virtual_pstates].frequency = CPUFREQ_TABLE_END;
+		policy->freq_table = freq_table;
+		if (max_boost) {
+			policy->cpuinfo.max_freq = max_boost;
+			policy->max = max_boost;
+		} else {
+			policy->cpuinfo.max_freq = perf->states[0].core_frequency * 1000;
+		}
+	} else {
+		policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
+	}
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
 		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
 
@@ -743,8 +817,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (result)
 		goto err_free_mask;
 
-	policy->shared_type = perf->shared_type;
-
 	/*
 	 * Will let policy->cpus know about dependency only when software
 	 * coordination is required.
-- 
2.54.0

