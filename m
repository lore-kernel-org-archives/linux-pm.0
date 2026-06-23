Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7E3D3332
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212464; cv=none; b=nMxoXPV761+ymLdtSVVgOqYoFwlA6mkUdZnlZqOJX8xg1vZscUsWEAHiJ+iVMHtDbeYoHeRstkQ8CdwLiQZ3lM/rZV8OpZVtrL2SRZxzAvviuJRuS6rzFEFMZP4F+HURXEVmGBSXq6XkvQTQbsg130AaUiTKF2+3K0UmNrU8Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212464; c=relaxed/simple;
	bh=Iingc9D7WKTOmltnRerscQKF+Vt4yNKXO3/rFIlE2jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zz2IqUdU4yYVLXvk+XxBqlM4UiJva/qOJ2oEsrpQ/SYKBFWeScv4H4jDXP6814OKsUEfAra3ico4yxjNooxjpzfXGdFCgidPsFDF1clrL/OLCjO5WisOr8B2r6TfazfbKNtTFXtCoR/GLGMzs5jDQ9J7I4GxOHV+uYCiPxrVYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbpV6s4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbpV6s4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590151F000E9
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212461;
	bh=WKat0PBEx+CjqWV20OZBRlpw8wBobYCIff+XhiUceX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PbpV6s4bnRoSkgET8XVXU5Xxz3eeN9GYHwByWOkrlY8Xx16WDRn9hrE2mW7AmLJ7/
	 hCvV3gN6KyDlNUd3JmGw0KmU0nV/ydS+4pNa1U//lMB5Z9gYs6vjJJJGrM1HQBFRxs
	 Omg36o4RZrc4rXGn4p2PHOWPQt2l1yCUv/mP5VrPIxlqM1GRsHpeC+FW/iw7Yp6GNw
	 FOAB93cRyNcL66brr/4TGBjLbKR+kqoGjEcPps55IYvliq2UHPugssl+Do9PJGNYMU
	 O9LTNqFvFW6auM3Cbl+perwISOibdI/4UgrK9ttjlEoMdQXfHUM2JeWRDW9TFGbZZV
	 8EwdeM7vLpnmQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ad536cd0c6so5714483e87.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 04:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8DmjfNUB0iphOcaPTS7wYewG6/WSbGHxa2Efe+ce7fHdytbWGgRWjsulxlnOGko/d5aK+z6AZ3YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUw3upPo0EF5sM4qWwkeJR1NzWAcw0DGEB/2oFnUTE+lGu1aSF
	Gp9dxW0OARBNOG0/aX9VCG7ND45Ef0CVdqDvwTkOk3X3VeXbM7zECzQ2qPfmREjBuxmxOeL1JLM
	oq3UpmXN1WH+VpHjcg4dMxZYVuUnG8GM=
X-Received: by 2002:a05:6512:3d20:b0:5ad:4d1c:9361 with SMTP id
 2adb3069b0e04-5ad57729695mr5523794e87.50.1782212459462; Tue, 23 Jun 2026
 04:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623095403.3407436-1-sumitg@nvidia.com>
In-Reply-To: <20260623095403.3407436-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 13:00:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
X-Gm-Features: AVVi8CfraFDtZoZYaKOOHS5HhhoiQGmwBcDt8Rp971nZHV1k-Mb8zAiIPGWcjwA
Message-ID: <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:54=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
> boot parameter) can be lost in two ways:
>
>   - Across CPU hotplug: the platform may reset a CPU's registers when it
>     is offlined.
>   - On driver unload: the value the driver wrote is left in the register
>     instead of returning to its pre-driver state.
>
> Add a small table-driven mechanism that handles both:
>
>   - Capture each register's firmware value when a CPU is first seen and
>     restore it on driver unload.
>   - Record the last value the driver set and reapply it from ->init()
>     when the policy is reactivated after CPU hotplug.

I'm not sure if this is a good idea TBH.

The overall system state when the CPU goes online may be completely
different from the system state when the CPU was online last time, so
there is no reason to restore its settings from before offline, at
least in principle.

> The firmware value is captured on a CPU's first activation rather than
> once at module load, so CPUs offline at boot or hot-added later are
> covered.
>
> Reapply is only needed on a full policy teardown and bring-up, which goes
> through ->init(). In a SHARED_TYPE_ANY policy, offlining a single CPU
> leaves the shared register untouched, so nothing is lost there.
>
> Cover the OSPM Nominal Performance, Autonomous Selection
> (auto_sel) and Energy Performance Preference (EPP) registers. For
> auto_sel it replaces the previous unconditional
> cppc_set_auto_sel(cpu, false) on unload with a restore of the firmware
> value captured at the CPU's first init.
>
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>
> This applies on top of (not yet merged):
>  [1] ACPI: CPPC: Add ospm_nominal_perf support
>      https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.=
com/
>  [2] cpufreq: CPPC: add autonomous mode boot parameter support
>      https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.=
com/
>
>  drivers/cpufreq/cppc_cpufreq.c | 194 +++++++++++++++++++++++++++++++--
>  1 file changed, 186 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index a3fabfb07fbe..d6ea2cbde187 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,174 @@
>
>  static struct cpufreq_driver cppc_cpufreq_driver;
>
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value set via sys=
fs or
> + * the autonomous boot parameter is reapplied across CPU hotplug, and th=
e
> + * firmware value is restored on driver unload.
> + */
> +enum cppc_saved_reg_id {
> +       CPPC_SAVED_OSPM_NOMINAL_PERF,
> +       CPPC_SAVED_AUTO_SEL,
> +       CPPC_SAVED_EPP,
> +       CPPC_NR_SAVED_REGS,
> +};
> +
> +struct cppc_saved_reg {
> +       int (*get)(int cpu, u64 *val);
> +       int (*set)(int cpu, u64 val);
> +};
> +
> +/* u64 wrappers so the bool auto_sel register fits the table signatures.=
 */
> +static int cppc_get_auto_sel_u64(int cpu, u64 *val)
> +{
> +       bool enable;
> +       int ret;
> +
> +       ret =3D cppc_get_auto_sel(cpu, &enable);
> +       if (ret)
> +               return ret;
> +
> +       *val =3D enable;
> +       return 0;
> +}
> +
> +static int cppc_set_auto_sel_u64(int cpu, u64 val)
> +{
> +       return cppc_set_auto_sel(cpu, !!val);
> +}
> +
> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] =
=3D {
> +       [CPPC_SAVED_OSPM_NOMINAL_PERF] =3D {
> +               cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
> +       },
> +       [CPPC_SAVED_AUTO_SEL] =3D {
> +               cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
> +       },
> +       [CPPC_SAVED_EPP] =3D {
> +               cppc_get_epp_perf, cppc_set_epp,
> +       },
> +};
> +
> +/*
> + * Per-CPU saved state for each register in cppc_saved_regs[]:
> + *   firmware_val      - register value before the driver touched it, re=
stored
> + *                       on unload
> + *   requested_val     - last value the driver set (sysfs or boot parame=
ter),
> + *                       reapplied on policy reactivation
> + *   firmware_captured - whether firmware_val has been read, so a not-ye=
t-seen
> + *                       CPU isn't mistaken for one whose firmware value=
 is 0
> + */
> +struct cppc_saved_state {
> +       u64 firmware_val;
> +       u64 requested_val;
> +       bool firmware_captured;
> +};
> +
> +/*
> + * Per-CPU and not tied to a policy, so the saved values survive policy
> + * teardown/bring-up across CPU hotplug. cpu_data->perf_ctrls is per-pol=
icy
> + * and freed on policy ->exit.
> + */
> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_=
saved_state);
> +
> +static void cppc_cache_perf_ctrls(struct cppc_cpudata *cpu_data,
> +                                 enum cppc_saved_reg_id reg, u64 val)
> +{
> +       switch (reg) {
> +       case CPPC_SAVED_AUTO_SEL:
> +               cpu_data->perf_ctrls.auto_sel =3D val;
> +               break;
> +       case CPPC_SAVED_EPP:
> +               cpu_data->perf_ctrls.energy_perf =3D val;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +/*
> + * Save the requested value for the given register and CPU, to be reappl=
ied when
> + * the policy is reactivated after CPU hotplug. Also update the per-poli=
cy
> + * perf_ctrls copy so the saved and current values stay in sync.
> + */
> +static void cppc_save_requested(struct cppc_cpudata *cpu_data, unsigned =
int cpu,
> +                               enum cppc_saved_reg_id reg, u64 val)
> +{
> +       per_cpu(cppc_saved_state, cpu)[reg].requested_val =3D val;
> +       cppc_cache_perf_ctrls(cpu_data, reg, val);
> +}
> +
> +/*
> + * Reapply each register's last requested value from ->init(), so a valu=
e set
> + * via sysfs or the boot parameter survives a policy teardown and bring-=
up
> + * across CPU hotplug. Also keep perf_ctrls in sync with it.
> + */
> +static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *p=
olicy)
> +{
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int cpu, i;
> +       u64 val;
> +
> +       for_each_cpu(cpu, policy->cpus) {
> +               for (i =3D 0; i < CPPC_NR_SAVED_REGS; i++) {
> +                       val =3D per_cpu(cppc_saved_state, cpu)[i].request=
ed_val;
> +                       if (val =3D=3D U64_MAX)
> +                               continue;
> +
> +                       cppc_saved_regs[i].set(cpu, val);
> +
> +                       /* Keep perf_ctrls in sync via the policy's CPU. =
*/
> +                       if (cpu =3D=3D policy->cpu)
> +                               cppc_cache_perf_ctrls(cpu_data, i, val);
> +               }
> +       }
> +}
> +
> +/*
> + * On a CPU's first ->init(), capture each register's firmware value to =
be
> + * restored on driver unload. Later calls for the same CPU are a no-op. =
Capturing
> + * from ->init() rather than module load covers CPUs that appear later. =
Also seed
> + * requested_val to U64_MAX so its zeroed default is not taken as a requ=
est for 0.
> + */
> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *polic=
y)
> +{
> +       unsigned int cpu, i;
> +       u64 val;
> +
> +       for_each_cpu(cpu, policy->cpus) {
> +               for (i =3D 0; i < CPPC_NR_SAVED_REGS; i++) {
> +                       struct cppc_saved_state *s =3D
> +                               &per_cpu(cppc_saved_state, cpu)[i];
> +
> +                       /* Capture once per CPU; skip if already recorded=
. */
> +                       if (s->firmware_captured)
> +                               continue;
> +
> +                       if (cppc_saved_regs[i].get(cpu, &val))
> +                               val =3D U64_MAX;
> +                       s->firmware_val =3D val;
> +                       s->requested_val =3D U64_MAX;
> +                       s->firmware_captured =3D true;
> +               }
> +       }
> +}
> +
> +/* On driver unload, restore each captured CPU's firmware value. */
> +static void cppc_cpufreq_restore_firmware_regs(void)
> +{
> +       unsigned int cpu, i;
> +
> +       for_each_present_cpu(cpu) {
> +               for (i =3D 0; i < CPPC_NR_SAVED_REGS; i++) {
> +                       struct cppc_saved_state *s =3D
> +                               &per_cpu(cppc_saved_state, cpu)[i];
> +
> +                       if (s->firmware_captured && s->firmware_val !=3D =
U64_MAX)
> +                               cppc_saved_regs[i].set(cpu, s->firmware_v=
al);
> +               }
> +       }
> +}
> +
>  /* Autonomous Selection boot parameter modes */
>  enum {
>         AUTO_SEL_DISABLED =3D 0,
> @@ -766,6 +934,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>         policy->cur =3D cppc_perf_to_khz(caps, caps->highest_perf);
>         cpu_data->perf_ctrls.desired_perf =3D  caps->highest_perf;
>
> +       /* Capture a CPU's firmware values on its first init, before any =
driver write. */
> +       cppc_cpufreq_save_firmware_regs(policy);
> +
>         /*
>          * Enable autonomous mode on first init if boot param is set.
>          * Check last_governor to detect first init and skip if auto_sel
> @@ -812,7 +983,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>                         if (ret && ret !=3D -EOPNOTSUPP)
>                                 pr_warn("Failed to set EPP for CPU%d (%d)=
\n", cpu, ret);
>                         else if (!ret)
> -                               cpu_data->perf_ctrls.energy_perf =3D epp;
> +                               cppc_save_requested(cpu_data, cpu, CPPC_S=
AVED_EPP, epp);
>                 }
>
>                 /* Program min/max/desired into CPPC regs (non-fatal on f=
ailure). */
> @@ -826,7 +997,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>                         pr_warn("auto_sel CPU%d failed (%d); using OS mod=
e\n",
>                                 cpu, ret);
>                 else if (!ret)
> -                       cpu_data->perf_ctrls.auto_sel =3D true;
> +                       cppc_save_requested(cpu_data, cpu, CPPC_SAVED_AUT=
O_SEL, true);
>         }
>
>         if (cpu_data->perf_ctrls.auto_sel) {
> @@ -850,6 +1021,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
>         }
>
>         cppc_cpufreq_cpu_fie_init(policy);
> +
> +       /* Reapply any saved values lost across a full policy teardown. *=
/
> +       cppc_cpufreq_reapply_requested_regs(policy);
> +
>         return 0;
>
>  out:
> @@ -1039,6 +1214,8 @@ static ssize_t store_auto_select(struct cpufreq_pol=
icy *policy,
>                 }
>         }
>
> +       cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_AUTO_SEL, v=
al);
> +
>         return count;
>  }
>
> @@ -1111,7 +1288,7 @@ store_energy_performance_preference_val(struct cpuf=
req_policy *policy,
>         if (ret)
>                 return ret;
>
> -       cpu_data->perf_ctrls.energy_perf =3D val;
> +       cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_EPP, val);
>
>         return count;
>  }
> @@ -1193,6 +1370,9 @@ static ssize_t store_ospm_nominal_freq(struct cpufr=
eq_policy *policy,
>                 }
>         }
>
> +       for_each_cpu(sib, policy->cpus)
> +               cppc_save_requested(cpu_data, sib, CPPC_SAVED_OSPM_NOMINA=
L_PERF, perf);
> +
>         return count;
>
>  rollback:
> @@ -1258,13 +1438,11 @@ static int __init cppc_cpufreq_init(void)
>
>  static void __exit cppc_cpufreq_exit(void)
>  {
> -       unsigned int cpu;
> -
> -       for_each_present_cpu(cpu)
> -               cppc_set_auto_sel(cpu, false);
> -
>         cpufreq_unregister_driver(&cppc_cpufreq_driver);
>         cppc_freq_invariance_exit();
> +
> +       /* Restore auto_sel and the other saved registers to their firmwa=
re value. */
> +       cppc_cpufreq_restore_firmware_regs();
>  }
>
>  module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444)=
;
> --
> 2.34.1
>
>
