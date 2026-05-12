Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8937DAB1
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590025; cv=none; b=qV4oJwZKDa1yWDJQaYvxZ5Nj+N911u9JoEwDELOBsQoS8bRAVGhL5pn+ieSl55fKu+izxjWYDv/vpeIOllhrmZksH840SMtUEs+ElILe9Fu+0xm7qnEQoEyIRePlY/Mb2IH+YrjHNRqLwcW5ucHmNCB+YEMntK/MvdaDdIwjnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590025; c=relaxed/simple;
	bh=bInddkVfc+pXKGHkffHzPuEVIu2QTRfs6h6awa+Mp9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TgvEYxhOzFYLoRCMNbzd5grGRDlxcYdsbbYIPQzR2i58/VERiCV9o8VstFhqIAuY/APTbITgbT9tYNTi+Nqwp7M66O3PiNFGEgar4ibJb0XkqTk9KUgjLVBuwptey0gMXR7XIlGujqc7YpoS7QS6rT03rRlBW9Du8FA0KMSVRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=yMXmNQiO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="yMXmNQiO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-448528f4e69so3267122f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778590019; x=1779194819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr874m6JcLiCyYvzD6j4nKzU3/HV5h/qU/z04aUpwE4=;
        b=yMXmNQiOH4vzaGBH0I9De7gaa578qEH1xGs0HWVjvw9dB6isrPVhzxOkLOJF0K0pFe
         +G8BCTcPexS4n2bFwafUVYg7cD+wPbAh3VasGxkHe64apTrsmXleYWUgkNp7AtyGU3CV
         8IPrtgdDO8L/8WG5i0NBwOXMdW8LFdCvbMxF1uXb9DQUSWQI8CrsXcbs1V8kwZHgxj6Q
         8epxcCRZ+rVN8HY8VPQKpcVdb3iVFfgixlisaZ83wEf/S9OA98kt7iSbseIYbrWhuYxG
         l+zt3IhNh5v/4an6xW0ATss4UUJuBRqqNP1FBTyPm6Ragmx9shpItxXUtLEqpStIxpS+
         1vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590019; x=1779194819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr874m6JcLiCyYvzD6j4nKzU3/HV5h/qU/z04aUpwE4=;
        b=Lt19zZNfp4bUAD7tI4HEvcQ757XKtKrMPhKXd3qrDVRAnGMysI2GeJlMOZLlD6QQoi
         DCGsUWGRvYxtR5ldBATQyEN7x2XBl1QcrM/WYI4e5xhZnR/fXUJIeNtSOe5uq4dUItw4
         ILM5grHy31An9affO7tZMSgj2Xbh54mUrlRJuoHq78lkhrux4HisSUf1xsEQSNbge4ap
         V3XczRRsHUsUVLVTp5dDTGsmV6z9MeUBTQ+zCsHNKjA6Ba2bNYRUPPRu4o53O4seRY29
         4cbYZVD4lkUmxyS2dSs5vhr9976TNDSQuZ+oCftDILCN7WZKRRW1e7n1jE5UdccfUrMn
         brog==
X-Forwarded-Encrypted: i=1; AFNElJ8RLHJQOIxuF0y399LT8Cl5EOETbVSA5w1BpxsGFoGTZVdD2XyaPQYtyGwTjK4gUfWsGI+rHuksig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9cvrtfFxBIfNAeBU1mtEngRu+r58idX+KHFypW4w3G7j4H4C
	86I3n+kmfiGewdjObrspnDiGqR/SLjkoBS7+2fHNTmgzsBxLa4oV2Jy10/BiX1xT5nQ=
X-Gm-Gg: Acq92OF2nwCCyIe5bahxADgSgkmW7iZ7ZwI4OeO+ahcBOdMUFfoI6AzXy7Ckq8EV5+s
	pZkSkRyVXh1M8zq4R2GnL6jI0TedZfUQIgA/mY0NdXuYEjhoRW0X3mv2A1OSwgeRtbj+Aaq90Jy
	Sd5BZq+smVgk44TXlfTe/dNc7/Vi2fzwbPpPNFhP4eS4MRsoTGhtkAbGuYpFUgHQALDNqvhO0f/
	WIKcPYoG2BXw9aR+yOkt1358EdzsBLlDxx6T3Kyjxc6xvC8cWK+r/7ePbkObWO3SddpM7qR35df
	rwzPxagOft3HfI5akWgaLwv7uOc5AjYpACroXfoJeCX+wGcwnjjhgmh3tWTVMFZT08MS9mcOMOw
	4dNJV5uC2IC1x3E2qVYCKB8ga19oYe0xcycIKhgM3UpijiumIbEYnBByyNFfH03OzxnIA6RsxGT
	ZJ/Tc/KcDPTdikxcC/CyG16UlgtyFyuUg=
X-Received: by 2002:a05:6000:2287:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-45461316920mr28476029f8f.10.1778590019078;
        Tue, 12 May 2026 05:46:59 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm33224020f8f.18.2026.05.12.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:46:58 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] sched/fair: Call update_util_est() after dequeue_entities()
Date: Tue, 12 May 2026 13:46:53 +0100
Message-Id: <20260512124653.305275-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
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

Fixes: b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

This is split from [1] series where I stumbled upon this problem. AFAICS it
needs backporting all the way to 6.12 LTS.

[1] https://lore.kernel.org/lkml/20260504020003.71306-1-qyousef@layalina.io/

 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 728965851842..96ba97e5f4ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7401,6 +7401,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
+	int ret;
+
 	if (task_is_throttled(p)) {
 		dequeue_throttled_task(p, flags);
 		return true;
@@ -7409,8 +7411,9 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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

