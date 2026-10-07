Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD14ADD8C
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383785; cv=none; b=LDnUO6fXe0wmNgdWwvwLC9hSCUq1m6Pb0P6qfilaKXWmfkhnmw7Ez72mhrlu86tw82s0/zFeqohAXsYndtACu2jfaFZbjdrvoXtJC+HKcycv0786b4VldQmgoagsu+PH3i9lveXXNg56yjfwLIBGaSxNOgueT/rMXifJ5cP1fh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383785; c=relaxed/simple;
	bh=QWObiRcI8iK0yCBnTv4yWqzm10A+0RXDZ+Svr6rN6ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9dWy9AM97YLm7QHSOkftlCsnZRSYDd+S/9xQBQi4Lp1XNZEjzDGgG3P2oTa6VjkXpH5L2UJhFZArgyHWdPJbYzAwBP+5tiKZsVRyczHOmCpQN+eXqj4oa7K9bk0JtDtdHkGo2YaOyfzBEFfsPR+JDTuqt9iqxRXDHGFVXOPRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkPKJU+e; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkPKJU+e"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48c6a19c353so175238f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791383778; x=1791988578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmqGbiXwpu78fwTCvPVzxN5FL6dMSRh2h6ri1F2bfkI=;
        b=pkPKJU+empfQGPxM2GPwXXQJUwmacJ4Ku51ERYfoE81SCcLArwCDx+PyeBKq1gQ2RO
         UqmAsFEBrJVR0qBPWvZ1Pp+em2Ssuhc/0YvkQobX4M2XdwlKSCdQzOiGAWUuNyoxT6fd
         WWzc3lapgLwMqJNDsJ2ZPtG+gMZ+6++GSa4qgW3sXS5vzKAOVIVGS7uaPm2HU0nuM8dj
         7/hB6HsEPBX0xBR5eS5PoOlp9tw3jCWkwPHYSFhJ0rWC9HaujdWVgzKJxTk36GdF+Fs5
         kXLA7GXOXOZasZDOGejOBUV3kodELVBbLwiqdStpzhlJnl4hUy2bNYL+sl7+BhhaZ64z
         /QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791383778; x=1791988578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmqGbiXwpu78fwTCvPVzxN5FL6dMSRh2h6ri1F2bfkI=;
        b=q+Ul/4Yp3SnYKvIF85d3Hzbj4E19xCA0YFYGkWqrVdZ5RlzdUxcYDtqhq83TgQIrW9
         Y7fL1wnI2nfjfuwxSJeWbympSaV0XAZRGeV2nZtHxLQ1k9uUR28sdDb88RVjV9w1yCIP
         Ql34snf5fRCqvGJGZ9PzIya+BAYNKJ8zttipSrDvRrH8fyUwp2I+X3rerZ8OohV1hJiW
         eyKU9U96FGIWfuIOXEG3GND4MPSoW59OgnpLhA/FBasbOECD+iZcFysBI6vM6JjGmMML
         F8/PiTPAQMQkYWWmxgT5wrSzV45sV0kVnHmQlSskxmrrBLh+dHCTCsYOsRQHpjtrWeuK
         S5Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxlGabWi3ATYXhOLhepQkwIRDKXW1z7Mnt+jQDOkKVGX/9peOALzFkOOrlUtBxKecAwq0NM/zLdHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5VGA+/rWTsWARLUnLwDyLG5E2PEhRsjUzuqeVFdrcTXgj0rRw
	rSi2kg0zTRd+AgZutYStSOVffBqdpUU1sedPvuDROCp9NyT7zTPVHez9bST3+A==
X-Gm-Gg: AYBFou10/sk3Qhzpj+NxRVQ7/iTALNS4foqlfG/rt9nUbL4dAu7Ga3Zr4/dzjp+/gXw
	4NtaCY4ISyKPSEa+Uqd+1I9vQnA1sx54jqo/ibNumV6iSR2OfoEzouQc3WYeGIHqBXOZCOTbx4u
	orSKegkyUnbcGmREnjZKIL3Eu6iq1n7NXznEoOIzY/ncJM1E74mFSpU8dSrf4Qp67ybwBvq9Kyb
	IHRzN/aHjC/NwHigXsna7lU1PnIr465QBzgTIuRbA7P1GEWVQN/Bw1QkAv2UebfHX/Ypo51aRmz
	3W0lgN767eJSXgR/4bnAwDI7GZULviUKmBfh5S/5OPhdbYFJ1QUNUfK92Qs8xsH/SwTvh5WFhuY
	cpLHNVRTb53li2MmWBoypdhehC08m49Xx0kTO9+u72WM491i9AQclth8iLZZWce/R7V5aKvccSe
	n4yBqIvgEWgVMAzQ8yaVStfy4q9CNrurHVj3Nq8K8GbTW8DK6mFN1UjI4NuyH7VERD6wvzht2yR
	On1fNQB9OqLBTlQ6rUG
X-Received: by 2002:a05:6000:2992:20b0:48a:f41d:846 with SMTP id ffacd0b85a97d-48c7277c7eemr3689759f8f.3.1791383778341;
        Wed, 07 Oct 2026 07:36:18 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d30603sm5948935f8f.49.2026.10.07.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:36:17 -0700 (PDT)
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
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
Date: Wed,  7 Oct 2026 17:36:14 +0300
Message-ID: <20261007143614.27368-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-19-vincent.guittot@linaro.org>
References: <20261002154415.2270586-19-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When the cost is the same, take into account the slice of a task to try to
> select a CPU where is will run first.

'is'? It gives 'it' vibes more of 'is' vibes... (:>)

>  static bool update_best_cpu(struct energy_cpu_stat *target,
>  			    struct energy_cpu_stat *min,
> -			    int prev, struct sched_domain *sd)
> +			    int prev, struct sched_domain *sd,
> +			    struct task_struct *p)
>  {
> +	unsigned long task_slice = p->se.slice;
> +
> +	/*  Select the one where you can run first */

Again. A typo. An extra blank. I'll normally make a joke but,
I'm tired. ;-)

> +	if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> +	    task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> +		return true;
> +
> +	/* Favor previous CPU */
>  	if (target->cpu == prev)
>  		return true;
>  	if (min->cpu == prev)
> @@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			 */
>  			if (target_perf < min_stat.min_perf)
>  				find_pd_cost(pd->em_pd, target_perf, &target_stat);
> -			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> +			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
>  				continue;
>  
> 			/* Save the new most efficient CPU of the PD */


Also,

Scene:

On the reworked version of feec(), we have this check:

  if (p->on_rq && !p->se.sched_delayed && cpu == prev_cpu)

A little after and outside of this check, we call update_best_cpu().
Now, if this check can get true, on this state:

prev's min_slice cannot be bigger than p's task_slice.

So when target is prev the first check is always false,
and when min->cpu is prev, the second check is always true.

Also also, I have a really important issue abot the patch
series that can finish the whole patch series and end the world
itself...

The issue is...

I need to sleep.

Thanks,
Kayra


