Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051FE1DF261
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860021; cv=none; b=SYewFmlaVrQ7Tt//eRELZLkVI7nCWm0p2lyhbDL/9CkSdft8pPZprTFQ0p2FRa5IhgMliJIKMkZE4SsnSKI+tcXr3YJwlLqh5/VGzCB8CBdMo7RhSFNfhImg+kZTRVVLZd4Pe6c0tHlSzfhfG5eWPKWvx4Cb2O6aP8vCbw8yIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860021; c=relaxed/simple;
	bh=5vG3U0BaZnJmp47YUmn031O5Pq3+fxqw0xD41MTuiO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAKzU/MD5X0IIUvkNAjUZt1zcZCdBVFqhgmyB2opFxAm0L4k8HWcznDOSd08BKyiW01uGAuOxNPNJUw3fQlmFsyNpMtBAE5E4U3a20RwAUtJ06iON3NFjkOOyirYMOYdeRrGFWCw5Eydx9O9fS2Y5bdhWHy9oyHlGmOfn6LNiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=zo7bdswt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="zo7bdswt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so47093915e9.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860018; x=1778464818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHhjICQePhZbdRVPnhX620Fr/hMNUIWexLWzur3AOv4=;
        b=zo7bdswtBG58Ba4mypZij16OpIJehK4oU66FWjeh8TrPKjHyUfi1Ad24e6dT3l1OEV
         aMEQ+dbzAGpqM22s0YwnNHkmdPB3bX7sSOufQEBwuojBhZnwzx0GeWqJBIEiZrJFGDMn
         1o/onr32myFA+t7A7JHALVEG28zmm7PHVUjl9WfOiGpWWq94T9n9+F21agMCkTT28wzI
         z/OEbxq9U1u8JB757TfA/zqbXN8ptxc+aWae3mYg2YmDAhc0KPApWdOKEVS51QveTK0R
         5/BVJOAJ++8FA4zXApan3g4HbS6hZQmIDigGfEOu/u66OfKOT3PHOYeYyTe0U6IMenlv
         qWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860018; x=1778464818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHhjICQePhZbdRVPnhX620Fr/hMNUIWexLWzur3AOv4=;
        b=WoWPllROtOcKNKG7mUz1X/aLOhMx8UDNVric8tikNEqFOzU0t6vS4X60O/rJvGXOzv
         hlpz0Y7scPhayLmXzakyoGIQxyLQMeCkojpIkvWaPfqA2w7U6z7qTsPLuIbSd24401uw
         ikluQQt5UartFIjTB7bstygYkmI6bBW4c5Z+O4tCFCU8FHd7QoLIVoBEvbzly0jzgd3S
         rVe9xRjHzQCWjXtws9M2uqSjZBjUKl0aU+aeNwPyOEYAfrhOMmNWl7jkvRp6573U4Ho3
         OnXL2jZEvC0LNTNZkFKL4VNVPgw7csms0f4hIjjTHFqHAvOk/P7Q5dELNKO8MXPBIJ0O
         Bwng==
X-Forwarded-Encrypted: i=1; AFNElJ9kIKRJObzDS1KGJxugxSVHkSZM8R3ALUMr9SgykENFQqE/YK8qxuvy1E+CpQc0HJgN6L9ETqKvWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhN4TQijeNzWmlan3gG5A8g8f6DqYczo5BdfDRgEKyyBgqo9vE
	kn+Dk0fT8KklUoAsZnBSZlSLDMpHAs6mrsxsH+wzOJM0AVu7xAhwIrS+KBwFBkAoOEE=
X-Gm-Gg: AeBDietAc+SH9Wi5mjMZjEOY9ubbGcEOOZ3MErIXozxEKMZ40KDbLNWl70tOhzLGSFx
	dRC9I9iPvGU8tP69I4tgP/CK3eJDbvG7iFwi69mL+aKq66zqH0IO8WbHop7MOnrwhDMDd8zt5Wa
	2MwKDg8MX3NgaaaJQP/f/FVu54k7IMwLyIT0EqwQqtPN9LSj1xg2HWHhqrHgeEXReh0dxCq5908
	cfQ84QfQEsn2AmGPCahdYLgx038zFBAkaAt5fe6YJ73RysZYkxc1GKkK3WdcUYtD0hxzaUyTgd0
	1ChewVUAuyuuUZ4HOL9JYcwOsTGI185weKlHi944gPzueuloXJWTxOi6ethiOv3MGYdH99A5yCA
	MpLafYHBwuhNOZagy+eg4wDlA+HpHO9V5Bqs9M0HAdseDMJjsk2dQOHZfMklrzDwI2dju04N/B2
	Hg8iaezw41+kidp9KDEPqn7ur0iLwJ1ew=
X-Received: by 2002:a05:600c:45d4:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48a9865e17dmr116960415e9.13.1777860018401;
        Sun, 03 May 2026 19:00:18 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:17 -0700 (PDT)
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
Subject: [PATCH v2 03/13] sched/pelt: Add a new function to approximate runtime to reach given util
Date: Mon,  4 May 2026 02:59:53 +0100
Message-Id: <20260504020003.71306-4-qyousef@layalina.io>
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

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 5a8f4dc99ffc..dbd450798b03 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -508,3 +508,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 190515b50dc8..a445add5cc3a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3528,6 +3528,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1

