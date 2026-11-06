Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978412;
	b=dw8yrRwd4LxS9MYPmQ/8GWTeiZKAfLR/vgJobUIgkepncJiZ1DLmEfTU4g2hgiel50Qy
	 +UQy4GUkQk1R6tdpW8NuHGLRgm6MJFx3SjlWRoQetHGqLi2somRBfmRSl9jTGA1xhfua6
	 jZOvkQH2HxiG8qtT6ubXHNNwbaFe0lvLQwehjlofNeR/sjt3KjJeY/cEP6/rKkSQyR1Mb
	 Q0tBSaYHqZD416lfVDD+YahcqGJZmrFG9X7NMkNxYmo5d/2pXZV7cpMT56c4nl1SZJqVB
	 61HNtqVe+1LUZB7qfPiDPzZFGdrF1YuW1VzvWEJaQd4KCKpgBbP05SnnxAXbq0O37wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
	b=RhXkT6R+2e6Aj6K41OIpz+l4SjxNfD69m5gto/lBcgzz5NMjfe6cB+kc6QWBHqszSJ8u
	 5rjhT3nty60Z1HFO77XZbnLywFyaX4LT/mt5z3sG/z6J21WsuREHrQApTELEwMQz85BHj
	 8XgWIx2hiCkHgXXerTh++23IxktmtT9oz/PqUQjsD1mnl9kfK1/gbmWFAPJ7fVC6ntBTf
	 qWeRO7QPwy9eDT1NtyWN9zinRJzEgpxDWGXQsbB8dQ1diOmR7BA1XS3Jdi4t/6A+s+vdX
	 zILJUB1hg+a8dMTiRSHK8GcIsG/yd4FvaBYAhRImAhQN1wmcxq+NYel/UoF42gYVodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Z/HokBF6";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EF606D831
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8EF606D831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z/HokBF6
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e09aa5264so428625f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978411; x=1794583211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
        b=Z/HokBF63OcT8/uXjKE8jxK7kF2n+GTlB36g0rRefvhUZxeD4Hz+edO1yIeA0L82ZA
         mwNsQjg6kOvF7LhtMNhVyd3nmixN8KuFHgXEmy+u/Wdf29PQbZykiIVzW+6CGF8vLAjx
         +XBQAVOUW2DaxHg2YWndY4g1bMKWT0czu1ioPHRWGXzbvaKH6qSjTAAJKlnYSFsXFISk
         R6Wxq9tmBTMxfXK2hqypRxcFgj1EsV/4m8FgQc41UAK4wdPNjdnfS+LACWtxlMVstDrT
         Nh9kv0IudI3kDpKHR0lQuE1U6vyYLsIZMvx9VmQGKjT3mAc2JeqpM+JeMCdgu/PZgHxw
         uKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978411; x=1794583211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gkJwtkA4b9iHfeNLX2Rr658084iNaApVrGzPIHFhBr8=;
        b=S7r9ZeXb4abYQdGzm9a2OZvPXz+sjAECWvu8GktE9mz973ToEIfttGL4vjQ+RqHCPO
         bhAJ3YB7uuuMXTvBHF4Ygx+m72da+UFt4K7gGEi3beRMNHFmrs1oiJYnqwKXoO8eHqXs
         lUGKyA2ld5qwCsuvhKVR0h2DSEPYV+0r7PcvL5b90OPWZu23EaKBDRKlLQ2mCXikNVKQ
         Rje/iTh5mZ61yZmMb9ltrueEWxJQOC6xtLS8N/Sek5jZxUTWaUDzQVpsio2hkhI3E6LH
         h26DJEvS3HobqAaHFcObklkb4Z6CItR4ucwEN4szqczrbQCaiIYOSSsSNbhQgkwNE/Gj
         xmZg==
X-Forwarded-Encrypted: i=1; AL+hErFIJEn4PO+Al0C2jxyOd5genXCdH/Md6yuScT3+2q8WB6mMOV2NmH7P3wXorVBYEwHf7i+T77Azkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2rzak8gk0/yw5G/05WHfdP6RwAGobq7xGQ3FVJjO44+NyzGyB
	TzE/hnUQ+GRR2FNX215odaEzautd7bfZZxWW1zpsZ4GThQNhYcU4J6wFxyCWWQQAtyc=
X-Gm-Gg: AYBFou3r+2VGeZzlUD4BMVscIyDywW0LE3eG2X6544wPXncwFdq+ZSjbpXJqod1tyNq
	TM7v2sQv0B8xZ11Ahn56wSB9TnsNkJNTpkpKfzPR3UgLJVgCMucU2mqRJGuB3XsAaKj9vJKXW6T
	JXxNhaMzEjH6vrZyOVCvYRvl2uT/ggrdYjmjEuuMK3uCwVyzjkI8cjjGYzeFOoK+CjBEGrxAvZe
	iNi7K8+d3bPGnigtrcEgL+XvO7uQMQMkrjPleMxsTUm1V3koNnMtwxNQAp9OUFEVaFart3QvNsz
	H/63+7lB3tbPpDgLlfAH9rJTQXw46ganwaqMJHLEkhs+ZsYiyW6qxY31e+nKpC/pXxhD8VunvmQ
	ZmILaJsXaFvtEgKpZ+AiYqFuVf5aLOB2MAcKOuK+6sv2TrjKMbjxLfwH7eGPSgHunLmswr8+QR3
	W1Olav9c5WuzII0c9uLpZLcrhKlCdZ02buUzjlTt2o1ySI6QgYS568gLDcp9LfOu8VTd4XYnRfO
	ljZ4nuN7IwmFgreUNBYDKU0ycWu6v0hoFNyXE6esZYL1c3Yg6zIutNUqEAJ12rTTjNFx2BiWqYP
	0iZ3l1ILG6wiNEvt1sdtnc6zkLGnbCoFI6TM/JwKFUWZ3xw=
X-Received: by 2002:a5d:5f48:0:b0:492:f6b7:f488 with SMTP id ffacd0b85a97d-492f6b7f755mr4873277f8f.7.1793978410645;
        Fri, 06 Nov 2026 07:20:10 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:10 -0800 (PST)
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
Subject: [PATCH 11/20 v3] sched/fair: Add force push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:38 +0100
Message-ID: <20261106151947.3991524-12-vincent.guittot@linaro.org>
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

When the task is alone on the CPU, it's never put back in the enqueued
list; In this special case, we use the tick to run the check used to push
runnable task on a better CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bcb663ebcde..f2a0d2c2bb63 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10233,6 +10233,75 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
 		__fair_add_pushable_task(rq, prev);
 }
 
+static int active_load_balance_cpu_stop(void *data);
+
+/*
+ * See if the alone task running on the CPU should migrate on a better than
+ * the local one.
+ */
+static inline bool tick_push_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
+	__releases(__rq_lockp(rq))
+	__acquires(__rq_lockp(rq))
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_push_task_enabled())
+		return false;
+
+	if (!rf)
+		return false;
+
+	if (WARN_ON(!p))
+		return false;
+
+	if (WARN_ON(!task_current_donor(rq, p)))
+		return false;
+
+	if (is_migration_disabled(p))
+		return false;
+
+	/* If there are several task, wait for being put back */
+	if (rq->nr_running > 1)
+		return false;
+
+	if (!fair_check_pushable_task(rq, p, NULL))
+		return false;
+
+	if (!raw_spin_trylock(&p->pi_lock))
+		return false;
+
+	new_cpu = select_task_rq_fair(p, cpu, 0);
+
+	raw_spin_unlock(&p->pi_lock);
+
+	if (new_cpu == cpu)
+		return false;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else {
+		return false;
+	}
+
+	preempt_disable();
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+	stop_one_cpu_nowait(cpu,
+			    active_load_balance_cpu_stop, rq,
+			    &rq->active_balance_work);
+	preempt_enable();
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+
+	return true;
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -15713,8 +15782,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_fl
 
 	task_tick_cache(rq, curr);
 
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!tick_push_task(curr, rq, rf)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.53.0

