Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9333E95B2
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746193; cv=none; b=R//kTU5LdacdjFLRq7dZfIHRcPHlpo1mwsxQOUy43rUSmfhMLhH1TPKQeqTfLJNhcwZdyezFDkqFMd1QT3c9KuLEBlGFuUX78zqxxZjXwXbo46iS/fGxgtL15+H0lPnTTdLeEojoUStPAabex4u5NVIFdeHnx2VYinNBXi2osUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746193; c=relaxed/simple;
	bh=TyroLfUweTHzSwj+sw+Mxymv1hw4VkQqYksGpk/3r6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG47UAfzYqcifFKFg+HBs66VoYu6fwYQ1K4RHoxCaCerDY6442Du8LLsxCTwnqYGtckoMPcYGcp6b3dEIP+mTx9Uel272sP0dPnzFAwJV/Vb4vox7GDhvcMR4/fda9GxhId2VZS39NLY+xRrWYISszaRL6AYbeTYEfF7UuoNwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioI86TQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioI86TQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7841F00ADE
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782746191;
	bh=mu128c2lKhMUV7F9G/OBVNv+GOpQJNZquCp8iILOmR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ioI86TQiijOCF+e38d+1nZtGjwY6fjWUEx5hprN/5g5Cpfad32uY7dcO2IOahNXL/
	 NwufDU/76Ge9CDs2iG/uuzFabL0gFM8Ir6dSWvbMbCJgfiEuvWk8JNLuuiZmToEJIj
	 PLKm7wdimHCGhI4hEubwroUqBjT7Bh+FMfhH6NUs9rWviGwQR6XWtfW7OQYVMabWkf
	 9ZGNd19d0EYzH2ANUZ5ZA4jQhid4JfThNqeSxGBnN9oulAUQ1ES1Z09fh93tlTMT/h
	 XU/Z14y9SbOaAGXZthrPVZtINGCScoC0KzP8Z7WyJHWZtpBjrdwsWytHdgXM7Movwd
	 qx5weVjJobeTw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1204280e87.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 08:16:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrcy5DuOb9IY1aXWUjAnQxpLO+/Y118bbHRv/TGQLCz6qqE4MFIWR8befSdJs5xwZQSjwyLHyz9YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/Zzea5jSsueqVY0yRvQloPXk0fjHNJ8mGEU00a+2O1a2TL0m
	QCNmVMqOnNvz4LzJYW/MSOrsT2IJ/4e5I4lsweUswkL+tGj7/udjeHUITFwKgjb5T6+Hv5oR5jh
	aPCg3aLRR6qNumG82ZLuBa/YMOfJTAL8=
X-Received: by 2002:a05:6512:400c:b0:5ae:b260:cf4b with SMTP id
 2adb3069b0e04-5aeb260d09emr1686299e87.64.1782746189818; Mon, 29 Jun 2026
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
In-Reply-To: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 29 Jun 2026 17:16:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
X-Gm-Features: AVVi8CdVLP70R0zK3UrM3FilV6lOIfpGj5d14bmmpB0rSBs-JGFC2A3o7FL3oPo
Message-ID: <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: =?UTF-8?Q?Lucas_de_Lima_N=C3=B3brega?= <lucaslnobrega38@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
<lucaslnobrega38@gmail.com> wrote:
>
> EAS currently refuses to enable energy-aware scheduling on a root
> domain unless schedutil is the active CPUFreq governor for all of its
> CPUs (cpufreq_ready_for_eas()). This requirement exists to protect the
> accuracy of the energy estimate: EAS predicts the OPP a CPU will run
> at from its utilization, which is only meaningful if the active
> governor actually requests OPPs that way, and schedutil is the only
> one that does.
>
> That requirement does not apply to artificial Energy Models
> (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> get_cost() callback instead of real power numbers, and only encodes a
> cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> given utilization). It never claims to predict real energy use at any
> specific OPP, so there is no per-OPP accuracy for the governor
> requirement to protect, regardless of which governor is in control or
> whether it tracks utilization at all.

But it is still about comparing the cost of running on different CPUs
at different performance levels.

For instance, say the scale-invariant utilization of a task is 256 and
it can run either by itself on a P-core, or with another task whose
utilization is 128 on an E-core, and say the P-core's and E-core's
capacity is 1024 and 512, respectively.

Say the cost function tells EAS that running a P-core at 1/4 of the
capacity is cheaper than running an E-core at 3/4 capacity, so it will
pick up the P-core to run that task, but if cpufreq ramps up the
frequency of the P-core to the max when the task gets to it, it may
actually turn out to be more expensive.

This means that EAS still has an expectation regarding cpufreq which
is that it will generally tend to run tasks at the performance level
corresponding to the sum of their scale-invariant utilization at least
roughly.

IIUC this actually has nothing to do with whether or not the energy
model used by EAS is artificial.  The schedutil requirement is about
choosing a performance level proportional to the utilization (which
schedutil generally tends to do by design).

> intel_pstate registers exactly this kind of artificial EM for hybrid
> (P/E-core) systems without SMT, regardless of whether it operates in
> active or passive mode. In active mode it never uses schedutil, since
> HWP picks frequency autonomously, so on these systems EAS never
> engages even though SD_ASYM_CPUCAPACITY, frequency invariance and the
> EM are all in place: find_energy_efficient_cpu() is never reached
> because is_rd_overutilized() is hardcoded to true whenever
> sched_energy_enabled() is false. cppc_cpufreq registers the same kind
> of ranking-only artificial EM and is affected the same way with any
> non-schedutil governor.
>
> Allow EAS to be enabled when every CPU's EM in the root domain is
> artificial, even when schedutil is not the active governor.
>
> Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pstate in
> active/HWP mode: find_energy_efficient_cpu() was never called before
> this change (confirmed via the sched_overutilized_tp tracepoint and
> ftrace) and is exercised as expected afterwards.

If this is about allowing EAS to work with intel_pstate running in the
active mode, you may argue that what the processor firmware is doing
when intel_pstate runs in the active mode is not much different from
what schedutil would do.  So a driver implementing an internal
governor (that is, using the .set_policy() callback) would need to
declare that its internal governor is as good as schedutil from EAS'
perspective and so it will pass the "cpufreq readiness" check.

> Signed-off-by: Lucas de Lima N=C3=B3brega <lucaslnobrega38@gmail.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |  9 ++++--
>  Documentation/scheduler/sched-energy.rst      |  7 ++++-
>  kernel/sched/topology.c                       | 28 +++++++++++++++++--
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentatio=
n/admin-guide/pm/intel_pstate.rst
> index 25fe5d88f..c8fef1e60 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -409,13 +409,16 @@ Energy-Aware Scheduling Support
>  If ``CONFIG_ENERGY_MODEL`` has been set during kernel configuration and
>  ``intel_pstate`` runs on a hybrid processor without SMT, in addition to =
enabling
>  :ref:`CAS` it registers an Energy Model for the processor.  This allows =
the
> -Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler=
 if
> -``schedutil`` is used as the  ``CPUFreq`` governor which requires ``inte=
l_pstate``
> -to operate in the :ref:`passive mode <passive_mode>`.
> +Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler=
.
>
>  The Energy Model registered by ``intel_pstate`` is artificial (that is, =
it is
>  based on abstract cost values and it does not include any real power num=
bers)
>  and it is relatively simple to avoid unnecessary computations in the sch=
eduler.
> +Because of that, EAS does not require ``schedutil`` to be used as the
> +``CPUFreq`` governor in this case: the cost ranking it relies on does no=
t
> +depend on the governor tracking utilization when requesting frequencies,=
 so
> +EAS works the same way regardless of whether ``intel_pstate`` operates i=
n the
> +active or in the :ref:`passive mode <passive_mode>`.
>  There is a performance domain in it for every CPU in the system and the =
cost
>  values for these performance domains have been chosen so that running a =
task on
>  a less performant (small) CPU appears to be always cheaper than running =
that
> diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/sch=
eduler/sched-energy.rst
> index 4e47aaf10..c23ca226d 100644
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -379,7 +379,12 @@ Consequently, the only sane governor to use together=
 with EAS is schedutil,
>  because it is the only one providing some degree of consistency between
>  frequency requests and energy predictions.
>
> -Using EAS with any other governor than schedutil is not supported.
> +Using EAS with any other governor than schedutil is not supported, unles=
s the
> +EM in use is artificial (see EM_PERF_DOMAIN_ARTIFICIAL).  An artificial =
EM only
> +encodes a cost ranking between CPUs/OPPs instead of a real power table, =
so it
> +does not make any claim about energy use at a specific OPP and its concl=
usions
> +do not depend on the governor actually tracking utilization when request=
ing
> +frequencies.
>
>
>  6.5 Scale-invariant utilization signals
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5847b83d9..124a4bb4d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -212,6 +212,27 @@ static unsigned int sysctl_sched_energy_aware =3D 1;
>  static DEFINE_MUTEX(sched_energy_mutex);
>  static bool sched_energy_update;
>
> +/*
> + * An artificial EM (see EM_PERF_DOMAIN_ARTIFICIAL) only encodes a cost
> + * ranking between CPUs and does not claim to predict energy use at any
> + * particular OPP.  Unlike a real power-based EM, its conclusions do not
> + * rely on the active governor tracking utilization when selecting
> + * frequencies, so the schedutil requirement below does not apply to it.
> + */
> +static bool perf_domains_are_artificial(const struct cpumask *cpu_mask)
> +{
> +       int i;
> +
> +       for_each_cpu(i, cpu_mask) {
> +               struct em_perf_domain *pd =3D em_cpu_get(i);

I would do

if (!pd)
        continue;

here because the CPUs without a PD simply don't matter.

Also, is any synchronization needed for this?

And should it go into the EM code?

> +
> +               if (!pd || !em_is_artificial(pd))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>  {
>         bool any_asym_capacity =3D false;
> @@ -249,7 +270,8 @@ static bool sched_is_eas_possible(const struct cpumas=
k *cpu_mask)
>                 return false;
>         }
>
> -       if (!cpufreq_ready_for_eas(cpu_mask)) {
> +       if (!cpufreq_ready_for_eas(cpu_mask) &&
> +           !perf_domains_are_artificial(cpu_mask)) {



>                 if (sched_debug()) {
>                         pr_info("rd %*pbl: Checking EAS: cpufreq is not r=
eady\n",
>                                 cpumask_pr_args(cpu_mask));
> @@ -403,7 +425,9 @@ static void sched_energy_set(bool has_eas)
>   *    1. an Energy Model (EM) is available;
>   *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarc=
hy.
>   *    3. no SMT is detected.
> - *    4. schedutil is driving the frequency of all CPUs of the rd;
> + *    4. schedutil is driving the frequency of all CPUs of the rd, or th=
e EM
> + *       of all of them is artificial (i.e. a cost ranking rather than a
> + *       real power table, see EM_PERF_DOMAIN_ARTIFICIAL);
>   *    5. frequency invariance support is present;
>   */
>  static bool build_perf_domains(const struct cpumask *cpu_map)
> --
> 2.54.0
>
