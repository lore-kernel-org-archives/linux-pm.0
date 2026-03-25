Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4502494D8
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445546; cv=none; b=rSaV/XAGuO9TWtedM+1c16Im1le5PJkqoybAxm0VZOVQGWzKfwZSPXS1IRMShu/8WYbSOv9/+7OsvdvbSo7WseUr/y1L9ARCh+rUtovHmim9tJwX9FBxQXX0MLejwWUneKg7JHrOkST3ygLRIhjM5wX0iVRx+5cmFXDBju0dUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445546; c=relaxed/simple;
	bh=XY73DpzMPzwxeFdhnv17+xRoeqE3UsGbq7QiCS2vh0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5qG9LMy/c6nivlMkqJrT49vjymGIM6lnHElgJnRfTO/Q+xecgCmaHtFEJDTjd97ROjsIzdKuv09dDStoWZ3hW91W3WEDUupck89adRGX5eLxOf55SAb0p8pa3MC7p5/RlfotNMUH6v+M52VUr5zwu3jlsbw3eZ8AKqfzv6/KMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQZH1cAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQZH1cAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15692C2BCB2
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774445546;
	bh=XY73DpzMPzwxeFdhnv17+xRoeqE3UsGbq7QiCS2vh0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UQZH1cAN80Cwf0FaZfDSV9U4r7zKBN+ounWtJs242Wqhjy14p3C3lEmHepOcxwONZ
	 YUM2owXUIpeIGCpwukb+YxQTZi6+MDHHbjGaOgCZNth/deCmtmXKbYdLOpRNjjPugk
	 SCxZkNjhvBSSyQvalXlaC4rfLa5p0xpRe4t+HJyPbC0cADKv8PHnQxN+5zRn+hU6H8
	 1z0381vHveyEIvsuf8s+BFRjDF3aNvVTjIpJsyI9m+SR+MC4PcgPVnKBV33d7mGApU
	 KZnMBZu2D0ii0eva8hebV4/7l3RFoQGEIU5LiFYiqJYvh+wWoyKNjGKrayy1ta8IV/
	 MD/dfWBmbC+eQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c383f2fcso5470600a34.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:32:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9Ii37couXJ8kxgpQAd3v07cEiU1yldkMB5HCvV+92AQAbuR4i6QFXAxYwTNnpGWfvk3l7iU9Jxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5jMUQUT+piXn8zdCbDjMSEc3fgVdi8F6H7TSUnSdB5MkdJTL
	5YD5TGOYO1kUvTUDahohuZPinGb0niJiC6HKe9AJDQw3ZrW+GcdF//IfRVCScE8Q1RPfJukNxwX
	fmTneNxc+Qc+p4d4DgIhD1WnN3LOi7Go=
X-Received: by 2002:a05:6870:d30a:b0:416:b429:28e with SMTP id
 586e51a60fabf-41ca6e47cb8mr1881156fac.20.1774445545149; Wed, 25 Mar 2026
 06:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324090948.1667340-1-henrytseng@qnap.com>
In-Reply-To: <20260324090948.1667340-1-henrytseng@qnap.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 14:32:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hT_FJ48z0bCTcgNHgUHp-reUZGa4877MnNAGC6UTd5MA@mail.gmail.com>
X-Gm-Features: AQROBzCheUiE8Qqxed4qz1HhnN9ekihoy1ekq0S_GnHGApOpqbV_AxhifGw4QcY
Message-ID: <CAJZ5v0hT_FJ48z0bCTcgNHgUHp-reUZGa4877MnNAGC6UTd5MA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: acpi-cpufreq: use DMI max speed when CPPC is unavailable
To: Henry Tseng <henrytseng@qnap.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	SW Chen <swchen@qnap.com>, Kevin Ko <kevinko@qnap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:11=E2=80=AFAM Henry Tseng <henrytseng@qnap.com> =
wrote:
>
> On AMD Ryzen Embedded V1780B (Family 17h, Zen 1), the BIOS does not
> provide ACPI _CPC objects and the CPU does not support MSR-based CPPC
> (X86_FEATURE_CPPC).  The _PSS table only lists nominal P-states
> (P0 =3D 3350 MHz), so when get_max_boost_ratio() fails at
> cppc_get_perf_caps(), cpuinfo_max_freq reports only the base frequency
> instead of the rated boost frequency (3600 MHz).
>
>   dmesg:
>     ACPI CPPC: No CPC descriptor for CPU:0
>     acpi_cpufreq: CPU0: Unable to get performance capabilities (-19)
>
> cppc-cpufreq already has a DMI fallback (cppc_get_dmi_max_khz()) that
> reads the processor max speed from SMBIOS Type 4.  Export it and reuse
> it in acpi-cpufreq as a last-resort source for the boost frequency.
>
> A sanity check ensures the DMI value is above the _PSS P0 frequency
> and within 2x of it; values outside that range are ignored and the
> existing arch_set_max_freq_ratio() path is taken instead.  The 2x
> upper bound is based on a survey of the AMD Ryzen Embedded V1000
> series, where the highest boost-to-base ratio is 1.8x (V1404I:
> 2.0 GHz base / 3.6 GHz boost).
>
> The DMI lookup and sanity check are wrapped in a helper,
> acpi_cpufreq_resolve_max_freq(), which falls through to
> arch_set_max_freq_ratio() if the DMI value is absent or
> out of range.
>
> Tested on AMD Ryzen Embedded V1780B with v7.0-rc4:
>
>   Before: cpuinfo_max_freq =3D 3350000 (base only)
>   After:  cpuinfo_max_freq =3D 3600000 (includes boost)
>
> Link: https://www.amd.com/en/products/embedded/ryzen/ryzen-v1000-series.h=
tml#specifications
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
> v2:
>   - Extract else block into acpi_cpufreq_resolve_max_freq()
>     to avoid #ifdef in the main init path (Rafael)
> v1:
>   - https://lore.kernel.org/linux-pm/20260320095648.3598007-1-henrytseng@=
qnap.com/
>
>  drivers/acpi/cppc_acpi.c       |  3 ++-
>  drivers/cpufreq/acpi-cpufreq.c | 31 ++++++++++++++++++++++++-------
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f0e513e9ed5d..f53de414acf2 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1944,7 +1944,7 @@ static void cppc_find_dmi_mhz(const struct dmi_head=
er *dm, void *private)
>  }
>
>  /* Look up the max frequency in DMI */
> -static u64 cppc_get_dmi_max_khz(void)
> +u64 cppc_get_dmi_max_khz(void)
>  {
>         u16 mhz =3D 0;
>
> @@ -1958,6 +1958,7 @@ static u64 cppc_get_dmi_max_khz(void)
>
>         return KHZ_PER_MHZ * mhz;
>  }
> +EXPORT_SYMBOL_GPL(cppc_get_dmi_max_khz);
>
>  /*
>   * If CPPC lowest_freq and nominal_freq registers are exposed then we ca=
n
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index e7eff6c2f092..21639d9ac753 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -675,6 +675,29 @@ static inline u64 get_max_boost_ratio(unsigned int c=
pu, u64 *nominal_freq)
>  }
>  #endif
>
> +static void acpi_cpufreq_resolve_max_freq(struct cpufreq_policy *policy,
> +                                         unsigned int pss_max_freq)
> +{
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +       u64 max_speed =3D cppc_get_dmi_max_khz();
> +       /*
> +        * Use DMI "Max Speed" if it looks plausible: must be
> +        * above _PSS P0 frequency and within 2x of it.
> +        */
> +       if (max_speed > pss_max_freq && max_speed < pss_max_freq * 2) {
> +               policy->cpuinfo.max_freq =3D max_speed;
> +               return;
> +       }
> +#endif
> +       /*
> +        * If the maximum "boost" frequency is unknown, ask the arch
> +        * scale-invariance code to use the "nominal" performance for
> +        * CPU utilization scaling so as to prevent the schedutil
> +        * governor from selecting inadequate CPU frequencies.
> +        */
> +       arch_set_max_freq_ratio(true);
> +}
> +
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>         struct cpufreq_frequency_table *freq_table;
> @@ -849,13 +872,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>
>                 policy->cpuinfo.max_freq =3D freq * max_boost_ratio >> SC=
HED_CAPACITY_SHIFT;
>         } else {
> -               /*
> -                * If the maximum "boost" frequency is unknown, ask the a=
rch
> -                * scale-invariance code to use the "nominal" performance=
 for
> -                * CPU utilization scaling so as to prevent the schedutil
> -                * governor from selecting inadequate CPU frequencies.
> -                */
> -               arch_set_max_freq_ratio(true);
> +               acpi_cpufreq_resolve_max_freq(policy, freq_table[0].frequ=
ency);
>         }
>
>         policy->freq_table =3D freq_table;
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4d644f03098e..e6c5ef3173c5 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -156,6 +156,7 @@ extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
>  extern bool cppc_perf_ctrs_in_pcc(void);
> +extern u64 cppc_get_dmi_max_khz(void);
>  extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsign=
ed int perf);
>  extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsign=
ed int freq);
>  extern bool acpi_cpc_valid(void);
> --

Applied as 7.1 material, thanks!
