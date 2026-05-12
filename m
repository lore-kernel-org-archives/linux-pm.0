Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93E395AE2
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581273; cv=none; b=JZ0JsRFa7lg79ziP/LZZgWyhem7HoqU981l/cfyevmTR19G4XuomcAfizjHLSFNmUvsYmM+Vb0IxuRqrgZNGwf9wZzwAAuFbhl1eVBYI0DDD+wjD6cFpqqKu8V3hb2kSA3sK7trL3HxOIP07h+NqOJbWa5M2j5NW0X66yGVp1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581273; c=relaxed/simple;
	bh=3tJNIe+8ody8PnwpIo3DdNxPw5RwuhvoxlSORB0usoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOtKOOxPKxBcfg2NmmD6D0kATpsgmhEVlRXYTpqBEyl3ssObeUt6DJes7zyapfkfnL9FwOv+jEdEsFKc5G8JAAYHXADcUbb7JurzItmXOrii+66LCLLAW0UN8aUEalT4MpSU80vcXF+jab9hFAv2ewuzwy0aY7dFii/psuDKChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP/W7jSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP/W7jSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B62AC2BCB0
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778581273;
	bh=3tJNIe+8ody8PnwpIo3DdNxPw5RwuhvoxlSORB0usoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MP/W7jSaS9FdUNvdb4eiGuHPELTNTP3yGQoF3r8o6BsDSSuxUxUWg5nLf2CZPZVag
	 Gujs4RtrcrHfNR4RYOEtj4CysRZylXrcwsv66jpl5PY5QdwiR/YXZA2Ze7/zAPEy42
	 FTNBkzBwBZJhAPfDPwZD86tZ9kBYyQh/bVClROQofJqzS4/zthemqfsQRjtYTmb6ct
	 pz21SvwkY8xyQV6aWUr99J2KXSktRTM1VeqhFV6DKpvDMvc+QM3AVH7Tm3Ti1ZRB15
	 8xI8RwwHdxT25WFuNjuhpJ2fHDU/X4Bn1mr0HuNi+jepFHF3yi0ZsSd9G2iOUnYznY
	 xDU6VuN7cYeLg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8cb92f26aso2000998e87.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 03:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Pk82nYTmBt4CQQxHHK0LJ0QusUdpxjW0UHZ+vA8fVL5YoGaDA0euHyAXFm1qTJA+P1V4j/3L7uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rzyRdexbHhba7jq2MqUWp71cjrPsBk3K0U8jbTNf6UFldjU1
	XYAN66RXhzzEsXH5h7qYAuDI3atQg5WQxE6YJXrD7YyIslCoqn30f9CbsBIkW6QMAjdMnfJK1Gf
	uxttNSuTPIYPR0Rr259fiEEIPAzhGNvo=
X-Received: by 2002:a05:6512:2384:b0:5a1:1496:922 with SMTP id
 2adb3069b0e04-5a887ce682bmr8992226e87.33.1778581270951; Tue, 12 May 2026
 03:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 12:20:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
X-Gm-Features: AVHnY4LBczGWeT369NCWB08PIeG6KuVTTxElJCozqkbR50fAVd5ebsV6Mg5FHbA
Message-ID: <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Tseng <henrytseng@qnap.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:53=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Raptor Lake-E processors are not correctly showing cpufreq frequency
> limits.
>
> These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-cores, but
> P-cores still use hybrid scaling factor.
>
> commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> hybrid-capable systems with disabled E-cores") added support for
> such configuration. Here using CPPC nominal freq and perf was compared
> to still return hybrid scaling factor.
>
> Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling
> factors") restructured hwp_get_cpu_scaling() and added an explicit check
> for X86_FEATURE_HYBRID_CPU and when not set returns core scaling factor.
>
> To address this remove check for X86_FEATURE_HYBRID_CPU and call
> intel_pstate_cppc_get_scaling().
>
> Ideally this change should be enough. But using CPPC for scaling factor
> results in rounding error, so still doesn't restore the original
> behavior.
>
> In intel_pstate_cppc_get_scaling() return core scaling factor when
> ACPI CPPC is not present or when CPPC nominal frequency or nominal
> performance are invalid.
>
> Use hybrid_scaling_factor for P-cores when defined for a CPU, if not
> calculate from ACPI CPPC nominal frequency and performance.
>
> Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling fact=
ors")
> Reported-by: Henry Tseng <henrytseng@qnap.com>
> Closes: https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henryts=
eng@qnap.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1292da53e5fc..0379efdee5f8 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -421,15 +421,23 @@ static int intel_pstate_cppc_get_scaling(int cpu)
>  {
>         struct cppc_perf_caps cppc_perf;
>
> +       if (cppc_get_perf_caps(cpu, &cppc_perf) || !cppc_perf.nominal_fre=
q ||
> +           !cppc_perf.nominal_perf)
> +               goto core_scaling;
> +
> +       if (cppc_perf.nominal_perf * 100 =3D=3D cppc_perf.nominal_freq)
> +               goto core_scaling;
> +
> +       if (hybrid_scaling_factor)
> +               return hybrid_scaling_factor;
> +
>         /*
> -        * Compute the perf-to-frequency scaling factor for the given CPU=
 if
> -        * possible, unless it would be 0.
> +        * Compute the perf-to-frequency scaling factor for the given CPU
> +        * from nominal freq and nominal_perf
>          */
> -       if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> -           cppc_perf.nominal_perf && cppc_perf.nominal_freq)
> -               return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
> -                              cppc_perf.nominal_perf);
> +       return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ, cppc_perf.no=
minal_perf);
>
> +core_scaling:
>         return core_get_scaling();
>  }
>
> @@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
>                  */
>                 if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)
>                         return hybrid_scaling_factor;
> -
> -               return core_get_scaling();

Why is this change necessary or even useful?

This is about E-cores (because P-cores have been covered above) and if
hybrid_scaling_factor is set, it is known that the processor is hybrid
and E-cores have the "core" scaling factor.

Or is Raptor Lake-E covered by one of the
intel_hybrid_scaling_factor[] entries and hybrid_get_cpu_type(cpu)
doesn't return INTEL_CPU_TYPE_CORE on it?  This piece of information
is missing from the changelog.

>         }
>
> -       /* Use core scaling on non-hybrid systems. */
> -       if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -               return core_get_scaling();
> -

So we're now exposing all of the non-hybrid processors to the fun with
possibly incorrectly populated CPPC, which is kind of risky.

If Raptor Lake-E is not covered by an existing
intel_hybrid_scaling_factor[] entry, why don't we add one for it with
a "scaling factor" value indicating that CPPC needs to be used for
computing it on all CPUs?

>         /*
> -        * The system is hybrid, but the hybrid scaling factor is not kno=
wn or
> -        * the CPU type is not one of the above, so use CPPC to compute t=
he
> +        * The system is hybrid, so use CPPC to compute the
>          * scaling factor for this CPU.
>          */
>         return intel_pstate_cppc_get_scaling(cpu);
> --
