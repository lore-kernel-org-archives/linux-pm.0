Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358D347BC6
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470441; cv=none; b=HRlXlVNuTOsZrFHY+tR51jXAk4vkjdWR8YrcgJNvWTsjs/NRLSrVGuW2Km2VxaDbgp1wReHDrYTBbiZTQVFPPX0rWiKgSxyLxeZM1+/barn43Ikqz9zkj6JaH2KnJl0bzDUaZwyyjypFyopdEEVvQkKG3M88v53REnPpSdRFI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470441; c=relaxed/simple;
	bh=hxzeL93Eqj2WjozLPd3mD+3+TAo3cxBTnMtSJDK7Q1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/6KPIgz0XGLSosZRK5hJkIwc1Dd/eZUVZxB3jfNB+m1oLl/tjatqT1eRsb8lqsqo3DmWWOCNkT81HUzh7jNLO8oCpcK+DHEC6IQZq+y7g2OT8IbF/0cSIaQSDNpGwLWROgxwpISm1pDPoe5mtakKPk6MXwfa5ptH6L1clZgNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPOg91l7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPOg91l7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC931F01565
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470440;
	bh=SoTLmvK+p2QdfKbKRkuRhFbMIsCz6Ar7Fj1uqRxZ/4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mPOg91l7aqa+EACF5te2YeCd76TIMzjlf7arlBQsxvqGNm/ny3a1aiffQ+KPXhymT
	 JwSscDA5F7D3ETI2h4NucWJSq1buSUvTd58UhAV7CrVQ6BxUk6VZJtkw/tNvcXbmEX
	 u92i/Nrtgiuqpb+qsna9wbDVm8hGbp5PPAX7Kglh8NCRdFDXZt4+g00ujHj4LSZVQR
	 kLFGQd7n96rwlLwWuQSATle2bTR6u55s4IiTK7szJfVA6Ig3YIMPEY2RBakGhflTcU
	 /+j/HHfS1UzyG+2AegMKnKYL828Mc5FJS27d/UWAGDqKkqALjr+jOk3xc4z6j+XRe9
	 JYzV1Vlaub6+A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so4878277e87.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 10:20:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iRHWF9aoeENFO5Q72b8HBoOd0Pv6UWKMkRzDdYoXty2NkXlJEDq5xZBUrbmskdWKoQ/+l/xgmoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypShM5uWffGBkvFlWzmKpajUJM+uyPjiaWKN4MaYKdZpdiTRpy
	bDkIcX+adv+4ZXeS9HgebDVH8stsHw/pa97rFVJiX7BBVbad4XN4s5APH9P6PhWWF2Sz01+p6LC
	FSNDyM1RK61813LMEq5SysLqD0aVbKyo=
X-Received: by 2002:a05:6512:39cd:b0:5a8:88a6:3d65 with SMTP id
 2adb3069b0e04-5aa323843c5mr1512656e87.34.1779470438443; Fri, 22 May 2026
 10:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514194822.1841748-1-sumitg@nvidia.com> <20260514194822.1841748-3-sumitg@nvidia.com>
In-Reply-To: <20260514194822.1841748-3-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:20:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfgSTwwTHVyCiJfG7QCPD5fgXc2dJDJ3Q8R+qxe6YGLQ@mail.gmail.com>
X-Gm-Features: AVHnY4JXmvouSFwMdjRuXDLBetYE56eGTDvwNTiqgkBmaxm-c0g50EJkYQUN2Vo
Message-ID: <CAJZ5v0gfgSTwwTHVyCiJfG7QCPD5fgXc2dJDJ3Q8R+qxe6YGLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, 
	pierre.gondois@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	mario.limonciello@amd.com, saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:49=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
>
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
>
>   /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
>
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> every CPU in policy->cpus.
>
> The register is write-only; the kernel caches the last written
> value in struct cppc_cpudata for sysfs readback (returns 0 until
> userspace writes a value).
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Please see sashiko.dev's feedback on this patch:

https://sashiko.dev/#/patchset/20260514194822.1841748-1-sumitg%40nvidia.com

and address it, or let me know why you think that addressing it is not
necessary.

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++++
>  drivers/acpi/cppc_acpi.c                      | 35 ++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |  7 ++++
>  4 files changed, 99 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documen=
tation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..ac1bf1b89ac4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,23 @@ Description:       Performance Limited
>
>                 This file is only present if the cppc-cpufreq driver is i=
n use.
>
> +What:          /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:          May 2026
> +Contact:       linux-pm@vger.kernel.org
> +Description:   OSPM Nominal Performance (kHz)
> +
> +               OSPM uses this attribute to request a nominal performance
> +               level lower than the platform-reported nominal. The
> +               platform treats performance above this level as boost
> +               and below as throttle for power and thermal decisions.
> +
> +               Read returns the last written value in kHz, or 0 if no
> +               value has been written. Write a kHz value in the range
> +               [lowest_freq, nominal_freq].
> +
> +               This file is only present if the cppc-cpufreq driver is
> +               in use.
> +
>  What:          /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{=
0,1}
>  Date:          August 2008
>  KernelVersion: 2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c76cfafa3589..ad6ece16c30d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_epp);
>
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance registe=
r.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance re=
gister.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance leve=
l
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +       struct cppc_perf_caps caps;
> +       int ret;
> +
> +       if (!cpc_desc) {
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
> +       }
> +
> +       ret =3D cppc_get_perf_caps(cpu, &caps);
> +       if (ret)
> +               return ret;
> +
> +       if (ospm_nominal_perf < caps.lowest_perf ||
> +           ospm_nominal_perf > caps.nominal_perf)
> +               return -EINVAL;
> +
> +       return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf=
);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>  /**
>   * cppc_get_auto_act_window() - Read autonomous activity window register=
.
>   * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 7e7f9dfb7a24..6379b7ceee34 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -985,11 +985,50 @@ store_energy_performance_preference_val(struct cpuf=
req_policy *policy,
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>                          cppc_set_perf_limited)
>
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, cha=
r *buf)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int freq_khz;
> +
> +       if (!cpu_data->ospm_nominal_perf)
> +               return sysfs_emit(buf, "0\n");
> +
> +       freq_khz =3D cppc_perf_to_khz(&cpu_data->perf_caps,
> +                                   cpu_data->ospm_nominal_perf);
> +       return sysfs_emit(buf, "%u\n", freq_khz);
> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +                                      const char *buf, size_t count)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int sib;
> +       u64 freq_khz;
> +       u32 perf;
> +       int ret;
> +
> +       ret =3D kstrtou64(buf, 0, &freq_khz);
> +       if (ret)
> +               return ret;
> +
> +       perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +       for_each_cpu(sib, policy->cpus) {
> +               ret =3D cppc_set_ospm_nominal_perf(sib, perf);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       cpu_data->ospm_nominal_perf =3D perf;
> +       return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
>  cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>
>  static struct freq_attr *cppc_cpufreq_attr[] =3D {
>         &freqdomain_cpus,
> @@ -997,6 +1036,7 @@ static struct freq_attr *cppc_cpufreq_attr[] =3D {
>         &auto_act_window,
>         &energy_performance_preference_val,
>         &perf_limited,
> +       &ospm_nominal_freq,
>         NULL,
>  };
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..0b1dcdbea10a 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -153,6 +153,8 @@ struct cppc_cpudata {
>         struct cppc_perf_fb_ctrs perf_fb_ctrs;
>         unsigned int shared_type;
>         cpumask_var_t shared_cpu_map;
> +       /* Cached OSPM Nominal Performance value (write-only register). *=
/
> +       u32 ospm_nominal_perf;
>  };
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> @@ -180,6 +182,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *=
reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
>  extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>  extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -266,6 +269,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_p=
erf)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window=
)
>  {
>         return -EOPNOTSUPP;
> --
> 2.34.1
>
>
