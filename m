Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12814516160;
	Tue, 29 Sep 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678316; cv=none; b=GVlKBfIoxKterf25PRHEgVF7cakpqzPY69g7Lr7vj2FVztgqDodCmRza7le2Py6/Z9gyaHC4mokLLUmXsWxdk4u08O8ku5ODxkQEq6r9XjnBhiLpxqf1QmLXfq7LE9hjOCApJMpl9LfMKlvdfMCUfss3hJ1xRRzFN7Ze1mCmY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678316; c=relaxed/simple;
	bh=jS141X4c3OMFBTtEjLJAKaXarrTHW1pMnwbWixyREe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfcj1YNslEtom+JqLX/E6Jw0Cy6PzFzTFnGQv+geZN8vkCjb2qSps/UIQxJu+hUwzlsf9Leb3J4r18IokLpPWNpoRP+NglypuieT3wynt4p3rKwPbDuSiRoMaXngT36/20D1Y+OJ6o77MrQjrT1CtjCY5TetTo8v1G0tAiOWpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ezm1GZhH; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ezm1GZhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cf
	ld2cwTrYOuPLcQ+rdijj5y4bobOtCa+l0ukmiFTmc=; b=Ezm1GZhHfIly1H55b1
	7xG7E/VxNTcSjSlZAn326GRjavNgULazVttJAmEKUSyUIen2r7KPBT1YgclzeQXR
	U9DLfTG6zrDvOAWz4ZrQIFMwXU1RtyuE36vPQNMkwxUttBdpY0OR1cHRGgm+PzAQ
	Ftl6Gd+ou1jeHHkxBmObZ9l0E=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f73HlLtqMY85Bg--.27154S2;
	Tue, 29 Sep 2026 18:36:56 +0800 (CST)
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
Subject: [PATCH] cpufreq: schedutil: Serialize start against rate limit updates
Date: Tue, 29 Sep 2026 19:36:35 +0900
Message-ID: <20260929103635.3780346-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f73HlLtqMY85Bg--.27154S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF13Xr1rAFy3Cr43WF45Jrb_yoW8CryDpr
	ZIgFW8Aw4UK34jvrZIkw4kur48ua1DC347tryfCrs3Crn8Gw1Fg3s7KFnxXFWI9Fs8Cana
	y3WYvay7Ar10yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROdbbUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgjgQGq7lMjaGAAA3l

rate_limit_us_store() is called with the governor attribute set
update_lock held, but sugov_start() updates freq_update_delay_ns from
the same tunable without taking that lock.

This allows the two paths to interleave as follows:

        sugov_start()             rate_limit_us_store()

        read old rate_limit_us
                                  write new rate_limit_us
                                  publish the new delay
        publish the old delay

The sysfs tunable then contains the new value while
freq_update_delay_ns contains the old one. Unlike a transient torn
read, the stale delay remains in effect until another rate limit update
or governor restart.

Serialize sugov_start() against sysfs stores by taking the existing
governor attribute set update_lock around sugov_update_rate_limit_us().
This keeps the fix off the scheduler hot path.

Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
Signed-off-by: Hui Su <sh_def@163.com>
---
kernel/sched/cpufreq_schedutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..e759f09be638 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -861,7 +861,11 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
+	/* Serialize against rate_limit_us_store(), which holds this lock. */
+	mutex_lock(&sg_policy->tunables->attr_set.update_lock);
 	sugov_update_rate_limit_us(sg_policy);
+	mutex_unlock(&sg_policy->tunables->attr_set.update_lock);
+
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;

base-commit: 63de2367f6d280904a9c5e5bbc7c75bb91c5b3d8

