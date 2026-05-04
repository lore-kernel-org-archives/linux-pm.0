Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953A1F5847
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860048; cv=none; b=aBJwM26LXhdwMxeVSHI+9NuZAJf6rPdSLWloqEH41m9LT76hnyqUzstqY/ix6O0Yt2PyGnCGG6E4so4o5dCT1ObewTbzDsvPP/Yvhg/sQ9lf2dHd/ZEhxLQr06sXO/+leQl6LQveZ6Sm8mbOZvHAbrJcTqMWOOieJfVHiFrKXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860048; c=relaxed/simple;
	bh=syA1uKvD2SIpi113rRI2QtXJk6354F+wskAFbK+kYFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzMRTYH2LZUFKLH8yHgPOtxpMV7T89DQ8KPw8IGteFxM5v37vqD0bD0NLh9yH+d8OdpcVlyMAKgV+d70Ykl5mqa9qHZPSuzcNPVpaxK0xlKlNjRnUrXsUW3gCg8ljEA6P4NhxgnkN9NtbGQSNi0KpdGUGsPUiTmd0F2XJfN0POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=e8WBvnAc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="e8WBvnAc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d102471a4so801665e9.2
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860043; x=1778464843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gSJS7wB39WX+wxJ4xaZGWICn1EmJcXYfO92MXwTTkI=;
        b=e8WBvnAceDlJZbxrodQZ4iIq7a+NdxOaH9s6qO5h8wV3cJfTOi3imJs+ZVCRHMD/zk
         sgJRRdjzU6sCJAOu8ZQGVZh0lwMbUKRXbrXt38rO5IZScovP6vIkvJHG7xZqYV3wAQHX
         zI0waDQDz0q3wVxQiWdaDWOLWg3xTBdYJwMZCYg67K8d+vQ72mQkGCRtfJTA7j9+KViy
         zxCBnz4ZdsRkT7zaSDG3mXGQNuUuY9TVYV4APtsqnc0BzllEdyy+vQRdZQBON5LX6KEP
         pyN/NNK+tnSQhggv8Ik1HT8YYFuQv6zFEyAEpCxxwINq7PhUnZJjqx1SGCaCONGpgMG3
         eoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860043; x=1778464843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gSJS7wB39WX+wxJ4xaZGWICn1EmJcXYfO92MXwTTkI=;
        b=FnNKpxa/gGJMJ2ySXc7toA4EVYwsimR43cC9YhalzGoFM4JBS354gaFRUq/U7BWcZU
         D12sNQg6McjakWv/fuiaKV1GTfd4N0M1by362TIrT3geukVkoGfjUfmkqNjG3IODL87D
         iFupb4KYadzaa1riOF6uoTMFXrQYdnVYJOPen5TeHyGVLQWhJMhtu5dx+P/zGpGMI6BZ
         eV6rFQ959O14wJAhak8t1IzS8cQHyQx4mXJaHDmyh+USWO6O7KfHbC0+/f2a1SvTBt23
         REvBitS3qeEgcrQcsa12/aAV104c/pLZuP/45pf8Wte51i5MAS88A2B11ncHDc+WJvIw
         FvfA==
X-Forwarded-Encrypted: i=1; AFNElJ+mQ6W8uv9Vx9mv3HzDy2b4eTCiygeJ1GDHHTtU4a4RL75rR9yhdUvmhME+1iPqAELly7d/R+U7fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaVeV53MgUdKG85SdYM6BZDaWtWPCnI5STLfVISVW4pswfSo4
	a+ak5EUPWj1RCNEAGjpHjtlRrh/tHl87aLKXU+Pfrjax5gyDEDS8B7rFEus7HbVnZqs=
X-Gm-Gg: AeBDiet42aIg3CCBKj78QFLluSsjbCoqnF40tR/DAhBaCXFVyX5p3ra/FmMEpHeIyee
	5xU/YZtei/QmOJJJ23CbUDnezrM48rMVzdoW+TrpA+ky32q37i5DSuLNSlgUtWleMIigBkO/pJk
	apu+FFUDr14Zj0AIg1CJuifj6iPVsm/alUF+w8nbGOdue58GBiNJiRnOOhFZLCWgJZlxUBVfuxj
	af8e2T+TdoxaULsRf7SAVUId4Z5IeEpw5zbFOsilmqBP7wvfNFwuTD1rR29FALnRQBeySkEw/rL
	TF4QKKM2aYG7RK/q0+KCExuv4FQDt0M4rJ2gDB3bNGLqjmHuZMmBdbSz4pcLYNyGeY12tOL+8Sw
	I/rnw8m6Fdp4Nv5I9Ig0VD2iB0FGMWFRi98KcvzRcC7ROtnfC9FHuGkmlpOVcPJb4yEDDhu8ohw
	MUmZhIYPGSMg21oQPX3vpx6CA21in07HEp56DR9RJgLw==
X-Received: by 2002:a05:600c:8287:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48a986526f4mr115419895e9.0.1777860043115;
        Sun, 03 May 2026 19:00:43 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:41 -0700 (PDT)
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
Subject: [PATCH v2 12/13] sched/fair: Call update_util_est() after dequeue_entities()
Date: Mon,  4 May 2026 03:00:02 +0100
Message-Id: <20260504020003.71306-13-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

update_util_est() reads task_util() at dequeue which is updated in
dequeue_entities(). To read the accurate util_avg at dequeue, make sure
to do the read after load_avg is updated in dequeue_entities().

util_est for a periodic task before

                                periodic-3114 util_est.enqueued running
   ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
183┤                ▖▗  ▐▖         ▖ ▗▙   ▗   ▗▙▖▖       ▖▖   ▖       ▖▖        ▗  ▟  ▗▄▖          │
139┤               ▐▛█▜▙▞▀▄▄▞▚▄▟█▞▙█▄▟▀▚▄▄▞▚▄▄▟▀▀▛▄▝▄▄▄▙█▛▛█▛▜▛▄▄▀▄█▙▛▛▛▙▄▀▄▄▖▜▄▟█▟▀▜▟▄▜▀▄▄▟▙▖     │
 95┤              ▐▀    ▘   ▝   ▝        ▝▘        ▘   ▘▘       ▝▘       ▝▘  ▝    ▝        ▀       │
   │              ▛                                                                                │
 51┤             ▐▘                                                                                │
  7┤      ▖▗▗  ▗▄▐                                                                                 │
   └┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬┘
  0.00      0.65       1.30      1.96       2.61      3.26       3.91      4.57       5.22     5.87

and after

                                 periodic-2977 util_est.enqueued running
     ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
157.0┤               ▙▄ ▗▄  ▗▄▄▄ ▗▄  ▗▄▄▄▗▄▄  ▗▄▄▖ ▄   ▄▄▄   ▄  ▄▖▖  ▄▄▄▄▄▖▖▝▙▄▄▄▄▄▄▖ ▗▄           │
119.5┤             ▗▄▌▘▀▀ ▀▀▀ ▝▀▀▘▝▀▀▀ ▝▀▘ ▝▀▀▘ ▀▝▀▘▀▀▀▘▝▀▀▀▀▀▀▀▘▝▝▀▀ ▀   ▝▝▀  ▀   ▀▀▀▀            │
 82.0┤             ▟                                                                               │
     │             ▌                                                                               │
 44.5┤             ▌                                                                               │
  7.0┤      ▗   ▗▖ ▌                                                                               │
     └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
    0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.56      5.21     5.86

Note how the signal is noisier and can peak to 183 vs 157 now.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0f646b32c2d..2fec5b6a7c30 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7455,6 +7455,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
+	int ret;
+
 	if (task_is_throttled(p)) {
 		dequeue_throttled_task(p, flags);
 		return true;
@@ -7463,8 +7465,9 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
+	ret = dequeue_entities(rq, &p->se, flags);
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (ret < 0)
 		return false;
 
 	/*
-- 
2.34.1

