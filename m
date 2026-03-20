Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E731985D;
	Fri, 20 Mar 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006488; cv=none; b=nq24GqbN1NY7D3RVdZtKmZZZom10SCR3NLXSIdQs9NsnFaugGD2IQb6CQZapux3e8/gKtFZbrSldk3oij1XYwX1uEpptAbsa1Wj44tUSrHd9MYMJl5yjoatN+sKQdduhYhh6ClQW4xEe9edx0V7g8JIlAEWNdaG+DOHLVBfcgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006488; c=relaxed/simple;
	bh=/qqM60j7L5RuMC+sLsrNNAD8fx+3um94OWqBxqRiEG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDBB4ZqrUFN3TcWhjMLD/Wlum+D1+B/frcjZ7IPOx/v/o6QTNFN8SRtdZ2QPRuVuwRpeDo1qDkmxgZv1YQguexNQ9L7YCac+Lv4urPsb+/iyGaRCWRmVGJpMAyCJW6bSzxAX6GN2kyedQc8LMgNUoBH1M3BBEXPGH10HibKgTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=YfAN190c; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="YfAN190c"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 62KBW7Z3079699;
	Fri, 20 Mar 2026 19:32:07 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4fcgNT5vsgz2P3j4T;
	Fri, 20 Mar 2026 19:30:33 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Mar 2026 19:32:05 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <daniel.lezcano@kernel.org>, <amit.kachhap@gmail.com>,
        <viresh.kumar@linaro.org>, <lukasz.luba@arm.com>, <rafael@kernel.org>
CC: <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <di.shen@unisoc.com>, <jeson.gao@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in get_load()
Date: Fri, 20 Mar 2026 19:31:47 +0800
Message-ID: <20260320113148.7308-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 62KBW7Z3079699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1774006347;
	bh=intbztJfHf06gFSxKp2hvHtN9/7tYwHdZc6Pk8HwZtA=;
	h=From:To:CC:Subject:Date;
	b=YfAN190cU+UYA/THsL54kz6R0PuI2lVxGNLTM0uhiXNXB5YjPpvdrq16x/lAS+YFY
	 HwWzFZLiRvtQrhip8B5H3aU3H3xUowYfzws0mk3ehpxm/XOElLxUdF7aA9SMOK1IdH
	 4nuR428PM3oOvJs/0IrKUB5abcsfm49bPSpgymneEId8Z9wheIh717tEVhA2z3UJvu
	 T63SlyURTZ9becAih1cM81qxqqiqVDkX5fWr0b0yuDPpwn1YzO1jdLgqQM7hogkInL
	 F9wqOhK0mUW2iaxzT4EyCKOiYSqeoTJ9B2HJSyn/fn8EDRIP81r7mpgxVdXWjYmI2z
	 VNyPmSc8ZhOkg==

From: Di Shen <di.shen@unisoc.com>

The cpu_idx variable in the get_load function is now
unused and can be safely removed.

No code logic is affected.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/cpufreq_cooling.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 32bf5ab44f4a..d030dbeb2973 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -151,26 +151,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
  * get_load() - get load for a cpu
  * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
  * @cpu: cpu number
- * @cpu_idx: index of the cpu in time_in_idle array
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
 #ifdef CONFIG_SMP
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
-		    int cpu_idx)
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
 {
 	unsigned long util = sched_cpu_util(cpu);
 
 	return (util * 100) / arch_scale_cpu_capacity(cpu);
 }
 #else /* !CONFIG_SMP */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
-		    int cpu_idx)
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
-	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
+	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu];
 
 	now_idle = get_cpu_idle_time(cpu, &now, 0);
 	delta_idle = now_idle - idle_time->time;
@@ -231,7 +228,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 				       u32 *power)
 {
 	unsigned long freq;
-	int i = 0, cpu;
+	int cpu;
 	u32 total_load = 0;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
@@ -242,7 +239,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 		u32 load;
 
 		if (cpu_online(cpu))
-			load = get_load(cpufreq_cdev, cpu, i);
+			load = get_load(cpufreq_cdev, cpu);
 		else
 			load = 0;
 
-- 
2.25.1

