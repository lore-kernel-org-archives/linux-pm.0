Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D993B2FDB
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555490; cv=pass; b=kTokgohtFbDUCg8CG3yw9mqMiyz+45nCU24afuZUCoKx9rcRoSMCH5sM8pgrIY+PJqilbs7V4f6HfiWaOHkw1Y9p8siGAXw5V1s8jMxtbPbwiiGOkNku2bS1php4nJp8EyPm7EnaBypa5mxVyH87CaPMuZH6y7l0345VY9tL3vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555490; c=relaxed/simple;
	bh=yXkOOHEp5xbA8RyWHIG6SKO9apysMTvV+h4+HDrM66E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbMLf7k+HnMLggSle+K0fp+p3Ch1K7s0vl1Fkt3SFmGhU4MAqKIa1hZ1xZJ/Cry6ML6QzJee9MrqwyT4fZGXGvhTogFCC5Wj/Muhvf09uUwI36TJVkUVoQdp6j4NoyhMns8FZn9Ech4K4fkIytRgvokUGa5Elmw+kT7eeEEjSKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yoJiEh7r; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yoJiEh7r"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so6526811a12.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791555480; cv=none;
        d=google.com; s=arc-20260327;
        b=J/r47jB9lK4mZ2/lyAFMw3t0H11gnqtBNB2cEgWZIwxLmlXBBEA86aWHvGsteY8wcn
         ZC3VCV5E2bMRne2s4fecuuxASRMc7wnQT5BN8ZDj3EjdlHooORuvkzAA6DyAqTBktu/1
         kfv/6u8f214CUcsKygPpaz6hfsQNgiBe5xB1kMBJHFbEqd/X4RZV6dBgm+LH9pnDIwxG
         txzQM0Xigh5nVzCKJhZQKrN0ljTWoAOAjelMa3dEB64jlfNXs48CfzY8+8CbmdtOxWNh
         b9shCxP0QJ6LH5t57MF/qarR4jwWTYv1Zs9CekD1siforWiOBzAW64a6lpTTB5E5P86U
         i0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        fh=RqV3HYUb5oa5ALB5pHkCq00kSCFrdEL9trqSYoNBkIQ=;
        b=GZkp9qEXzP2YhCXYxqQRR9sY6V11gSg4yXzk/AyuUEcUlYrjz2RCx1q9mtjGmIJMZx
         q4grKwbbal2hu0WgI+V2apkELYbA9pLJqN+ym/P1vPmsKaPlXzGzd/Io4iC4g9/4neCV
         ttEYh5sOPGpjR0LkoaMu/Aam3e8mkySXpAFDvuP3tXiau9kBM5TG97tkmpjwip+zKP2s
         v60e1S/yojWhx5Y0R0DsBD8Pnqfp2PIT9a333BORN1FJbZp1HUYmN/M4bEWdtI1e9gHL
         RRcsai2DqPh93rAihv7GptoKF3ss+Ybq4nMRdNezS6ag4+qE9o5HJ/Q+LOfr95ErFTIp
         PpaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791555480; x=1792160280; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        b=yoJiEh7rMJUI9DCeWnhkOq0rD2LIzXJD0M9JkRjaZcpTncnI8bNNNuC1WeeogM3C2w
         3M54CMRBazJK/CiB32AHVkSanB15eJhkW5i65Ld+KiljyurVuy3PsqH6VbUg0WQIh2gE
         OLiRwWFhh8W4UAKPip4l3eoYA8cEqT9BgVxWD/w9okmaNOjOXZjW+/PRLGwStqWHlM0e
         RT1uUFss+8UKUa4km50vDQYvr8DFzqOVneYbO/UxvkbsAhwUkNJYliM65N+QTCObNQJv
         ypRchJNlCQKnJ3khuqoLSM4dKhVmVcInZEd/3wSLU4E7hogc/aTWuNeRqEu813Voui86
         y6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791555480; x=1792160280;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        b=qomTkhN9fFXUakpAzVhoaHY4YiU0PzioDkaXnqMiHlwGjz+arhv+ev6JG7zndk0Tat
         yjhSP2i/vyM0oiQT7VCb1jXEVGL5R00RBNB8ucSqU1C5gvNG3wLbxD+JyrrrjIgFdebo
         rfVw8HPWhTrz68x+k8Lzrf8DT5jwo5Cdagb09A81mrtg/T7c/yA+6HmmrgREFFZH+wTe
         W3NqoEK4dv3BaOmSskkMyrzzxm5DX/IPMFYJEil9DioGW0xhUJlZ42rCSepbo0TmA1ab
         mmwaZa328xa6gz7IkA62aSfHUWebiu9OafqhyrDFdWqCTBBwLc7nXbLlIOLSeT2I+ehe
         0USg==
X-Forwarded-Encrypted: i=1; AKwUvBwxihJ9uUtWWkZyYRT1DIjtQUJ3FcBnzek6Xz+w5FM1f07K0+BGk/TxAtt6hn31XhHRKoSwcaWT9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYISLbVXSGsVEsx5LbSgtKh64C41XfDHZAcbOAMCZQTpBA8f+vFP
	E2TmS0kMkg+DZZgeIY4VSZ6ujAutbdK3yX86Ma/kzg4ZQfVLhPpMBVNufSpBjXYFVd89cB/RArl
	Q9nXHjWizzfjk+OjBBQgiS/aDwavpD+bUyNWceE2ljQ==
X-Gm-Gg: AYBFou2vkEK2pIPh4wZ0brDEINcPek3Pmkie8MZdSAK/NfmH7WmUlJHnNOYj0AAkTkZ
	cS18a0GF51ag5EKq52ZJtecqc8YC3NxvFB81f6W93FLOQ/kSS2CwX59zBLpFmX+H7M+GQht6dWV
	h3MpJ54HdThlOiY1CiyoEH7e/Tggfy6v5W/Btv4nfG5xZ4zoxOZXaWwTRD3F7/2Wjgn7Gw39dEr
	H8yvFraWqEDBUkMCyVAmCwD+klBFepJFup0COPBNsySMMS6wrdX0zWrSyJ0poej7pe+vYmrJ5V9
	atAkAPJF1M5UV2cyCPE+cSS/Trvw8ALJETzVIbhAQ1+DPWoMIBqjWWSwkVpx3z7QWBT/C8TeawO
	aFUatB+uGxkI=
X-Received: by 2002:a05:6402:4606:b0:6ac:6b18:345b with SMTP id
 4fb4d7f45d1cf-6b17c24e477mr1307684a12.17.1791555479602; Fri, 09 Oct 2026
 07:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-19-vincent.guittot@linaro.org> <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
In-Reply-To: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:17:48 +0200
X-Gm-Features: AclHuK8Pboa48bG0Ygkxu5EGL_q1lSvm8cRTKP-bJ5A1NhoyUuVzmn0zHI8xqpo
Message-ID: <CAKfTPtDcw6J72dJkbemySR1WKE_sWB0exXp_X1=DZSdO9BbrQA@mail.gmail.com>
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 00:53, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> > When the cost is the same, take into account the slice of a task to try to
> > select a CPU where is will run first.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 94554f165f42..d60bb6db4ce9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9598,8 +9598,17 @@ static int check_cpu_with_task(struct task_struct *p, int cpu)
> >   */
> >  static bool update_best_cpu(struct energy_cpu_stat *target,
> >                           struct energy_cpu_stat *min,
> > -                         int prev, struct sched_domain *sd)
> > +                         int prev, struct sched_domain *sd,
> > +                         struct task_struct *p)
> >  {
> > +     unsigned long task_slice = p->se.slice;
> > +
> > +     /*  Select the one where you can run first */
> > +     if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> > +         task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> > +             return true;
> > +
> > +     /* Favor previous CPU */
> >       if (target->cpu == prev)
> >               return true;
>
> Hi Vincent,
>
> The slice check above comes before "Favor previous CPU", so I read the intent
> as: the CPU where the task can run first wins, even
> against prev_cpu. But the slice check can fail for prev CPU
> and we can skip to "Favor previous CPU" and pick prev CPU, even
> though the task can run on min CPU first but not
> necessarily on prev CPU first.

yes, I wil fix it

>
> Take an idle CPU X and a busy prev_cpu. Any task can
> run first on X, because an empty rq has min_slice == ULONG_MAX:
>
> - prev_cpu scanned first: when X is the target, the slice check
>   selects X.
> - X scanned first: when prev_cpu is the target, the slice check fails,
>   and "Favor previous CPU" then selects prev_cpu.
>
> In the second case the task is stacked on the busy prev_cpu even though
> it may not run first there.
>
> Perhaps something like the following is better.
>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a47c6521a411..3fe305d690eb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9830,11 +9830,15 @@ static bool update_best_cpu(struct energy_cpu_stat *target,
>                             struct task_struct *p)
>  {
>         unsigned long task_slice = p->se.slice;
> +       bool target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
> +       bool min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
>
> -       /*  Select the one where you can run first */
> -       if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> -           task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> -               return true;
> +       /*
> +        * Select the one where you can run first. Check both ways, or the
> +        * result depends on the order of the CPUs in the PD.
> +        */
> +       if (target_first != min_first)
> +               return target_first;
>
>         /* Favor previous CPU */
>         if (target->cpu == prev)
>
>
> Tim
>
> >       if (min->cpu == prev)
> > @@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                        */
> >                       if (target_perf < min_stat.min_perf)
> >                               find_pd_cost(pd->em_pd, target_perf, &target_stat);
> > -                     else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> > +                     else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
> >                               continue;
> >
> >                       /* Save the new most efficient CPU of the PD */
