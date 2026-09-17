Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A04ED183
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667895; cv=none; b=Lo/Rh8DZ3WxYXYU+4pS+F+FvNplLfFaCOZGV8lRR2V6EfukxgP5y7W3kEq7crU63LJyKF10S8BZcXUqI0imA1ySvIn1YgtrYlVcr4z4v/OuQ5zhYMU6ChJElHqPhnCFuDSQj9rhNOYBcvRjOvE6TRYP3t0HYZrr4nGQu1XEiTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667895; c=relaxed/simple;
	bh=dAGirz+xKzOw6okpbMtB1sev1cFxSY0QjU/Gf2VfuAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oecNxAtDjoP504xtv7ZtxJq06oBjpU5ro4aw/0iKk5N9/jDA907XreFdpKcR+35ae9JGHflm1T72JQDsLFkeOR5sGiQyHN5A1yAAiAv+eSmRHNFvVwQ0Ng/vc4VGFmbpUrUHvNr11Y0riHPAUaeQ/tPd/eNDlu/BPepTyO2DvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahceBJ8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahceBJ8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D61F0089B
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789667893;
	bh=dDaYRTViiO8k6OdCzc9U02IRW6iOXT+m24w7Wy9I/lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ahceBJ8dcuv8LTtkuY9Jqi9y8i4D53PKIQ1Yakv/87PKSQCpMOWFLO2cIVxqfnJJB
	 lYzSk46vGoKo7LSbP3ccDL7BR3zqtXsgUPNAM70dsJ5QzmBjeUkCGbOi9UiJ0qz5PV
	 LNZ44tyEYsmJcYCUfjMUm4uDQDW8XeJgZp0Q7j9QHZ2Pry7oh/kERjd9robQI4UmuY
	 /yiUXFAt+0CD/XwZ6h1vOTRTcfIu8dGMiUQ46aqRPiKi3RKQWS80jQhDwVEE71EZNl
	 f58v0cwaet+lr9k8xv8lG/HoI8YM1YgSU2ZUg92j82lMQJAXAhyYZ1ugoJ9JThTxyS
	 C6+kqgPyzbLeQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59fa3112cso9531431fa.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 10:58:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBynMuHHXY4VFuyi/SSBGeiwJbEep9x2Xjv+22/G6OhVCOhhwf/IAP5zv6XfXLqI3Pcxt+uResgQ3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lTQ0lY6a3RiSIroM3Sen5TblO20vdD2H9+9FeBC4JXLlY/RsZ0
	kE/dia1EWJ2+FMHA16n0CwqVe2KwGlVEDw0+VuuIJHPqoGVmBriZozQUvpg0ZnA2OrAK0wpOktU
	PGOuedRW0EP4Zdc/wnsJ48EXw7UABZlA=
X-Received: by 2002:a05:651c:b25:b0:3a5:defc:81f2 with SMTP id
 38308e7fff4ca-3a5f8e0868cmr1207391fa.22.1789667892044; Thu, 17 Sep 2026
 10:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916140926740-DCokXh6dAgtqDn1EWdCh@zte.com.cn>
In-Reply-To: <20260916140926740-DCokXh6dAgtqDn1EWdCh@zte.com.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 19:56:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQxtypZoeKTQDnMKtq4qjVty8__XPN5SMw1542TSUH+g@mail.gmail.com>
X-Gm-Features: AcwNN1V7IUr1k24KlR_n7-ljae3EvsoW4FQ-CMALyz8TyzW2Gd2siROBabKIXbg
Message-ID: <CAJZ5v0jQxtypZoeKTQDnMKtq4qjVty8__XPN5SMw1542TSUH+g@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: conservative: Restrict deferred downscaling
 to low load
To: hu.shengming@zte.com.cn
Cc: rafael@kernel.org, viresh.kumar@linaro.org, zhongqiu.han@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luo.haiyang@zte.com.cn, zhang.run@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 8:09=E2=80=AFAM <hu.shengming@zte.com.cn> wrote:
>
> From: Shengming Hu <hu.shengming@zte.com.cn>
>
> For a shared cpufreq policy, dbs_update() derives the load used for the
> frequency decision from the maximum load among its CPUs, but it may
> also record deferred idle periods accumulated by an idle CPU in the
> policy.
>
> Consequently, a single update can contain both a high decision load
> from one CPU and multiple deferred idle periods from another CPU. The
> conservative governor applies the deferred down steps before evaluating
> the decision load. If that load subsequently triggers an up step, the
> deferred down steps can outweigh the single up step and produce a net
> frequency reduction.
>
> This was observed on a policy shared by CPUs 2 and 3. A CPU-bound
> SCHED_EXT task kept CPU 2 fully utilized while CPU 3 remained idle.
> On this system, SCHED_EXT generated update-util callbacks less
> frequently than CFS, resulting in sparse DBS updates such as:
>
>  load=3D100 idle_periods=3D7 interval=3D59 ms
>  load=3D100 idle_periods=3D4 interval=3D39 ms
>  load=3D100 idle_periods=3D2 interval=3D19 ms
>  load=3D100 idle_periods=3D7 interval=3D59 ms
>
> With the default 5% frequency step and a 2.6 GHz policy maximum, seven
> deferred periods reduce the requested frequency by seven 130 MHz steps
> before the high decision load adds only one step. Repeated updates
> therefore keep the policy near 530 MHz even though CPU 2 is fully
> utilized.
>
> There are two load values relevant to this behavior:
>
>   * sample_load is calculated from the busy and elapsed time of the
>     current sample.
>
>   * decision_load is returned by dbs_update() for the governor's
>     frequency decision. After a long idle interval, it may reuse
>     prev_load to improve the response to a waking task and can therefore
>     differ from sample_load.
>
> The problem is that idle_periods is derived from accumulated idle time
> and is applied independently of whether the current sample load is in
> the conservative governor's downscaling region. A high sample load and
> multiple deferred idle periods can therefore coexist, particularly
> when updates are sparse.
>
> As suggested by Zhongqiu Han, calculate the sample load separately from
> the decision load. If no time has elapsed, use prev_load for the sample
> load as the existing load calculation does, since no load can be
> calculated for that interval.
>
> Record the maximum sample load for the policy and apply deferred down
> steps only when it is below down_threshold. This makes deferred
> downscaling follow the same threshold that the conservative governor
> normally uses to determine whether the policy load is low enough to
> reduce the frequency.
>
> The existing code applies deferred down steps whenever idle_periods is
> valid, regardless of the sample load. When the decision load is in the
> hold region, the locally adjusted frequency is not submitted unless
> another frequency-update branch is taken. Thus, when the sample and
> decision loads are the same and both are in the hold region, this
> change does not alter the requested frequency.
>
> The difference becomes visible when the decision load causes a
> frequency update. In particular, if it exceeds up_threshold, the
> governor applies a single up step after the deferred down steps and
> submits the resulting request. Multiple deferred down steps can then
> outweigh that up step and cause a frequency reduction even when the
> sample load is above down_threshold.
>
> With this change, deferred down steps are skipped whenever the maximum
> sample load is at or above down_threshold, keeping deferred downscaling
> consistent with the conservative governor's threshold semantics. The
> requested frequency may therefore be higher than with the existing
> behavior when deferred idle periods are present and the decision load
> causes a frequency update. This is intentional, because the lower
> request previously resulted from applying deferred downscaling while
> the sampled policy load was outside the governor's downscaling region.
> Accelerated deferred downscaling remains available when the policy
> sample load is below down_threshold, including after a workload has
> completed and the policy has become idle.
>
> Cc: stable@vger.kernel.org
> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster fo=
r deferred updates")
> Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>

Applied as 7.4 material, thanks!

> ---
> Changes in v2:
>
> - Calculate the sample load separately from the decision load that may
>   reuse prev_load after a long idle interval, as suggested by Zhongqiu Ha=
n.
> - Preserve the existing prev_load fallback when time_elapsed is zero.
> - Gate deferred down steps on down_threshold.
> - Link to v1: https://lore.kernel.org/all/2026090215474182681fN7LLOSpqIc3=
s3OqJaW@zte.com.cn/
>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |  8 ++++---
>  drivers/cpufreq/cpufreq_governor.c     | 29 +++++++++++++++++++-------
>  drivers/cpufreq/cpufreq_governor.h     |  2 ++
>  3 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpu=
freq_conservative.c
> index 0b32ae28ec85..02bfd46543e9 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -85,10 +85,12 @@ static unsigned int cs_dbs_update(struct cpufreq_poli=
cy *policy)
>         freq_step =3D get_freq_step(cs_tuners, policy);
>
>         /*
> -        * Decrease requested_freq one freq_step for each idle period tha=
t
> -        * we didn't update the frequency.
> +        * Apply deferred down steps only when the policy sample load is
> +        * below down_threshold. Otherwise, multiple deferred down steps =
may
> +        * cause a net frequency decrease outside the downscaling region.
>          */
> -       if (policy_dbs->idle_periods < UINT_MAX) {
> +       if (policy_dbs->max_sample_load < cs_tuners->down_threshold &&
> +           policy_dbs->idle_periods < UINT_MAX) {
>                 unsigned int freq_steps =3D policy_dbs->idle_periods * fr=
eq_step;
>
>                 if (requested_freq > policy->min + freq_steps)
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index 710d93ec89b5..f3bd3dbe7c41 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -124,7 +124,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy=
)
>         struct policy_dbs_info *policy_dbs =3D policy->governor_data;
>         struct dbs_data *dbs_data =3D policy_dbs->dbs_data;
>         unsigned int ignore_nice =3D dbs_data->ignore_nice_load;
> -       unsigned int max_load =3D 0, idle_periods =3D UINT_MAX;
> +       unsigned int max_load =3D 0, max_sample_load =3D 0;
> +       unsigned int idle_periods =3D UINT_MAX;
>         unsigned int sampling_rate, io_busy, j;
>         u64 cur_nice;
>
> @@ -147,7 +148,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy=
)
>                 struct cpu_dbs_info *j_cdbs =3D &per_cpu(cpu_dbs, j);
>                 u64 update_time, cur_idle_time;
>                 unsigned int idle_time, time_elapsed;
> -               unsigned int load;
> +               unsigned int load, sample_load;
>
>                 cur_idle_time =3D get_cpu_idle_time(j, &update_time, io_b=
usy);
>
> @@ -186,6 +187,20 @@ unsigned int dbs_update(struct cpufreq_policy *polic=
y)
>
>                 j_cdbs->prev_cpu_nice =3D cur_nice;
>
> +               /*
> +                * Compute the sample load separately from the prev_load =
value
> +                * that may be reused after a long idle interval. The con=
servative
> +                * governor uses it to decide whether to apply deferred d=
own steps.
> +                * If no time has elapsed, retain the existing behavior a=
nd use
> +                * prev_load.
> +                */
> +               if (unlikely(!time_elapsed))
> +                       sample_load =3D j_cdbs->prev_load;
> +               else if (time_elapsed > idle_time)
> +                       sample_load =3D 100 * (time_elapsed - idle_time) =
/ time_elapsed;
> +               else
> +                       sample_load =3D 0;
> +
>                 if (unlikely(!time_elapsed)) {
>                         /*
>                          * That can only happen when this function is cal=
led
> @@ -220,11 +235,7 @@ unsigned int dbs_update(struct cpufreq_policy *polic=
y)
>                         load =3D j_cdbs->prev_load;
>                         j_cdbs->prev_load =3D 0;
>                 } else {
> -                       if (time_elapsed > idle_time)
> -                               load =3D 100 * (time_elapsed - idle_time)=
 / time_elapsed;
> -                       else
> -                               load =3D 0;
> -
> +                       load =3D sample_load;
>                         j_cdbs->prev_load =3D load;
>                 }
>
> @@ -237,9 +248,13 @@ unsigned int dbs_update(struct cpufreq_policy *polic=
y)
>
>                 if (load > max_load)
>                         max_load =3D load;
> +
> +               if (sample_load > max_sample_load)
> +                       max_sample_load =3D sample_load;
>         }
>
>         policy_dbs->idle_periods =3D idle_periods;
> +       policy_dbs->max_sample_load =3D max_sample_load;
>
>         return max_load;
>  }
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq=
_governor.h
> index 73b8ed7cfaae..806d8fb4dff1 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -95,6 +95,8 @@ struct policy_dbs_info {
>         /* Multiplier for increasing sample delay temporarily. */
>         unsigned int rate_mult;
>         unsigned int idle_periods;      /* For conservative */
> +       /* Maximum load from the current policy sample. */
> +       unsigned int max_sample_load;
>         /* Status indicators */
>         bool is_shared;         /* This object is used by multiple CPUs *=
/
>         bool work_in_progress;  /* Work is being queued up or in progress=
 */
> --
> 2.25.1
>
