Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD07410D34
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823642; cv=none; b=YWosLFCRh8PL0wugPFBrL6w+AtE2et9lJs6iUBaedm4qRY+AtKPTcGOL4hhrsQKjpjOfil81x6gOgyfWAu4SHiG1FMUqGowbmmRhto9gDv2dInX768QzrPcwgqL9rp6O7ttdrmWJkesPI1PbfzN1dc/tFpESrhjGtJ6R5DHniXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823642; c=relaxed/simple;
	bh=ZVBeHha1k2vE2amoq3LsXDdvgPvbuiAS6/2YyjkZND0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjWDZHnaEreVEwsTDLh/RTUkn+iCvfOD8e19Jgv5I5CFxg1E8DBd8wzhS5yuhE9/1nKENz+0vt9hejW/FmoN1ZUUu2p1Cv4f0oRIjEq/chVsJf7saquiHUBYcN82svfvLOXuW7pEM9gB6L+1s0vygy8jRbMsgGD0L9TUlbWd0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miSxAtH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miSxAtH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9321F00A3E
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823640;
	bh=3hpl5N15Cp3bDGaVKf/IMkruIfT5vBza60oFnQTiN6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=miSxAtH2dRKj88p8sfRP2R2l2s8bIlqG7vsU5hZAPREtihCT/B8LUIiNXZgEeeZ8S
	 OW85tJ/kbEeDJI9qp2yO7tdET+8Pud38SWgNthKrOrIUXQ2iW3bTXCeQzlLuL7js/M
	 n+r+anG0lpga2QQru2p+L3CnqV4W3Ht+QUspvZPnUhxAn4/NKYUcFNcyi8FGItQd6y
	 oelA/eHbbM1TvJK3m+RcMVZ+PYfG2ArxmfsImdP6Y0XFQY6qRbZ9mEGRZ65oCnB6PN
	 fj9FNCn1fN1CUC1rv+NuIznzBH+KmGRmQQhkwtJEEFCS7YtaZ9qPDxcd3Q5/i9/nKy
	 qtNsmIYaMDf7w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so2149385e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 05:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp49Yj/6G4mgBelb6inUFQ27mrm9Z9VU5xCtO1A6DIYVFK9ZySMJf69xHegYCkp+YTLjkiKO50Iig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgwn/q0NJzx6Meg7VomkmlZG8cw05x+Qdw6zeSSVgJroaJN1cJ
	NC6QGGJ5SvnkinxvMXQ5fUv3FNJI8L1vDNQJpnBW3HSTAqoFOgZbbEqX0UEdui8v/OJUWwsZgTJ
	R23ov+Gl/wYjzS61oKOH1QwrY/7anoFM=
X-Received: by 2002:a05:6512:2520:b0:5ae:bb51:9d3d with SMTP id
 2adb3069b0e04-5aebdb88d77mr834195e87.15.1782823638974; Tue, 30 Jun 2026
 05:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com> <CAMVixxWkriVFgvS_WBVJu3LYGJYOcEx50hpr2TrNnPi-1O7mjw@mail.gmail.com>
In-Reply-To: <CAMVixxWkriVFgvS_WBVJu3LYGJYOcEx50hpr2TrNnPi-1O7mjw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 14:47:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7F0VXFqyN6Xmd4=D+pM4E5KXnbe_-2CZg5bex67oRjQ@mail.gmail.com>
X-Gm-Features: AVVi8Ceo33b48XBVc36p14q1rRSBhBn8RksP1tpVea80x12RdrQYaUlzPwCD6iY
Message-ID: <CAJZ5v0j7F0VXFqyN6Xmd4=D+pM4E5KXnbe_-2CZg5bex67oRjQ@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: Lucas Lima <lucaslnobrega38@gmail.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:13=E2=80=AFPM Lucas Lima <lucaslnobrega38@gmail.=
com> wrote:
>
> Em seg., 29 de jun. de 2026 =C3=A0s 12:16, Rafael J. Wysocki (Intel)
> <rafael@kernel.org> escreveu:
> >
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
>
> You're right, and I want to walk back the "artificial EM doesn't need
> this" framing entirely -- it doesn't survive your example. What I want
> to argue instead is narrower: that even though intel_pstate active
> mode tracks demand much more weakly than schedutil, the specific
> conclusion this simplified EM's cost ranking relies on (E-cores cost
> less than P-cores at matched conditions) still holds up against
> measured energy, and that's a different, more modest claim than "OPP
> tracks utilization closely enough for per-bin accuracy."
>
> I measured the actual frequency behavior on this test machine (one
> P-core, one E-core, isolated, stress-ng --cpu-load duty cycles at
> 20/40/60/80/100%, turbostat Bzy_MHz =3D average frequency only during
> the busy portion of each cycle) under three regimes:
>
>                     20%    40%    60%    80%   100%   span
>   passive+schedutil  P    2523   2879   3786   4537   4567  2044
>                       E    2335   2416   2574   3070   3399  1064
>   active EPP=3Dbalance  P   2225   2285   2497   2646   2778   553
>                       E   2101   2215   2375   2462   2555   454
>   active EPP=3Dperf     P   4483   4519   4496   4537   4564    81
>                       E   3364   3377   3380   3387   3399    35
>
> It is visible now that intel_pstate active
> mode does *not* track demand anywhere near as tightly as schedutil,
> and i don't think that claim survives scrutiny, dropping it.
>
> What does survive, I think, is narrower: E-cores measured consistently
> cheaper per unit of completed work than P-cores, across every matched-
> parallelism configuration I tested (data below), regardless of which
> exact OPP HWP autonomously picked underneath. I don't have data on
> idle-state residency to know truly whether the race-to-idle behavior unde=
r
> EPP=3Dperformance recovers any of that gap through deeper C-states --
> that's an open question I haven't tested.
>
>   1 core alone:          P 7.27 J/unit   E 6.25 J/unit   (P +16%)
>   1 core, packed x2:     P 7.24 J/unit   E 6.13 J/unit   (P +18%)
>   2 cores, spread:       P 4.84 J/unit   E 3.82 J/unit   (P +27%)
>
> P consistently costs more than E for the same completed work at every
> matched parallelism level I tried. Separately, I also measured that
> spreading work across more E-cores is itself far more efficient than
> packing it onto fewer (8 E-cores spread: 1.74 J/unit vs the same total
> work packed onto 1 E-core: 6.10 J/unit. In fact, this is the most
> efficient placement --
> even better than global spreading) -- I also have traced
> find_energy_efficient_cpu()
> produced spread placement in practice under this patch with real tasks,
> and it roughly does follow this heavy preference for E cores during light=
 load.
> Note: P cores occasionally seem to spike, likely due to misfit tasks
> which are larger
> than E core capacity when nosmt=3Dforce is active  (512). To place E
> cores capacities
> at half of P cores' feels weird, as the vast majority of workloads enjoy =
only a
> 40-60% performance disparity between them both (the outliers observed are
> mostly float point heavy tasks, software ipc class 2).
>
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
> Given the data above, I don't think I can honestly word that
> declaration as "as good as schedutil" -- it isn't, by a factor of
> 2-25x depending on EPP. If a flag like this still makes sense, I'd
> want its justification to say something narrower: "this driver's
> internal governor, combined with this EM's coarse type-based ranking,
> still produces correct placement decisions in practice" rather than
> claiming OPP-tracking parity.

Yes, that sounds better.

> I'm not sure if that's a distinction
> that belongs in the flag's contract itself, or just in this
> patch's commit message -- happy to go either way, or to test more
> if that would help decide.

I think that the point regarding the need to combine the given
governor with a "matching" EM is fair and it needs to be documented.
I'll try to find suitable wording.
