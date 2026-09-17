Received: from mail-ej2-f23.google.com (mail-ej2-f23.google.com [74.125.228.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4C5221CD
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651706; cv=pass; b=fE40phG92J6POztGQ9PR33V/1agerP+r37Y/9yl4XYBJLvcPSQLziqLB6OC/47oBmZAe9yT1CaLk6Amr4QYAgmmFgKjIP8U9Vq6hdgA5qFV6E4WrMDrOosyAtDhv8HiVxac4B2pKkHUJJK0i1Dmj8V465mU8XyA6SKh7igVQcy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651706; c=relaxed/simple;
	bh=0WJXIdLQe4ElSlYT4i0l99nxpQnfGCMgUfJt7LZpHAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om8YCyE29l1PTiy9Y9ObMd1E2fXFTwwLvw3FdPdKuwE3OTQuvBe3tZZZC0Yo8eZo+dK7DsYdWUBdhvJO2DTNYQDSfiM9FPPDLfuu9XcZbD1WgOU3r/5xvnbfQ5yzNnaxJmradHTuMWhLeItQwW9fcPX3dHlsFVyZj6tf3WdF5Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXkPQMb0; arc=pass smtp.client-ip=74.125.228.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXkPQMb0"
Received: by mail-ej2-f23.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so119898666b.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789651702; cv=none;
        d=google.com; s=arc-20260327;
        b=qvk4+ce/4KdVlc2CfhIDlYSDyP+ZOjEPFyOCef7FxBo+R/xudDEd+nOhoLqDrgmJXc
         qxYyHFt2LwkGOtiKsUT3MzC5hM8XSixVr5OsjuJgC/9ohH4Wku+vrB8FK+PnD2/Gu0ML
         lufC7175dWTQwtBgWzf9UoGuViLkBfsRCTBBoHOUEw/Yry02lE73ynsJCSnWHsRrmIA8
         efnGAwkorJ1E3pzKlzgBF0kK2i4mVGHOhJjWjhEd+f/3paW8M2sbKoACx3+ckF6fo23l
         H1Gf9+nhqTI+1KvKl6ukCh556M4372OmdOomMgsAnJPQB8GTJ4A37HZJbnGaSSmUqsVj
         sgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LiiEkFORC49HDxXLzDmb4xC1eRwsEsw+cw7nlo0p/HM=;
        fh=dMUAgFujnN+mwzsmjUQWzbWimhrdF8RRzsWitE4pSoI=;
        b=mxxGNTj7DdhINWwYNZJNcaEkElRtffS0yl9QokgSYieZOHYRXHJyMdbcSciF/RDzEe
         T3wA+VUIBTGl/Acgi92mPlj1Ew+/ZQxvTV2CTqoDcONaycUejJpoIfxk+TLYMdjd3qdh
         cfNALCoqB6H/J7eVKykHfP9CmRiXkcfkXysoES8RvHzafZYFwfgoF7RtXTl8m9lkXcl3
         S/el4P734IrM/3pzAkbKBTgirKWloA0LmPdVupz1ttrYHbbsD9CBtRpWcAY7xqqauG+O
         Ywl408H4X0Ku5BTRf4XmUFBT88o78l09XdFLqTgO0LlvXOVXH5yXxh92tUOaTQKYgL/J
         IKmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789651702; x=1790256502; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LiiEkFORC49HDxXLzDmb4xC1eRwsEsw+cw7nlo0p/HM=;
        b=rXkPQMb0WW/RNOg6SNxG6XjlI3wt1sebSjrFuQc+I7o8qmHKzwzSNnYXeqMn99PzQH
         YViEUhnfxvg3VYlzaB+h5gu1428hntn7O9x/BWRN5Wfw8Jjvy/HpMfIfR5ATVI37YpgE
         9BIuhcu4HXmqhb2Ubtq9dEExv9J1RPeq0IDp9zphN83mjS7hZT7MosZrgdpq2+ztnk+t
         BkH2Cy+DaVEuuG77vUd+hOgLSW/uyCZwrGOmC+gtTRY4BXOgshZodfNjbU8fK+90I5X3
         BT3IgusQ8DXWHgwQNmXEI6oif2lTYjFlbM9pwWgK6qLTn6nXaa0OXHHUG/8prdBMrFP3
         g+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651702; x=1790256502;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LiiEkFORC49HDxXLzDmb4xC1eRwsEsw+cw7nlo0p/HM=;
        b=ExM5XkO8gfWVMJfeuPe8d6vScRvFXQ8ftvOz1XPOL/Qut+xA1iUhlR1xZERCK+7wQ9
         l9rVHCftVMJzd8jyB89IqhOjyMGmXgOsD08glhvGua8nxAUZLHYK3qYw2HRlMzypWdgj
         +wcfcgPwFV5A6o5ftXsQCLYR1yasvKI2ZVkHiQd4+qY0fqfMudhoJg9wR3h4GAyORVTi
         Y69Y4SNyiOosD0lS7Pm5wiGG1Yil3nSs+OB/p5wCal3AvB32BhT8YvErkqQdB9flrPzW
         ovSGY05VjVNywe5o2U5uPm8vCjj/I1s+kZjEgq1avLRgX3QV6qfRaaARTT/EFfXlNcwy
         3Lwg==
X-Forwarded-Encrypted: i=1; AKwUvBzRkQLLvtD5F4PrxhpkUtX5S/55dbOvASbfOB/gtgAEi76wZ04xEI9KLCjFTBHwhoq4K7futSwduA==@vger.kernel.org
X-Gm-Message-State: AFuF++l0PZO9ceZd4wD1Zqst0ZX6RXtc4uJ+9gg+OmWGlIfUrNMWDFl4
	1BwBFTHL1oDVNQIh0oDBhtFbicAN4INZHthOiA89GavP9QMIO5QEBV7iyCTqOTQjS8dFaJSoXjc
	KYBWGqEMOEkSZ7LnEi9+HPbLsFYgjQcIK5qUWZcIALA==
X-Gm-Gg: AYBFou0pwHQrQ905GRRvyHYrgZYcoMAjhLvWo7tu250i8bdPo4wBPqmzx2fZjyyCW7Y
	e/JfQPxWIk4H9tcSDUCYmuhf7ompNiZ65OEnDo3IUvcOU0aTPfpCgJbYKcgMo6ds5PDI/qoGdG2
	YxvOlgM3QZiYB5URomP3/hrB5i4sgT0wgvBrEON8RTQ2fQNF2pw28/bxYTNRPhkT5UeyG2tmNH5
	6xLpMn4Y708ut//uAF5oR1Nt6kksQ1YbzK6y5pYTLiJ1QUPnxCmRpD57TiubI24yKyZioSmvgqn
	xthIWMhfvqGs6eqTjVX2Asfy2XsCP3GhjEd2Fm48sO/yFjSgeZhW4A/Uixz3hAE8E9gQPWY3mSZ
	Eczp51+sXQH+f
X-Received: by 2002:a17:907:3d05:b0:c29:6cb1:bc56 with SMTP id
 a640c23a62f3a-c29e532bea8mr511794166b.46.1789651701772; Thu, 17 Sep 2026
 06:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916100116.701206-1-christian.loehle@arm.com> <20260916100116.701206-2-christian.loehle@arm.com>
In-Reply-To: <20260916100116.701206-2-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 Sep 2026 15:28:10 +0200
X-Gm-Features: AcwNN1UwSb7UKw5POOwin-HQQq1l6kQgh3OhpbZxQbQppke2fZwr_hYswOySiB8
Message-ID: <CAKfTPtCvfMEY__n58hGpbbEK88p82jT1kNTQF7tJfMFjBo9msw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Drop idle recency from slow-path CPU selection
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Beata Michalska <beata.michalska@arm.com>, 
	Elif Topuz <elif.topuz@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik <sh@gentwo.org>, 
	Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 12:01, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> The slow-path CPU picker favours the most recently idle CPU as a proxy
> for cache warmth.
>
> A more recent idle stamp may make ongoing entry more likely. Among CPUs
> with equal advertised exit latency, this may favour the one with the
> highest wakeup cost: if entry cannot be aborted, it must finish entry and
> then exit, while an already-resident CPU only needs to exit. The same
> advertised worst-case latency covers both cases.
>
> idle_stamp does not track the current CPUIdle entry, so an older
> scheduler-idle CPU may also be re-entering.
>
> A recent scheduler-idle transition may also mark a short gap in recurring
> task activity, so the CPU may soon be busy again.
>
> Drop the timestamp tie-break, retaining the first idle candidate unless
> a lower advertised exit latency is found.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/fair.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7455a83a6a99..ff5793bddc35 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8459,7 +8459,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>  {
>         unsigned long load, min_load = ULONG_MAX;
>         unsigned int min_exit_latency = UINT_MAX;
> -       u64 latest_idle_timestamp = 0;
>         int least_loaded_cpu = this_cpu;
>         int shallowest_idle_cpu = -1;
>         int i;
> @@ -8480,23 +8479,11 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>
>                 if (available_idle_cpu(i)) {
>                         struct cpuidle_state *idle = idle_get_state(rq);
>                         if (idle && idle->exit_latency < min_exit_latency) {
> -                               /*
> -                                * We give priority to a CPU whose idle state
> -                                * has the smallest exit latency irrespective
> -                                * of any idle timestamp.
> -                                */
>                                 min_exit_latency = idle->exit_latency;
> -                               latest_idle_timestamp = rq->idle_stamp;
>                                 shallowest_idle_cpu = i;
>                         } else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -                                  rq->idle_stamp > latest_idle_timestamp) {
> -                               /*
> -                                * If equal or no active idle state, then
> -                                * the most recently idled CPU might have
> -                                * a warmer cache.
> -                                */
> -                               latest_idle_timestamp = rq->idle_stamp;
> +                                  shallowest_idle_cpu == -1) {
>                                 shallowest_idle_cpu = i;
>                         }
>                 } else if (shallowest_idle_cpu == -1) {
> --
> 2.34.1
