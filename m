Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DD3126D6;
	Wed,  2 Sep 2026 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335280; cv=none; b=H/DdtOyfr1eL+nUzA1sV6Ewn80uPlr7NBAxF+JPfwztCZu6dB72J5NW1NDnTQUa9R4RmuXw7OAM1q/zb2ojHhmAl2ZgxmCPTdnjZDpu7jbHlkyOxXm5NFDNB+hFuOeHocfQvC5DWn7I/irWsq2FnVfOHJoevX3dyi0Eqz9fjjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335280; c=relaxed/simple;
	bh=RlPn/tvVZtGftu+7JOxuNbPVj4H0V6O9cpmvAwURE3s=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=l5dc4F59lrkivsxKHGKFxTRDi0ZCUX/TuSh9DXABcrWNuv//lVA4Utiq4Gba+i7liL1blk2VDqZ7/ofISNLZ8VO8/+sv0X8N2WEcg6W2IM3T/u6ZeQGwBipZW8PR+7QJ3KEgOsSC/eXgeCxO733RrNcD0hdcN00ukKZGaun/W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hZZZs5wHrz5B10R;
	Wed, 02 Sep 2026 15:47:49 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6827ldAq037007;
	Wed, 2 Sep 2026 15:47:39 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 2 Sep 2026 15:47:41 +0800 (CST)
X-Zmail-TransId: 2afb6a97d49d986-de614
X-Mailer: Zmail v1.0
Message-ID: <2026090215474182681fN7LLOSpqIc3s3OqJaW@zte.com.cn>
Date: Wed, 2 Sep 2026 15:47:41 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <luo.haiyang@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBjcHVmcmVxOiBjb25zZXJ2YXRpdmU6IElnbm9yZSBpZGxlIHBlcmlvZHMgd2hlbiBhIHBvbGljeSBDUFUgaXMgYnVzeQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6827ldAq037007
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 02 Sep 2026 15:47:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A97D4A5.003/4hZZZs5wHrz5B10R

From: Shengming Hu <hu.shengming@zte.com.cn>

For a shared cpufreq policy, dbs_update() derives the load from the
highest utilization among its CPUs, but it also records deferred idle
periods from any CPU whose idle time exceeds two sampling intervals.

This lets a single update report both a high load (from a busy CPU)
and several deferred idle periods (from an idle sibling). Since
conservative applies the deferred down steps before the up step
triggered by the high load, the down steps can outweigh the single
up step.

The issue reproduces on a policy shared by CPUs 2 and 3: a CPU-bound
SCHED_EXT task keeps CPU 2 at 100% utilization while CPU 3 stays
idle. On this system SCHED_EXT generates update-util callbacks less
frequently than CFS, so DBS updates are sparse, tracing shows:

 load=100 idle_periods=7 interval=59 ms
 load=100 idle_periods=4 interval=39 ms
 load=100 idle_periods=2 interval=19 ms
 load=100 idle_periods=7 interval=59 ms

With the default 5% step and a 2.6 GHz ceiling, conservative first
removes seven 130 MHz steps and then adds only one. Repeating this
sequence keeps the policy near 530 MHz despite CPU 2 being fully busy.

Only retain deferred idle periods when every CPU in the policy meets
the long-idle condition. This keeps the existing behavior for
single-CPU and fully idle shared policies, while preventing an idle
sibling from downscaling a policy that contains a busy CPU.

Cc: stable@vger.kernel.org
Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 drivers/cpufreq/cpufreq_governor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 710d93ec89b5..64eb6b5f08a4 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0, idle_periods = UINT_MAX;
 	unsigned int sampling_rate, io_busy, j;
+	bool all_cpus_idle = true;
 	u64 cur_nice;

 	/*
@@ -233,13 +234,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)

 			if (periods < idle_periods)
 				idle_periods = periods;
+		} else {
+			all_cpus_idle = false;
 		}

 		if (load > max_load)
 			max_load = load;
 	}

-	policy_dbs->idle_periods = idle_periods;
+	policy_dbs->idle_periods = all_cpus_idle ? idle_periods : UINT_MAX;

 	return max_load;
 }
-- 
2.25.1
