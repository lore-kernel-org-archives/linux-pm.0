Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E93383339;
	Fri, 21 Aug 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298221; cv=none; b=iL5YbkYkWR94/o4ZJCpZBlUUHNgdgFDGd8y3HBhHXxfUM9C9ouSRpy+xwBgF4C2ZRpcdNZCf6MZZu0JAjMMEgxaX7TiuAUZNkMIYFi2Lj8mp4zV9Q2ncuENkZLRUndVfLcq5PlGuiviLLNUl/Hj+wUcScs6tFfPt34YAxxA2hPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298221; c=relaxed/simple;
	bh=CORZnotHqGVk68tIyZd7XpxXM47q1V3ga8iH9kgpAw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cXq/TUzaB+oYw3MzHwZVptWIDHGSm3yqkJzLHTNJojb6WrLCxg0h/71Ow/CGJF/mQ43ROg9CppQpx58qfufZX5ckFsKscmrDFsSs/7Dhk1enWx8PwuPvYQyUhuUi7Hyn/H+UnY3DRFiXT6hLteIiZDJ7RoH/jT5X37v6zfUPJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hRC374VcNzTZjX;
	Fri, 21 Aug 2026 15:43:15 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hRC3628RMzwcTf;
	Fri, 21 Aug 2026 15:43:14 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B0F4E848E;
	Fri, 21 Aug 2026 15:43:05 +0800 (CST)
Received: from jianyong.hygon.cn (172.19.20.52) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 21 Aug
 2026 15:43:13 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wujianyong@hygon.cn>,
	<jianyong.wu@outlook.com>, <zhongyuan@hygon.cn>, <huangsj@hygon.cn>
Subject: [PATCH] sched/fair: Only apply cpufreq pressure where frequency is invariant
Date: Fri, 21 Aug 2026 15:39:27 +0800
Message-ID: <20260821073927.455475-1-wujianyong@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

cpufreq pressure lowers a CPU's capacity by the ratio between the highest
frequency it may reach and the highest one it can reach right now.
Utilization carries the matching scaling only where the architecture is
frequency invariant; without it a fully busy CPU accumulates the whole
SCHED_CAPACITY_SCALE whatever frequency it runs at.

Reducing capacity on such a system scales one side of the comparison and
not the other, and a fully busy CPU ends up reporting more utilization
than it is credited with being able to run.

This became reachable with commit d2d5c129d07e ("cpufreq: Make
cpufreq_update_pressure() fall back to cpuinfo.max_freq"); before it the
pressure was always zero there. Whether that matters depends on frequency
invariance rather than on the fallback itself: a system that has it scales
both sides and is unaffected, while a system that does not scales only the
capacity.

Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c19a025d8d68..a163e00c9882 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5854,10 +5854,17 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+	unsigned long pressure = hw_load_avg(cpu_rq(cpu));
 
-	capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+	/*
+	 * Utilization only follows frequency where the architecture is
+	 * frequency invariant. Elsewhere, lowering the capacity would
+	 * scale one side of the comparison and not the other.
+	 */
+	if (arch_scale_freq_invariant())
+		pressure = max(pressure, cpufreq_get_pressure(cpu));
 
-	return capacity;
+	return capacity - pressure;
 }
 
 static inline int util_fits_cpu(unsigned long util,
-- 
2.34.1


