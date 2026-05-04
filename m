Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB51F1534
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860041; cv=none; b=RKItmyqh8+sMCR21EXt9/D/l/UzeBIzjAdcxtNZUuGWqPf2+umo64ntuxfyINvKcyoW2gfJVtAMWUe+ztX+91n1p5fJ5QJfN04rmsrxmkxjyervwSQuvtFRzv8HSpJeiaDEevMM5z9KvL0L/XWBf+ljf9rvngtvDv38OdPSOZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860041; c=relaxed/simple;
	bh=QkOKQICC5yt2pJugqkrh+wtd/pyAXJ2pn3e2FMLdQkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYPu77IdFd1KPmRu1HAYLDOwQGr7ibtqaavI500INflQFFQTlmEuv7sGxwfTv3ZHVN4RMqMPbmeGqeZvcbVeEqGrIg9APyjbdGLj2dcmDSd7o6yb5WmEbkz8YlBgsCtn9YrsEqOyrufD67H1q5DVK7VEMaBnPKnn+YgfIbo/jiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=ceBXQfUo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="ceBXQfUo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso42882365e9.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860038; x=1778464838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/E8KR0XEjeExn68lfo2HlzMQ0sz7ZGE2ppHllIbcQU=;
        b=ceBXQfUoXnimbX+ewxK6669e9h3oAduv8WpkxwdxDPLnxkzcvgvRBDzVUfVuLpv6A9
         HewZC4NMSgxf0fymccKuzHD8Sn32smryU7F+mSMxJUgMeBr3duM7r/FCpMCYWFiH+KuR
         /IWyTSGAxvrMsyDyh4NcGrmpzjROMknbAKQsjKoOXkr7I2uUD8ZKVqK6ZYCzG5Qxgwsc
         YSMRIBwh6dHxiD21rwjdSA9w0GiiqcJXAsvr8OHwkuIJbPfIvx8ymHBNMUDxF1zbUg2I
         nXDakDHjF2nK3Tcf1/xEoTF5Xt5hSWS3PCXcuQJkwj+RuQ9QacG2m4TnA4RTlVZUoPMt
         93ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860038; x=1778464838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/E8KR0XEjeExn68lfo2HlzMQ0sz7ZGE2ppHllIbcQU=;
        b=orFy9BsORgU2+JxfPBxyrRHlIZupL2K1zNc5F3OEpZPsWtGguM5or39MYhYc0cmpRb
         kCWtzMmHYSvgHcRQGggjat8r/ZdjCD9g3BqQCsFBvGnWMcuKZJDVrAT0RCquL3nBjgr0
         xzpBWpiZ7XOqX22Wq4RoxtfxkNF7XH2T/ufaEIg7GsGLYD/HUsKC8NQnqChtKk5kvn7b
         +M8WxgxAVe5JKFrqAgqXOpzgQiKWZnLvte6iccuTmyl4vR/887HS/4HTGQCsCO3ygxAJ
         xhJWj3/ITcLIV81pf/0WE6D707FMjP+5Q0REyjpHvTYZ1MXci9nAJATeUACxXa4J+FFs
         L3Rw==
X-Forwarded-Encrypted: i=1; AFNElJ8NuXR8QOI+yksksi4oZDJx3LX4tUXnLV/OwO+udTvZDFwD7V/jHwHxwu95GShvtLQ/CDsLgTvV+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgDztqUJqjDEvn/jr73ouzPg0T+/ssYhClf15LxPRdkH6nP9t
	v6Ul6jYNfd06Etgo2Tgqd1WQdZw2Dx1cGWEIPTm208osselX1j9IeJqp4oU+75Oitmg=
X-Gm-Gg: AeBDietIvjh3xSDjP2pcGbh9egEB54v2p/vXTgEHResQK8WNPAK3XLYoi9uexPJxYXo
	UBI4sj7HnFUMKWttUlaGU/kOyY9D2BwZKyGid6ZYbbpjjZfv/TLiTOWz7ftWhUddpxHHLqsAEbu
	mLf83UGRycVzIux/IeMsbjI5v4/P9gH4ZHtrVAGiUdUZTfq4oz6NGfC/t/YP3V0mR/u6TaoKw16
	6QkpXrtvwKPVHgDZcQvLSjlC7s9c4UTBa9ARPFKt4TcrxkE5hIUueQRMPL1AG7jeZnbUdrvrtrK
	atw2ek8G8yPI8eVpaOWsntJUTkzizAec8+6OrGOnf/RrvMqi7433gwtAy0gYOj1VuTUwOQTsunD
	kcoc2xFjNCM8CZKCa2nlSfDfKu4GBw7qHmt9893x0uONVhmaqa/QRLhMfSttTyFEhgvNrdmZdpj
	z+i3jbwkJi2vrHq8IwDl/mdrjn4W0Xw9Q=
X-Received: by 2002:a05:600c:828a:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-48a986790e9mr129881665e9.29.1777860037407;
        Sun, 03 May 2026 19:00:37 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:36 -0700 (PDT)
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
Subject: [PATCH v2 10/13] sched/fair: Disable util_est when rampup_multiplier is 0
Date: Mon,  4 May 2026 03:00:00 +0100
Message-Id: <20260504020003.71306-11-qyousef@layalina.io>
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

util_est is a great feature to enable busy tasks with long sleep time to
maintain their perf level. But it can also be expensive in terms of
power for tasks that have no such perf requirements and just happened to
be busy in the last activation.

If a task sets its rampup_multiplier to 0, then it indicates that it is
happy to glide along with system default response and doesn't require
responsiveness. We can use that to further imply that the task is happy
to decay its util for long sleep too and disable util_est.

The behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feat that
is enabled by default.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c     | 8 ++++++++
 kernel/sched/features.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8124bcc602d3..a36d6abaf6d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5104,6 +5104,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!sched_feat(UTIL_EST))
 		return;
 
+	/*
+	 * rampup_multiplier = 0 indicates util_est is disabled.
+	 */
+	if (sched_feat(UTIL_EST_RAMPUP_ZERO) && !p->sched_qos.rampup_multiplier) {
+		ewma = 0;
+		goto done;
+	}
+
 	/* Get current estimate of utilization */
 	ewma = READ_ONCE(p->se.avg.util_est);
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 6f7e5bba854f..05eed37a9064 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -122,6 +122,11 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 
+/*
+ * Disable util_est when rampup_multiplier is 0.
+ */
+SCHED_FEAT(UTIL_EST_RAMPUP_ZERO, true)
+
 SCHED_FEAT(LATENCY_WARN, false)
 
 /*
-- 
2.34.1

