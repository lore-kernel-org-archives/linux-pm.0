Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE371EB5FD
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860016; cv=none; b=QLsZril7kmDz0TtMit5L4Zvvv43tacW2+L/v3717QuM4WzVO7ZiZEUyyjg1CEEqFVTPbX3klj+DpFSFZn9lpmrNiiszpcF0KtqknyDo0X8txBzHlWP9AkVAfNJR7HqCvh7ZXHuLrDbUs378BjrzQ59uX1d+MIXXYWIrQrz3+xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860016; c=relaxed/simple;
	bh=E0eOydXd6tos3soGOgmN/ynT018kCln/FbX5evGbwxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cdq3ufRwlRDVC0ePDRsh7gyDt7GEnyaHBRHoUDvNC9OACcziYyQpo+v0B7ZxhKZjaOalXPuj4tUBsAcLVtwFYAaIGoz0bmaqL+SFn5FTIvYao0Bf3PU9P7yzGF3+hCQJU06+/b+z79mPqlqeVXhSXRzJWjOf2mjfiIv677VtnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=MA6tL0Db; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="MA6tL0Db"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso24245115e9.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860013; x=1778464813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd98iPPe5qNyrXCohE1KHWmMS9J/mTeoNujknNshEaI=;
        b=MA6tL0Dbfy6ra/uxYYbet0+M+K6YOuDbr6alQ/mim4xZgZQT/jf1sFGGb+0Gs3QOfA
         2V785mryMPgNQPsWvSWG1Ndq+UlOtPvY0ZMLfnck4uLBv5pjdE5ozepKmuS+pqoQNeiM
         FsucTN6J/KgbBZ2estZ4UqGGLu5DKacrfvUVu5PUBbF3BYoEHdtELqCntnLWsRa8WwO2
         vFxFlJBN0xaV/I50bYS0lt0BD43th3hJF95pjJ5EJaRF3FPJwwtmnN+4B+7UIRGzs1aQ
         n+S8ysKUJoIE8kcHs2j/Ys3MZ/+0cQ2txRrcPBQ50Y3QHOS6qTc74Edg3E0P7RUd5hz5
         CgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860013; x=1778464813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wd98iPPe5qNyrXCohE1KHWmMS9J/mTeoNujknNshEaI=;
        b=U29oG5P5jCtbFqmpEmJb0eXQL1GkFXjCxOF8h3Q4NDhkx+3vVUHmS72Oadcz8+AzZK
         KqDwJAbIZ4BzUYucLD/C8Fvu0C/csZ6lj15umwjOi6SpPZACYbm6CbcAuDRRwIEeLvnq
         /VmqGTzT4bIbrnGR/29+KUk7XQFuHfT/Jucti9M5wFXFJMRoHo4Te7SAYRgCLezWSxb2
         ifaNVLfr35A9cLTUL/qSMwcyc7eP24pH5XE0EZNH8N779S96b5E1pJ0ohaSMBmro8vz9
         E3KKah/w1tV0Li0EIltDK1xt4rybweGHERz9XHjB9gdDggvRj8Pu/CD09ErUOfGHLZB+
         /lEw==
X-Forwarded-Encrypted: i=1; AFNElJ/04rH/MpiEZ2X6A+/LtOODDyFncYgPC5iLCDyq/LOCkfJnxMnwK2lbsrPtSkD+eXEl96MgcdyDgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBpEWZ0OZKncf1QCP3mB/BK9bijiBlWVV6HbEmu10ZGJf4cOF
	ehIRYt7qzk451w6DpQVxlrBTRtfb7zmCeS0vIof3H6XA5y/82gMkwvnF7KII0EJYVBs=
X-Gm-Gg: AeBDievTMn5tUZcNBrC2pjj4WtasKA51CaypMLrnhc3HtxfQBpKNZjpjX+4saDohiTS
	qvm8AjtU/2yq2CUMhwuoB3CVcqqPpiWes0pph4Qm/ZbZCQ1nwHYyUsMCRqyJInhBci1UMIbYnAz
	1ewqGjSSX4J2LqQQDbo57p1lcYqX7jqvOq3Uso5fjjW1nfOhgFrXPv9rYTt8/ZsfwdeM+sfR/z0
	w1oZc6LRGM+LTBdi0UP/A2uoyJD0SLUnfv8lq3uny5sMWlwY3TCC7AVHsOfv1ek3wOsPlH3ofcU
	AjRzdM5v0onEfWNJdD+lOHQWnGvca4XVRxP0IpdNAcCV//NcfPct1tnKCJXEDRnuTlpUF4v9Ars
	iyAbnzjYNTBXLW7rCd9i9bzvm9fhNKMSjX5cOCmIRshGK1pD+oTVM68K6h4QmqJBdVOv5O9twXZ
	fCrdYByp8Kr125teryW50yTpq4x+1aQX4=
X-Received: by 2002:a05:600c:6215:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48a988a9c49mr113907935e9.5.1777860013459;
        Sun, 03 May 2026 19:00:13 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:10 -0700 (PDT)
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
Subject: [PATCH v2 01/13] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
Date: Mon,  4 May 2026 02:59:51 +0100
Message-Id: <20260504020003.71306-2-qyousef@layalina.io>
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

We are providing headroom for the utilization to grow until the next
decision point to pick the next frequency. Give the function a better
name and give it some documentation. It is not really mapping anything.

Also move it to cpufreq_schedutil.c. This function relies on updating
util signal appropriately to give a headroom to grow. This is tied to
schedutil and scheduler and not something that can be shared with other
governors.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..d01755d3142f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
 {
 	return freq * util / cap;
 }
-
-static inline unsigned long map_util_perf(unsigned long util)
-{
-	return util + (util >> 2);
-}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 153232dd8276..f6de241fc62c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -206,12 +206,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+/*
+ * DVFS decision are made at discrete points. If CPU stays busy, the util will
+ * continue to grow, which means it could need to run at a higher frequency
+ * before the next decision point was reached. IOW, we can't follow the util as
+ * it grows immediately, but there's a delay before we issue a request to go to
+ * higher frequency. The headroom caters for this delay so the system continues
+ * to run at adequate performance point.
+ *
+ * This function provides enough headroom to provide adequate performance
+ * assuming the CPU continues to be busy.
+ *
+ * At the moment it is a constant multiplication with 1.25.
+ */
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
+
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
+	actual = sugov_apply_dvfs_headroom(actual);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
-- 
2.34.1

