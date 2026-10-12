Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BE47143B;
	Mon, 12 Oct 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814050; cv=none; b=iMEco6IlGYd2vo8CI8VpYDh+6tjiUBWZftf6NdV6UJLPBZv2sm5nNxsr0ZIYOE0OZ34VLzlaQOpOXiO9kJUWN9H9O3QE0VpIsdceeir7ffkG/+fhqYNiaLvGYoEVKAbboMejbvRM2i9hEOIiUY5hyDhOEWyeHO+RBrm7xdJ4+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814050; c=relaxed/simple;
	bh=IOsm0a+mLy0LCidkdXj7UvnPgFNUeOkicKRaAc59L+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xfoo4qltycdX9Rl4/uudGsHcZSs4mo71XpWO4Vze70/b+Xa9MVM/AVA/AuojprnPsdSS3t0qgEkTrmz06NErKtmEk38NrbZD89mEunmaS0PYAl/e5GYCYU5wVjcsSH61/UdShvztll+/UEH9KP4w1CXtwN6Kn/dM1yYPoWSpSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jhdh5bqp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jhdh5bqp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEFfQ3209708;
	Mon, 12 Oct 2026 14:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qeA59R
	IsoXY8Nl/lTPQrbb7DOeUe2FMJ5fUyWua3TpU=; b=Jhdh5bqpULQ+Za5fjIYbt9
	Zvw/M8kJBWFT1ILh2De34ESxTbveBYXgRyLni+YXvwyLaNplXKYLyQ7zvb0MiWuS
	MrfScu12aS6DTk8uPYz8l74CQrnAzAf99knPMJkGlbLcmrgeXZtaJoF+1K7zd0qQ
	nZ2FNVrAwbz/tcxrp74sU4pqSRDdeJUPFJVnTN/jPnVFTnYhbCHAOc2U6S1DD/fm
	VYdR+jCEhSa7gUAV3v6659AMnUiOc+/a8p1fnypvvBUSVcALEUXVtENtUjwhuJAC
	PdqHaGV0i/0Gzv4t7fQEj88US0xfZ1HlzJs9POrKG1Jpi+pisJPeDLh0Xm+63ehQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv08xjn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:06:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4tZR1212027;
	Mon, 12 Oct 2026 14:06:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnfk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:06:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CE6uw841484666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:06:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0427A20040;
	Mon, 12 Oct 2026 14:06:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4130E20043;
	Mon, 12 Oct 2026 14:06:51 +0000 (GMT)
Received: from [9.124.214.197] (unknown [9.124.214.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:06:51 +0000 (GMT)
Message-ID: <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
Date: Mon, 12 Oct 2026 19:36:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com,
        arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261002154415.2270586-8-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX4p+WsUFUAH0H
 dCRl9htz6V++UPeJI2iws/QzfKo6ilzYJJ8+mdjvloDKXM8XGGzSMRXW7pW2VhmumqC+DSHuh0s
 HwEkeKlirUOKapQwwc5sqKEgPe3xyJyOgbIH8gxgJ634WgfWJTdPnePaQxrR0hTQta/VdiJ9bF4
 ugp0KthXDcrC7zwrU89PvkuoKjXV50WFDNC8DDiYOWywmbherl/d8U4cHMW5Olj8eDmD8APvll+
 L2vV3cRjlBr9aunmeXl+WcEnpO5MwDgJfXO8npk+xW24v4XoitGqzdq5gP9Nm/wcfU96MOJp3Eq
 W0pVZcl7hh5ozcE2VA0UYcbRtWr6eYNMd/VNA0NWBOsLrKTf6GxUBc9HKX1GBK/levMoedvXlLm
 0FUCRixq0p6E6rdRob2mMTSgooCBRfu/pQ/76V250IyRtBbiVlz+lNBwQkzWNgAvChFgjoFtOfy
 o2xFjv/b9WT/y+FO7Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfXxNXr7Cp9pqfr
 lKr869FxfCcMwsHjdsjhHQ829T/Dfz8FwzOsG82pC5h9C6GZqaftDS6YEmBqrXfzPK/FkJra84q
 aDQpgr2VkgY2ybHCNE60nXBawWe4RWQ=
X-Proofpoint-ORIG-GUID: ZMLqM1gFd0IG0N0c9dSWWIUCfWed7K-8
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acce983 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=gqQX_c8xQYifrDOYiekA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nAiyoH0XI1M5C1XsWKxNvGf400sQ1cvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120054

Hi Vincent,

Disclaimer:
I haven't read the full series yet. I will try to do. Sorry in case i read
it wrong.
Thought of quickly checking the push path since i had recently worked on it.

On 10/2/26 9:14 PM, Vincent Guittot wrote:
> EAS is based on wakeup events to efficiently place tasks on the system, but
> there are cases where a task doesn't have wakeup events anymore or at a far
> too low pace. For such situation, we can take advantage of the task being
> put back in the enqueued list to check if it should be pushed on another
> CPU.
> 
> Add a push task mechanism that enables fair scheduler to push runnable
> tasks. EAS will be one user but other feature like filling idle CPUs or
> short slice tasks can also take advantage of it.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/core.c  |   4 +-
>   kernel/sched/fair.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h |   7 ++
>   3 files changed, 172 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 837dc74c9a8d..18692b752814 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>    *
>    * Returns (locked) new rq. Old rq's lock is released.
>    */
> -static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> -				   struct task_struct *p, int new_cpu)
> +struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> +			    struct task_struct *p, int new_cpu)
>   	__must_hold(__rq_lockp(rq))
>   {
>   	lockdep_assert_rq_held(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f12678850ce2..00078ac7fada 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8179,6 +8179,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
>   	}
>   }
>   
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
> +
>   /*
>    * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
>    *
> @@ -8195,6 +8197,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>   	bool task_delayed = flags & DEQUEUE_DELAYED;
>   
>   	clear_buddies(cfs_rq, se);
> +	fair_remove_pushable_task(rq, p);
>   
>   	update_curr_eevdf(cfs_rq);
>   	update_entity_lag(cfs_rq, se);
> @@ -9799,6 +9802,157 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   	return target;
>   }
>   
> +DEFINE_STATIC_KEY_FALSE(sched_push_task);
> +
> +static inline bool sched_push_task_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_push_task);
> +}
> +
> +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (!task_on_rq_queued(p))
> +		return false;
> +
> +	if (p->se.sched_delayed)
> +		return false;
> +
> +	if (p->nr_cpus_allowed <= 1)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> +{
> +	if (!__check_pushable_fair_task(rq, p))
> +		return false;
> +
> +	return false;
> +}
> +
> +static inline int has_pushable_tasks(struct rq *rq)
> +{
> +	return !plist_head_empty(&rq->cfs.pushable_tasks);
> +}
> +

Should this use static key?

> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->cfs.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +
> +	/*
> +	 * Remove task from the pushable list as we try only once after that
> +	 * the task has been put back in enqueued list.
> +	 */
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +
> +	return p;
> +}
> +
> +static int
> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> +
> +/*
> + * See if the non running fair tasks on this rq can be sent on other CPUs
> + * that fits better with their profile.
> + */
> +static bool fair_push_task(struct rq *rq)
> +{
> +	struct task_struct *next_task;
> +	int prev_cpu, new_cpu;
> +	struct rq_flags rf;
> +	struct rq *cur_rq;

You likely need below to keep clang's context tracking to be happy.

	context_unsafe_alias(rq);

> +
> +	next_task = pick_next_pushable_fair_task(rq);
> +	if (!next_task)
> +		return false;
> +
> +	if (is_migration_disabled(next_task))
> +		return true;

If migration is disabled, then it shouldn't endup on pushable_tasks?

> +
> +	/* We might release rq lock */
> +	get_task_struct(next_task);
> +
> +	prev_cpu = rq->cpu;
> +
> +	/*
> +	 * We need to release rq lock and take both task and rq w/o
> +	 * triggering a deadlock.
> +	 */
> +	raw_spin_rq_unlock(rq);
> +
> +	cur_rq = task_rq_lock(next_task, &rf);
> +
> +	/* Task already migrated */
> +	if (cur_rq->cpu != prev_cpu)
> +		goto skip_push;
> +
> +	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
> +
> +	/* Task doesn't need to migrate */
> +	if (new_cpu == prev_cpu)
> +		goto skip_push;
> +
> +	update_rq_clock(cur_rq);
> +	cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
> +
> +skip_push:
> +	task_rq_unlock(cur_rq, next_task, &rf);
> +
> +	/* Restore rq state */
> +	raw_spin_rq_lock(rq);
> +	put_task_struct(next_task);
> +
> +	return true;
> +}
> +
> +static void fair_push_tasks(struct rq *rq)
> +{
> +	/* fair_push_task() will return true if it moved a fair task */
> +	while (fair_push_task(rq))
> +		;
> +}

Would it better to iterate through the list? This is bit difficult
to read at first.

In failure cases also, it can return true. No? for example,
is_migration_disabled(), It is needed since you need to iterate the
rq to see if there is a task to move.

> +
> +static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
> +
> +static inline void fair_queue_push_tasks(struct rq *rq)
> +{
> +	if (!sched_push_task_enabled() || !has_pushable_tasks(rq))
> +		return;
> +
> +	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), fair_push_tasks);
> +}
> +
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (sched_push_task_enabled())
> +		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +	plist_node_init(&p->pushable_tasks, p->prio);
> +	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
> +{
> +	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> +		__fair_add_pushable_task(rq, prev);
> +}
> +
>   /*
>    * select_task_rq_fair: Select a target runqueue for the task.
>    * There are 2 ways to select the target runqueue:
> @@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>   	cfs_rq->curr = NULL;
>   	if (se->on_rq)
>   		__enqueue_entity(cfs_rq, se);
> +
> +	/*
> +	 * The previous task might be eligible for being pushed on another cpu
> +	 * if it is still active.
> +	 */
> +	fair_add_pushable_prev(rq, prev, next);
>   }
>   
>   /*
> @@ -15379,6 +15539,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
>   		goto repick;
>   
>   	clear_buddies(cfs_rq, se);
> +	fair_remove_pushable_task(rq, p);
>   
>   	if (on_rq)
>   		__dequeue_entity(cfs_rq, se);
> @@ -15423,6 +15584,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
>   
>   	update_misfit_status(p, rq);
>   	sched_fair_update_stop_tick(rq, p);
> +	fair_queue_push_tasks(rq);
>   
>   repick:
>   	/*
> @@ -15439,6 +15601,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>   {
>   	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
>   	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
> +	plist_head_init(&cfs_rq->pushable_tasks);
>   	raw_spin_lock_init(&cfs_rq->removed.lock);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e025d2a6c302..74130bd2a2c8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -721,6 +721,8 @@ struct cfs_rq {
>   		unsigned long	runnable_avg;
>   	} removed;
>   
> +	struct plist_head	pushable_tasks;
> +
>   #ifdef CONFIG_FAIR_GROUP_SCHED
>   	u64			last_update_tg_load_avg;
>   	unsigned long		tg_load_avg_contrib;
> @@ -3877,6 +3879,8 @@ static inline bool sched_energy_enabled(void) { return false; }
>   
>   #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
>   
> +DECLARE_STATIC_KEY_FALSE(sched_push_task);
> +
>   #ifdef CONFIG_MEMBARRIER
>   
>   /*
> @@ -4209,6 +4213,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
>   	wakeup_preempt(dst_rq, task, 0);
>   }
>   
> +extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> +				   struct task_struct *p, int new_cpu);
> +
>   static inline
>   bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
>   {

