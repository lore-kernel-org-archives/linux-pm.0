Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79724B2044
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215902; cv=none; b=KTWRnGoHohTBib6YI3r+VwxHZlKQ0eIx2E3Ie5T1/HOl2IAIckxeQUx3ZO8KQX/hF39EheJhKHFE3FM4H4tjB6D8TQ/razeal4nwtoimJEmi70OGyJeFsAnsiTS+Qjn9T3+dqddEmYCmZZue2RWUUWBJQr0sx7V6oj+lnUAnlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215902; c=relaxed/simple;
	bh=NREAtkckTJS7Rgm5WxX0oAn2XgDJTjfslmcI/YdSoG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFtlvWnxnJMYCtf1fju15IiVoRhvN+p0t7zZQjGbhVMkcd2Cp6wsCFBTT4tYh/XEKleHS4BpFyrZWv4X164TdggSwRujIw/Wh+wIpMEZ5eBBPsht/btcKa1n3CXJghbjrszOyjRmE3KItXFHkoPW7Z4fqZp5v1XYTlAX11yfHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+KLJbLS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+KLJbLS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so891175e9.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791215898; x=1791820698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHGq165bL6ZkwlwLwwziFcNqAcI7e1VaujqMV2T4VM8=;
        b=r+KLJbLSmKagbw5fS6kftdbby7C4IKtVO+L58OTUPAtoCwwbu7u5TvaCn9u7+8salQ
         DdtdH6ou6VVsLKTMjI9Xmqvl8rY1MTIgYSk0jyyl8LXbXDD4OuZh1xFAhA3mdm/hUluh
         5CJbX6eYkCBvihY+g6GSjZrPOBBowz7ykxqO6++qAzTosxw3vzHkuagCZM4w+a2cmce1
         HEOxKkVi/+kcq+GCwVHqw6qnPL3hRnBT0R004Lw/Uq2gXOYacNUbh2eez+KaX8Awuy0B
         TBU/52o52CmbzriRpS8SdGBuAcFMqPRFto+uHOXvdsrlKQA3kSasHElRRsV4S0KdZgYk
         QDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215898; x=1791820698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oHGq165bL6ZkwlwLwwziFcNqAcI7e1VaujqMV2T4VM8=;
        b=VSrlh10JYk4qPyP4HyQpRMdN3rZ7IqK4IwjE9WgO1Zztg0f1cBEO8VkyFcZ2yhuxOM
         yB0DBatEZsaTAjfJLW4K/ct7KgEEl9Jrmg8fx1213Q8m1B+rZZDESADLVlcV6f4HBK7k
         dUy23CV310oeosuVewAm0/lm6HMWmW6PcSZ2Gp3gcXb211nf7w+1PtG62nsFbVXTRo3E
         DHrumZxY5evStx7AIiNgshmAzp1IEonc8ucs3ZfNqh0wbLHZKLjyKPgih6dx8xVg/acL
         Xp7iYYV7WKyfrFGLo9nuqc+2NVrquB5S8H+n9TU5ln8K6b1+ha9RPpMRBNsmy6ZSLhpZ
         1DFA==
X-Forwarded-Encrypted: i=1; AKwUvBw22m6Ovo5SCoe90KosXM0oFV7I5pHG4869/6a5zzs3GI0fwP2gn3f7RrsQWkCJ0uu0j+c0a7zKpw==@vger.kernel.org
X-Gm-Message-State: AFuF++mENneWjGyg6/sBcfPT0tFN1faVr5ZNhPr8HFKI92BqfY3r9QXe
	0I4oS7AQKr34yVL0qlrpp/kyJhcym3X0oQkjcY9Aztyop4vDJpZO8RJG
X-Gm-Gg: AYBFou1iT+cl/iEsAebByCxXsmWDO7YjOhglZd9CPmHqgzDFcJ2/yC06JH08A2MgkLG
	Jp0kYbTKCvjxpjP8SbMrlgRzFhYlbKaTte4YYP63tskJvQpM0p2Kz1Q0vz8T5sOmbgA4u4DE/tr
	POClYSWRk4GtsOX/LRoJOWAclQFSbBzB0LxU3SfLDumif/yr6BYYJajUqxIf6L3Z1XUqsPA2w/V
	z4sHq5vDW0VzVNzJ/Sp/BX1qkv8nj6v+I1GXFtL8zbT8I1n92b+0QmkUTCJZv1g+4lzVhX+iQTU
	tzErMCx5geioN/lNz6iljSr7KECZhEkjM1P+oeCqNxLFCQp/1XBGyJMAhE33boF8upyaJ0QCnjj
	2Bb5KYKopL096vbzaGaJ/A4GOWOWY8TUqyS/E8EVKVoDJJUXkuX+kiqFloe1ZVts4vDh82sxiBm
	32eR05lBkfPVX+SDZe1QEEOpfEA67tW0/qZtcr/6N2Aj/+NeJnHx+zTkKOaQb4fnx1B877ebw3K
	guWb1ToOghDAu5hNRnulgEAiDmgeqc=
X-Received: by 2002:a05:600c:6217:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4a027454f31mr164261805e9.0.1791215897683;
        Mon, 05 Oct 2026 08:58:17 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1787e7792sm1644085e9.0.2026.10.05.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:58:17 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 04/18 v2] sched/eevdf: Compare min slice during wake_affine
Date: Mon,  5 Oct 2026 18:58:13 +0300
Message-ID: <20261005155813.25126-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-5-vincent.guittot@linaro.org>
References: <20261002154415.2270586-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add a new level in wake affine where we check on which CPU the task
> would most probably run 1st between this and prev CPUs.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ad72b8536d6c..eeac0aaba3cd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8422,6 +8422,9 @@ static int wake_wide(struct task_struct *p)
>   * wake_affine_idle() - only considers 'now', it check if the waking CPU is
>   *			cache-affine and is (or	will be) idle.
>   *
> + * wake_affine_slice() - only considers 'now', it check if the waking CPU can
> + *			 be preempted becaus using longerslice.
> + *
>   * wake_affine_weight() - considers the weight to reflect the average
>   *			  scheduling latency of the CPUs. This seems to work
>   *			  for the overloaded case.
> 

Nice. A typo. 'becaus'. 'be' wanted to be part of Santa Claus instead of 'cause'.


> +static int
> +wake_affine_slice(struct task_struct *p, int this_cpu, int prev_cpu)
> +{
> +	struct sched_entity *se = &p->se;
> +
> +	if (se->slice < get_rq_min_slice(cpu_rq(prev_cpu)))
> +		return prev_cpu;
> +
> +	if (se->slice < get_rq_min_slice(cpu_rq(this_cpu)))
> +		return this_cpu;
> +
> +	return nr_cpumask_bits;
> +}
> +
>  static int
>  wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>  		   int this_cpu, int prev_cpu, int sync)
> @@ -8508,6 +8525,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  	if (sched_feat(WA_IDLE))
>  		target = wake_affine_idle(this_cpu, prev_cpu, sync);
>  
> +	if (sched_feat(PREEMPT_SHORT) && target == nr_cpumask_bits)
> +		target = wake_affine_slice(p, this_cpu, prev_cpu);
> +
> 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
> 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>

Also,

Scene (Why I always start like this? Answer is... IDK neither. :>):

CPU0 has an RT task running named TA, and CPU1 has a fair task running
named TB that has 100 ms slice.

cfs_rq_min_slice() looks only to rq's cfs_rq skipping others like dl
and rt. The value that's coming from cfs_rq_min_slice() is then checked if it
equals to the currently saved value.

So if the cfs_rq is empty, cfs_rq_min_slice() just returns the starting value of min,
that is ~0ULL. And we write this.

In the case of CPU0 and CPU1 the behavior will change whenether or not which one
of these is prev or this CPU. If CPU0 is prev it will be chosen, if not CPU1 will.

IDK if this is tolerated tho. But shouldn't this be changed?

Or Am I getting something wrong?

(To y'all that are currently attending to LPC, enjoy! I'm sadly only enjoying my room.)

Thanks,
Kayra :>


