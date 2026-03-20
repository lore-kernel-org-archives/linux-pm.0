Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A539934D
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004327; cv=none; b=jcgBN2R3Z+E081EXE7c/R2tCT8bwtHuDyoS8pN8/qfo2AElDhKC0CaphwGEf/d0lom69raYfFR1dncJxWoT9HCtAYHBUBtNKmHviC+ZJfLgCU1qMDB2Q/DnMcUFP8aJ/H6BvFpOwUWMU6j5cgiT2MFLKHPvo2UUxuht/O6X4hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004327; c=relaxed/simple;
	bh=AwmwR+eu6X8nr78nsuwE9tKQ52118WdtCyPewVKlRos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahjxvoY5lwdurJclW2A3Nptu+7ZA3uJ8hAssbKaX+7cMUk0wOKkMSOQpbGPt0DCUZOEppy2prtT6CFzpVt86awsO5psJv0jbbwm24/w5xTu0zkvifrnliBG/3dwNaU1UlSG71fl6YWDrq6GSA0c70z5FlfaUb2zp7wZcGs6RD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFH3DDgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFH3DDgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771EBC2BC9E
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774004326;
	bh=AwmwR+eu6X8nr78nsuwE9tKQ52118WdtCyPewVKlRos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GFH3DDgPvgWkiaONLYeGGDTUhApgZD3trcXWnsMofG/zt3HAsYi1lf0FtkdMHLXr4
	 lcjEtunqK63ThhZYY617eTJ5BUxgmmZXe+Z2bbf1t6fmdFvtQNxgojYE+xxbkc4NkG
	 UNAu+vRBZ9peZcuZ+MqO1gwS0zeaiYWUqqJlF66hpdB1pGRffaXVT7/f07blb5FIpk
	 sJ3WTrGzTsGnxB43zYvA1M+dZOjGvV8dPiJ1pmDfGGUGIrxP1BUyfmyWb+xaa7xDRp
	 VU0N6z2qXyh4+WgfvJbyTBW2rI0NMQYejzIGv30uUbsAwQb5WrvLclnn1pSkVsWu3T
	 xQpOUzh2kIgZA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d750eeaec3so208533a34.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDVvUWRqESmvXfXxxW+lZYolLqUXwU8DF0DBU+ECmTqtu67DoU6G87+yeatrVsZFQH2QZ9wJDBXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16KdKHzVWpjw6bVWL00QgVi1jcwwDspUgmFLBELcIm3uPU+4Z
	qaI/mB7iPzsvu8jo2tjyx+4Wq8wXz3dyUTa5RHoBgZd5QP4LDz9dPVlk/EszApgdbmSiNVdGR+l
	ITSF7srZ8jv9zZ+RVZUWq8rJY5cLpbSc=
X-Received: by 2002:a05:6870:2499:b0:417:4164:5eb8 with SMTP id
 586e51a60fabf-41c114f9a9amr1457515fac.51.1774004325544; Fri, 20 Mar 2026
 03:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320095648.3598007-1-henrytseng@qnap.com>
In-Reply-To: <20260320095648.3598007-1-henrytseng@qnap.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 11:58:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9bydM7wMUQSQx3y4p--cZQxDUYJyfcL7s9W-Y88Xw1A@mail.gmail.com>
X-Gm-Features: AaiRm51syvkaOTEXr3O6U2Uo1PqXrjIG0moDUcmPa91DcqlC6jLLSs4-30pEPQ8
Message-ID: <CAJZ5v0h9bydM7wMUQSQx3y4p--cZQxDUYJyfcL7s9W-Y88Xw1A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: use DMI max speed when CPPC is unavailable
To: Henry Tseng <henrytseng@qnap.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	SW Chen <swchen@qnap.com>, Kevin Ko <kevinko@qnap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:57=E2=80=AFAM Henry Tseng <henrytseng@qnap.com> =
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
> Tested on AMD Ryzen Embedded V1780B with v7.0-rc4:
>
>   Before: cpuinfo_max_freq =3D 3350000 (base only)
>   After:  cpuinfo_max_freq =3D 3600000 (includes boost)
>
> Link: https://www.amd.com/en/products/embedded/ryzen/ryzen-v1000-series.h=
tml#specifications
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
>  drivers/acpi/cppc_acpi.c       |  3 ++-
>  drivers/cpufreq/acpi-cpufreq.c | 21 ++++++++++++++++-----
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)
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
> index e7eff6c2f092..9b4638ad27ba 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -849,13 +849,24 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
>
>                 policy->cpuinfo.max_freq =3D freq * max_boost_ratio >> SC=
HED_CAPACITY_SHIFT;
>         } else {
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +               unsigned int freq =3D freq_table[0].frequency;
> +               u64 max_speed =3D cppc_get_dmi_max_khz();
>                 /*
> -                * If the maximum "boost" frequency is unknown, ask the a=
rch
> -                * scale-invariance code to use the "nominal" performance=
 for
> -                * CPU utilization scaling so as to prevent the schedutil
> -                * governor from selecting inadequate CPU frequencies.
> +                * Use DMI "Max Speed" if it looks plausible: must be
> +                * above _PSS P0 frequency and within 2x of it.
>                  */
> -               arch_set_max_freq_ratio(true);
> +               if (max_speed > freq && max_speed < freq * 2)
> +                       policy->cpuinfo.max_freq =3D max_speed;
> +               else
> +#endif
> +                       /*
> +                        * If the maximum "boost" frequency is unknown, a=
sk the arch
> +                        * scale-invariance code to use the "nominal" per=
formance for
> +                        * CPU utilization scaling so as to prevent the s=
chedutil
> +                        * governor from selecting inadequate CPU frequen=
cies.
> +                        */
> +                       arch_set_max_freq_ratio(true);

Please move the code in the else {} block into a separate function.

Then you'll be able to return early after updating cpuinfo.max_freq.

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
> 2.43.0
>
