Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978429;
	b=0/8LyxF98zBN8h+DrqdTxxFhbDawylhAXWNPePTKGG4VisTP1HnwUmeZzO/lflZ7uWf8
	 QvBE+3IHRmXvgM45eZBDfdzwaXILfjinCUHug0AeMfXZdkhWVZpo4BAOYU8F13RzvQDmc
	 BhR3ahxzXSSgVLhZcFvi2DMkL+4T9WZtQ2KTGuSbrLqgQbLl2D9IwQAMn04yBEAkciltD
	 ASP7cXew2KdqWdrOPhRq8dW6jFEBrN2Z4tJZyI0TgITgvQ0njhWgBQogHm+JrS9uP2CTr
	 Ht70EiAThOHWiENhfyacQPjiln6lR23cgw5OptZJ3vGBZVUj+K/FN2HfiWucQiaN0aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
	b=PLlY1ghSfGdMWEe2EartHVod//uyUl7JbicR8AHU/LrbQ7Bu1yY+H4aZPgmACx0YHuAl
	 m7DN2+DMg7+Szbexj699ukHWfS+dnPR+wGsPkrN4yNRzb00pY8PLQK8ei5aAzTdfCuJ2p
	 WrtEfm9K7M28MA2AdAGlIBolzmIBPThqluFnG6YwBb2kMOSDZK5z1bGGWfoLGaRgZAZ6d
	 2Dad3236mYcjYjv+LdACo2DN46t5F6EVbUXdPWNd3+jHzMPBDu6UJUnzl3bCxoYzO13BO
	 sFHdJQa8Or+FEEDhaS1jZY/ifwMjzDh3+8Upz28ZRqdSmPcjHvJzwGWxwulUoNM6q0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aXw0r6OX;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB17606D813
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB17606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aXw0r6OX
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a215e64962so8758595e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978427; x=1794583227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
        b=aXw0r6OXQRTTv0UHqcjPdCYBL30ITSlQSZzInGtGmJSzA+Masknl3jfpwmA9IUYIHH
         yGlQctaAIT1B+4dBWWeabeO5T89Qg1+5PrXLNU3TljBJCLAf3U9kfQgsmjlKzaEhQCqL
         GoJFbxOXVgTG2PhbK/bTe0P2Ynk5C3jCr1txGD/IT2WygaGs9r2TH58zv1m6M61ge35X
         tl43/F9xzc0lqTdIdgbOoxedwGWHzi4lRRwfcEEcyP2iTknWaOsgaPFA15KQh1Edxlk2
         wayXRgAKdBCJo/L4iWIkOXclNgi3kbKISDzZAEcdm9dABG1cim69qpuTa/9NN48Ea1RE
         BMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978427; x=1794583227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ST6MD8nmbeHSATr23Q5RjwDAfq9V48NFRR4Gq9s30TE=;
        b=ZvVn59B8QiZ2OT2vqgM62ba/OJt/NhSEj9ELpvHA41m/Gn8ytGTAJajGopH8KBSIRH
         gEJMwBXVgxSVqpkjk0S0JjiOQgRyMQ1Qs+c+5CG2YYBqteQkCPINl3sVWEj6jD/7dPei
         Snjxxd3uIx/A1YGKAvEgPek2Bq108zk4S2TWeBkIzhlg706nt9g9nQGwySDUNaJuRV4q
         Mc+Mx6AVifYXFcMUc3yJjAh+oWRPyQbo0gAUi6okzfIch2cyQGlsxciMEg71a7YO9Vi3
         q0kuRwF+AmljjM52/SvSOBrm/RrluA8o0lQpXBoo+gm11QVDEjWSxHai/AxDYJB6M2MP
         bBnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHa0RGV7dzi1C0tmgacna+86ock47CtQDP3ugmBMmPS42ifHESGcKTQ8Hg6jLJrErc9GY19DUWtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9eum8x1Rikif7k5tkwuVoACudjXgFoEZd5XxBskp/GLXpfZqxn
	OCHkW4XIuHvHRKvFhAQhwBCsMTpjIYfTs2lpNYvsqS204io2J1u2QKhhAg8qb1jYQGc=
X-Gm-Gg: AYBFou1WRO+/Avi8Q4Yze3aAhnOHo3EeaDL+wLsePUxxVNj1wpomNkKTtNvfglh2ZkP
	Az1pOVOtQouP65l0/aEx65nSePklKQb87jwD2uIcjf9Z2U4+kYC4YDVswzeEWmSsIEcwHfzXXG4
	h7Edt8j/WI5/WjrmvzkHz4QfSUuGMfHjNr6CelTyGJaZ4tyOTiuP2uFPiT5KiSApffXvFoHYMDW
	kWnverkuc07qr6LIuZRwIBzs1+zrmmNAiDDExB7njdr10CexT/VxCFp7Th9Y4fYkVtxe68pOpwb
	u3DxnMgrxBvHk+8oTV3JtTB+k9oXgmo5ppWv8mZ8HzNv0SyNfhLO+vES1gm5fkceKGX3GYu4wC6
	9RKRf82r/zA8EfULyAwEoJOQFfS0f7DeiYIHuuesB8d8FWoj1mOPapHTgrS+rDI3DX0ty4W1J1k
	pAEIP56Hmf7jlA6YfbGz8tN5Ds9pUjyXRQ8n3KWTRz6dnjMrsq2TsdC0XEHOxK5S32zKCm0Ji+w
	qO28pIwmTQhKH+OU9zbs7UMsspyU777lB/UKJB5wUzc2QHlvygCz4GSSjiVdt1VRNHWNGJFF1ht
	3N2wYiFfFMLjp7t2cZ5xCNUW8Hz+SFaNSffb7KTTe7N55pA=
X-Received: by 2002:a05:600c:3111:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b6dff87640mr49109825e9.30.1793978427419;
        Fri, 06 Nov 2026 07:20:27 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:25 -0800 (PST)
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
Subject: [PATCH 20/20 v3] sched/fair: Fix tasks stacking on same idle CPU
Date: Fri,  6 Nov 2026 16:19:47 +0100
Message-ID: <20261106151947.3991524-21-vincent.guittot@linaro.org>
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

When tasks wake up simultaneously, they can easily stack on the same idle
CPU but only one will run immediately. For others, a different CPU might
finally be a better choice. Take advantage of the push callback to try to
find another CPU for those tasks which lost the fight and haven't been
picked.

Call also sched_class->wakeup_preempt for the higher class so fair can be
prepared of handling several tasks stacked on the CPU. Other class returns
immadiately.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c |  1 +
 kernel/sched/fair.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1a3aa45ecf6..ef4cbcca2437 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2311,6 +2311,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_class->wakeup_preempt(rq, p, flags);
 		resched_curr(rq);
 		rq->next_class = p->sched_class;
+		rq->next_class->wakeup_preempt(rq, p, flags);
 	}
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da9c4416f1b5..262626455497 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10649,10 +10649,22 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
 	/*
 	 * XXX Getting preempted by higher class, try and find idle CPU?
 	 */
-	if (p->sched_class != &fair_sched_class ||
-	    donor->sched_class != &fair_sched_class)
+	if (p->sched_class != &fair_sched_class)
 		return;
 
+	if (donor->sched_class != &fair_sched_class) {
+		/*
+		 * When rq is idle, several tasks can select this rq at wakeup
+		 * without knowing others did the same. Give another chance to
+		 * select another rq if not picked.
+		 */
+		if (sched_class_above(&fair_sched_class, donor->sched_class) &&
+		    entity_eligible(cfs_rq, pse))
+			fair_add_pushable_short(rq, p);
+
+		return;
+	}
+
 	if (unlikely(se == pse))
 		return;
 
-- 
2.53.0

