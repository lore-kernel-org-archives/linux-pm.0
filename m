Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2838655A
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004317; cv=none; b=u9xPhZrsflnpdtTbLzxMukETRfiGmRdRVFxu7wuZL19ocKAoxqR1mbCeG3U6Zs2EkPM5YQF89eE64ezrwqTr4yS94yn8S6ilInXItZXgdUEUKyV/8SGSv1JvH69ajL16/gT/oSWaivPa2BwhqRo45SSfo2D4O36Dz6Aq2iEY3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004317; c=relaxed/simple;
	bh=A7AZH8u6xZfVyivgyLoGB9MIP8KEZWlP5cCLbGiuRTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQnew40NM497U1CUHaykoWN1ndXz/yLDM6HpTsOdv9Wj0+Kdh9aHk+I3zCmCxhUTcQOtVH31CE2iMRdYbqH/VQbb1nvwo9F+A4/J3lNXouTPNdvvt9EzVva7j1R1JQsbtte85kUZdZb55NwV8cYbdZN9sXUlJUusgoctWpplXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eubdz39G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eubdz39G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A471F000C6
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004315;
	bh=anX1IJWSMuicvC/rJP/1rz/QekscKlLJOjsgMgqa9ew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eubdz39GTNqLVv0zV0BXTHWtgLzfwoFx/qMpQPMdAI9Tq4GR/HOj8FPkmGgExWKzf
	 5J0HcUcaKUcJ6V61guh9zsdP9Fjrxd0D6tp+Yz/WHvIg4XojhTvvW7hJQpMxGtbQMz
	 OQmkOQiPkoK1VgMzMgAMNgwZOoVWpMFiQc5BkBuGimjjKH3C7AzikHW9tnK5OwaTNP
	 3x9f+xmmaTShWbRatNZr/2f+aHv2Q9thjENxkZLRcaj8+2/zEx+nPMBiKE522GP9lL
	 RpKvt366q9Rcd8x2rttcw+633YpfcbnYpiA+rvN7mh2k3znxV/ujvOr6Li/mM7eC6c
	 zeNB/cqsoHDFQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb3726952so625210e87.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 11:58:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwOowSa7QY1rt1/Z38HWW2+7W2N5pYBQpD/DSY7ig2das2s1aeXjcuPFYvPUYQHLzz4KuE6sos6sw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLm6h8yjtYI2mqYQo2gjKgWhKT/xcRSnaAe1hIh3dzSIHmO444W
	i0gYtICDhAsrwkzETxpFbfuUkyJXKyw6BANG9IgNOjEXsuPW8D+DhA1FBIFD6H20sDQ048H6Wkr
	wZjmRVFLvuVWdwfHIVKXelxRdemtVQJk=
X-Received: by 2002:a05:6512:15a6:b0:5b8:998c:e94 with SMTP id
 2adb3069b0e04-5bcde8bde34mr6055261e87.46.1792004314035; Wed, 14 Oct 2026
 11:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013034235.2678177-1-sh_def@163.com>
In-Reply-To: <20261013034235.2678177-1-sh_def@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 20:56:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1vmjdVBs6A0AEzcfNJb-uX7uvxQgRb6ieGzA6e3HKKA@mail.gmail.com>
X-Gm-Features: AclHuK8u086bxt4j6UkoVHFuzpBnPTF_NmYyDk0WzxL-5pthywQOy01h_uva0fI
Message-ID: <CAJZ5v0g1vmjdVBs6A0AEzcfNJb-uX7uvxQgRb6ieGzA6e3HKKA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: schedutil: Serialize start against rate limit updates
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

On Tue, Oct 13, 2026 at 5:43=E2=80=AFAM Hui Su <sh_def@163.com> wrote:
>
> rate_limit_us_store() updates the tunable and freq_update_delay_ns under
> update_lock, but sugov_start() reads the tunable without it. Startup can
> therefore overwrite the new delay with one based on a stale value.
>
> Serialize the startup update with sysfs stores by taking update_lock in a
> schedutil-local wrapper.
>
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler=
 utilization data")
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
> Changes in v3:
> - Use a schedutil-local scoped wrapper and clarify the locking comment.
>
> v2: https://lore.kernel.org/lkml/20261007155820.3194105-1-sh_def@163.com/
> ---
>  kernel/sched/cpufreq_schedutil.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 49ccd6f1c185..1d0878dad4b0 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -73,6 +73,16 @@ static void sugov_update_rate_limit_us(struct sugov_po=
licy *sg_policy)
>                 (s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>  }
>
> +static void sugov_update_rate_limit_us_sync(struct sugov_policy *sg_poli=
cy)
> +{
> +       /*
> +        * Serialize with rate_limit_us_store() to prevent this path from
> +        * overwriting the new delay with one based on an old tunable val=
ue.
> +        */
> +       guard(mutex)(&sg_policy->tunables->attr_set.update_lock);
> +       sugov_update_rate_limit_us(sg_policy);
> +}
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64=
 time)
>  {
>         s64 delta_ns;
> @@ -861,7 +871,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int =
flags);
>         unsigned int cpu;
>
> -       sugov_update_rate_limit_us(sg_policy);
> +       sugov_update_rate_limit_us_sync(sg_policy);
>         sg_policy->last_freq_update_time        =3D 0;
>         sg_policy->next_freq                    =3D 0;
>         sg_policy->work_in_progress             =3D false;
>

Applied as 7.4 material, thanks!
