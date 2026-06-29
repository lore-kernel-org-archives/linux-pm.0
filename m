Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E837F8C9
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767587; cv=pass; b=PcPV/hcUipTTszMqkqcOE1y8kA+HI222tQAZLMX3K5xiK9p1O9o3xicozRbahSv/9IO0PpvKI5/ujwWZdHIK5CHzjSS8oIAGLpF40r0uy/0o3ePhucu7t8NorJxw6bc/7dsadzIdwmSmeTEXAbhSWZU7V3kE9EsuAgWm0VEXZX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767587; c=relaxed/simple;
	bh=2U11dd3c7MU/cITIimxfZJB1UDDsbWaV0aAb5l/6KzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThSOmqra6As5mCBauZm9zq+g5UxlfdlF0YhGMda2lrQrPBw2qiMY6asUUHWzvAquOE4pJmE82VDE+JjpgvOEnXnhrJkCJvJFixmh67S4yZC0Y1gF/HU/81qa1ybb3HWfZdCulY/CX6Vs7AB1ayotBRvcpzNgYiC3ws8/QTJdcoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTNK4MJC; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTNK4MJC"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so1349439e87.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782767583; cv=none;
        d=google.com; s=arc-20260327;
        b=GCY5dftTic2zbC48QAKUVOkJHQgnLf73Q7HEgNYqtMVfK6sj3BWplebuRDg7uF8k2P
         UY1Dp1+icMk3KGqMiXbAp3T+kr2kNj+/cnrFp61mKhw+uSc3N23xVOOmkAFh9qjy1Oei
         206HsOwENViFTLtJwW3e+oSqabj2P7nTHIz0rMDafWNnHpTNA6aKxEx8YrsxOrWfMu6r
         KQtDaD3q01m1fhwyCvJKXeMg8uD8wJdra9Y3Z/YcDeynUrBfnOZJhS7DvnTDlf5vBde2
         4ROL7v1lo6aK0505KiOLQ3pUDSUJVnVGxyCR+/PfZtlm5iNz7wKjleBg66UtSmzEKXOV
         c4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+REWoDpnZnXowg1qoaQ9RmZvqVtyWxBL4m5S7IFqaw=;
        fh=txrFtQw0UAtJ+nR4L4NhJr8JKYuCSWFKV7CzTv1WsFc=;
        b=ArPQMEujNRmnqxm1GZ5wNub51jagKZzEqc/JFkG2WXYp1Hy8Db2v4QZowhyOC3BQdx
         a3ouL9WmVbFNdNDEwcF8bDNuqKCRLIsQsGjDmPsWeZ5kJcgbY0r00tfSLca/FalwQJgE
         hW5gF9vbYlQtnMouOCC7bqJ4qn/VBhW5YFwLqBj93x7jC4bMDYRI8ln+P7WdH4kkKpS/
         hCUKYmM2vaHxhUXjFiXb6e9rzQAicsKAwF0pBSdZDnWSOa5vU21l9H1pqw7zGWRQ4I/t
         RxpK0TiL4nGZA6rPGlN4C2bYUj9Tg2BarVx4TPbSCpATgU9IsnbgzAUvTP4+O0CwxlRP
         GExQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782767583; x=1783372383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+REWoDpnZnXowg1qoaQ9RmZvqVtyWxBL4m5S7IFqaw=;
        b=OTNK4MJCclBAUN8589wUiPXdyTSAHbTP1Rkth6sw7pk9c/JLEYkNxZc0SV10wTaa/7
         uWxhNymlRL/UG2pPAIwnRejmzdNfobyN2W48O/YKvbf1gSr9w2WPNbK04Tqb4pkKDyhF
         rrrEpy5/evEHEGnaO2TJMFJbSED8sanc+iLF/gfYWZ2AM8PiMBSaPvVuusDOgQTFA3As
         uxVteM2JShaFfd59fS0xnsfqKpXLf7nHvITZv7lrUFP0FkEjZ0PTi6bHKqn3iTy35xDg
         0ynPJ5TmEzxMnwxPpN3lBj91GxSgAkx/7WIyu/HOIQXqCLj/Lk4Tf6a7HzIayUWVEvIU
         P5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767583; x=1783372383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+REWoDpnZnXowg1qoaQ9RmZvqVtyWxBL4m5S7IFqaw=;
        b=RmEdbNLHlT3WT/MnwHSS/+aTUS1Yfoe4STCcUcyYu+B76EawDcg9IRK8OkOdPkmuNY
         cnDvQsr02NnXEIgb7JFkV0sidlCh8BhMGxAEhEpfakxZ7Wd2MHtb93atPuZCFY8CWL0O
         hP0gtlm5GwbYKvofMddD0jvZkac3pln91Cfe+D2IB4+59pt5uDLtxrGO0/x6GVMN0eUQ
         3qcKV751gtg/oWAjT/0jTmr0IOImc7y2050lzgJCUoEfO8lb3xmaxrx/8zGvZFRsrXHP
         bXhprNcW78qRO9sqCY2kZJASBLHeDCm4GpE7iUOBkEDdXb1TtV1ErzvN8F3CYByqL7cT
         iHOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX7GwpObtD+8JbPijMqugnIGCisEYkwzwEorVqC70eMya+UMSOVZuC/gH/t+u/hHGXnSPClmzelw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBSu835qKo4TeCyj+QalRAs9f3gauD8awdqLN9ZlmU92EgBiO
	ulfhAUjp6CVW8A++iRobgAWNMLnxFJ+UitB7C/cDPpfpI3dzE3bO5G6sIujFsi0qknwZEqazjlg
	BYzdJffgwPQutNv41pbdvSw8YJPNOR6Y=
X-Gm-Gg: AfdE7cncsaYFBUNtjQUhysO7zt/lFpmRaa3/XkAT74Q7+oDmLYs3d63UrjHNF6FjSb2
	fqNUXIcUhuwBsNkYbvq+/MY2c5WAdds0j/9T2UdWBSOXANL5DVgNJUfIY2R3iCM+NUED/pTP31e
	yzxWI2B6VhO87xlnYGYERGDtIxHGorSSjBylvd2iYyrCjlM4OkQ1v20xj6FL1LF+Ycgs3Q+kR4A
	445hBtKSWPfmhVQAwq5w+oF9cv9Gu9TDz3GnzfDTDdLlEQVnvLQpsz60KdUbI98zhduLn5XcyGW
	XHGAMz5G0JMihCiclPJMYXAKMVcMBno=
X-Received: by 2002:a05:6512:61ae:b0:5ae:b0c3:bb89 with SMTP id
 2adb3069b0e04-5aebdbdb349mr193180e87.63.1782767582911; Mon, 29 Jun 2026
 14:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com> <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
From: Lucas Lima <lucaslnobrega38@gmail.com>
Date: Mon, 29 Jun 2026 18:12:50 -0300
X-Gm-Features: AVVi8CdwHxbLA63H991JC71Qw8Csnfm7fyJpV5N4UeMOhX-QPUILwCYNDZFvhoc
Message-ID: <CAMVixxWkriVFgvS_WBVJu3LYGJYOcEx50hpr2TrNnPi-1O7mjw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 29 de jun. de 2026 =C3=A0s 12:16, Rafael J. Wysocki (Intel)
<rafael@kernel.org> escreveu:
>
> On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
> <lucaslnobrega38@gmail.com> wrote:
> >
> > EAS currently refuses to enable energy-aware scheduling on a root
> > domain unless schedutil is the active CPUFreq governor for all of its
> > CPUs (cpufreq_ready_for_eas()). This requirement exists to protect the
> > accuracy of the energy estimate: EAS predicts the OPP a CPU will run
> > at from its utilization, which is only meaningful if the active
> > governor actually requests OPPs that way, and schedutil is the only
> > one that does.
> >
> > That requirement does not apply to artificial Energy Models
> > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > get_cost() callback instead of real power numbers, and only encodes a
> > cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> > given utilization). It never claims to predict real energy use at any
> > specific OPP, so there is no per-OPP accuracy for the governor
> > requirement to protect, regardless of which governor is in control or
> > whether it tracks utilization at all.
>
> But it is still about comparing the cost of running on different CPUs
> at different performance levels.
>
> For instance, say the scale-invariant utilization of a task is 256 and
> it can run either by itself on a P-core, or with another task whose
> utilization is 128 on an E-core, and say the P-core's and E-core's
> capacity is 1024 and 512, respectively.
>
> Say the cost function tells EAS that running a P-core at 1/4 of the
> capacity is cheaper than running an E-core at 3/4 capacity, so it will
> pick up the P-core to run that task, but if cpufreq ramps up the
> frequency of the P-core to the max when the task gets to it, it may
> actually turn out to be more expensive.
>
> This means that EAS still has an expectation regarding cpufreq which
> is that it will generally tend to run tasks at the performance level
> corresponding to the sum of their scale-invariant utilization at least
> roughly.
>
> IIUC this actually has nothing to do with whether or not the energy
> model used by EAS is artificial.  The schedutil requirement is about
> choosing a performance level proportional to the utilization (which
> schedutil generally tends to do by design).

You're right, and I want to walk back the "artificial EM doesn't need
this" framing entirely -- it doesn't survive your example. What I want
to argue instead is narrower: that even though intel_pstate active
mode tracks demand much more weakly than schedutil, the specific
conclusion this simplified EM's cost ranking relies on (E-cores cost
less than P-cores at matched conditions) still holds up against
measured energy, and that's a different, more modest claim than "OPP
tracks utilization closely enough for per-bin accuracy."

I measured the actual frequency behavior on this test machine (one
P-core, one E-core, isolated, stress-ng --cpu-load duty cycles at
20/40/60/80/100%, turbostat Bzy_MHz =3D average frequency only during
the busy portion of each cycle) under three regimes:

                    20%    40%    60%    80%   100%   span
  passive+schedutil  P    2523   2879   3786   4537   4567  2044
                      E    2335   2416   2574   3070   3399  1064
  active EPP=3Dbalance  P   2225   2285   2497   2646   2778   553
                      E   2101   2215   2375   2462   2555   454
  active EPP=3Dperf     P   4483   4519   4496   4537   4564    81
                      E   3364   3377   3380   3387   3399    35

It is visible now that intel_pstate active
mode does *not* track demand anywhere near as tightly as schedutil,
and i don't think that claim survives scrutiny, dropping it.

What does survive, I think, is narrower: E-cores measured consistently
cheaper per unit of completed work than P-cores, across every matched-
parallelism configuration I tested (data below), regardless of which
exact OPP HWP autonomously picked underneath. I don't have data on
idle-state residency to know truly whether the race-to-idle behavior under
EPP=3Dperformance recovers any of that gap through deeper C-states --
that's an open question I haven't tested.

  1 core alone:          P 7.27 J/unit   E 6.25 J/unit   (P +16%)
  1 core, packed x2:     P 7.24 J/unit   E 6.13 J/unit   (P +18%)
  2 cores, spread:       P 4.84 J/unit   E 3.82 J/unit   (P +27%)

P consistently costs more than E for the same completed work at every
matched parallelism level I tried. Separately, I also measured that
spreading work across more E-cores is itself far more efficient than
packing it onto fewer (8 E-cores spread: 1.74 J/unit vs the same total
work packed onto 1 E-core: 6.10 J/unit. In fact, this is the most
efficient placement --
even better than global spreading) -- I also have traced
find_energy_efficient_cpu()
produced spread placement in practice under this patch with real tasks,
and it roughly does follow this heavy preference for E cores during light l=
oad.
Note: P cores occasionally seem to spike, likely due to misfit tasks
which are larger
than E core capacity when nosmt=3Dforce is active  (512). To place E
cores capacities
at half of P cores' feels weird, as the vast majority of workloads enjoy on=
ly a
40-60% performance disparity between them both (the outliers observed are
mostly float point heavy tasks, software ipc class 2).

>
> > intel_pstate registers exactly this kind of artificial EM for hybrid
> > (P/E-core) systems without SMT, regardless of whether it operates in
> > active or passive mode. In active mode it never uses schedutil, since
> > HWP picks frequency autonomously, so on these systems EAS never
> > engages even though SD_ASYM_CPUCAPACITY, frequency invariance and the
> > EM are all in place: find_energy_efficient_cpu() is never reached
> > because is_rd_overutilized() is hardcoded to true whenever
> > sched_energy_enabled() is false. cppc_cpufreq registers the same kind
> > of ranking-only artificial EM and is affected the same way with any
> > non-schedutil governor.
> >
> > Allow EAS to be enabled when every CPU's EM in the root domain is
> > artificial, even when schedutil is not the active governor.
> >
> > Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pstate in
> > active/HWP mode: find_energy_efficient_cpu() was never called before
> > this change (confirmed via the sched_overutilized_tp tracepoint and
> > ftrace) and is exercised as expected afterwards.
>
> If this is about allowing EAS to work with intel_pstate running in the
> active mode, you may argue that what the processor firmware is doing
> when intel_pstate runs in the active mode is not much different from
> what schedutil would do.  So a driver implementing an internal
> governor (that is, using the .set_policy() callback) would need to
> declare that its internal governor is as good as schedutil from EAS'
> perspective and so it will pass the "cpufreq readiness" check.

Given the data above, I don't think I can honestly word that
declaration as "as good as schedutil" -- it isn't, by a factor of
2-25x depending on EPP. If a flag like this still makes sense, I'd
want its justification to say something narrower: "this driver's
internal governor, combined with this EM's coarse type-based ranking,
still produces correct placement decisions in practice" rather than
claiming OPP-tracking parity. I'm not sure if that's a distinction
that belongs in the flag's contract itself, or just in this
patch's commit message -- happy to go either way, or to test more
if that would help decide.

>
> > Signed-off-by: Lucas de Lima N=C3=B3brega <lucaslnobrega38@gmail.com>
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst |  9 ++++--
> >  Documentation/scheduler/sched-energy.rst      |  7 ++++-
> >  kernel/sched/topology.c                       | 28 +++++++++++++++++--
> >  3 files changed, 38 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentat=
ion/admin-guide/pm/intel_pstate.rst
> > index 25fe5d88f..c8fef1e60 100644
> > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > @@ -409,13 +409,16 @@ Energy-Aware Scheduling Support
> >  If ``CONFIG_ENERGY_MODEL`` has been set during kernel configuration an=
d
> >  ``intel_pstate`` runs on a hybrid processor without SMT, in addition t=
o enabling
> >  :ref:`CAS` it registers an Energy Model for the processor.  This allow=
s the
> > -Energy-Aware Scheduling (EAS) support to be enabled in the CPU schedul=
er if
> > -``schedutil`` is used as the  ``CPUFreq`` governor which requires ``in=
tel_pstate``
> > -to operate in the :ref:`passive mode <passive_mode>`.
> > +Energy-Aware Scheduling (EAS) support to be enabled in the CPU schedul=
er.
> >
> >  The Energy Model registered by ``intel_pstate`` is artificial (that is=
, it is
> >  based on abstract cost values and it does not include any real power n=
umbers)
> >  and it is relatively simple to avoid unnecessary computations in the s=
cheduler.
> > +Because of that, EAS does not require ``schedutil`` to be used as the
> > +``CPUFreq`` governor in this case: the cost ranking it relies on does =
not
> > +depend on the governor tracking utilization when requesting frequencie=
s, so
> > +EAS works the same way regardless of whether ``intel_pstate`` operates=
 in the
> > +active or in the :ref:`passive mode <passive_mode>`.
> >  There is a performance domain in it for every CPU in the system and th=
e cost
> >  values for these performance domains have been chosen so that running =
a task on
> >  a less performant (small) CPU appears to be always cheaper than runnin=
g that
> > diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/s=
cheduler/sched-energy.rst
> > index 4e47aaf10..c23ca226d 100644
> > --- a/Documentation/scheduler/sched-energy.rst
> > +++ b/Documentation/scheduler/sched-energy.rst
> > @@ -379,7 +379,12 @@ Consequently, the only sane governor to use togeth=
er with EAS is schedutil,
> >  because it is the only one providing some degree of consistency betwee=
n
> >  frequency requests and energy predictions.
> >
> > -Using EAS with any other governor than schedutil is not supported.
> > +Using EAS with any other governor than schedutil is not supported, unl=
ess the
> > +EM in use is artificial (see EM_PERF_DOMAIN_ARTIFICIAL).  An artificia=
l EM only
> > +encodes a cost ranking between CPUs/OPPs instead of a real power table=
, so it
> > +does not make any claim about energy use at a specific OPP and its con=
clusions
> > +do not depend on the governor actually tracking utilization when reque=
sting
> > +frequencies.
> >
> >
> >  6.5 Scale-invariant utilization signals
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 5847b83d9..124a4bb4d 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -212,6 +212,27 @@ static unsigned int sysctl_sched_energy_aware =3D =
1;
> >  static DEFINE_MUTEX(sched_energy_mutex);
> >  static bool sched_energy_update;
> >
> > +/*
> > + * An artificial EM (see EM_PERF_DOMAIN_ARTIFICIAL) only encodes a cos=
t
> > + * ranking between CPUs and does not claim to predict energy use at an=
y
> > + * particular OPP.  Unlike a real power-based EM, its conclusions do n=
ot
> > + * rely on the active governor tracking utilization when selecting
> > + * frequencies, so the schedutil requirement below does not apply to i=
t.
> > + */
> > +static bool perf_domains_are_artificial(const struct cpumask *cpu_mask=
)
> > +{
> > +       int i;
> > +
> > +       for_each_cpu(i, cpu_mask) {
> > +               struct em_perf_domain *pd =3D em_cpu_get(i);
>
> I would do
>
> if (!pd)
>         continue;
>
> here because the CPUs without a PD simply don't matter.

That's fair. I will be updating the code to ignore cpus with no perf
domain. I also want to discuss whether or not is it worth it to
aggregate E clusters inside the same perf domain, as they share the
same L2 cache and
migrations are likely easier.

>
> Also, is any synchronization needed for this?

No additional sync besides what is already in use today. In fact, this
very pointer is dereferenced the same way in other paths of the
kernel.
