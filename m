Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA63FDBEA
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141505; cv=none; b=poELN7StE6s5z7HgrV603TZjCBhlJn3F3ma8u/fspJYveK+s5W3I0eBg0tRVIQlTkl/leaPveyowVLTvB78d94C6HDZ2lTUQf7gpVw3UWmy2MNhRFA/0wO79ixJqZnB4Oyd+VaMu5UhtpnoBijAtI3i4V8ufCJ9VYYMvd1qEZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141505; c=relaxed/simple;
	bh=cxqvPvmP5LEKCuOrQcNT+FDABIRF0pkCGT0tYhdiTXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVmubkHB2VvglQoUWaF1+X+EjkXsvpM4XncA+XFnSNHKY6rbJl13c1UidKnCw9OICNIvEe1YqiI8v7fjbUiZLlsHgkU/anCPKq3f9dn2qNjgtAgcbgABoCrcqftn609L6tGxSlKsCyCTvNdXcDGGRmlsmBTtjzxXNui6S+N8JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3pUI4+v; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3pUI4+v"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48aff407b13so132721f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791141501; x=1791746301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPTMVIIAJFn9U/eu7HQEBuEphGxHwxWPSlT9dvO4lqU=;
        b=m3pUI4+vtvXlwQQ0prQwLq01IAmQ8fmp2mggHNRBhGAiIsGmoRgOZcbKFvToxZPUyI
         sHbu2g+6yzTceF8Wp1eHAa/+4klY8uk/5W9VATtIHFrkmfRCpXEEjvebsrhZZd1QTyT1
         TBh1JG2CuC9fE01Ic+80bu7WETTe4d5fneZpQmd5WVYgDtUqU7tRQ+Pd4etAtxYeRSqF
         ZDiwV50tRYY+9yhfJmsvbZL3VVeeZsJI4QELIpofmo1nFx8zBQtGmMBdDS5bPiUO+BUO
         EixWplPNN/v/arDaBg2hVw2p6eFsqfzvDSVEdb7Kmxs3HBdNhnnPJhvYdgwh1npO45YT
         w6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141501; x=1791746301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPTMVIIAJFn9U/eu7HQEBuEphGxHwxWPSlT9dvO4lqU=;
        b=z3wqA6JvJ+3JkOynPlOFQV1Jg+EOEKA9aB+WHbn866no5yDfzXk3GF1Dd0BWR6E1Ac
         ARv/BdK/SREA5qrF5HIEPtFjy+Od4hYxdAzGxy7wqS30gWrZqyI1I2jiKskB7Ywcp6FG
         Tt4BCY+LkhUd6YQw/i+tNN1XCDsnhq1y6HX8Z01/M5FVDuE310uEAs6FuQCI9LQEeOnO
         xmjX+LomQuAll1xiqozRCWyjDNwaRfSwtJOBNsUFHfbJRsbFWRIq3Td6hfd8U8VrngAC
         18lqW2JA54va+6TPrTV89ahn+BfpCG4uhBGEe+WUTSTi17b0MVonpetB9P/craYF7dxC
         Y9mw==
X-Forwarded-Encrypted: i=1; AKwUvByltw0zgPBUMU3+gkn7incsqPc3ppvbyn6SnTbO87wjlkAikY+oX2A+Cqhy/h/hWwic7S7B25pGqQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nOhbRWBa3odAB0l/GgufDfZc+UISasomHKKBnyGnYJ8a+E+ELm
	1/gK4N6MwuYF2zpeAzKMEqtEoUdQgTWBtnhKZ8DjhAhdXcyLK1gI2T0N
X-Gm-Gg: AYBFou1chtHAhkYWOdEf2XUB8zMz/EW9cS7n75WKVHdSMcBDMmNSgaP3TJwXi9cWEgp
	hISH4/binM+LVJ6Y+AM8c0D1Vgsk8OFJMGKgA1+nEYad3Lxo+ECtyid+psT6/eDYXk/acm2h9Bt
	Wb4dEIKrwpg1rR89yotFRLTaX7fZpVs8AnRDhawNyiOncfYORv5otvRDdhvQilCRRVejCJ8l9/R
	vAyjwb5Lz34mXYYWNOePLov4IWSBUdJ7yQ2LfSpGWa4GOaFH3+OvJMFhz4NSCsVCLzqqLDpyznT
	2LCHZ60twnYRWE+X5nefJEp/MrDpIFbPTsnYhs9UAHzcZsVQneq9z5dUZDXbzlQaIalUdEuI3hm
	Ogwk17RlAjZpcL0/Xq6ORKqiROLWqM/TWbgIMZmuJflnWyDCkwIhnDUS8WN4w5KtWdTYPVyFXoG
	ml2HrwK6Jc826f6Mxwy1h8bTOFh2T+Ovfp2FthDCGHVDHBuM3z2IymBbSDX19U4SH2Nz2NQIFs1
	zKObl8ohqbx3e2Vrf28
X-Received: by 2002:a05:600c:46d5:b0:4a0:1ca8:70e2 with SMTP id 5b1f17b1804b1-4a02751fa7fmr143583805e9.1.1791141501458;
        Sun, 04 Oct 2026 12:18:21 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276fa954sm279357515e9.3.2026.10.04.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:18:21 -0700 (PDT)
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
Subject: Re: [PATCH 05/18 v2] sched/eevdf: Add min slice check when selecting CPU
Date: Sun,  4 Oct 2026 22:18:17 +0300
Message-ID: <20261004191817.20225-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-6-vincent.guittot@linaro.org>
References: <20261002154415.2270586-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new level for selecting CPU when select_task_rq_fair() fails to find
an idle CPU. This last level will compare the slice to select a CPU where
the task could run 1st.
This helps a waking task to select a CPU where a longer slice runs
instead of one where a task with the same or shorter slice already run.

There's a typo. 'run'

> @@ -8771,10 +8771,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int *best)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	int i, cpu, idle_cpu = -1, slice_cpu = -1, target = *best, nr = INT_MAX;
> +	unsigned long task_slice;
>  
>  	if (sched_feat(SIS_UTIL) && sd->shared) {
>  		/*
> @@ -8795,6 +8796,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (!cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr))
>  		return -1;
>  
> +	task_slice = p->se.slice;
> +
>  	if (static_branch_unlikely(&sched_cluster_active)) {
>  		struct sched_group *sg = sd->groups;
>  
> @@ -8814,6 +8817,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  					if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  						return idle_cpu;
>  				}
> +
> +				if (slice_cpu == -1 &&
> +				    task_slice < get_rq_min_slice(cpu_rq(cpu)))
> +					slice_cpu = cpu;
>  			}
>  			cpumask_andnot(cpus, cpus, sched_group_span(sg));
>  		}
> @@ -8832,11 +8839,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;
>  		}
> +
> +		if (slice_cpu == -1 &&
> +		    task_slice < get_rq_min_slice(cpu_rq(cpu)))
> +			slice_cpu = cpu;
>  	}
>  
>  	if (has_idle_core)
>  		set_idle_cores(target, false);
>  
> +	if (slice_cpu != -1)
> +		*best = slice_cpu;
> +
>  	return idle_cpu;
>  }


Also,

Scene:

Let's say that in our domain there are 8 CPU's and has_idle_core is false. And nr equals 4.
And sched_cluster_active is true. select_idle_cpu() enters the for_each_cpu_wrap block
and the else branch. Because nr decrases each time, and if there are not any idle_cpu's
even if we found any slice_cpu it's not set to best. We just leave the loop after checking 3 CPU's.

The same thing a bit differently happens below on the main loop too.

But I don't think is more important than typos. Typos is the reason we're here. They are the or nevermind.
This is a joke btw. (that, destroyed my masterpiece and created a new one. Saying a joke is a joke because it is,
is one thing while saying a joke is a joke as a joke is one thing. I wanna go on with this but it'll be to long. :<)

I could be getting something wrong tho. (No one is perfect, but I'm not perfect at all so ya know.)

Thanks,
Kayra
