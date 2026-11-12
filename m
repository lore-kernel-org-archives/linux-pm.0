Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476962;
	b=xHXsXyTfz5RnUWe0y9zC1HyetAYcNrfVdsv4FICIfoP4i76tSGA0HbzZRc0XtJOJBegk
	 CoHMBoAywk4puqeKSEhVNeuK3j7nx/i5MQpHW+/KEhfNONlZpnFTjogOCcgHM3JTtypu6
	 S5VGVFNvH6RRtMc17iM/aWSZL3gyQjdWkQB93joIquaefTHu8KFMEx0Edt6smRmDKp7Di
	 Uu05iYaFzpgUO0gb2chHUWoFA6qGLlsO3gIJGqZFsg3uUQqxJ8OvYfMWEJVbPxGDgxy5I
	 rIp9Nxo1vEbgO3YAkTrdrQ+VwHSG8HM3BxAaOOdPspom7D/lQJFY/N3JjGbplHRO4TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476962;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zD0jJHrRRvAkjkRc1n4QCTiR4ZH0I6f9OpoiYG7kF2I=;
	b=gGSlR8C4YUjCEakJh2Wi6doyaWWQ7w8pDI6dKuOQSbfQgXeuFhpm9ShmcoxoUEVadyHf
	 OFqaYqfZKu0Im7hQ8PLcLPyb3aASRLgciPuaVgfa0VwhGHYBXEaktK+0OmDnGloD5XD8F
	 88/hZfE0mUiPUTFG+V/5VxGzGRaGkM2QGhUvIdNF50LTlwcH8P7Atd5JQh8IGWgc1XHBB
	 ocMG4twUk4Kq3f70QdeHk8OlYotNffEpNp+UG+vBc9Y1BrSkW1mB+HRqLu9mXtSXlpnvz
	 8d/PUQF/ViSmVm9R5SM0SXifBbyb8BNhRmsl+yIoMQYsH8H1t28VlxIJr9kgBL9c1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OiO0xzly;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCA606A31C;
	Thu, 12 Nov 2026 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BCA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OiO0xzly
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zD0jJHrRRvAkjkRc1n4QCTiR4ZH0I6f9OpoiYG7kF2I=; b=OiO0xzlygaCWZXBcbOoGbnjGS4
	I3ogB51oqj35kLDCI4g9Tm8lX175JhQspX3OZVzfhHfwM+f01tpu7GWZm6lhsdlNsWaA3DhBb6Jks
	wGqWAxBcxkHoFCGtpTulgZibXc7pY32E++XnxkYqdTPLfmEY32WH8LIvyhSCNoEyrcEGMf45bDyx+
	rfc/xVbkVIVUKNjcYaApiC0pvsUgsV5PQvX3R+DEIwbXT4x/lO7Y5YUV4Y+B0jzvJyU0eglAFG5xf
	KrNdQdqzqzsrRpARn8cusO1zCsh/10h65g9J3uv/Eu3UeqhNTIQNlnnp+0JSKP2ujIEoBBdXm6rxS
	o6HSPr2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRQe-0000000A9Wg-1yOf;
	Thu, 12 Nov 2026 09:49:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF3A2300400; Thu, 12 Nov 2026 10:49:10 +0100 (CET)
Date: Thu, 12 Nov 2026 10:49:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
Message-ID: <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
 <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>

On Thu, Nov 12, 2026 at 08:01:17AM +0100, Vincent Guittot wrote:

> I don't want to take any random task from the rq but only one that is
> meaningful. Why do you think having a dedicated pushable list like rt
> and deadline isn't worthwhile?

Well, effectively cfs_tasks *is* the pushable list. The below patch
makes no effective difference, and can be argued to be an optimization.
Currently every consumer of cfs_tasks goes through can_migrate_task()
and every task that has nr_cpus_allowed == 1, will fail that function.

The thing seems to be that you want additional constraints on your list;
like dropping tasks after one push attempt. The other classes don't do
that, they do the same thing cfs_tasks does and keep all runnable tasks
that can migrate on the list.

I'm not against adding another list per-se, I'm just struggling to
understand your extra semantics, because its not _just_ another pushable
list, it has some extra flavour.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0552eaf64e95..8c81d236b24d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4693,7 +4693,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 		account_numa_enqueue(rq, p);
 		account_llc_enqueue(rq, p);
-		list_add(&se->group_node, &rq->cfs_tasks);
+		if (p->nr_cpus_allowed > 1)
+			list_add(&se->group_node, &rq->cfs_tasks);
 	}
 	cfs_rq->nr_queued++;
 }
@@ -4709,7 +4710,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 		account_numa_dequeue(rq, p);
 		account_llc_dequeue(rq, p);
-		list_del_init(&se->group_node);
+		if (p->nr_cpus_allowed > 1)
+			list_del_init(&se->group_node);
 	}
 	cfs_rq->nr_queued--;
 }
@@ -15620,7 +15622,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 			set_protect_slice(cfs_rq, se);
 	}
 
-	if (task_on_rq_queued(p)) {
+	if (task_on_rq_queued(p) && p->nr_cpus_allowed > 1) {
 		/*
 		 * Move the next running task to the front of the list, so our
 		 * cfs_tasks list becomes MRU one.

