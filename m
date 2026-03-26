Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A493BFE4D
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520655; cv=none; b=TZhc9W0C/+5W/PNe1PUMFJRBSRAREtVEBWFtTXchklS0UKXpefujgGQpaWIZiaFG3rzomkasETNXvbKzmVrEJpnDqC7lKOkeeX/8MdRRzFO2Y4moC1/j1xLjQKug8J0rVwzQ/+JGQNd2f9nIBdJmeXr6Z+w2NXQaaFb7Kh8uH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520655; c=relaxed/simple;
	bh=8z9kuFohHFAEDa+n13oQhOek4ZBpOYRRIr229FgbWHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV/aTgP4W8lGAhhxmO21ev3ogU5FjZJnMhBuB1/PXpWfCwY6yDzr5IvPjqQTBn/BxZ7MF9ed0KdMBShPFttpFZeJvNObTOpw5Dpmc3RdC+c7VU05CaWjohAqMrUJuHS+uUOzgdbN9Bl/uje/1AXaUQAO0pvy8R/VXDlwR05MjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2+2dj+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2+2dj+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17FFC4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774520654;
	bh=8z9kuFohHFAEDa+n13oQhOek4ZBpOYRRIr229FgbWHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2+2dj+0q0hQLPRMMCaGYy+F2mUnFcMtfymh/Jfge6lcuCM53B3nD5ZNUIm57FdDa
	 n9pvB4PH2uS6SZMogDMMS0JLYSKCoXHa6M0dQg8wtYaohBidhpUgoaG1r83Tt6fZpp
	 nU2qNVRvSSAnKBvBUh1svpRJK34H6WIZhwbF/VIrQzwSUnb5wREEVOBOjlQ+vlM3mi
	 rrHjMu9vrZxFF7JnUj/GR1NB9vHpUcNTG5NnfxfcPMM6HOSKQNQ+WYb8BHanjEiF7I
	 KTcDkUfWT0+80NiXzWkjnSbKBZ1nnKz9fVL68+te/H0dq9cvIG7VY7/OmfwfeMVjTM
	 vxux6vHvGYShg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f387a688dso683177fac.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 03:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU40quSBkVm0H/rH71fsMzcpy2pH93PZ2ALR+bSBf5Pa8aJ17Rj3I6n75fH7vdtthG0kDxebm75yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLG3KpuTN3RN/+54rcP55HyJIriOSMjvwDZPvvJvTQ8XSXSaFX
	fae7i/EygowzEqmcB18tnateLwl5I8w80/WOlZVgtyjoAVUVqiaLKll9d+7vzdu81CsKRUKA2MA
	3mjoC0DaewBL83PkYJeKHsL1NQ0SNKas=
X-Received: by 2002:a05:6870:612a:b0:409:54ac:12ae with SMTP id
 586e51a60fabf-41ca6d77a2emr3980285fac.8.1774520653834; Thu, 26 Mar 2026
 03:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org> <20260323160052.17528-7-vineeth@bitbyteword.org>
In-Reply-To: <20260323160052.17528-7-vineeth@bitbyteword.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 11:24:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gkDLLgom1QmAGJ=7UgOt2Dg2sLBtTvU4MExtm31fd6dw@mail.gmail.com>
X-Gm-Features: AQROBzCJWDEQWM3cP1V3UK44WrPSHg8H9ezEhWFsIFWxE8oG7Mtz9hjw6hhoxOA
Message-ID: <CAJZ5v0gkDLLgom1QmAGJ=7UgOt2Dg2sLBtTvU4MExtm31fd6dw@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] cpufreq: Use trace_call__##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 5:01=E2=80=AFPM Vineeth Pillai (Google)
<vineeth@bitbyteword.org> wrote:
>
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq core
& intel_pstate

> ---
>  drivers/cpufreq/amd-pstate.c   | 10 +++++-----
>  drivers/cpufreq/cpufreq.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..4c47324aa2f73 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *pol=
icy, u8 min_perf,
>         if (trace_amd_pstate_epp_perf_enabled()) {
>                 union perf_cached perf =3D READ_ONCE(cpudata->perf);
>
> -               trace_amd_pstate_epp_perf(cpudata->cpu,
> +               trace_call__amd_pstate_epp_perf(cpudata->cpu,
>                                           perf.highest_perf,
>                                           epp,
>                                           min_perf,
> @@ -298,7 +298,7 @@ static int msr_set_epp(struct cpufreq_policy *policy,=
 u8 epp)
>         if (trace_amd_pstate_epp_perf_enabled()) {
>                 union perf_cached perf =3D cpudata->perf;
>
> -               trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf=
,
> +               trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highes=
t_perf,
>                                           epp,
>                                           FIELD_GET(AMD_CPPC_MIN_PERF_MAS=
K,
>                                                     cpudata->cppc_req_cac=
hed),
> @@ -343,7 +343,7 @@ static int shmem_set_epp(struct cpufreq_policy *polic=
y, u8 epp)
>         if (trace_amd_pstate_epp_perf_enabled()) {
>                 union perf_cached perf =3D cpudata->perf;
>
> -               trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf=
,
> +               trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highes=
t_perf,
>                                           epp,
>                                           FIELD_GET(AMD_CPPC_MIN_PERF_MAS=
K,
>                                                     cpudata->cppc_req_cac=
hed),
> @@ -507,7 +507,7 @@ static int shmem_update_perf(struct cpufreq_policy *p=
olicy, u8 min_perf,
>         if (trace_amd_pstate_epp_perf_enabled()) {
>                 union perf_cached perf =3D READ_ONCE(cpudata->perf);
>
> -               trace_amd_pstate_epp_perf(cpudata->cpu,
> +               trace_call__amd_pstate_epp_perf(cpudata->cpu,
>                                           perf.highest_perf,
>                                           epp,
>                                           min_perf,
> @@ -588,7 +588,7 @@ static void amd_pstate_update(struct amd_cpudata *cpu=
data, u8 min_perf,
>         }
>
>         if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)=
) {
> -               trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpuda=
ta->freq,
> +               trace_call__amd_pstate_perf(min_perf, des_perf, max_perf,=
 cpudata->freq,
>                         cpudata->cur.mperf, cpudata->cur.aperf, cpudata->=
cur.tsc,
>                                 cpudata->cpu, fast_switch);
>         }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913c..58901047eae5a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpuf=
req_policy *policy,
>
>         if (trace_cpu_frequency_enabled()) {
>                 for_each_cpu(cpu, policy->cpus)
> -                       trace_cpu_frequency(freq, cpu);
> +                       trace_call__cpu_frequency(freq, cpu);
>         }
>
>         return freq;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 11c58af419006..70be952209144 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu=
, unsigned int trace_type, in
>                 return;
>
>         sample =3D &cpu->sample;
> -       trace_pstate_sample(trace_type,
> +       trace_call__pstate_sample(trace_type,
>                 0,
>                 old_pstate,
>                 cpu->pstate.current_pstate,
> --
> 2.53.0
>
