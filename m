Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978419;
	b=pFhh0GKPHUgm5s8p0zoWo5gXdV+hsw6hPqDABT/aK0ZQoesKiqM7L1xueC/CJnlrmOFd
	 w7FwngeuW0+4+FGn0Per/6DGcI1PKOc35P1qqLbQGZALTmsGtaMBjT99JcYZzFhbIm3Yy
	 1zLVvE7Mz21CRGxFQY8qSVAPSETKj/R6uCdM801ppYvk0XGp7wGxip5m443DCimxuuwHN
	 WaKGDSsnJuXNb+zAH7PzXWZDyNvBBWHNiGhDLFGt60Ol2z1lDXIL/mvposB6xSh1akif4
	 xrC/ouFg3GJpZzM50jCcb05OTvByJbygsK7oVYltOsOhURWm8XK2IMKQbCkLr6ceSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
	b=DG9n5wHABGe3UtntTlQL42eM0OxyyemoKaOcprVLzUgAIvD8CLwDM/zlcWYLMGPvi5Xs
	 gP6GtRW4y0RgyzZPMHnpc5U0pDmiSW/dwmKyrZOujykIyRD58YyQQETeSotkWLPfmYSQh
	 XhdomjZok75KVC/NBbPXspZVYOhlTXEYSETHdy+YojnpGXIPjx7BRO2J+y5mnc9nGL/nx
	 Q8UGW6FjGGRxu1AjW3iYZhXqpvAMOEh5EfElbuZuEKKd0tSW9tzQeXx+aQhpSoABtwxBB
	 sTMgZ6x5erkaJDM1+HmRowUqJyLA1FPQbruciF2wlJr5Txnoq4pRhHI2Iqa/TZZM1FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B99UTQcq;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE446082BFE
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DE446082BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B99UTQcq
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so424542f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978416; x=1794583216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
        b=B99UTQcqb/Kdi3E+lLCDL5A1ROyssp6z47+0gSXIlizQKHFZBVC+1HcElAn+egUcie
         7S2Je9kSBpoGg1OZ+8tzqBRAuzbqDbng+jUFZUb8Yo2++GInPg1triAZc0MYK3A5EAAd
         VJkJYiQa9blT7Du84H3pp9Q1P4YX+gBudoDriFcrXNV9QjEq6EGjurRVnnhxpgIG4eiD
         4lgEncjwl+4mawiOHkdsFyw8vI+G9ij5RuJb8HVwLvxJWfkgKO+eOUloLFCMnEYm4/QX
         tclCGEUpWZCYu+aVjQwrmiZpXyx56WrAtgBYlcWsrKbEcTG6EsZ/TIR2SI8xJseb4/ml
         JKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978416; x=1794583216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43QcRTZ2xbLW2eh4U1VgtQuQohzOHYlTBhBh08gkyrE=;
        b=1dB93a7HBAiKvujyyOz0gRl+BqLrn24lF84RhAZAMTVv5nF/HG7Iq/Ih+hyXbRbIIH
         NeCrYNVG2KFMqZ9/OS1K3LK6FrUCPGKyym2bMSMsa0QAMYIUitClHwAmdBCwej+Te5bg
         CQ6KTuqxYvKiuGOkb27R/7rLGGkq6UyWpwmbycTnUO4QdnAMfsqtg+dT1BE53SJ3jFu9
         IXPRTdM0tU8SO6iE0ay16X88Nj8EoUTjXede/rIjAJsxOBxWq1dXsvOMwGRChRTdZULt
         gbh/LevYB+IvC79Pbpb0/6qqsbgg1QaMu7vGRbDvKOs5JrWdX61KgOabond+zOQHmHnM
         P03Q==
X-Forwarded-Encrypted: i=1; AL+hErFSlI5lloFYb7RxkjdXvmStjyevxAY9emBSY4ZYU2H7Enz4A1bpsNh1bQLRMEo7UyAKeNx70T2ndQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xxxkMHP5cdLCVpXuvEtLfvcwllmY/0apyT7aA8rP9YiSERXR3
	IXxpNKmZwz4MOQivw2BqqxC2UjKU3rcV7iuojryTvnzDHvRUKkijrDpq3oF/ydLpXcg=
X-Gm-Gg: AYBFou3uLfcGcmsJFUJGUyhHRUccvudHeuR7XiK6boIsPOfz8XrNO+c+N7UrIsM3rMK
	+idJT0tKqqyf5FF9EV5u3TrPTgyV4jauSWv/DdJ5c/9N7pYn3O49MxjxOBh5BHqpXpq9ReUWEFm
	vIPpbYhY2rRTlNYN1aYXaTVgKQJibU92kuLWbq2g3er8HkeeIPD7jnDO0/jTAhadKwnGVd9ltxR
	rxd7ZLEBvxYy51B2PxwzpSx2L0bl6AwT3MBy14lyuNTAF1SBgMqnA0Muu7pRl/fyZYshqP3SCjd
	Pjq128ric4Loae6JxaHHg7MGh50OivvNHA4knngin7xu0X8DegWU4Ry7mbjm2lhDcRk5En9HGDJ
	hdT8BFKkw7uoYnO/r4EcTm0VAHGrJK7uNeZ18pv8CCslfARPNkQeC2eRGIIUkV+vhVt/L/T5doO
	Vd0lSwqIii7Wydm4MklzFDzrr+ONriHkyaYW4nEtvGGojyKDfq81QYZkCvFr2rCOdQER0lLUruN
	JTs/jTy2Otb0tBTEpw77ml5hjXH+ybyMiZnnxtH1/Wbpaf8YIHUUuYKRpoPVv8EvNTzNxg7REbl
	TjjdqHC0lximLqQhtFmSRLfs3uqt5ftYHmt3GG4YpS38abU=
X-Received: by 2002:a05:6000:460c:b0:48e:c84:5be6 with SMTP id ffacd0b85a97d-49275fe4e54mr5481109f8f.14.1793978416458;
        Fri, 06 Nov 2026 07:20:16 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:14 -0800 (PST)
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
Subject: [PATCH 14/20 v3] sched/eevdf: Push short slice task that are not picked
Date: Fri,  6 Nov 2026 16:19:41 +0100
Message-ID: <20261106151947.3991524-15-vincent.guittot@linaro.org>
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

Even when set as next buddy, a number of event can prevent short slice
task to be picked. Add the task in the pushable list in case it is not
picked so it get a chance to be pushed on a better CPU.

This can typically happen when several short slice tasks are pushed on the
same CPU at wake up.

If the task is picked, it will be removed from the pushable list before we
queue the callback otherwise we will look for a better CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3923587b66e0..894bee51b99a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10273,6 +10273,12 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
 		__fair_add_pushable_task(rq, prev);
 }
 
+static void fair_add_pushable_short(struct rq *rq, struct task_struct *p)
+{
+	if (sched_push_task_enabled() && __check_pushable_fair_task(rq, p))
+		__fair_add_pushable_task(rq, p);
+}
+
 static int active_load_balance_cpu_stop(void *data);
 
 /*
@@ -10723,8 +10729,10 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
 preempt:
 	cancel_protect_slice(se);
 
-	if (preempt_action == PREEMPT_WAKEUP_SHORT)
+	if (preempt_action == PREEMPT_WAKEUP_SHORT) {
 		set_short_buddy(cfs_rq, pse);
+		fair_add_pushable_short(rq, p);
+	}
 
 	resched_curr_lazy(rq);
 }
-- 
2.53.0

