Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900B200110
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860046; cv=none; b=gLneYhcrXK/AbmGpDbzEZIwApZUQf1tDN+9TScO/ffSyymKd2JW6TrOJdryatUffHKvSxm9DbaX6PBN3xhS/7nW9NLIn1hBE/Sld7poYKI0zPz1Jvy4xPzwyJZqcYNNLgUwl8o6gQw43RYXLqLWV5CJ5kNCkMGUWf4YctC9bUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860046; c=relaxed/simple;
	bh=w/5BpgtwWB9gvhUeO0LymK333h3v7QsTdN0RrznuU4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjRF8ltXGXBv6O0Y8TKcH+XogLSIYHQbn12TU6e9WMWIxqKD0u8hDnSYwGfuq4yDT2Ay2QLYLC11ij1RBVcb+j/k8l7FnCYK5g8tLyduSs6iZrKcEHYqNE6PJ6QAVIHkZ6iqo5JNnAXGddrBDTfDzEcJMI1Otml0gNFBKyBr3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=VYnT8zsq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="VYnT8zsq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so30082465e9.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860041; x=1778464841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt5Yn7iSlTX5edqzbUliEK6b4yg+MnQ5F8uUHtLwLtA=;
        b=VYnT8zsqK3Bh2OpN2sjNldJRtT2PuKcdbQdoC09W3EPQorfuffdeBkNK4DGpNqBuyD
         ADeS93D9LLxkygXXtbQ1c97rdZP2prhm0DD693Gn+8VZDsVi0cowueCtLleTLuSY9dt7
         TJ3g5hWxRvssU8vznDzEr2kemeXXZgyiVj53OBVDL+Pch/oWNkMpJmCsw3sKZxghwR4S
         GbmQmZrrM/RRdRpS3TUPLwab61QSm97v9eb+Z0vOHY04i/DtjtGDKADAlEU6QzdAJYwW
         yaTE1pjZVlDm4NxvGtYv9fdo3tzJ7gFHG+itgXp6ISzF1QCr48ujysDKaHJfRrSKiXlm
         0g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860041; x=1778464841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yt5Yn7iSlTX5edqzbUliEK6b4yg+MnQ5F8uUHtLwLtA=;
        b=DJ5Ge+7IPbkCDrGWGVypWkkI2QK6XyPYprfw+APw9e0h95Vh2Ju6phApbQyt8spPB3
         Yb2DSupjvztODCyCdiVpGoxt+PnU8TyEA++SKKe+lPFnQKjLYLw6ffF4N1aPFJWRmv6y
         pju733BJ+TkW5dNkunOCUEvUrZQjZHNBK+cPUQGW3p0YSbqNGUDNjozBaXEhxVAwk27H
         dvIycJwmFEs5a52iPHeTJccGOzNqgzMaFJ+3dx8OPVox6t/odrdjonST7Tun/ZxYSRL/
         fKrQ9Nsb6B95vY3/Yw+3JsLFXrwACcdGVS6hEN36n++0UT9EL47fF7z++66DK5/5aMO4
         Zd/A==
X-Forwarded-Encrypted: i=1; AFNElJ8Mmht5/ZC2ZpMFaT1JYRc99cpjvvyYpuYEha60UmcuWJH13wuFF9WAhzHmqacwogRu33IRyU72Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeB9A6wtgh+OT/2RZjsD/jCxrZe+Oy2RKG0rGV/+Lqx83hSWz
	ntvuD60rFP9UugfO2vtNs5hyRyWz+4xvq2HW7MffAu2qOQ7vobJL5Eh7mig2yC7tGRk=
X-Gm-Gg: AeBDieulfywM0mxOG5whgaEEvVL9qzheLYl1DOi+pE+pn8DNDd0ti85YcUyF5CPR/Mk
	wKMbm2fWNpCv9JkFV+hcHc2Qafl17+d6Ps0O2uKFFSaliGxWQacur5PwWmVFX3C8qNO5w8H227R
	GXrxJY6srPzwBKbmmG768b2OGfO4U/he/zsTJMEmAowd01s5G5WAK5DnwpJfmy8i8mb6Jq0Ycm/
	1IBJTSF/5ypWksCZ5bKvKSjBAjc0EjnTgPoGuITMc0wii9Z8eovXCOEgcnpXRuTjGaGI/OvGUo1
	p/F1mdx8iKhAkhgO1Caf3dvpf6cCi+jBMbOzGFrrkiO8TEpiSgsNsA1r9/Bj0khYdFCudxICiGx
	p+FAkvgZc9luEZ7D2Ys3riPByA41TRE+Q9RiI623CJZKlvy8Ru8Gi7DudP6ffSLNzGOZWVInPTo
	OJt2JS0xEfE90WlzoScLq1dwlrdVFIm8A=
X-Received: by 2002:a05:600c:154b:b0:489:a4:e58a with SMTP id 5b1f17b1804b1-48a988b1ec0mr138910845e9.19.1777860040320;
        Sun, 03 May 2026 19:00:40 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:38 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 11/13] sched/fair: Don't mess with util_avg post init
Date: Mon,  4 May 2026 03:00:01 +0100
Message-Id: <20260504020003.71306-12-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extrapolation logic for util_avg for newly forked tasks tries to
crystal ball the task's demand. This has worked well when the system
didn't have the means to help these tasks otherwise. But now we do have
util_est that will rampup faster. And uclamp_min to ensure a good
starting point if they really care.

Since we really can't crystal ball the behavior, and giving the same
starting value for all tasks is more consistent behavior for all forked
tasks, and it helps to preserve system resources for tasks to compete to
get them if they truly care, set the initial util_avg to be 0 when
util_est feature is enabled.

This should not impact workloads that need best single threaded
performance (like geekbench) given the previous improvements introduced
to help with faster rampup to reach max perf point more coherently and
consistently across systems.

The logic can be forced back on using UTIL_EST_FORCE_POST_INIT
sched_feat.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c     | 19 +++++++++++++++++++
 kernel/sched/features.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a36d6abaf6d2..d0f646b32c2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1261,6 +1261,19 @@ void init_entity_runnable_average(struct sched_entity *se)
 }
 
 /*
+ * When util_est is used, the tasks can rampup much faster by default. And with
+ * the rampup_multiplier, tasks can ask for faster rampup after fork. And with
+ * uclamp, they can ensure a min perf requirement. Given all these factors, we
+ * keep util_avg at 0 as we can't crystal ball the task demand after fork.
+ * Userspace have enough ways to ensure good perf for tasks after fork. Keeping
+ * the util_avg to 0 is good way to ensure a uniform start for all tasks. And
+ * it is good to preserve precious resources. Truly busy forked tasks can
+ * compete for the resources without the need for initial 'cheat' to ramp them
+ * up automagically.
+ *
+ * When util_est is not present, the extrapolation logic below will still
+ * apply.
+ *
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
@@ -1310,6 +1323,12 @@ void post_init_entity_util_avg(struct task_struct *p)
 		return;
 	}
 
+	/*
+	 * Tasks can rampup faster with util_est, so don't mess with util_avg.
+	 */
+	if (sched_feat(UTIL_EST) && !sched_feat(UTIL_EST_FORCE_POST_INIT))
+		return;
+
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
 			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 05eed37a9064..fa8e7d458029 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -127,6 +127,16 @@ SCHED_FEAT(UTIL_EST, true)
  */
 SCHED_FEAT(UTIL_EST_RAMPUP_ZERO, true)
 
+/*
+ * Force extrapolating util_avg on fork.
+ *
+ * When util_est is enabled the extrapolation is not necessary since tasks can
+ * rampup faster and can be controlled with a rampup multiplier to get better
+ * responses making the need for the extrapolation moot. Switch this on to
+ * force the extrapolation logic.
+ */
+SCHED_FEAT(UTIL_EST_FORCE_POST_INIT, false)
+
 SCHED_FEAT(LATENCY_WARN, false)
 
 /*
-- 
2.34.1

