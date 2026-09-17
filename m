Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D44E73A9
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666807; cv=none; b=UuKgwVx8cf10BBVw3+E/iSPRUGKeN8RnamaHLlFlpJUCOzYXGD8bIjr7N5SwFteDGxW1RDVocgmFrFbHuIuOFbhzgVKOJdoD6jrjFYU0dD0yhrDjra18NELUpbILPnd1voXX7Z88P64erXaUBl4+mSsYq61+L2XOa0mcTbZJMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666807; c=relaxed/simple;
	bh=blW9R+7vnIrek2uF+WxAEIXKnkjIklh0LLDGEqIl4mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1PAXldl7o6Rdw0+ZU+f6DMzNpgpG2zEAHsiM4bqdfi65ysASCHlIKUEfiFJ2XkDa5aiOe9qvL2tIqQdRjbnCph/6wqBB17fZjo0uZgbkp6NiDuxb4iqNoWqfJkse30CsZPn+UXCOFIPUeyreGiOeorQ589LUWRGS3Hq3+MSXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU5zy7Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU5zy7Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B21F00898
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666805;
	bh=PbJ/Kc47hAhrgRgg4YeuzXPd4EE0XeBlUFiD6KaVUt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BU5zy7SvjK+JukLqns0JVMU3MoRZxb6Nz+ZClUpS7vt8ps6/O+RzUzJS8CLMmIwfZ
	 uT6LLY4PMhLU9+HO+aG8EWkSIhopmjSjsgn3T9J1+EISKBcs8o0fVMEg0VfozR8fK5
	 AkD/XHah+lcYgxIM9gfms/8eKu8CYtWf1BApDEtSOcOMpy1LlaOKeS/GdmDiqAu4Sx
	 WXXiHnhd0CuOvLhV8zLmo95J7aoSn/NCYps2N82sWmgzBIM4NrNdaI4e5pQXexww20
	 3WhTOXOZc+e1n27fNQzWAd1deSIqpQ3gyYwtcLONu/MlNDDCXadz3TKgmK36CiQk2R
	 GaVnxFUvjeKnQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso11201711fa.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 10:40:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDOQ5KqLeoCKELslEx9kBpSTwkDznFlldmW08Gku4AkPNUCR5WAsRNZ7OS0y97IAPftFmphpGlzA==@vger.kernel.org
X-Gm-Message-State: AFuF++kAHXeHeJh9NKWfmYaOsB93nCsaRc0M0FWOFi8aSdxas5k8wI8x
	LkObw+GTZb+Vix4Zfp04D6Jbpk5VToDJW0h32v8Lig+MYzqnz7eX0CIbMckKtMQXz3oO8QQgrU+
	/cxoHINq9/HbS3NWMLW6IvGfNZK0hDJQ=
X-Received: by 2002:a05:651c:1503:b0:3a4:99ed:beac with SMTP id
 38308e7fff4ca-3a5dc9b2ffemr20454221fa.4.1789666803984; Thu, 17 Sep 2026
 10:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
In-Reply-To: <20260915065747.1671965-1-wujianyong@hygon.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 19:38:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
X-Gm-Features: AcwNN1VTmLCPhyZPJ_sS60J0ZwVtuPaN4TtZiM2tsLLytdZtRJKbc8A5ZDcur58
Message-ID: <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure calculation
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: viresh.kumar@linaro.org, kprateek.nayak@amd.com, 
	vincent.guittot@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ray.huang@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	pierre.gondois@arm.com, sumitg@nvidia.com, 
	srinivas.pandruvada@linux.intel.com, hongyan.xia@transsion.com, 
	zhongqiu.han@oss.qualcomm.com, jianyong.wu@outlook.com, wangfengyu@hygon.cn, 
	zhongyuan@hygon.cn, huangsj@hygon.cn, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:03=E2=80=AFAM Jianyong Wu <wujianyong@hygon.cn> w=
rote:
>
> Commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
> back to cpuinfo.max_freq") introduced cpuinfo.max_freq as the reference
> frequency for cpufreq pressure when arch_scale_freq_ref() returns zero.
>
> However, cpuinfo.max_freq may include boost frequencies and therefore
> does not necessarily represent the maximum sustainable frequency.

And then it really matters what is sustainable and for how long.

> On some systems using acpi-cpufreq, cpuinfo.max_freq includes boost while
> the frequency table only contains non-boost frequencies.

In which case selecting freq_table[0] may give the processor a license
to go to the turbo (or boost) frequency range.

> Consequently, cpufreq pressure remains nonzero even without an additional
> frequency limit.

So when and where does this matter?

> Furthermore, drivers may update cpuinfo.max_freq when boost is enabled
> or disabled. With a fixed policy limit below the maximum non-boost
> frequency, this changes the pressure reference and hence the reported
> pressure, although the non-boost frequency limit remains unchanged.

If the capacity is updated though along with the cpuinfo.max_freq
change, then this is all fine because the pressure is then computed
relative to the new capacity.  intel_pstate does that.

> Add max_sustainable_freq to struct cpufreq_cpuinfo to provide a reference
> frequency excluding boost. Populate it from the nominal frequency in
> amd-pstate and cppc_cpufreq, the maximum non-turbo frequency in
> intel_pstate, and the highest frequency-table entry in acpi-cpufreq.
>
> Use this value when arch_scale_freq_ref() returns zero. Preserve the
> existing cpuinfo.max_freq fallback for drivers that leave the new field
> at zero.
>
> Tested with acpi-cpufreq, intel_pstate, and amd-pstate in active and
> passive modes. With no additional frequency limit, pressure is zero.
> With a fixed limit below the non-boost reference frequency, pressure
> remains unchanged across boost transitions.

Which may not be what is intended.

> Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back t=
o cpuinfo.max_freq")
> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> ---
> The earlier fix was incorrect and has been abandoned. This patch takes
> a different approach.
>
> Previous discussion: https://lore.kernel.org/all/SI2PR04MB4931A8BA0EF213B=
0238BD9E4E3BD2@SI2PR04MB4931.apcprd04.prod.outlook.com/
>
>  drivers/cpufreq/acpi-cpufreq.c | 3 +++
>  drivers/cpufreq/amd-pstate.c   | 2 ++
>  drivers/cpufreq/cppc_cpufreq.c | 3 ++-
>  drivers/cpufreq/cpufreq.c      | 4 +++-
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  include/linux/cpufreq.h        | 2 ++
>  6 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 21639d9ac753..e7b22456ebb8 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -856,6 +856,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>         }
>         freq_table[valid_states].frequency =3D CPUFREQ_TABLE_END;
>
> +       /* Init max sustainable cpu frequency */
> +       policy->cpuinfo.max_sustainable_freq =3D freq_table[0].frequency;
> +
>         max_boost_ratio =3D get_max_boost_ratio(cpu, &nominal_freq);
>         if (max_boost_ratio) {
>                 unsigned int freq =3D nominal_freq;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3a6b4b224a66..6fc28bb1499b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1085,6 +1085,7 @@ static int amd_pstate_cpu_init(struct cpufreq_polic=
y *policy)
>                                                 perf.lowest_perf);
>         policy->cpuinfo.max_freq =3D cpudata->max_freq;
>
> +       policy->cpuinfo.max_sustainable_freq =3D cpudata->nominal_freq;
>         policy->driver_data =3D cpudata;
>         ret =3D amd_pstate_cppc_enable(policy);
>         if (ret)
> @@ -1912,6 +1913,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_p=
olicy *policy)
>         policy->cpuinfo.min_freq =3D perf_to_freq(perf, cpudata->nominal_=
freq,
>                                                 perf.lowest_perf);
>         policy->cpuinfo.max_freq =3D cpudata->max_freq;
> +       policy->cpuinfo.max_sustainable_freq =3D cpudata->nominal_freq;
>         policy->driver_data =3D cpudata;
>
>         ret =3D amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 6fe0e972952a..f803fcdca483 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -682,7 +682,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>         policy->cpuinfo.min_freq =3D cppc_perf_to_khz(caps, caps->lowest_=
perf);
>         policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, policy->boost=
_enabled ?
>                                                     caps->highest_perf : =
caps->nominal_perf);
> -
> +       policy->cpuinfo.max_sustainable_freq =3D
> +               cppc_perf_to_khz(caps, caps->nominal_perf);
>         policy->transition_delay_us =3D cppc_cpufreq_get_transition_delay=
_us(cpu);
>         policy->shared_type =3D cpu_data->shared_type;
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b898b6544069..c1d54a22265d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2587,7 +2587,9 @@ static void cpufreq_update_pressure(struct cpufreq_=
policy *policy)
>         cpu =3D cpumask_first(policy->related_cpus);
>         max_freq =3D arch_scale_freq_ref(cpu);
>         if (!max_freq)
> -               max_freq =3D policy->cpuinfo.max_freq;
> +               max_freq =3D policy->cpuinfo.max_sustainable_freq ?
> +                                policy->cpuinfo.max_sustainable_freq :
> +                                policy->cpuinfo.max_freq;
>
>         capped_freq =3D policy->max;
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 6e984c114d96..daef7e99fead 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1474,6 +1474,7 @@ static void __intel_pstate_update_max_freq(struct c=
pufreq_policy *policy,
>
>         policy->cpuinfo.max_freq =3D READ_ONCE(global.no_turbo) ?
>                         cpudata->pstate.max_freq : cpudata->pstate.turbo_=
freq;
> +       policy->cpuinfo.max_sustainable_freq =3D cpudata->pstate.max_freq=
;
>
>         refresh_frequency_limits(policy);
>  }
> @@ -3052,6 +3053,7 @@ static int __intel_pstate_cpu_init(struct cpufreq_p=
olicy *policy)
>         policy->cpuinfo.min_freq =3D cpu->pstate.min_freq;
>         policy->cpuinfo.max_freq =3D READ_ONCE(global.no_turbo) ?
>                         cpu->pstate.max_freq : cpu->pstate.turbo_freq;
> +       policy->cpuinfo.max_sustainable_freq =3D cpu->pstate.max_freq;
>
>         intel_pstate_init_acpi_perf_limits(policy);
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ae9d1ce4f49c..aa3f60a167be 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -45,6 +45,8 @@ enum cpufreq_table_sorting {
>  struct cpufreq_cpuinfo {
>         unsigned int            max_freq;
>         unsigned int            min_freq;
> +       /* Maximum sustainable frequency excluding boost, or 0 if unknown=
. */
> +       unsigned int            max_sustainable_freq;
>
>         /* in 10^(-9) s =3D nanoseconds */
>         unsigned int            transition_latency;
> --
> 2.34.1
>
>
