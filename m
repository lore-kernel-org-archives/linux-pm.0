Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023837CD40;
	Tue, 13 Oct 2026 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863026; cv=none; b=n6RfyP6VGltuLokULw54by9VhqrKi7shohhCJgVY0BIBuwAkPrdzU8xJEwGVr2BwGKFz6RztrZVgfWpX4u0bsWekbVPyzDdXF2S/NK4jGoyZ5P001EzfvbE8UhuEYBfB89n5skAyWVbB6qa0cTyTfegSRZKkC67nt7HXwzfnOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863026; c=relaxed/simple;
	bh=uQnjncTmPqU3/4q5ipNsE5ij3tw4fP/bOHA6qTI5RWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4s745FZ0Zz6VIYmtQD3XqY8RZst0yG8iqqENKQBDu8i0jsl3iIpFGL3YxgLx9rn8f4mNiWE1wjl0Kp0HNgyPxz5DT1LJ2qpzzK4LSyPX3ganwDdZ3odW/J4hSzzMd3dQW/hNVs/ar1Ms3OnyjN1Jz+O4elr8zY82AOrufML2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KNcn8jXj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KNcn8jXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LI
	5WAfJe3kqChS2SVbsIW5VyVng0CUQfoNUpoy+XrrU=; b=KNcn8jXjJv+MM9AMch
	ZrwB9ses0383OzR5DNTmv56+TvO3ANQr22enP1SiHNzO7xoz3izEQocp5Oyl/5we
	yTne7kaes9uX8LIVdQkncGqXEJEzkOZdWHTnIgJWa0U4UVFG0NlGeacISbKBfQno
	hD7KOxoYrxXivyLqZrIoynmOQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31y2rqM1q1HSsEA--.28685S2;
	Tue, 13 Oct 2026 11:42:36 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v3] cpufreq: schedutil: Serialize start against rate limit updates
Date: Tue, 13 Oct 2026 12:42:35 +0900
Message-ID: <20261013034235.2678177-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31y2rqM1q1HSsEA--.28685S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4xWw4xXry5AFW5ury8Krg_yoW8uFyUpF
	ZI9FWFkr1qg3WUtrWa93Z7ZayrA3WDJ3yDKFyfCFsYywnxG34Fg34xKFnrXFyxCFn5ursa
	y3WYva9rCw10yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROVysUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6Q1jwmrNqK10TAAA3f

rate_limit_us_store() updates the tunable and freq_update_delay_ns under
update_lock, but sugov_start() reads the tunable without it. Startup can
therefore overwrite the new delay with one based on a stale value.

Serialize the startup update with sysfs stores by taking update_lock in a
schedutil-local wrapper.

Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v3:
- Use a schedutil-local scoped wrapper and clarify the locking comment.

v2: https://lore.kernel.org/lkml/20261007155820.3194105-1-sh_def@163.com/
---
 kernel/sched/cpufreq_schedutil.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..1d0878dad4b0 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -73,6 +73,16 @@ static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
 		(s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 }
 
+static void sugov_update_rate_limit_us_sync(struct sugov_policy *sg_policy)
+{
+	/*
+	 * Serialize with rate_limit_us_store() to prevent this path from
+	 * overwriting the new delay with one based on an old tunable value.
+	 */
+	guard(mutex)(&sg_policy->tunables->attr_set.update_lock);
+	sugov_update_rate_limit_us(sg_policy);
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -861,7 +871,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
-	sugov_update_rate_limit_us(sg_policy);
+	sugov_update_rate_limit_us_sync(sg_policy);
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;

base-commit: 63de2367f6d280904a9c5e5bbc7c75bb91c5b3d8
-- 
2.55.0

