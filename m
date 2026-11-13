Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566958;
	b=QLv5Po3BQsdNkH7/RdD41ScPOHTl2T2UfBkBl9XwCSMJXb15hfbjLZWUexgOEMXULYgo
	 H9SrQJxiq2a1PWItRrIYMhgb9HkkVwHd9ASMDr5jRiiOL4VpQCUek8/dDLQBuF9OBWqtH
	 Yikv5AClVoQj7eSDEaV/mS3pm+o0sEty2mx8ALhLCitbbl/sG3eHKoJ9toK3ST2BM26Vi
	 GYCX2kLMo7SEw2Ucqrr4t61/uKr2KsxFfX/dmbHbEW2PvyhuiSTHeML+mbb6yGoFi8+gA
	 AahkP7GKQ+IU/oMdu0K8rUJa9NgWK0lZT+Pr0lWSu8zzlHihTZyB2tDT9VcVZt7Izng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
	b=m9wQ+JLRhGiP0pfMx4m4KpMVnYDhEhRoNDN44iIwEJR/hzGriIWSj7kes0myz5Y73loD
	 X5rzYO6Rkq5doFoe0haOuuHowKDIYnI4DCeOpQKLaBmT0kf0ji2xHneesNTJp589bfdsu
	 sE8ujzXgZymizAk7cEQ4s9Oqf3BIta3kXbEPYIm78Ij9hktdde0OxZqPktOCOHrBLYrjy
	 BiUkjTV/8sDVnwnshn02wxzIfCGkZMoifKStT97SGhKHFM2CMMYG1VjBj/v9Dm5eiFxiQ
	 nxAUvX3wds6IDz47VMncO8Lq6ZTuEu/qr6p9HfA0J5sLAVbNGeM1D0GZe+F2Y9qIvAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sUiJzb5j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77844606A337
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 10:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77844606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sUiJzb5j
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso1524025a12.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794566956; cv=none;
        d=google.com; s=arc-20260327;
        b=TqJ3/abMvOwrBxYM6l4VAlXbgaTWufVVbVjkLW0BLJhrZVKgup9zLzP6nn9WJTr9qP
         /ZkZ9yehIqcJqvh1aEPNcLxKNsskU6p34Qh62mkYXGvJaCq6ApcsryS3XbfEBy8IUbbk
         SaddMMbL7oV6H1b76p0FMV/HqLUVc0IoZ9UvcaiHSrkI1Fqi9KwP4m+2S3Gy9v5H0X5M
         4nTS14K17R62cjINcm/Hw0/z0pFtyDvM+isYtCZg2dfC8PllvTYZ7qnGwlyPSt+pPvJx
         bHf4HNRmTi4jrRDgrof2c9mUnprgGkKmAZLYj37sBS0MjopfBHT2jcgjEdpY8fC79vdy
         1jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        fh=SYVJeCXUXrK/tE/mN5QEsm4O4fcwfCdFyTzGLEYPyLo=;
        b=LJ+EbseKSYfrMRiFhv75KAGeEouPAbT0g8BnebkeyCux3wYRaIrPZnOPqaCgQRKjqb
         b6AmBFou5zZFyl37q82IkFUCQjtvnCA7cBFvizRM8BHRZ5HZqc3KtLMzNMd4kfWio0KT
         3ZprGSvJXycj/79S3NPPFQtq8H0Pc7he+f1dIIOvaMHx0Tglwee5cofYRQhcnUqnlQhW
         DsBwn6jLLXTPM1oJrV+RGQc9IuM/H4HEqyWLmt4T6aanSRYNItKzuh/37lMUgT8xpeWw
         ilXzUtS5PvlJ5a0ecokfiQyVkgQXhouIAROBC9+pK2jTh1ZSehDJyvdscgit1k2Q6fWc
         JWug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794566956; x=1795171756; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        b=sUiJzb5j8kzjG5rFAwt2lYPsOrZC8lwZwqlP31LJtDvdcJ01+c/zeWa/v7zmdHqJ2s
         R7GaIh2zsKQEPhTm79GWV+vFc/ZJkat5LJNZ8TMmqiIVI4XNbcVLuk3p25uKHmEvjLE7
         RDFDL5XFE192cw+TZ9w2LvsiFN/Ubm2ZU+lsyvBWRgZXP1UnaWxZ7JZ5yPkS0T2N/ZEK
         O5VKKIYqtoXLuSZEz9DB/EmmIGGHjTIq128D9+TdUfKxoDUxjUx1BwhNfo18JxpBYnGr
         tFCFcmSiPI+KDAsR0c9B4tNffO01rwil5zH17ca3R4nh/0oKZBXBjKCDYG/EVoMnRkMJ
         oi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566956; x=1795171756;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        b=AxOoK+cxL/FDHacBRcCYc90dk7pT05kXZ4uxUP3/+Y4fadXEfYGiGYC4PX2qZSov/6
         7+O1gBYGFjrenFwHz+/YhgyaLoqLZERPkH1OswtBg6xGGR3V8ZUR/+E0EkKjCMSIv9XR
         MBPTiT9de6W6T/NAqQuy1+ciCeyHzRlx8syPdlZwG0Y0nerPB0vbSJJ6WJV4VleJP/+6
         1Y9heK8F/pEd+iYRQfWVZQRZJPvPvh8bpmqmQKkc26XzMIWyGVuontlo9qFiFivfsCUu
         OVHixXP2qgYQrKFazWRE6ZOEHX1CL+jrSCjZFC/wAKnzOO7K2PLq75GF93Lx6LTMJ468
         U6cg==
X-Forwarded-Encrypted: i=1; AL+hErE7+yj5wL0rzrSf5mqUrA7+CBPA687p8DVwsCloYVnaU9VM9MbhwXui0FU9cBXBXgahCC40smroYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hpQk6EK9/Hb56/3oXLT4oYm4H8qw629JfiUncpWo0Jwbd/ceT
	vc9lLgpHEEqYuNnsuO1KcWwjSRF/YnICuUmfYYdLWN/nT5Lxv1m1Yq341A7pwXqjOnK7y9HJO1/
	iqWqwq+dGDPXuL9f/EI7SpTdaC6tI8XE/85hAw8HExg==
X-Gm-Gg: AYBFou01DhpBKJuBtLEGvDjmt8gwsk6QMOkBZg8fF3ANpn+mBihVQilJZfsPOVsRJzk
	HGS0nsqRijFWM3nO6h0aI4nZ9I4YOXmck+Gdifr7Jzlw+Whn0diEClxvYARFt/hCtwNZzL+JSmi
	JOxUCfZFFBdUlA3QRKAzIzucCvTU0Mf9B5caeSnYi547mk6n0fZb0aNCjynVPcPRlNQ/5abOGM+
	yLeRx3TSuUm4GrqCAMzZcE6ew0ms/hLlvEMM2YnVumuVrAy75taAaxyqSDjOvtYwz62CjsOe2Kg
	r7+0teDu4bqeZuXUtt1opTomI6jIYDYn2Ydb6qtWSLSCE4FzEUDMehFKCqKSiJbGCo3NIQ9T83f
	CGkEKyr2oCtPTqOWfyGzYyhnISKom+1gEpG0FDEYPIwM4rbxUxXaDHz+0qx9aE/uMFKRqnA==
X-Received: by 2002:a05:6402:e05:b0:6b4:2fb2:44f8 with SMTP id
 4fb4d7f45d1cf-6b7c0d1cabcmr1977930a12.42.1794566955396; Fri, 13 Nov 2026
 02:49:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-14-vincent.guittot@linaro.org> <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
In-Reply-To: <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Nov 2026 11:49:01 +0100
X-Gm-Features: AclHuK93LzBqjNugOvp7vsT1Zi6WPLqjO3BWR9AFgUHwCjO2r9c6gTAQV4RnDhw
Message-ID: <CAKfTPtBE3pU=71EyEfVRSbOBG+Y9itNEhfwd7svT9+JZhek-vQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] sched/eevdf: Try to push short slice task on a
 better CPU
To: Li kunyu <likunyu@open-hieco.net>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 10:25, Li kunyu <likunyu@open-hieco.net> wrote:
>
>
>
> On 2026/11/6 23:19, Vincent Guittot wrote:
> >  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> >  {
> >       if (!__check_pushable_fair_task(rq, p))
> > @@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
> >       if (next == p)
> >               return false;
> >
> > +     if (next && next->sched_class != p->sched_class)
> > +             return true;
>
> Would it be more appropriate to use sched_class_above(next->sched_class,
> &fair_sched_class) here? I think placing prev on rq->cfs.pushable_tasks is
> justified only when next belongs to a scheduling class strictly higher than fair.

class strictly higher is the most common case but we can have cases
where sched ext dl server preempt fair task

>
> I also wonder whether doing this in the normal CFS hot paths -
> put_prev_task_fair(), set_next_task_fair() is really desirable. PATCH 09/20
> already replaces the unconditional raw_spin_rq_unlock() + task_rq_lock()
> sequence with a raw_spin_trylock(&next_task->pi_lock) that skips the push when
> the task is already locked, which I agree is an improvement.
> But could the push decision itself be moved into the load balancing path
> instead? That would keep the hot paths free of migration-related locking and

LB is not the right place for several reasons:
- the period between LB can be quite long compared to scheduling constraint
- EAS disables load balance
- periodic load balance looks at balancing the CPUs in a scheduling
domain without taking care of indiviual tasks requirements. It looks
at CPUs and then tries to find a task on this CPU that matches the
constraints whereas the push mecansim is done per task so we can take
into account task specific insights like slice, min capacity,
preferred_llc when looking at a CPU.
- We want to use push in a selected number of cases where we want to
act immediately

> select_task_rq_fair() calls. Or is the next-aware context (knowing which task is
> preempting) something the load balancer cannot reconstruct, making the current
> placement necessary?
>
> Is my understanding correct?
>
> https://lore.kernel.org/all/20261020083746.37068-2-likunyu@open-hieco.net/
>
> The SMT push work in this patch is intentionally quite simple; I think
> it could be generalized with only modest changes to perform push at
> larger scheduling-domain scopes, such as the LLC (last-level cache)
> domain.
>
> I realize the push direction is somewhat at odds with the current
> cache-aware scheduling work, which instead tries to make cross-LLC
> migration less attractive. Still, I'd be interested to hear whether you
> see any value in a push-based approach at the LLC level, or if there
> are related plans I should be aware of.

I think that Chen is looking at using the push mechanism proposed here
for cache-aware scheduling
https://lore.kernel.org/all/as2-2b417B8ZaFdO@chenyu-dev/

Thanks

>
> --
> thanks,
> kunyu
