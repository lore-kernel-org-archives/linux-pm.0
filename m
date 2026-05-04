Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499E1DA60D
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860019; cv=none; b=frx17UYSSFNeLlrIN1uv/YkqP1yZfUVYDAl83R8+6XOKFxY1zFS06qAecF6iODsV3Wsfs2indTKJwrY0FlnbZG6JujcFjozw6McucisI3pZGHagRIUeoaMSwNf25iCMzzVhjnFlY/NXyQ8iLTPhkkfvUWkz/jZqm8w6cY/TSEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860019; c=relaxed/simple;
	bh=jNS5ugF6VA1XQQCNnhAQXK2hOKiFWxczMDSZ5HOFuUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWgTJI02+jYBGlCUefNpjlY/uKmxXfTBCUzRKf8NHPi/teAKsDHehl4cJcWhaVYIzRONmDczu9drTxEaSPGBS6IwM2DhebwWP6ll83NqRJmoBMdtnFLTVTgv7buP5Df3253ktLeAUUJ4Socw4Vfg8QNI1LSGQnNIxOGFNFJpovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=u7FUT96S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="u7FUT96S"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso23867855e9.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860016; x=1778464816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGX9LyWWhnXaPHL2xAB0hm15nm1TdqQjuBEHx8htUtM=;
        b=u7FUT96SLKXTZPSzpz+e1Vz6PLtLbwEr0an4RkODpJu7J1rxyPUUnmiMRHt2FftjG5
         vn93FwLbgohRJsv76HW6h4fUXEDR1DTSMvphKZvZ3zCQUQp7PjN77Gw5uUmJbAklexzu
         Vh834BSS5VRKCB6pVYQXUPNLW0+9DtKrhHo4UgfG/fx18mbWWnZ0QWGiy6Hw5OqdZjmA
         n2pXYQ0gDs1eeGI04m7bY9UCUFlBa1IB5nWIt3/kF6JYWckhBbb8dhFBgAsaQizucCyR
         r/+jMymtVZSIbxy5dOElH40LHwJD49goZvnGgPLa12Jlnn2gT/oQzJHr4NEunG9Ct6wC
         glVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860016; x=1778464816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGX9LyWWhnXaPHL2xAB0hm15nm1TdqQjuBEHx8htUtM=;
        b=rDZY3aZwk2RWGviwZ3ZRiRsFmVG5QJJ4B63s3YDDRq2LqHefa6fZ1ehB20rsbJPTmr
         ZjlypV7iAMWD7CY0W2d0HPOUBP3JsN6K7qVV78T9Pn4MFNpxa5CgUlQABIOS/Kf6/twR
         M7lXvYsggCxDlaD1COqeaSOADpROdLWfAeb8lhbvmXO6Ldvkjm0amy3MBxRGyw1+uHiO
         uus0OB2K3hpBtquPB1s5BVA+HP82hEnnh5M0mtJWwUjpdyYYQneA1kmtUntioKNMJXaO
         5gt/F6hniW31W8R3GuPnljoio6YojSss/UcXWWq13g8FwVDo/ryuyHB5T7q5W/alH1Js
         hyEg==
X-Forwarded-Encrypted: i=1; AFNElJ9P/hJkpeezqzG+LK/j+dTKXqnHSBm7pec7CAHMIHTDh1pCD+tRxT+4AwmmwJbV5FiNmZM1QIdiLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8i9HfmZmWpFNKB9+lH7IMFaIC/PkbzKgGwSHRIdkTVbH9dUzp
	xZ43ugaDkgEOdZp4pbsevOcjllWZ15D9I/Mq8itggIKa+av7s5CAJzVkPArnKSX9U6I=
X-Gm-Gg: AeBDietLInHK8gQlLbPiM5adGuQ5xBIKoe7j29D5WicYv6dx1K2z8R9aOiuS8LfJHE9
	ePgiTVpyW2TkT3MhhtY8sxNkJieVtrTxugto/V63M/3ZP4M+K/mw6ckTX4/dRgcZim2tXe77471
	YKG9UpqjfUh1Vitn3JYtXBOY68pcgDjvprTNU4f4sQrCLUEHwug3kkkGvEuwZeNoD5XgTArDqCo
	nuaD3z6Lx9rEx6ZX65YcR0S7DOvahcR1FpyVwnHqbDgquUyHiwymbYnxdlzQjeYhF6oXA6ZtEi+
	+LqlSU0vpDYh5XFX2tu42aG9PKINlttwSPVzSt0TglxwGuGsiD7M4EMkTXRIxjLb4YY1LgYZ9mX
	r5HuFl57cjdyT3eLhtuxfmQwsOmRnZku3WvJeWMYbo2Glcla1Ocpuln4J+tjo8PWfqKnIfhYX7O
	HYyjEmz5m7D+McaXHWDWH0y/9sXxmIaNA=
X-Received: by 2002:a05:600c:8b0e:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48a9852d122mr117385575e9.5.1777860016270;
        Sun, 03 May 2026 19:00:16 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:15 -0700 (PDT)
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
Subject: [PATCH v2 02/13] sched/pelt: Add a new function to approximate the future util_avg value
Date: Mon,  4 May 2026 02:59:52 +0100
Message-Id: <20260504020003.71306-3-qyousef@layalina.io>
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

Given a util_avg value, the new function will return the future one
given a runtime delta.

This will be useful in later patches to help replace some magic margins
with more deterministic behavior.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 897790889ba3..5a8f4dc99ffc 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -488,3 +488,23 @@ bool update_other_load_avgs(struct rq *rq)
 		update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		update_irq_load_avg(rq, 0);
 }
+
+/*
+ * Approximate the new util_avg value assuming an entity has continued to run
+ * for @delta us.
+ */
+unsigned long approximate_util_avg(unsigned long util, u64 delta)
+{
+	struct sched_avg sa = {
+		.util_sum = util * PELT_MIN_DIVIDER,
+		.util_avg = util,
+	};
+
+	if (unlikely(!delta))
+		return util;
+
+	accumulate_sum(delta, &sa, 1, 0, 1);
+	___update_load_avg(&sa, 0);
+
+	return sa.util_avg;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c95584191d58..190515b50dc8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3527,6 +3527,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
+unsigned long approximate_util_avg(unsigned long util, u64 delta);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1

