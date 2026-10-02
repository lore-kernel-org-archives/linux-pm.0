Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF54EE84D
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955931; cv=none; b=MA0JnoSbw39Lh7lhmTm+oEoG51L+CFIh+86MsGBg9u3PCH4S4UqNOq/rA3ZRdIc/J9GlQe55+KeR6IUKOo8Q8HQVSMQQnotwwXETsiMH0ZW0SHoQhPHFSZ+5aRCaP950wmYwowvf29n/Ogv4uIB0znMjPCsMK3aKrPayaHMnuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955931; c=relaxed/simple;
	bh=CeTHB4ypLnb5H3d23FrgyQcrpY2y8roNeeEMV+cxjyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb33yWFqc/b5ypU+1q7+OvbVngPDoLnppxoBdn76r9pSFkSR9+2wTgOYFcAEwQ+ETVbW2JfQ0isk/q79P+jAk+rmnQ37kaxF616J++RcTxht3hhaPpsNuNK30OtzmUcOchbk6NZBsStDABYNiNPAEGb45iGLWc0qk650Zx5aZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HB446zzV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB446zzV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso189965e9.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955922; x=1791560722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZjs7e//iaMUq0DbBBAkyBGkWfGjYDHq+81y/lPHXV0=;
        b=HB446zzVAK31YlA23DKZGSW+unxN2agRncqN8pZ8aqyMcPLjQLhwDr4uxuEKyUh2V/
         vLK8Sma5TkDvAd3JQfWR2dm5QYpfL9hUOwJa+QGEf9UmF5AMFWli87nljpDrlSIgCb0O
         2ZZv6jpz21wxBPPgIgSjHkxlHkwEq6VkfB5rheVbz8/8tJHVfjg2WTxZlSopesI0DBhG
         T0e2rMipBeyXcjplUKxlDGsmLqBM96Ds07z8TIqDDUhOe3YcFg0FRppYcMAYUStTSbPO
         QaX0npVGIdf/Vtt3GPh5V5lTkjo5QR4qmV08V3v98UzZ8vD/hi6HPja1W5Rgwi+NEtaS
         uoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955922; x=1791560722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZjs7e//iaMUq0DbBBAkyBGkWfGjYDHq+81y/lPHXV0=;
        b=ih+iiXQokUHIAAFOglyQ0AS9l3TcwUdgB0IKVy896n73KQcgSdznmfTR3f0lvHkN2N
         F8wXAGPkyZFyaWIRcH2B+9sQO49IVYeKMHRaftsKrF8gkncELhEhhbJztAZIUM9wh4j2
         mT9atcws75m/PBRhGmv/lx8Ea1wvHjcbQI8l9/g/GURJgF0M2P+miewesgEm93P20JeW
         hlyYfBhoRVfUojVHf1teFP+7Cz3EpH1PjPMB4hsc0IhPySfmhwDVYHX/nA0ujhCJ9HOc
         j2b0bQu3NyXYhyxSwmqNCvbogKb5AOVbFTAyP3fJLAvy7NGU65PBvtMmdaCwRGLb6M4s
         fgTg==
X-Forwarded-Encrypted: i=1; AKwUvBxTizLDAeRJGHva3LJ1Bw/avO6ZWwy7ZKjHdJlIjbKHTfTIFsqgLAI5dHWiw0BU5/Rtv0YKmkFlOg==@vger.kernel.org
X-Gm-Message-State: AFuF++m3qocufG1uQPJQ+8JeTJjVVwx5eFlYcLkFWChh3vvWOVhRkH0V
	jNuXO6y7feCFI8V47sxeFSmme9hTHO04P96AKmLqCUnA+Gvg7CYJhchHgD+MJ85BiM4=
X-Gm-Gg: AYBFou0J/e9A9Hkiu9+9tLr5NH1+hQ/gVKYzjrW3UmI/heuER0xlbp8JeTz6iNrXW6l
	/xzph5xjdz9nthKvhbgauaDkosfRyyc6UsNx6ZaTkFeaQe/cUs+1HwjIt2W8mQoyEYggRuJr4nC
	c9BH/f/VMTlanqMOeQmL80MhWMaZ2kZbPVF8CX1KLji63f9szPHnLMT9hmHvbFL9Hl5IWH43q+v
	mPvLMQbovGQ7/f0REApoadQNSgJIeAFW68NwgtLNU/8wCwMaL444u2KAx1nGMbjyiB+cdthY/5Q
	AavEmtc7deH8CtDFfo7Rjj5xFIObhCg1URSH4WaIydEFuK7PSAfv4DN39CbTi6wFN66GlADRM1p
	BplBXZSzjLBJ+vh6lQHIqmd/yeC/SYlU/50khCVWvarJ5rRRpTLfzqQa8ic7S94X2vekYaoR2HA
	6h/yWhaYCQ3nN4UMO5uL4e4+7f7jrwB9SPlP7UYV2R7NvxPy/2nQSBFaSGibJVdpvGE0GvwYfqw
	kaaa9Y2GkIuPakl
X-Received: by 2002:a05:600c:230b:b0:4a0:2533:c8b7 with SMTP id 5b1f17b1804b1-4a0276c6176mr42183355e9.35.1790955921951;
        Fri, 02 Oct 2026 08:45:21 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 13/18 v2] sched/eevdf: Push short slice task that are not picked
Date: Fri,  2 Oct 2026 17:44:10 +0200
Message-ID: <20261002154415.2270586-14-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even when set as next buddy, a number of event can prevent short slice
task to not be picked. Add the task in the pushable list in case it is not
picked so it get a chance to be pushed on a better CPU.

This can typically happen when several short slice tasks are pushed on the
same CPU at wake up.

If the task is picked, it will be removed from the pushable list before we
queue the callback.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 186f10173eed..cccdc40b8a24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9981,6 +9981,12 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, stru
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
@@ -10419,8 +10425,10 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
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

