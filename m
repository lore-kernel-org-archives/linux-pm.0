Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EA4E3786
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=rE+v/BObDPRAuepNWskPfegE4HDF10r3zBbcxQy3onmdjivSyVq/oxuw8wjR/7X4WACF6ROgJFk7lZN9PoGmiysCRKEogs64vdT0BToazYrNMZeqoNGlH3HQJkZCt+H39JHxDru/SqOoJGWnMcprUMZsjI5iN/pQPP1puv+jG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=1lvJcxD9+zZwv6HbWjirpJuv17LA3EvKwbPn3OvpJ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdZCrra9NEzmGx4E5totmirY6sDbYw9Dg1u6J2dchJ4N7pvJN7eewTR6u/gbr4EX5RbeS8QzgBdy7LmKdBNA9dF8EjHarLoc1livEVbQke+zhRFVZPQh6FCx1SkcmD+p0U5TVfbJ2N31UNRZNSMd+cXZI61meGkA2XjYDfa1cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=desfDIIh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="desfDIIh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso303505e9.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955919; x=1791560719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ya9RfmxJPM2JLLUcoTWuhNhFBf+WLZtJ0RXJ7Ml9FIQ=;
        b=desfDIIhs6Fh0LwGP6JhPZlhLSwy6CYw/6c7aaKBZtCJZaXDB0ifqeM6xhT9vcGXId
         iwSvG8WhwuyJq1447ztBTUBBY5G6oe2YuumtdFo1PUkhXhQ6kR0uiicW6uCg73T2P34C
         t4cQv6SF2ypbwOLOhYOG5Usv9iz2JxgSenhjqvZpYO4QY20GYeYsNZ050+VJ5JUJdKmu
         vPK+Gamng/s+0MX61CWAteIKUo9jeTnp6pZ1aLqxtBhQwJYH69NRc8lquh0Es+Ck7Haf
         h1HAHBMx/ksc5Lxq9V6abY6kXlNpJ4nU6Ne0Yxy/Vh4uG79ULl4M8w/V8Dk1d67XgjKU
         YMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955919; x=1791560719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ya9RfmxJPM2JLLUcoTWuhNhFBf+WLZtJ0RXJ7Ml9FIQ=;
        b=jOjA5bCj+ZevQaGcMrXiUKrYsj51nmyPGB8BlHGRzHCzN9/vBUi+oCPKQpPYk1/DvI
         bm3ia98XILbVq1BXioDbUzyhaZswMUG1UD59DBMkjQ/qa3OLC15iQsDFnnLOQ93OhM5C
         VCveWQZo4qshW73dEiu3sOQNnfbCuobIce0BtM8fZvOWTvMJv2N2tos3JEvlTZ9tFjf4
         5mq0FTdFmvDAzYoKyjb/p92mZ6567KnQFJnqpV95W1WoPnqsRBxjOSy57af5ltTvGlJg
         +/IipTu6eqq9+deyM4xtzHktClgqvMjUej5s9u04IkjS6wmNMjtYwT38RXmHqogefgUV
         dRaw==
X-Forwarded-Encrypted: i=1; AKwUvBycvYdkVmwA60AAhcPU3O8s5fGr7+CGJv03pWMfvpnSDDkxGT03fGSo5yLmIya+8+PZq/aVjkH7aQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nn7ledDIgGLyszMMi50VG+BouXyKPBI2xVyZ7mrSZkF9v5l4wq
	JeZ0spuSnneeW3mC30ZrvnZzexSqAQ8ESv/7vkMekuRtSqpFkOKj+ntGHmlonOWWuG19EGGXwmk
	QX5zI
X-Gm-Gg: AYBFou1/iBtt9/16YFzh2v3Y1wKTjXwRMvOHMbQUExTBsp6r1sls3UcNe1F4HxBT1Jw
	AIx5VGzeeZn9iGQdHcIHD/Ojmuv5YPr9TH9bHW5qcs84pHCcVfE3y1srTJKka7TtqcXGW5Gi/PJ
	kZ2ADn71MY5X1oGV97BtTjz0MZwL/EXFnIcWWcRNsuX35BuXQJnEdFKNy2soNo80udsDjPR0pdw
	kxbGjM3xuhst1x+7T2z384A/azRCj9/A8fn93jM/A8PY8nm3kvDPKLYf1ns0C1N2XwnUhk78D6N
	G8FJRGl4aD5iLYb2hwQCbVQ2DeixqBBEQaZOpJoVful2QOa7S7YdfeE5idH4OQTRuk1rDlxPT0f
	a96IBAPZoRuJaDEX2csxUX/M/pDK2OaEKWGHtKKkmt2UegjZYHPC+RvTHI5O+exYSuF7nRNbrwR
	3Yamf0KTdJLfkNdM7Ol9iFE/palvroyndwJ0E6jSOVcb3xiYYPEvTsrV1aV/lm1Cc0hO+d/3EXx
	Tzw3+R1MO0ukkWl
X-Received: by 2002:a05:600c:c08a:b0:4a0:208e:2393 with SMTP id 5b1f17b1804b1-4a0276d9c16mr48912255e9.24.1790955919350;
        Fri, 02 Oct 2026 08:45:19 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
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
Subject: [PATCH 11/18 v2] sched/fair: Support not wakeup case in select_idle_sibling
Date: Fri,  2 Oct 2026 17:44:08 +0200
Message-ID: <20261002154415.2270586-12-vincent.guittot@linaro.org>
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

With push callback mecanism, select_task_rq_fair can be called for a task
that is already enqueued. Task into account this case when choosing idle
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ed3e5bb7fd6..38eb80dbd1a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7974,10 +7974,13 @@ static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
 	return sched_idle_rq(rq) && !task_has_idle_policy(p);
 }
 
+static int idle_cpu_without(int cpu, struct task_struct *p);
+
 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
 	return available_idle_cpu(cpu) ||
-	       choose_sched_idle_rq(cpu_rq(cpu), p);
+	       choose_sched_idle_rq(cpu_rq(cpu), p) ||
+	       idle_cpu_without(cpu, p);
 }
 
 static void
-- 
2.53.0

