Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561961;
	b=fPk1ljbEyb1n4kG0vfv4DH1RpfrG5mWZmqjxwek04q/8VGVgJZGTPs6sdJy55rp66JyM
	 D0Qre/OwFHowTVfjUgZYc1wQu01R9L3mu01Mt4Bsoy2mkuPC+zDOatSmuvLe1Rz5ydPZz
	 oc6CKq7xmHIYMtvk4FgcJrIvhom3oQ6/zzGfSBuL0UBDbjuNi8Z7ufiYJjCzXlNzykqBV
	 D8+Q0tIfiuw7/vrwQfxEGb8lmVm4NtT9HboFozN2tAfiFzhf9tRbEXzYd8LRBDsNAJFF3
	 uL6+ymBPMNFQCr70Fjht8EOvIEv6Qp2rjvf6FMoA/QsAWnSV8tVpzjl8RfsTa0hFBlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561961;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Subject:To:Cc:References:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cmlk37tKcDHGEQEkS96XUk1sqWPWdpBp23HETVNGO2M=;
	b=EW2BdAudA2luI7aBPs+TA0dQ92lTtvtjND9Bwy6dHdcTe1omoFvFgW98vtPBz0jA2bpA
	 X4ClzIdkwndybuXtBQ5dSePRxcS4HzsItoKmpYKlnfmij0JCW8wboGNmelSXIKrTUMGjh
	 qzaTFLlJGY5T0Brisc2VczCY65eQ89jfBvR3yotP0Py/gVAgekeiS2/ZZYAw+Cg9GEuc2
	 GRzgmgcmn28wFR0v81hZ6rT+FT1312k2Q9OCYG2sF/V8TLO0hIOdVVAm4wiTfChQ3cg8v
	 gZH+r9gFMjg+Lx2X//EQZdHIDIH8otp54qf8D8819ASHgOqTD1S+nmwcB0usGg3GTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF29606A327;
	Fri, 13 Nov 2026 09:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF29606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07733507|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.644173-0.00282016-0.353007;FP=3946660559307230458|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=likunyu@open-hieco.net;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.k1AyX04_1794561952;
Received: from 172.18.25.145(mailfrom:likunyu@open-hieco.net fp:SMTPD_---.k1AyX04_1794561952 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 17:25:54 +0800
Subject: Re: [PATCH 13/20] sched/eevdf: Try to push short slice task on a
 better CPU
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
 <20261106151947.3991524-14-vincent.guittot@linaro.org>
From: Li kunyu <likunyu@open-hieco.net>
Message-ID: <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
Date: Fri, 13 Nov 2026 17:25:51 +0800
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
In-Reply-To: <20261106151947.3991524-14-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 2026/11/6 23:19, Vincent Guittot wrote:
>  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
>  {
>  	if (!__check_pushable_fair_task(rq, p))
> @@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
>  	if (next == p)
>  		return false;
>  
> +	if (next && next->sched_class != p->sched_class)
> +		return true;

Would it be more appropriate to use sched_class_above(next->sched_class,
&fair_sched_class) here? I think placing prev on rq->cfs.pushable_tasks is
justified only​ when next belongs to a scheduling class strictly higher than fair.

I also wonder whether doing this in the normal CFS hot paths -
put_prev_task_fair(), set_next_task_fair() is really desirable. PATCH 09/20
already replaces the unconditional raw_spin_rq_unlock() + task_rq_lock()
sequence with a raw_spin_trylock(&next_task->pi_lock) that skips the push when
the task is already locked, which I agree is an improvement.
But could the push decision itself be moved into the load balancing path
instead? That would keep the hot paths free of migration-related locking and
select_task_rq_fair() calls. Or is the next-aware context (knowing which task is
preempting) something the load balancer cannot reconstruct, making the current
placement necessary?

Is my understanding correct?

https://lore.kernel.org/all/20261020083746.37068-2-likunyu@open-hieco.net/

The SMT push work in this patch is intentionally quite simple; I think
it could be generalized with only modest changes to perform push at
larger scheduling-domain scopes, such as the LLC (last-level cache)
domain.

I realize the push direction is somewhat at odds with the current
cache-aware scheduling work, which instead tries to make cross-LLC
migration less attractive. Still, I'd be interested to hear whether you
see any value in a push-based approach at the LLC level, or if there
are related plans I should be aware of.

-- 
thanks,
kunyu
