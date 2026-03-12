Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E593C6604
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341900; cv=none; b=KUhiqzJslX768nK1BU0YtQ0WKWY/43F0cAJmsiVllB9FWDPUPmsQ4DNYFxXK55YouVkIxG9CP0GAeoAXIlqCuZZfb1BcDwYpzo5GMAcSOHduOtl/TFzC2oZ1KJ9lfH3B/wBMecDYYCWq3EN5xoVBMKycxKLhWUjalqHyzyUKkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341900; c=relaxed/simple;
	bh=Q8IVoWCsmkWJyLd6RKA73QX4Rhsp3c6MdOvH0moGQ6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7XItcLXHT11HQST9AqgQe/eZtpN/aKpL3wGoAqx5mdAEC5hFAHl5JeARWN2o/mGEgjyDAvN7Gd+vCnt/S6mSPwel2njGRO+x6gEIrmIEyqrgFIK8n7GZc8YoijrMSLfI97Rtp2KqISFTBBkK01T4by6Ellta3sKJPlo8/QRY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCtJUBxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCtJUBxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6FBC2BCB2
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773341900;
	bh=Q8IVoWCsmkWJyLd6RKA73QX4Rhsp3c6MdOvH0moGQ6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sCtJUBxb3+9J3t9Iw+kTliggxtN54o/pmpFjUJlz5sLvROyyLvn2gtjXbisUKKmn4
	 JdBvt2hswsaROuBh9bXye6cakfOIF/hr2NJJSiiAPKDzWX4pD67FJcXMk8b2+Nvad0
	 NhubGvPxWuBGePduwZjC8VruXOXfbQtM60kD0qHLJQoRo2GDUdttBJKF1LXgYNHzD1
	 zkqsIQMqBW0aN2hP5L4NO9iaX48RlGjmr8ZjJRmjBaZd/s2Gzi/ofgIsSjH6kYGKI4
	 TvRhVfDoCIbM8VRM1l7h601LP5MbHlSWk99Ug/bCbhLUVT60MmWWV3iaEnwcWx3UiG
	 kkufejGrRoE6Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-679f6ee3fb0so625069eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 11:58:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFEvy9Q96bIYaWYGzjmZW9FsR7ObGdoLGeTj5c2UeDhDIiFR5clxMshyOuM4GX8JKNTeUZgMDU/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3NXVsrg93bp3+g2tCBD+7AWKSHsJp/OUGIEkhWQm20+XYr0Z
	VYfPSmBxAhs1s0eYfq3Ta8kCRSuX1CTWSGJoLbj9PmJXNbMOrL+JSykQ6JisbAYucAHx/mxL6Up
	FO2vckD/KuygD88T1SLc76h2kO1tzANg=
X-Received: by 2002:a05:6820:2b12:b0:67b:db23:4f73 with SMTP id
 006d021491bc7-67bdb234fdemr109330eaf.51.1773341899301; Thu, 12 Mar 2026
 11:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org> <20260312150523.2054552-7-vineeth@bitbyteword.org>
In-Reply-To: <20260312150523.2054552-7-vineeth@bitbyteword.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 19:58:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0huw1TabNsO30RRWMez1XM1NGXQ_zRhXV_psSWS+s2rRQ@mail.gmail.com>
X-Gm-Features: AaiRm53ivx2mW0g_aq6AqhGUYmn4K1fNwjagiHIJ_z30Df6_oL0YOub2aqsehFw
Message-ID: <CAJZ5v0huw1TabNsO30RRWMez1XM1NGXQ_zRhXV_psSWS+s2rRQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] cpufreq: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: vineeth@bitbyteword.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:05=E2=80=AFPM Vineeth Pillai (Google)
<vineeth@bitbyteword.org> wrote:
>
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

> ---
>  drivers/cpufreq/amd-pstate.c   | 10 +++++-----
>  drivers/cpufreq/cpufreq.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..3fa40a32ef6b5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *pol=
icy, u8 min_perf,
>         if (trace_amd_pstate_epp_perf_enabled()) {
>                 union perf_cached perf =3D READ_ONCE(cpudata->perf);
>
> -               trace_amd_pstate_epp_perf(cpudata->cpu,
> +               trace_invoke_amd_pstate_epp_perf(cpudata->cpu,
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
> +               trace_invoke_amd_pstate_epp_perf(cpudata->cpu, perf.highe=
st_perf,
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
> +               trace_invoke_amd_pstate_epp_perf(cpudata->cpu, perf.highe=
st_perf,
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
> +               trace_invoke_amd_pstate_epp_perf(cpudata->cpu,
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
> +               trace_invoke_amd_pstate_perf(min_perf, des_perf, max_perf=
, cpudata->freq,
>                         cpudata->cur.mperf, cpudata->cur.aperf, cpudata->=
cur.tsc,
>                                 cpudata->cpu, fast_switch);
>         }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913c..cf57aeb503790 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpuf=
req_policy *policy,
>
>         if (trace_cpu_frequency_enabled()) {
>                 for_each_cpu(cpu, policy->cpus)
> -                       trace_cpu_frequency(freq, cpu);
> +                       trace_invoke_cpu_frequency(freq, cpu);
>         }
>
>         return freq;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 11c58af419006..a0da9b31c4ffe 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu=
, unsigned int trace_type, in
>                 return;
>
>         sample =3D &cpu->sample;
> -       trace_pstate_sample(trace_type,
> +       trace_invoke_pstate_sample(trace_type,
>                 0,
>                 old_pstate,
>                 cpu->pstate.current_pstate,
> --
> 2.53.0
>
