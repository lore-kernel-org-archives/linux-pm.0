Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5363DDDAB
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335481; cv=none; b=mRfGOf0zum9sq+kbtqUja6IQSM4eywqQlCF4EP3nsxfM6GDDchvDghwVEcDdUyR4mucKNtTQ5Xi17/CDFXnHSUvVKT9q1gy3d2buNot1oZX4PbeV4xog/8SQ54TNOQ1sxI8JyS4vqnVtwG5+WdrvECvnjz4yZJ53yqIkU3L8/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335481; c=relaxed/simple;
	bh=df/amR/kLwkxsGQOJwWAM5GmaSR7m2OcK4ooa6VDoS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0nL1Z4T/JQbUrIX+hp+lnUqP2hcdFTDlbyYSeVO0TXmLFt+KT+1jry68GMxau/qdW3aN/7AB+9kAQYD2xXjoHhfp0preK0ypXnlDDU22qVL3H0XTQmy2pnEjuDB+VFREV0eJiiiZK9A4urugv2Ad0HO60BKddoJD0zuXOdQVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRvdDR99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRvdDR99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64ED1F00A02
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335478;
	bh=H7SFs6AciS9HtX+vO6nb06GsMw5dbSS/v2vGNC/2pa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MRvdDR99qa8K10n7eQ5wMRfZWK21ug7MRQp0BKTdLrgSxDRNDnT0vEQ5+F+BVjsHe
	 cjHkWEj7gYWwx5Idqp2Q5c28AuawmCJxBQanFUAdg6XCTowsOPW7WR3xtY2pM/wBvn
	 od3bLxcJ9it/+3yNzkPRxioUtzVR405gtund/deT3qC37zZGfQvXba0Jqm/VdcFD4N
	 qPN/JNnscgOQF5IdbLt4ElAezDGfdloLFSmLbzWQgDHwGtPx3sphGRDBICWu4vWAHA
	 h845qV8X1CT9kSshjhZDrsB2LpMNMSm0HWrWFv+x6mjumrHEdACcE29Rlblyv8IDR/
	 s1KtWIWPcvMaQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa63628d26so1933669e87.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 10:37:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+kB6xOHXRnJ3ArvN27iFEQUCrIWZiaz8T6En0VMfmvZ3Vds2bwcHNbhESEPBhG8HF/XubWcmUvfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3D3Nx2GsJ13oFIpnBhwRzvOA2Vg7XO5kPbxQjxVVgbk7NcrT
	PkkTcbl3KcGbSScIW46nlxrmypvAd/s14ySdf3ioKgyWzHFeO7YI7sWx9qoEGB9Vm4W5X9feNwM
	xjRklXjAC2JsLCryTjtWVHeOleh9RET4=
X-Received: by 2002:a05:6512:3185:b0:5a8:8df1:61bf with SMTP id
 2adb3069b0e04-5aa74304014mr343527e87.21.1780335477287; Mon, 01 Jun 2026
 10:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527194626.185286-1-sumitg@nvidia.com> <20260527194626.185286-3-sumitg@nvidia.com>
In-Reply-To: <20260527194626.185286-3-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:37:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icPAmaiThjgUTxWRymNGBQFarodurJhODFOkLKpVwtOQ@mail.gmail.com>
X-Gm-Features: AVHnY4KU5BqE06IDKh9R9dO-EvUUPEYauhejTr3HcPK3qROeDgfiK_nynvaLr24
Message-ID: <CAJZ5v0icPAmaiThjgUTxWRymNGBQFarodurJhODFOkLKpVwtOQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, 
	pierre.gondois@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	mario.limonciello@amd.com, saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 9:47=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
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

There is some sashiko.dev feedback on this one that is valid AFAICS:

https://sashiko.dev/#/patchset/20260527194626.185286-1-sumitg%40nvidia.com

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
>  drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      | 12 ++++
>  4 files changed, 124 insertions(+)
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
> index 15a728dea911..5c54af1655b5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1139,11 +1139,70 @@ static int cppc_get_perf_limited_filtered(int cpu=
, u64 *perf_limited)
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>                          cppc_set_perf_limited)
>
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, cha=
r *buf)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int freq_khz;
> +
> +       if (!cpu_data->ospm_nominal_perf_set)
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
> +       bool prev_set =3D cpu_data->ospm_nominal_perf_set;
> +       u32 prev_perf =3D cpu_data->ospm_nominal_perf;
> +       unsigned int sib, freq_khz, failing_cpu =3D 0;
> +       u32 perf;
> +       int ret;
> +
> +       ret =3D kstrtouint(buf, 0, &freq_khz);
> +       if (ret)
> +               return ret;
> +
> +       perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +       for_each_cpu(sib, policy->cpus) {
> +               ret =3D cppc_set_ospm_nominal_perf(sib, perf);
> +               if (ret) {
> +                       failing_cpu =3D sib;
> +                       goto rollback;
> +               }
> +       }
> +
> +       cpu_data->ospm_nominal_perf =3D perf;
> +       cpu_data->ospm_nominal_perf_set =3D true;
> +       return count;
> +
> +rollback:
> +       /*
> +        * Restore the previous value on siblings already updated.
> +        * for_each_cpu() iterates in CPU-id order, so siblings before
> +        * @failing_cpu were updated successfully. Skip restore when
> +        * there is no prior known-good value (first-ever write failed).
> +        */
> +       if (prev_set) {
> +               for_each_cpu(sib, policy->cpus) {
> +                       if (sib =3D=3D failing_cpu)
> +                               break;
> +                       cppc_set_ospm_nominal_perf(sib, prev_perf);
> +               }
> +       }
> +       return ret;
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
> @@ -1151,6 +1210,7 @@ static struct freq_attr *cppc_cpufreq_attr[] =3D {
>         &auto_act_window,
>         &energy_performance_preference_val,
>         &perf_limited,
> +       &ospm_nominal_freq,
>         NULL,
>  };
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 9b18fb9aab7c..14c6d5d0ac12 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -154,6 +154,13 @@ struct cppc_cpudata {
>         struct cppc_perf_fb_ctrs perf_fb_ctrs;
>         unsigned int shared_type;
>         cpumask_var_t shared_cpu_map;
> +       /*
> +        * Cached OSPM Nominal Performance value (write-only register).
> +        * ospm_nominal_perf_set is true once userspace has written, so a=
n
> +        * unwritten cache is distinguishable from a valid 0 perf write.
> +        */
> +       u32 ospm_nominal_perf;
> +       bool ospm_nominal_perf_set;
>  };
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> @@ -181,6 +188,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *=
reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
>  extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>  extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -267,6 +275,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
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
