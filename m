Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29977468C14;
	Wed,  7 Oct 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388791; cv=none; b=ms1rqNKNRLVccKGBXQgzWrF1/W7NlIUHNz6nbZec015zlomaFUbmaUheH2/wzShrMTRC8yqlOQQIDa5Z75MdubasX4PJOFvxkGLmgewQg0RBMeSF7xqFiEGFCfbjU8o+6Lpn6+fUEgehkhaGOPfWWenbqOy0dshmZue5H++0OKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388791; c=relaxed/simple;
	bh=IJIrQ3xl4JHykPy6ruz8CD2suxfeOMFfo9rsww7fC+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8vjQMNW//9wM4jI/2cylzFkiWs1sYPCyr/HcbdRoO7dJKzbNTJQVEGLrtCgxe+Py+quuHAcFADBpA1bQIFNs/wC8s1+IwncztK3rKh8GG2AAkKFhUwx0gcXkxe9/Nc+S00fQEU+69QlCD+Pl9Kg2EVUOYZ+Gt82m8d6J6oIXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dCSm2kcF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dCSm2kcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xh
	ZR27BK/0vJsaZyZU2OhrXvj9xBCf2oiYLvM0ZWnUM=; b=dCSm2kcFmuZR/hPofH
	Xe40E+ZaBT6krZm+lKcnaZ3lBxcvuRWwapDiv4FKSM0rVYYFmSWflu9DrwSiE3zV
	xJ/P+SfTiM5keY4if3DqM/M5AJFpwczmcjHGa37yPd4q8+G5nuo0wxhtR38d61F2
	7930Gt79oQXXapdBqx/owzRy8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnJvIcbMZqicxJDA--.10145S2;
	Wed, 07 Oct 2026 23:58:21 +0800 (CST)
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
Subject: [PATCH v2] cpufreq: schedutil: Serialize start against rate limit updates
Date: Thu,  8 Oct 2026 00:58:20 +0900
Message-ID: <20261007155820.3194105-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnJvIcbMZqicxJDA--.10145S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4xZw4DKw13uw43WF45Jrb_yoW5CFy7pF
	ZI9FZ7Ar4UGr1vqrsIkw48Za15Xw4DurWjgr97Grs5CF1Dtw1Sgr9rKF17ZF1akrWDurZa
	vF1YgayUZF4jqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROdbbUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6h5uzWrGbB7wCgAA3z

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
governor attribute set lock around sugov_update_rate_limit_us(). Use
gov_attr_set_lock() and gov_attr_set_unlock() to keep locking details
within the attribute set interface. This keeps the fix off the scheduler
hot path.

Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Wrap governor attribute set locking in helpers as suggested by
  Zhongqiu Han.

v1: https://lore.kernel.org/lkml/20260929103635.3780346-1-sh_def@163.com/

 include/linux/cpufreq.h          | 10 ++++++++++
 kernel/sched/cpufreq_schedutil.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35ce665edfd8..5448eb0a0885 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -694,6 +694,16 @@ static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
 	return container_of(kobj, struct gov_attr_set, kobj);
 }
 
+static inline void gov_attr_set_lock(struct gov_attr_set *attr_set)
+{
+	mutex_lock(&attr_set->update_lock);
+}
+
+static inline void gov_attr_set_unlock(struct gov_attr_set *attr_set)
+{
+	mutex_unlock(&attr_set->update_lock);
+}
+
 void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
 void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
 unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..b847311c307d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -861,7 +861,11 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
+	/* Serialize against rate_limit_us_store(). */
+	gov_attr_set_lock(&sg_policy->tunables->attr_set);
 	sugov_update_rate_limit_us(sg_policy);
+	gov_attr_set_unlock(&sg_policy->tunables->attr_set);
+
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;

base-commit: 63de2367f6d280904a9c5e5bbc7c75bb91c5b3d8

