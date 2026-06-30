Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1A395AC7
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807083; cv=pass; b=euth3P6jAB7K6kmyZGEQVG3FUTGCxxN31NsKjIBVot6Wvt3xJln0HscUDgPJtgZTeA1Uwljccyeagi8NKNeELB5jPzfjGrsKQwKrXGJlHN/fohDttxOpP+6EMzWHtl6TjkoJdXjTDoyn6bdQT1h1Vx9K0BY+2q6dsJ51zhvQXmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807083; c=relaxed/simple;
	bh=3CRqg4jjJBFOEEQUI8942ovOs3MSz8reLt9alwmH2Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnZRg+PIXPu1t+7fc9H8Abz+L3A8Zr7mwO3UB9D/gWWXOGiISbf0g7kNmo+FIe4j4HaghQUnwSqMLQahLJMZwLoLEIMrv+na4x4WfKLJYICKC8seMC5Bow/9w773J50nnpw0HoDNN12hV/WiKtEICrXl/pLKW14ePDPEBvZnWXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iufYDOjd; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iufYDOjd"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39b237fb695so1907771fa.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 01:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782807080; cv=none;
        d=google.com; s=arc-20260327;
        b=hBrW1gRAKZNZ8V3NQ3wPEI2a/gjOUXTj7GAPz2LJ/GirLWo/Ztwhj4CByYFb01wsnP
         itfbd5Kr2aQPZxoj85kZpEb2TMtuFLJRhp7+c2D/iRPrY5Ds8ovg9JY6fB7IJ2AqFR7w
         xOxQmUadfixxb9CMaUC6eXGViuqedJoIYiaJOv/4CCX/NYkugTBM1wQM59WhiBKSuyId
         pojEP9HsuygrRDZ/lHfqKTzIDVoJS9egyfFikXCQeCEsRKWxrv9DkzdU4bQiwRMzYLOl
         m5xG7Lopzva1W9oVNGaNjpQywP3BB6zzYXFLfX3F7G5KdBqcAN9+YJFYmioDpaJcWfUQ
         AO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIFNyBiGV125IWoTbnKZBjGH67zjqTCIkC6QJio46H8=;
        fh=siGeZjU0elVRfP3DBmUENrD89ZU0kLZiSbsOYAFiTpE=;
        b=i5QjEe8/0ADdGmqCfQXruFsvE4VGf3syC199wxFYIDzgYzgCH8r+F1rw+bzPgzAdMS
         7P8LmJxsggJFxem0gD8N2CDEgH0kAM55fwIFfMH8Cwz/+pY7FRAaJHvHbcakRovKZCLA
         clise6ZVm9/nP4/LZto33qiOEl9sn+sbFZXqJEmBpHyj+12gJriuc8gpBPRFhso3tIoI
         4SMX50pSXqyrl7PBiksy4mg0IO2vMwy2sIHObWHjw1fbXfCtI6nonjmrMJoD+6xACXBI
         nrXWLvqwrVhrlS+wbaLUDrcOCD/gXfUVb5K4+Q0L66rb19T6TfuyoGeDcczOY8zSzwP1
         qBVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782807080; x=1783411880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIFNyBiGV125IWoTbnKZBjGH67zjqTCIkC6QJio46H8=;
        b=iufYDOjdYk0okCaFTB0r7dUmStmH3pa11qY+Q6kUIpywK31XfoPuxkZpftFUCHVOSU
         ExIy9R3kfe2n0/lT2hoDbPOlRj+ggbxLyqydy/rXDBGPITrs04Q8WeRxx1ARnGCNkVc2
         hSgT9ZFdskYa0nVDNuNPJJYdZ/z8YOjSr34L3bR1l4aEJkLH+pnSs8noTx5ZGj35pQct
         uUZg85LGGjgLMTcO1fa9mmM4idS6FSRW3WZqY7a8xXKzfO1rq1EO9Lfi2ikzOM0irTrj
         GgDimL176VojqvPHurttq7EO/w8EZkOwMwlQpUR3lZ19whvxDW6CBVbRGMKT0m2nydia
         OZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782807080; x=1783411880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIFNyBiGV125IWoTbnKZBjGH67zjqTCIkC6QJio46H8=;
        b=edUDIYwxTuH4OlEfR9MMumD/planAz4Qk9nMc8H1K8FOWhCXe2mVuz23otCuih5Jlv
         +dutRUPjzy/CliLqOAIHJM3M/b6JO0EAp9f4EiJSO3gCv1pFs4Wxs/lg2Dor86CdJigH
         k1u7QK3vU4+cQ6LNm2kGWg8Aff1m90djKK1APRjlSp2b/qyguXlB6odJlLOk5SxMtNIu
         E5tbHiabz3XjprwrYrYiAG09kC6OyvyiuqDOIk30V2/Ev89XXZ49FUw2aDHKDU14ji72
         EkrSdcUElVBO795frQibND7Oj5Jwh/nFNOfs3lUvAfLUygbo6uT4KBI4oWTYPb+O/UeN
         t2Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rph1IyF0DaPIRLuJnxKkmtlX5dO5Wwnv2qWwGGXFdRocovCZQtxHoqr1HJs5feHMGbJkMxgX+G+hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhKCRDxIAjhzbcKcR62LSxZFVjGNxgXfGUVrhPnC0JFWAGGrr
	EaASdWb8IvPt2/Ef6QM0t9elFEUCbDNzMuX1E0Lb487y0I8ddpIY2imjlTkPVGoCcH6zU9NQR/+
	/iVEObj5Thtac7YSL30LN16lErSkaWZI=
X-Gm-Gg: AfdE7cl+hicF8C8BPZl6V2FlUSiBaixSxoERu4SjXugdrGrHnEzVjv/kBspxlWbpLTJ
	ncLY7HZeDDDwNJ+nTBTBlanFZoQNH9x1uIJT4oq4Bdv1FbNxv1AdSS54TyljcOpdkjCDSnXSMvH
	+8qXacjrFRmhlZ/JzUrisz+Ov6Fd9PZ3ctJ1HMTOsUAvqhURprXMG2X2Ya1R3yu9NvhBk9UqsCx
	faBZkIX16dAq23S5MZS1frZ+iAnNkgT+D7jUiT52XQesvGu6aGOJ6xSsv4NRsFEdnug5p6cmI87
	s02S8YClfhCHUrYrg53uV4KUQQh3bok=
X-Received: by 2002:a2e:9657:0:b0:396:668f:b7f9 with SMTP id
 38308e7fff4ca-39b1ddfdee0mr4316791fa.24.1782807079383; Tue, 30 Jun 2026
 01:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com> <6021784.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6021784.DvuYhMxLoT@rafael.j.wysocki>
From: Lucas Lima <lucaslnobrega38@gmail.com>
Date: Tue, 30 Jun 2026 05:11:06 -0300
X-Gm-Features: AVVi8CdboQGFGMh_5EKoVOk7TQrzmHfNsXbHneuVGM6SxXOiX2PsDmgqMWtLEV0
Message-ID: <CAMVixxV83tSLEi_o1vmHjqfgPnnXDwo2LjP_m-Y7iEWfvUAP2g@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 29 de jun. de 2026 =C3=A0s 16:06, Rafael J. Wysocki
<rafael@kernel.org> escreveu:
>
> On Monday, June 29, 2026 5:16:17 PM CEST Rafael J. Wysocki (Intel) wrote:
> > On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
> > <lucaslnobrega38@gmail.com> wrote:
> > >
> > > EAS currently refuses to enable energy-aware scheduling on a root
> > > domain unless schedutil is the active CPUFreq governor for all of its
> > > CPUs (cpufreq_ready_for_eas()). This requirement exists to protect th=
e
> > > accuracy of the energy estimate: EAS predicts the OPP a CPU will run
> > > at from its utilization, which is only meaningful if the active
> > > governor actually requests OPPs that way, and schedutil is the only
> > > one that does.
> > >
> > > That requirement does not apply to artificial Energy Models
> > > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > > get_cost() callback instead of real power numbers, and only encodes a
> > > cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> > > given utilization). It never claims to predict real energy use at any
> > > specific OPP, so there is no per-OPP accuracy for the governor
> > > requirement to protect, regardless of which governor is in control or
> > > whether it tracks utilization at all.
> >
> > But it is still about comparing the cost of running on different CPUs
> > at different performance levels.
> >
> > For instance, say the scale-invariant utilization of a task is 256 and
> > it can run either by itself on a P-core, or with another task whose
> > utilization is 128 on an E-core, and say the P-core's and E-core's
> > capacity is 1024 and 512, respectively.
> >
> > Say the cost function tells EAS that running a P-core at 1/4 of the
> > capacity is cheaper than running an E-core at 3/4 capacity, so it will
> > pick up the P-core to run that task, but if cpufreq ramps up the
> > frequency of the P-core to the max when the task gets to it, it may
> > actually turn out to be more expensive.
> >
> > This means that EAS still has an expectation regarding cpufreq which
> > is that it will generally tend to run tasks at the performance level
> > corresponding to the sum of their scale-invariant utilization at least
> > roughly.
> >
> > IIUC this actually has nothing to do with whether or not the energy
> > model used by EAS is artificial.  The schedutil requirement is about
> > choosing a performance level proportional to the utilization (which
> > schedutil generally tends to do by design).
> >
> > > intel_pstate registers exactly this kind of artificial EM for hybrid
> > > (P/E-core) systems without SMT, regardless of whether it operates in
> > > active or passive mode. In active mode it never uses schedutil, since
> > > HWP picks frequency autonomously, so on these systems EAS never
> > > engages even though SD_ASYM_CPUCAPACITY, frequency invariance and the
> > > EM are all in place: find_energy_efficient_cpu() is never reached
> > > because is_rd_overutilized() is hardcoded to true whenever
> > > sched_energy_enabled() is false. cppc_cpufreq registers the same kind
> > > of ranking-only artificial EM and is affected the same way with any
> > > non-schedutil governor.
> > >
> > > Allow EAS to be enabled when every CPU's EM in the root domain is
> > > artificial, even when schedutil is not the active governor.
> > >
> > > Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pstate =
in
> > > active/HWP mode: find_energy_efficient_cpu() was never called before
> > > this change (confirmed via the sched_overutilized_tp tracepoint and
> > > ftrace) and is exercised as expected afterwards.
> >
> > If this is about allowing EAS to work with intel_pstate running in the
> > active mode, you may argue that what the processor firmware is doing
> > when intel_pstate runs in the active mode is not much different from
> > what schedutil would do.  So a driver implementing an internal
> > governor (that is, using the .set_policy() callback) would need to
> > declare that its internal governor is as good as schedutil from EAS'
> > perspective and so it will pass the "cpufreq readiness" check.
>
> And I have a prototype patch (on top of 7.2-rc1) doing this which is
> appended.
>
> I wonder if it works for you (that is, if it allows intel_pstate and EAS =
to
> work together both with schedutil and when intel_pstate operates in the
> active mode with the "powersave" policy on your system).

It does work, thank you.

>
> Also I wonder why exactly you want intel_pstate in the active mode to
> work with EAS.  Do you see any significant improvement in that case?

About that specific topic i do not have any testing data, but it felt
like schedutil drains more battery than pstate active (likely due to
worse c-states management) and presents more stutters in general usage
(I would guess it's slower to react to load changes). After bypassing sched=
util
those very observations were gone, and the responsiveness of the system
looked very similar to EAS disabled, pstate active. Since EAS does
prioritize spreading
onto E cores, which do consume less energy by my testing, IMHO it's
almost too good
to be leaving it unused.

I also want to point out that gaming (mainly minecraft) stutters a lot more=
 with
EAS on, even when pstate is set to active. So i wonder what do you think ab=
out
capturing the system power mode (currently only clamps frequency) and
disabling eas_compatible when set to "performance"? That would need
updating cpufreq_policy, but feels reasonable to let the user disable EAS
for latency sensitive tasks, since E cores struggle at those.

I also want to point out that gaming (mainly Minecraft) stutters a lot
more with EAS,
even when pstate is set to active. So I wonder what you think about
capturing the
platform power profile (via the platform_profile subsystem) and
disabling eas_compatible
when set to "performance"? That would need a notifier from
platform_profile to re-evaluate eas_compatible
across active policies when the profile changes at runtime, but feels
reasonable to let the
user disable EAS for latency-sensitive tasks, since E-cores struggle at tho=
se.

I know that for now, my observations are only anecdotal, but if needed
I'm eager to test those assumptions!

>
> ---
>  drivers/cpufreq/cpufreq.c        |    2 +-
>  drivers/cpufreq/intel_pstate.c   |   11 +++++++++++
>  include/linux/cpufreq.h          |   16 +++++++---------
>  kernel/sched/cpufreq_schedutil.c |    7 ++-----
>  4 files changed, 21 insertions(+), 15 deletions(-)
>
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -3058,7 +3058,7 @@ static bool cpufreq_policy_is_good_for_e
>                 return false;
>         }
>
> -       return sugov_is_governor(policy);
> +       return policy->eas_compatible;
>  }
>
>  bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2921,6 +2921,9 @@ static int intel_pstate_set_policy(struc
>                 if (!hwp_boost)
>                         intel_pstate_clear_update_util_hook(policy->cpu);
>                 intel_pstate_hwp_set(policy->cpu);
> +
> +               policy->eas_compatible =3D hwp_is_hybrid &&
> +                               cpu->policy !=3D CPUFREQ_POLICY_PERFORMAN=
CE;
>         }
>         /*
>          * policy->cur is never updated with the intel_pstate driver, but=
 it
> @@ -2930,6 +2933,9 @@ static int intel_pstate_set_policy(struc
>
>         mutex_unlock(&intel_pstate_limits_lock);
>
> +       if (policy->eas_compatible)
> +               em_rebuild_sched_domains();
> +
>         return 0;
>  }
>
> @@ -3030,6 +3036,11 @@ static void intel_pstate_cpu_exit(struct
>         pr_debug("CPU %d exiting\n", policy->cpu);
>
>         policy->fast_switch_possible =3D false;
> +
> +       if (policy->eas_compatible) {
> +               policy->eas_compatible =3D false;
> +               em_rebuild_sched_domains();
> +       }
>  }
>
>  static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -118,6 +118,13 @@ struct cpufreq_policy {
>         bool                    strict_target;
>
>         /*
> +        * Set if the current governor meets EAS' expectations regarding
> +        * performance scaling (that is, it selects performance levels
> +        * proportional to CPU utilization at least roughly).
> +        */
> +       bool                    eas_compatible;
> +
> +       /*
>          * Set if inefficient frequencies were found in the frequency tab=
le.
>          * This indicates if the relation flag CPUFREQ_RELATION_E can be
>          * honored.
> @@ -657,15 +664,6 @@ module_exit(__governor##_exit)
>  struct cpufreq_governor *cpufreq_default_governor(void);
>  struct cpufreq_governor *cpufreq_fallback_governor(void);
>
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> -bool sugov_is_governor(struct cpufreq_policy *policy);
> -#else
> -static inline bool sugov_is_governor(struct cpufreq_policy *policy)
> -{
> -       return false;
> -}
> -#endif
> -
>  static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *po=
licy)
>  {
>         if (policy->max < policy->cur)
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -797,6 +797,7 @@ out:
>          * Schedutil is the preferred governor for EAS, so rebuild sched =
domains
>          * on governor changes to make sure the scheduler knows about the=
m.
>          */
> +       policy->eas_compatible =3D true;
>         em_rebuild_sched_domains();
>         mutex_unlock(&global_tunables_lock);
>         return 0;
> @@ -839,6 +840,7 @@ static void sugov_exit(struct cpufreq_po
>         sugov_policy_free(sg_policy);
>         cpufreq_disable_fast_switch(policy);
>
> +       policy->eas_compatible =3D false;
>         em_rebuild_sched_domains();
>  }
>
> @@ -931,9 +933,4 @@ struct cpufreq_governor *cpufreq_default
>  }
>  #endif
>
> -bool sugov_is_governor(struct cpufreq_policy *policy)
> -{
> -       return policy->governor =3D=3D &schedutil_gov;
> -}
> -
>  cpufreq_governor_init(schedutil_gov);
>
>
>
