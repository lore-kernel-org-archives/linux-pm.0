Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB18375AA2;
	Fri, 20 Mar 2026 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006489; cv=none; b=ZJ056Xzl9EY8D9S/NOJL8DkeSDE1YlP5Lao8jZdcSpj4jNXQe2QpLYojQHtXSjbMPMaIcEn+SRsWksVndQbU7dNOB4hDJHqD1K6jkJzkhiwL1dDgaJCs/frCOPoeX07OCCn9jUNSz22lTcAZJTsihU2QQR2+Vn7oD9C1JXnvCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006489; c=relaxed/simple;
	bh=1Ulg3Pd9SIXQpCsm4/EZr1CIiCXfgM5+A3TPAynO8B0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3HPMf30E3qD4+awFzfNmnUr8g64pmKhm6BwF0P6sFXsjueQEgG62w85niz5BQZA2UpEMcyq5Gg/041ks3UNpIozaWOuD6A7inrwK9CGDqytTGCR5VqlipXJK7L5V50v+S1sqoh8QchEsfx/E34bHoIHxGASdG/rp5N4fgqUIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=G3QcMVb6; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="G3QcMVb6"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62KBWNfh080680;
	Fri, 20 Mar 2026 19:32:23 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fcgNn5Xkxz2P3j4T;
	Fri, 20 Mar 2026 19:30:49 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Mar 2026 19:32:21 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <daniel.lezcano@kernel.org>, <amit.kachhap@gmail.com>,
        <viresh.kumar@linaro.org>, <lukasz.luba@arm.com>, <rafael@kernel.org>
CC: <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <di.shen@unisoc.com>, <jeson.gao@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH 2/2] thermal/cpufreq_cooling: Use idle_time to get cpu_load when scx_enabled
Date: Fri, 20 Mar 2026 19:31:48 +0800
Message-ID: <20260320113148.7308-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260320113148.7308-1-xuewen.yan@unisoc.com>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 62KBWNfh080680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1774006350;
	bh=eZZ3Jfe6+MzvcFsKWOJJujLRln305nEULjFs3TSqpMg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=G3QcMVb6Lt8eLp6+nVluFvod4x01rIXbPpCPJW0EPWgcOZ3Y6LzHTfj+N4HHGg4uY
	 zt/uOKCmt2cFvCEbsCBMKc4ZnYIuJGovM9aFBOZWq/0ol0cXBuXtcT5EctbwNE0PCB
	 /w+RKOcLDReMbvgd5eYkNggOpy2Z/J1HTtJI98w+EZQHP6UQ+HeRsOHLz7aJhLQ8WV
	 hJTvv8RoDBo135+dd5hme/n+ZFCHQrRC5KFl5WG2v3FKccXndS/agx5s4A8PjiNrKo
	 y0pWdPYnJjrCalhQacpmDzpDA2t5GSnicz1ZDuZx6JSUxAoO0HZz9NYhaeeL9KFVah
	 Mgel1bf64rcZw==

From: Di Shen <di.shen@unisoc.com>

Recently, while enabling sched-ext debugging, we observed abnormal behavior
in our thermal power_allocator’s temperature control.
Through debugging, we found that the CPU util was too low, causing
the CPU frequency to remain unrestricted.

This issue stems from the fact that in the sched_cpu_util() function,
when scx is enabled, cpu_util_cfs becomes zero. As a result,
the thermal subsystem perceives an extremely low CPU utilization,
which degrades the effectiveness of the power_allocator’s control.

However, the scx_cpuperf_target() reflects the targeted performance,
not the utilisation. We couldn't use it.

Until a perfect solution is found, using idle_time to get the cpu load
might be a better approach.

Co-developed-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
---
Previous discussion:
https://lore.kernel.org/all/5a5d565b-33ac-4d5c-b0dd-1353324a6117@arm.com/

---
 drivers/thermal/cpufreq_cooling.c | 54 ++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index d030dbeb2973..e8fa70a95d00 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -24,6 +24,9 @@
 #include <linux/units.h>
 
 #include "thermal_trace.h"
+#ifdef CONFIG_SCHED_CLASS_EXT
+#include "../../kernel/sched/sched.h"
+#endif
 
 /*
  * Cooling state <-> CPUFreq frequency
@@ -72,7 +75,7 @@ struct cpufreq_cooling_device {
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct thermal_cooling_device_ops cooling_ops;
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT)
 	struct time_in_idle *idle_time;
 #endif
 	struct freq_qos_request qos_req;
@@ -147,23 +150,9 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	return freq;
 }
 
-/**
- * get_load() - get load for a cpu
- * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
- * @cpu: cpu number
- *
- * Return: The average load of cpu @cpu in percentage since this
- * function was last called.
- */
-#ifdef CONFIG_SMP
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
-{
-	unsigned long util = sched_cpu_util(cpu);
-
-	return (util * 100) / arch_scale_cpu_capacity(cpu);
-}
-#else /* !CONFIG_SMP */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
+#if !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT)
+static u32 get_load_from_idle_time(struct cpufreq_cooling_device *cpufreq_cdev,
+				   int cpu)
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
@@ -183,8 +172,35 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
 
 	return load;
 }
-#endif /* CONFIG_SMP */
+#endif /* !defined(CONFIG_SMP) || defined(CONFIG_SCHED_CLASS_EXT) */
 
+/**
+ * get_load() - get load for a cpu
+ * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
+ * @cpu: cpu number
+ *
+ * Return: The average load of cpu @cpu in percentage since this
+ * function was last called.
+ */
+#ifndef CONFIG_SMP
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
+		    int cpu_idx)
+{
+	return get_load_from_idle_time(cpufreq_cdev, cpu, cpu_idx);
+}
+#else /* CONFIG_SMP */
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
+{
+	unsigned long util;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (scx_enabled())
+		return get_load_from_idle_time(cpufreq_cdev, cpu);
+#endif
+	util = sched_cpu_util(cpu);
+	return (util * 100) / arch_scale_cpu_capacity(cpu);
+}
+#endif /* !CONFIG_SMP */
 /**
  * get_dynamic_power() - calculate the dynamic power
  * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
-- 
2.25.1

