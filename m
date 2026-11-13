Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559632;
	b=yiqeoYR+hQ0Y0IASLqhejphNm07neZ5IRStTGcVQBw9pJCaxTy0pq/+qjEHH1zPANoB5
	 Lkp9GJDAAK2BYP6q2X2SdkWP9LXCXpmCAmty2Eb9udMNGxfWF+MXancHq8oJ2IZHBder6
	 bsKhu+UeDBzaT8SlA1UOoVW80Vr5yLn7dtOq4YNsJXQYGhOaKt76slEhV+uoxXTgasJjK
	 1sUTGWVc2vdajpuGvar0ksJc7WyVZ8eJDROAq46btVHEPMlHywDm0jnOH82r4b2h37ecQ
	 5MEWSUIqZFGxKwLEW7XSgkDtQx8iTblTnZT1lQy/0WA/D30tiYuQyx646fd0OfJytNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559632;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Subject:To:Cc:References:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7IK0olkrbLVYnqLKQcOR+p0F4uBvZyrDMfmTykxx+8g=;
	b=yK3RUwmA+038BFfN/RmtVEzT/aB9aYIV9Qo8RAs2JEB0kwhZtgz5ncldje1nR2c07n7Y
	 srJDXvHCIhUlqemLAIOGkdKP9+7dyM9z4xN7NHNoeOP52xVWL5tttejuRERKyTXDkH+LQ
	 6U1TvWqZW7JVan2Polsfst08bzUECML4ZxMmtghwkw8A8XminxoS+5ozeEmGNc2iXgbtP
	 q1RCL507l7iOB+ETD6+SZbCRZHBQRMS1b3v83S4iSa2XKYnI6/SsR6Suaw09wCqwdclI0
	 o+Ylp1t0RrKLSPr+qubKCrWgr5zkxN+79QMWht4a+AWlaoLeHRB6LOabR3NGnt0WbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB2606A33B;
	Fri, 13 Nov 2026 08:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FB2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08146114|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0105523-0.00030552-0.989142;FP=13248491661041634554|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=likunyu@open-hieco.net;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.k1B5v3a_1794559620;
Received: from 172.18.25.145(mailfrom:likunyu@open-hieco.net fp:SMTPD_---.k1B5v3a_1794559620 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 16:47:01 +0800
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
 sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
From: Li kunyu <likunyu@open-hieco.net>
Message-ID: <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
Date: Fri, 13 Nov 2026 16:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106151947.3991524-9-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 2026/11/6 23:19, Vincent Guittot wrote:
> /*
>   * select_task_rq_fair: Select a target runqueue for the task.
>   * There are 2 ways to select the target runqueue:
> @@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>  	cfs_rq->curr = NULL;
>  	if (se->on_rq)
>  		__enqueue_entity(cfs_rq, se);
> +
> +	if (next) {
> +		/*
> +		 * The previous task might be eligible for being pushed on another cpu
> +		 * if it is still active.
> +		 */
> +		if (next != prev)
> +			fair_add_pushable_prev(rq, prev, next);
> +
> +		if (next->sched_class != &fair_sched_class)
> +			fair_queue_push_tasks(rq);
> +	}

Regarding if (next->sched_class != &fair_sched_class) - would it be more
semantically correct to change it to if (sched_class_above(next->sched_class,
&fair_sched_class))? The current code migrates all CFS tasks on the current rq
whenever the next task is not of the fair class; I think it would be more
appropriate to do this only when the next task has a higher scheduling priority.

I'm not sure whether my understanding is correct.

-- 
thanks,
kunyu
