Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978399;
	b=z0ONkEocdODqZkeaPMc4iM7nYg6rvj9bidbQZjHmc3Hkd6F8SiY2jDPOLMnmMbSjn8Mw
	 mXvdHkeet4323ofw6ppyKC7cgcFPWorIXYcPoISRj+pxtFW8rR1tn/A4/2fr8Ga174cj5
	 BxvBCAZshXa6Pwo27a26WbSHfjmYWrdPQPCkrI5Ut+o0lrpzzZ8KAHbD+rLZRct1nLBU5
	 RDHTlf+KTKbDhDwC6BdGENtPrpZgUSuBK5w7Ly317jdrHHDf4UqqUdYEcyGoCg0j/uPxG
	 JafdLxWLqBM5ATPQo4RC/FeVE2HfGJeAXshsEerKEXzIP/ODn2q9GglPxiMEKC0sNrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
	b=oP04MQ3aUoYfDteQEU5RNfjGfKlsKBAUQxbXK19qck+VNsGWalmEbDEvrsomTa4iNiiF
	 25+vCPH/i2ZuMkYbavuluhpnb1/9SAc5VyiZ9kRa+/8dz46pe7s1fY+9FV4OudnM2if1T
	 Tuci1PNiWuuKILHXzNGzmUhbJ4Vt2j8CHwb4rOzs8JBPIgcsaYGxEt76vuv54oCgm4Xdt
	 YkpqLKjBMjgUSmyPbaIGC0AMLdyVFPlDDBgRDNUeEACSRKlJpiK53vViQhbqdZO3CkXLQ
	 QMLA4ipw1DTGgWJJ+EMTmHnyTuUtLQm1tJa1hN6XE6W9kwaWyHu9K8aBHcxFyZ20jjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RnAnz9Lx;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97495606A33D
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97495606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RnAnz9Lx
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so7335765e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978397; x=1794583197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
        b=RnAnz9LxQMnGYZ9dxhc9AiUSIU9JQZyo3E1EEKZQR++1OmdLkecZqS9etqzBSTGnSB
         nIWvW+zhuPVl+83PpQsfRKtRHknZKnHWNiYnjqpUcEwzONYm60t0L8hQkPhgEbVgCjaF
         cJ2VK5cuMt+fOiOS7yG8QNj45+gTD5v8Z7YkdYgnQ9FsULO46z2Rs86x0LDMNvTHa/hO
         3BttJYMZr2eJ5Kdqz0jNi5N984hZz0e1k2A2pwmKJqR28Xkc8Dyt77OiUmGOMryuUQaH
         O5jTBzsgULOPAnzy+9x8nVNOJwdYOJDxahpxNHg0QBNGlSCKZVaM1Mv3DWfKexBr/x2F
         Hn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978397; x=1794583197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iQOQ14MU4M2V3E3LBaEma6rT5obzfuyFx7uEPZEbprw=;
        b=n2teX2XzM5OUydSdkpsY7YLVM92UV7dpBDy+k9MxAZvJYnmVA26N3qF9C5+BimjkMj
         jkAc6f+WgT6DkFMGrtWD1ct7YBOUyYHit+AR2H4FKH8V41Z48LdxoKu8HNaO9SCV4EPQ
         TDRVTU3iGPcZ3GC0ZYI9oVgyVA9zQhl+L4eRqbGj8UkinASrcmBCooB9Q+U1wQTQpdbe
         W6MAasbZGJRI9Ie9swKNsKNMQ93crFKQoJNpNKx9NsnfmCqzs8zLuM/brh4b2HtvOLZC
         JRZlrZey5Xj7JJe/1gz7Bo9AX+mHl7kxYoih6l9jKNjvylnRVY//XUgJSkiCaybr9aXJ
         66yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIg9m3oZDZG4EB6UorL5a3LIcleWXNrzAljbfwsPrfndLaYAKylKH7gTqTaNHz9R++DDsbEKcrJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9F+xS0tS/8sNA2R+T7SmZdvW83b6cWpz6ej3e4nY+TJSLzK0vQ
	eVk01IQVcCAqvnXEldFP+Dj5fg6JbIVoSyDhiktuL7HDJ4FKF1MgK6Gk/I8qiWZLtNQ=
X-Gm-Gg: AYBFou3hsG8cW3MeU142IEfB4rJGooM1XaH0WWoxwitwXrvmSyUUBJqILLjnEWFqv/o
	V1KAUZ4npyvc3tvP1Bj5VMHT74yPacBFXByrQgKtLjo99fV1X/2rQLmI01/gbXJy/CTaTSOijIO
	27w/WOeR5iPG0d8DfqbGBnpMFx6UTTR16otLL+1cV5HfA7kwAgdXJouYXdjjGadzqneoC6lUHMq
	4uSC8Q+FRDZbgFMMk3kecBLbuOyMs2OHOUwSLLrIdh81N6twNHoaDT6qYkRTaMJmMjQqICn8Jy8
	PR1sd8AlfcHqomx6CaKXvz2u/RCIwSMTrNgDPAj+EJGqa18jGfIo+MCZ8ONiGMT7kr7Or0qYPnm
	/KdkGAE7yu0zPap1qBkpU5G5IQt2IR9kvLbG9BfR2T91PA66AcW77KBggSkqhalw9dhzZfTGgaN
	ake5D/pnof3v8hGRLrXUm08MatSVeeQm0xnIYVOdvVJJWXrfMAjxvL916n1Ckj9JN5bRSMnNkNh
	fmT0sTtVTTHoo756OS/uFrU9/7ES02Lv9a9PgY85wMo8bAsI85sOwUJjZqqjfX5qEs9WuqKfe3Y
	OPsykW25JnN6mGV9LjCh/5PoDW6XBZhDlishhSZzXWbLJzY=
X-Received: by 2002:a05:600c:3d05:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4b6dfba86fbmr52101995e9.22.1793978396996;
        Fri, 06 Nov 2026 07:19:56 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:56 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 04/20 v3] sched/eevdf: Reset lag when waking up on idle cpu
Date: Fri,  6 Nov 2026 16:19:31 +0100
Message-ID: <20261106151947.3991524-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When several tasks wake up simultaneously on an idle CPU but their prev
CPUs were not idle, their final vlag will depend on the enqueue ordering
as the first one will lose its lag but not the next ones.

Reset the lag during the enqueue if no fair task has already been picked
and set as the running task.

As a typical example:
- CPU0 is idle
- TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.

Depending which task grabs the lock 1st, the behavior will be different:
 - If TA is enqueued 1st, TB will be enqueued with a positive lag and will
be picked 1st.
 - If TB is enqueued 1st, it will lose its positive vlag and both TA and
TB will have 0 vlag when eevdf picks next task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 945de0215abb..6ce4162a7703 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -967,6 +967,14 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 	if (vlag <= 0)
 		return;
 
+	rq = rq_of(cfs_rq);
+
+	/* You can't claim any lag when waking on idle CPU */
+	if (rq->curr == rq->idle) {
+		se->vlag = 0;
+		return;
+	}
+
 	/* No fast access to prev rq task clock */
 	if (flags & ENQUEUE_MIGRATED)
 		return;
@@ -977,8 +985,6 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	rq = rq_of(cfs_rq);
-
 	/* Compute sleep time */
 	delta_exec = rq_clock_task(rq) - se->exec_start;
 	if (unlikely(delta_exec <= 0))
-- 
2.53.0

