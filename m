Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E293E274D
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337346; cv=none; b=b1Rc1SGbaN8REA2g4lPP+XpvGKv4XQpRXgIGFrj79TfFEGok74SBNSu+WaDOzRZFSB4ERt0kkPWYuU4YjFDYUvWS6XlHSBeqxj9ZRvBVJgvDWp1fgWrm1K51bizGIRzASxsPWwAEshOoUELbnF4e4wiuoiAxchFGOLJmXZ8cKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337346; c=relaxed/simple;
	bh=xPkR0Crgc+DiudCNfhE4jEgQSZuUow+5dWREHAUDuos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4fyqhV0Bn006SMQReyrN+oBRVt0lsYw4/U4co9UaQOaj9XNUw3nc/bFHRtIzrSZToEQTYD7VSrPIem1qZBSaAA+H1yOubSGG6G1nJVGxq43Zcpvy8AMy7w3qDCVKuehodU1ieQQN1n89F1OrXhrzj/xPOB28q3ugO1Z50MMmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElQsIOSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElQsIOSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2051F0089F
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337345;
	bh=8a1T2nczzhAJXAnulpdxwQnDZVw6jQ0eNgXdqdJ2210=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ElQsIOSovb6sImfus40Yrz5Li8+DGLzEFKLlfhFLKd+8bfXliKY4xhB2jStMziayP
	 G0l14yWSFn9YwcBhzZDC+AILF2FNRyOsHMYJUKNuxRCfDfmUOm5TBbB0hytX7leVIA
	 InWwqihtzkV87I07zrTQ0fyPoxhfcKt2y4hDp8YHu2KSmb/xdtyUgfSocy7ymGg+xZ
	 W4g9hsYegXfnckj+uc1gROGu0BW2tw49Z97QcEq3K678x0xVlus+nBKMD47CTBbGe+
	 XngGrTm/uESEVTOlwImCR9IJFS10QB7LI6f1NRYNBrZmoCeubIN2mddR36DW3x4Iak
	 R4dlNyG8wZbcQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so1596348e87.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:09:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+rEK0fydKkS/y6zEcv8rTz7yOZio9hYmqA2d5Yxu+upJpTIGV+mQA8VWlFJujGy6JcyX1sPD4aIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGe8AeKJ21nj9gFvUapdJVpR5ZA1+p5AkDeIq23bHeQ+KR5nTz
	BZBqpvgCNmSRZGDllgJkbk5xJQWKi+JO5OPn3qG8DTb100iCLPZo53fg/p8p26PAXughWPQAotI
	xUT6QKRBTb/4xsesqgqGMucPSb0FqdAY=
X-Received: by 2002:a05:6512:3b97:b0:5aa:6e86:55e5 with SMTP id
 2adb3069b0e04-5aa6e865850mr1257448e87.13.1780337343486; Mon, 01 Jun 2026
 11:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528090913.2759118-1-pierre.gondois@arm.com> <20260528090913.2759118-4-pierre.gondois@arm.com>
In-Reply-To: <20260528090913.2759118-4-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 20:08:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwYcvYZJ1jCSo_5vpynOLBciW-4-KeracQTyUCw7fSGw@mail.gmail.com>
X-Gm-Features: AVHnY4JjEBXOjcgvXxMXg847AEXBp-yEE12VDaag-pa32OsmMQwWVJsebOubX9g
Message-ID: <CAJZ5v0hwYcvYZJ1jCSo_5vpynOLBciW-4-KeracQTyUCw7fSGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: Remove driver default policy->min/max init
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:10=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
> Prior to [1], drivers were setting policy->min/max and
> the value was used as a QoS constraint. After that change,
> the values were only temporarily used: cpufreq_set_policy()
> ultimately overriding them through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
>
> This patch reinstate the initial behaviour. This will allow
> drivers to request min/max QoS frequencies if desired.
> For instance, the cppc driver advertises a lowest non-linear
> frequency, which should be used as a min QoS value.
>
> To avoid having drivers setting policy->min/max to default
> values which are considered as QoS values (i.e. the reason
> why [1] was introduced), remove the initialization of
> policy->min/max in .init() callbacks wherever the
> policy->min/max values are identical to the
> policy->cpuinfo.min/max_freq.
>
> Indeed, the previous patch ("cpufreq: Set default
> policy->min/max values for all drivers") makes this initialization
> redundant.
>
> The only drivers where these values are different are:
> - gx-suspmod.c (min)
> - cppc-cpufreq.c (min)
> - longrun.c
>
> [1]
> commit 521223d8b3ec ("cpufreq: Fix initialization of min and
> max frequency QoS requests")
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Acked-by: Jie Zhan <zhanjie9@hisilicon.com>

sashiko.dev has some feedback on this patch and appears to have a point:

https://sashiko.dev/#/patchset/20260528090913.2759118-1-pierre.gondois%40ar=
m.com

Can you have a look at it please?

> ---
>  drivers/cpufreq/amd-pstate.c      | 14 ++++++--------
>  drivers/cpufreq/cppc_cpufreq.c    |  5 ++---
>  drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>  drivers/cpufreq/freq_table.c      |  7 +++----
>  drivers/cpufreq/gx-suspmod.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c    |  3 ---
>  drivers/cpufreq/pcc-cpufreq.c     | 10 ++++------
>  drivers/cpufreq/pxa3xx-cpufreq.c  |  5 ++---
>  drivers/cpufreq/sh-cpufreq.c      |  6 ++----
>  drivers/cpufreq/virtual-cpufreq.c |  5 +----
>  10 files changed, 23 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 62b5d995281d2..2f0bb732ea173 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1086,10 +1086,9 @@ static int amd_pstate_cpu_init(struct cpufreq_poli=
cy *policy)
>
>         perf =3D READ_ONCE(cpudata->perf);
>
> -       policy->cpuinfo.min_freq =3D policy->min =3D perf_to_freq(perf,
> -                                                             cpudata->no=
minal_freq,
> -                                                             perf.lowest=
_perf);
> -       policy->cpuinfo.max_freq =3D policy->max =3D cpudata->max_freq;
> +       policy->cpuinfo.min_freq =3D perf_to_freq(perf, cpudata->nominal_=
freq,
> +                                               perf.lowest_perf);
> +       policy->cpuinfo.max_freq =3D cpudata->max_freq;
>
>         policy->driver_data =3D cpudata;
>         ret =3D amd_pstate_cppc_enable(policy);
> @@ -1915,10 +1914,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_=
policy *policy)
>
>         perf =3D READ_ONCE(cpudata->perf);
>
> -       policy->cpuinfo.min_freq =3D policy->min =3D perf_to_freq(perf,
> -                                                             cpudata->no=
minal_freq,
> -                                                             perf.lowest=
_perf);
> -       policy->cpuinfo.max_freq =3D policy->max =3D cpudata->max_freq;
> +       policy->cpuinfo.min_freq =3D perf_to_freq(perf, cpudata->nominal_=
freq,
> +                                               perf.lowest_perf);
> +       policy->cpuinfo.max_freq =3D cpudata->max_freq;
>         policy->driver_data =3D cpudata;
>
>         ret =3D amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 7e7f9dfb7a24c..5abac50df7508 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -660,8 +660,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>          * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>          */
>         policy->min =3D cppc_perf_to_khz(caps, caps->lowest_nonlinear_per=
f);
> -       policy->max =3D cppc_perf_to_khz(caps, policy->boost_enabled ?
> -                                               caps->highest_perf : caps=
->nominal_perf);
>
>         /*
>          * Set cpuinfo.min_freq to Lowest to make the full range of perfo=
rmance
> @@ -669,7 +667,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>          * nonlinear perf
>          */
>         policy->cpuinfo.min_freq =3D cppc_perf_to_khz(caps, caps->lowest_=
perf);
> -       policy->cpuinfo.max_freq =3D policy->max;
> +       policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, policy->boost=
_enabled ?
> +                                                   caps->highest_perf : =
caps->nominal_perf);
>
>         policy->transition_delay_us =3D cppc_cpufreq_get_transition_delay=
_us(cpu);
>         policy->shared_type =3D cpu_data->shared_type;
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-=
nforce2.c
> index fbbbe501cf2dc..831102522ad64 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *po=
licy)
>                 min_fsb =3D NFORCE2_MIN_FSB;
>
>         /* cpuinfo and default policy values */
> -       policy->min =3D policy->cpuinfo.min_freq =3D min_fsb * fid * 100;
> -       policy->max =3D policy->cpuinfo.max_freq =3D max_fsb * fid * 100;
> +       policy->cpuinfo.min_freq =3D min_fsb * fid * 100;
> +       policy->cpuinfo.max_freq =3D max_fsb * fid * 100;
>
>         return 0;
>  }
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 5b364d8da4f92..ea994647abc88 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
>                         max_freq =3D freq;
>         }
>
> -       policy->min =3D policy->cpuinfo.min_freq =3D min_freq;
> -       policy->max =3D max_freq;
> +       policy->cpuinfo.min_freq =3D min_freq;
>         /*
>          * If the driver has set its own cpuinfo.max_freq above max_freq,=
 leave
>          * it as is.
>          */
>         if (policy->cpuinfo.max_freq < max_freq)
> -               policy->max =3D policy->cpuinfo.max_freq =3D max_freq;
> +               policy->cpuinfo.max_freq =3D max_freq;
>
> -       if (policy->min =3D=3D ~0)
> +       if (min_freq =3D=3D ~0)
>                 return -EINVAL;
>         else
>                 return 0;
> diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
> index d269a4f26f98e..d40c9e0bbb740 100644
> --- a/drivers/cpufreq/gx-suspmod.c
> +++ b/drivers/cpufreq/gx-suspmod.c
> @@ -421,7 +421,7 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy =
*policy)
>                 policy->min =3D maxfreq / max_duration;
>         else
>                 policy->min =3D maxfreq / POLICY_MIN_DIV;
> -       policy->max =3D maxfreq;
> +
>         policy->cpuinfo.min_freq =3D maxfreq / max_duration;
>         policy->cpuinfo.max_freq =3D maxfreq;
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1f093e3464301..dfc1e321f9e02 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3049,9 +3049,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_p=
olicy *policy)
>         policy->cpuinfo.max_freq =3D READ_ONCE(global.no_turbo) ?
>                         cpu->pstate.max_freq : cpu->pstate.turbo_freq;
>
> -       policy->min =3D policy->cpuinfo.min_freq;
> -       policy->max =3D policy->cpuinfo.max_freq;
> -
>         intel_pstate_init_acpi_perf_limits(policy);
>
>         policy->fast_switch_possible =3D true;
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.=
c
> index ac2e90a65f0c4..0f185a13577f8 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -551,13 +551,11 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>                 goto out;
>         }
>
> -       policy->max =3D policy->cpuinfo.max_freq =3D
> -               ioread32(&pcch_hdr->nominal) * 1000;
> -       policy->min =3D policy->cpuinfo.min_freq =3D
> -               ioread32(&pcch_hdr->minimum_frequency) * 1000;
> +       policy->cpuinfo.max_freq =3D ioread32(&pcch_hdr->nominal) * 1000;
> +       policy->cpuinfo.min_freq =3D ioread32(&pcch_hdr->minimum_frequenc=
y) * 1000;
>
> -       pr_debug("init: policy->max is %d, policy->min is %d\n",
> -               policy->max, policy->min);
> +       pr_debug("init: max_freq is %d, min_freq is %d\n",
> +                policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
>  out:
>         return result;
>  }
> diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cp=
ufreq.c
> index 50ff3b6a69000..06b27cbc59d6a 100644
> --- a/drivers/cpufreq/pxa3xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa3xx-cpufreq.c
> @@ -185,9 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy =
*policy)
>         int ret =3D -EINVAL;
>
>         /* set default policy and cpuinfo */
> -       policy->min =3D policy->cpuinfo.min_freq =3D 104000;
> -       policy->max =3D policy->cpuinfo.max_freq =3D
> -               (cpu_is_pxa320()) ? 806000 : 624000;
> +       policy->cpuinfo.min_freq =3D 104000;
> +       policy->cpuinfo.max_freq =3D (cpu_is_pxa320()) ? 806000 : 624000;
>         policy->cpuinfo.transition_latency =3D 1000; /* FIXME: 1 ms, assu=
med */
>
>         if (cpu_is_pxa300() || cpu_is_pxa310())
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 642ddb9ea217e..3c99d7009cbe2 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -124,10 +124,8 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy=
 *policy)
>                 dev_notice(dev, "no frequency table found, falling back "
>                            "to rate rounding.\n");
>
> -               policy->min =3D policy->cpuinfo.min_freq =3D
> -                       (clk_round_rate(cpuclk, 1) + 500) / 1000;
> -               policy->max =3D policy->cpuinfo.max_freq =3D
> -                       (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
> +               policy->cpuinfo.min_freq =3D (clk_round_rate(cpuclk, 1) +=
 500) / 1000;
> +               policy->cpuinfo.max_freq =3D (clk_round_rate(cpuclk, ~0UL=
) + 500) / 1000;
>         }
>
>         return 0;
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-=
cpufreq.c
> index 4159f31349b16..dc78b74409af4 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -164,10 +164,7 @@ static int virt_cpufreq_get_freq_info(struct cpufreq=
_policy *policy)
>                 policy->cpuinfo.min_freq =3D 1;
>                 policy->cpuinfo.max_freq =3D virt_cpufreq_get_perftbl_ent=
ry(policy->cpu, 0);
>
> -               policy->min =3D policy->cpuinfo.min_freq;
> -               policy->max =3D policy->cpuinfo.max_freq;
> -
> -               policy->cur =3D policy->max;
> +               policy->cur =3D policy->cpuinfo.max_freq;
>                 return 0;
>         }
>
> --
> 2.43.0
>
