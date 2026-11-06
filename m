Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978401;
	b=iC2cgEryKOb4qwKwLlFBxrODhHeIBF/CE2pc09qVgb6mX6Zt3wQf14gx0wP5IuB+4LDT
	 sXNixcmca7Z0x6gnKBN6a167IPThg7BkNkjbCzT0FrG1IdDnSZ2ftvKJayNaIZ9NzYgZC
	 SG81RuMZ5NdZui9PM/UzAs/lzVEZFSI5TVIWxQTxD6sBynkATl6Gn4YeorVgXI7IdSUn/
	 BFRFfsZMqri1M3FEk5wDf3Zko1PNrMAzqZPkdg2J3faT1GgXnX4aGbYxVeWGstpnVrqAa
	 BOCjdXulu+fqSdg00ANidcxOoLFuBw9e3/Y3rVw1g0My9Zoa8NKHlyr8BlwYnhL1ZCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
	b=n2kgWpz2ZjMBI6LimQ9s65kNWq1H+M44TI6Ovagplt+UI6U6OOeqPPB20LJdj41AyatP
	 TwwV8R0Ox1U1t+NL7SasJYnFIZGxfE9UJjyB+WOFeiZKogomt+1Zd4h+NO0pnl+TlmtTS
	 tyd6bklx4nsBXPn7R4vQYWOnEKr16LqpfkouwHWD1weHjlZN05aipU5GNbDEExg3RM8kZ
	 vkwhuBqUwT7BL5zJNIAb6tRQSfwphp4EFCIqYdMOF+ABLfrfeVdc1ZEOQImw2YYF0FuIF
	 lnPbco3/LEG2h7gHBNfRk2G0VyrlPCGZdoGFDjMYATu3QMCNkyjk+8n32DytYkXqvhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m+2yBrse;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE606A329
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89FE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m+2yBrse
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490585eddfcso520334f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978399; x=1794583199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
        b=m+2yBrseO5m5TLXpRDXIXWYVcsoRdptxoOkmolG4XHT7SEj7Mp39I9L9JZYYL2Of2m
         lxCcycP7+JGKx2+ZoYVWvItVoSDKs+lrRsZ5/Y1X2zSGkQn8J3oqQMd7EbcjCK2X96JM
         +Gv+HEPU964scI6YZsIMG8InYSpnprKcrLkr/MOarIFAak2A7y7HbmgrcQtMGJFLwJ3h
         hdb4id41sSMQekNAjW0nT3GF8Tv3acqLHcTKJ86EDd4NkDwdCrQZrgoS3IyxYji4c7vU
         RbIPg5Bzh/dui11dUB2uVOdevUAjAtDcPoNDjt6nKLQBq0GjxgjkljZDZYueez9AeTOb
         ByGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978399; x=1794583199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
        b=2k0ngr3LOUFjIsOfwi1w4uOKhBRxThR51dywbuyAS/PyBOKjthkPDtqvBqhIJ8/rno
         Ak0EvIoRp5TF5G0t/MjlKt1trJ0f/YcZuzfm7dfNaXAtDmodRHHOKIHImVyRjItCvmZ1
         I6BfYnISh9d7Uy+h++Px4TO54M3snHDi14dggcCs8+Ks7+hGQ2sHNQ7c8GjSs8DzsdG7
         JqGzYwSHG9jMeRIz4JowMV4Tiv4AXMHoAfwkCCjU8UqZlCHjgyRtI6pZ/HPI9T4E6YOr
         110FYwuqggsra4/q/VEhAm6eoD7SFmhjuT803+1W+bL3YxSFSURVYuy6aAKzYkQw9TVh
         ksng==
X-Forwarded-Encrypted: i=1; AL+hErEMJjKcXGv5wbqs8wNLLeLeQ55iSu5eatu7wOord2whuDpWDZeDXmY53w+6QNypa2aSJQxDIgJdDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yKmUVkI11GEXwInsx5H1Ld3VtDDucRm86UoEgYW0+D8UkDDFQ
	ETnrbnzi1PCfef+XNMhGpXQ9SaQ4OY3zvrkSOZXyZopTM4PO9+SGpEWvZks8vPctazg=
X-Gm-Gg: AYBFou0o/INShVo8sBqcnj8aCHnVwEdAcRh1lk6hKNbIekFMe4lxEPgJrdkXYsqdpM1
	XDNJNByf7/9yuDEie2UGCJmLAhnosAUxFBo+ENapaSufdqiyvA87tiVSOZeBWBV6gKIQOHENU7o
	LYwRPFa7aWvozPT30W8PggcBC4xQEmT+7gS+gYaVvHNQEajHBtQOLoJQpYP4vjPzH0B6ZQDLE5I
	lfnwzkz+BcnvBQTS89g8WCky8r6IFHQtAPcMnltMqmTu9vNzir2qnEIrK/A4G0y91h4bf4F31hY
	nHhiBlUjTJpotK45kn9d313+qSfUoQ4WA4WN+w9jpvWjnFm+s1FSaotlYTeMaU8qnt6RgMBarmt
	WKkSedKMLDCv77tJsseYaCDEzc7fRmw7XhdLzww990F0nKoHr0DBzWvq3sYMTZPRBoue2WwQwjG
	j+q36zH+ANVYSYsJjoVOUjmBsN4Ivfaiv+YjUZcDF8gLqCeVNNGasEPeVn+NrXxtQ6PiuWfBRWy
	nm/9dPbpQwo5kCKBtgIB7p3VcOZVX4uLQ/mGIMdAozafwLt9MdynoJydU7RmbltkZHtxhKjjhnv
	RStsN4b4iATte3a1mcMptjXMeAGQ582prODiiYMDdubKC0g=
X-Received: by 2002:a5d:5f04:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49278174603mr5569876f8f.52.1793978399093;
        Fri, 06 Nov 2026 07:19:59 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:57 -0800 (PST)
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
Subject: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
Date: Fri,  6 Nov 2026 16:19:32 +0100
Message-ID: <20261106151947.3991524-6-vincent.guittot@linaro.org>
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

In order to use min_slice during CPU selection, update a cached value when
needed after en/dequeing a new task. This cached value includes current
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7c3b43158de..031efe7d49fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9012,6 +9012,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->min_slice = ULONG_MAX;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ce4162a7703..cfc99b94d9ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1130,6 +1130,30 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb,
 		     RB_AUG(slice, min_slice, min),
 		     RB_AUG(slice, max_slice, max));
 
+/*
+ * Entity's slice is in the range [100us:100ms].
+ */
+static unsigned long get_rq_min_slice(struct rq *rq)
+{
+	return READ_ONCE(rq->min_slice);
+}
+
+static void __update_rq_min_slice(struct rq *rq)
+{
+	unsigned long min = cfs_rq_min_slice(&rq->cfs);
+
+	/*
+	 * When there is no task enqueued, we check idleness instead of slice.
+	 * Reset min_slice so the rq will be selected because its idlenes and
+	 * not because of slice comparison.
+	 */
+	if (min == ULONG_MAX)
+		min = 0;
+
+	if (min != get_rq_min_slice(rq))
+		WRITE_ONCE(rq->min_slice, min);
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
@@ -8295,6 +8319,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		__enqueue_entity(cfs_rq, se);
 	}
 
+	__update_rq_min_slice(rq);
+
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
@@ -8420,6 +8446,8 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 
+	__update_rq_min_slice(rq);
+
 	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24f9b7bd8f0f..7a95df4f14d2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1173,6 +1173,7 @@ struct rq {
 #endif
 	unsigned int		ttwu_pending;
 	unsigned long		cpu_capacity;
+	unsigned long		min_slice;
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */
 	struct task_struct __rcu	*curr;   /* Execution context */
-- 
2.53.0

