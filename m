Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A293C13E3
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831556; cv=none; b=gLiq6/wn4qvFoCUdMt5fMTpWceb/djUme2T8cm4L6xzUMQ2kNpg60E4rRR3GENdGjDI5qgKK8yOVeMxSWQSus5ZPW7JG/TPZPNfpakZ8QBem2WUghwpjmi2wAjWrYUhkr+Zo86rgr9VkS8sBv2JLTotr01ccrbuGD2lLrATfBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831556; c=relaxed/simple;
	bh=0nXGACBN/x6TX9kfCTgsb4l252RYCW0IICb3v/pKq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiEup08qM6madADSrmVb8jkN3Ex0bF9vgdG5GJhw3mWrVH/yP6RkZg59wG046Y58PrSUSUcXZ+7cOGR9LEupZrPokgGogZNwAk8S/+Jl7pqroUyMq8Bosk5zKDiGGElRLATDKPHJxeie43SfnMKUQ7fOVHFhTHI/9ivju6CrGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REy5hcig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REy5hcig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21FB1F008A5
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831553;
	bh=xt5R5QIossr8PvFGF9z1aq+prpu9O6h0Df/bSvqtdU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=REy5hcigSNpGZuCUMAJoRMuOB7E2gF7kAwGnmZhEGf9Ej5RotAWpfUfmnuE+lSgRx
	 u+tNL9R+v9uE2pNpgwmI0n8ea8XkQAXFZ8gnJ6ZVFQInQ86gEth2M/3/oXraD0uEKK
	 z+Nz/nmt0bwaS7EokprAftNYFCVs1OhD/z1P32QhAWGWfl9FrHsE1td0bIP8m4M8xO
	 Re0yPBez7TkJG2yQeixupmnqnJMrRVsRnwm/1rVEQ12XdwGzmme6n8fZcyjOIWfFou
	 DE9Sai51wLi1KOC3h24/MEYz5Ab9ukZ8A/XONplO7u2fw9LIKsiUcbsovxuBsxi+Yu
	 1OGnQ8/lo+ayQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1707451e87.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 11:59:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzq57HVPS6YlClQVOQ3XSaefZNAlO5losjiPT2jlFFFGe9wp3KYjLzOt/6qKnJl6RnyO7l2yrr8JQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK1WQ+T+Pr7+GgP1GSiUxbYQRiO3o7Ay/dMOvQEVDJ69AQZYJQF
	nyaP3erh3k4FwDLIsEZ5rGRg0Dpk3fdm66/aMQL1clUBx6/VcxjEpPJ3V0uDCidZvijb9BBdOBx
	i2rQqwMfbW8vGjYQrUevN1cboKIE53DA=
X-Received: by 2002:a05:6512:6405:b0:5bc:e4ae:718d with SMTP id
 2adb3069b0e04-5bce4ae7220mr3129853e87.64.1791831552263; Mon, 12 Oct 2026
 11:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007155820.3194105-1-sh_def@163.com>
In-Reply-To: <20261007155820.3194105-1-sh_def@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:57:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHXc4+si4TspPB+oNyPNED+9s90B7VJwrMa91J6GOGCg@mail.gmail.com>
X-Gm-Features: AclHuK_mNZ2wKn_gme-IIZoeUlw1tE_wMnFnbScf3dXt5ZLPmlcVDWESBz1-BKc
Message-ID: <CAJZ5v0iHXc4+si4TspPB+oNyPNED+9s90B7VJwrMa91J6GOGCg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Serialize start against rate limit updates
To: Hui Su <sh_def@163.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 5:59=E2=80=AFPM Hui Su <sh_def@163.com> wrote:
>
> rate_limit_us_store() is called with the governor attribute set
> update_lock held, but sugov_start() updates freq_update_delay_ns from
> the same tunable without taking that lock.
>
> This allows the two paths to interleave as follows:
>
>         sugov_start()             rate_limit_us_store()
>
>         read old rate_limit_us
>                                   write new rate_limit_us
>                                   publish the new delay
>         publish the old delay
>
> The sysfs tunable then contains the new value while
> freq_update_delay_ns contains the old one. Unlike a transient torn
> read, the stale delay remains in effect until another rate limit update
> or governor restart.
>
> Serialize sugov_start() against sysfs stores by taking the existing
> governor attribute set lock around sugov_update_rate_limit_us(). Use
> gov_attr_set_lock() and gov_attr_set_unlock() to keep locking details
> within the attribute set interface. This keeps the fix off the scheduler
> hot path.
>
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler=
 utilization data")
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
> Changes in v2:
> - Wrap governor attribute set locking in helpers as suggested by
>   Zhongqiu Han.
>
> v1: https://lore.kernel.org/lkml/20260929103635.3780346-1-sh_def@163.com/
>
>  include/linux/cpufreq.h          | 10 ++++++++++
>  kernel/sched/cpufreq_schedutil.c |  4 ++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35ce665edfd8..5448eb0a0885 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -694,6 +694,16 @@ static inline struct gov_attr_set *to_gov_attr_set(s=
truct kobject *kobj)
>         return container_of(kobj, struct gov_attr_set, kobj);
>  }
>
> +static inline void gov_attr_set_lock(struct gov_attr_set *attr_set)
> +{
> +       mutex_lock(&attr_set->update_lock);
> +}
> +
> +static inline void gov_attr_set_unlock(struct gov_attr_set *attr_set)
> +{
> +       mutex_unlock(&attr_set->update_lock);
> +}

I'd rather not do this.

> +
>  void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *=
list_node);
>  void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *l=
ist_node);
>  unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list=
_head *list_node);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 49ccd6f1c185..b847311c307d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -861,7 +861,11 @@ static int sugov_start(struct cpufreq_policy *policy=
)
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int =
flags);
>         unsigned int cpu;
>
> +       /* Serialize against rate_limit_us_store(). */
> +       gov_attr_set_lock(&sg_policy->tunables->attr_set);
>         sugov_update_rate_limit_us(sg_policy);
> +       gov_attr_set_unlock(&sg_policy->tunables->attr_set);

But instead, I'd add a wrapper around sugov_update_rate_limit_us() that wou=
ld do

    guard(mutex)(&sg_policy->tunables->attr_set->update_lock);

before calling it and I'd invoke that wrapper from here.

Also, the comment should explain why the locking is needed which it
doesn't do now.

> +
>         sg_policy->last_freq_update_time        =3D 0;
>         sg_policy->next_freq                    =3D 0;
>         sg_policy->work_in_progress             =3D false;
>
