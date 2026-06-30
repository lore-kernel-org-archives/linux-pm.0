Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64E411688
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824833; cv=none; b=F0n6mlNRARpioiD1cjBfpirSM5zAZ5eM6UD5Li/OMstdMSahpIiOvNpbXXa9q6DpJNBkmhScoD29GV/aN9qFp3PYc9wFRe2g604TUa3DgMuQ5+MC5/4kYH+rVp20ZM4w7IkcTBtUlxKInk3VCb3sYYvwlYohTcdDHM9fff2jfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824833; c=relaxed/simple;
	bh=hkQVXksvs1+hoKg4jRPyHwvVG0kaAtmGUHOGd/K67MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQqq1Cv3W7uYHTL7Tsom/8yKZ3UcIVL38tARYyT/7dbwqT1hGnWm68hsA8n5Z6EsWDlANNgBXaOY3NV1pkDg50HaBgqPyyoHTdxdS6hwyqMthzyBJummxuYN8fI8AiqUcMjq9EqULIIoa7lMnVK1yryIgTkL9/4vkg7iq81c+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYv7X4Ni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYv7X4Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CAE1F01559
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782824831;
	bh=Gkte/lktTVRUYYoKzhVuxXn3p42paF+z9eeBGVuqlbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kYv7X4Nieka6wLjaDOnH5oIbtsHGXeJ0VQpyQhp+RzGxJyKpeoNq5mGU03rTDpI0M
	 4UTJRKALTzIa1uckXAT0eRvQeA0HmbWBOmv5ExDtqUOeSys4lpUYpsVwxgCnA6kGSm
	 AG2Zi+k0p+YCxJ80mJOLdzLuK0f5UBbooV4codRcid1GpKluC744vw/OcIv/J4eXsZ
	 x7iJkB418npqM88Ar6zS+q4be6Dah3wwDx2JO+MW0bg/hTxpWpx5bJw9cA6o15syql
	 veGyN7iR535r1/eRXdC8BTT/Tc2Z/BCcI5SwmAhN5QVhZyqhZCGrCGI8us8ju0Wr7t
	 lVaH2ty2v22kQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea0fff535so4643213e87.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 06:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rolyt51T7lYukF3qvWrXiFzUKIw1lpP2++PMHjlauSUzKtjGHKgCXuLHC2YnuMXFjydjwFJ4n8vew==@vger.kernel.org
X-Gm-Message-State: AOJu0YysqsJMQocK9LbwOS/p6NQLbrYGmRpd29UdpuxR/6t+h9jcDjw7
	clXQ71KG9bwGgCW1S+Get5LUz9mEug9omEr+Leui9Ov6pzaDdxsYEBcfkluy+udylYNA0GBVabj
	OfT95UUOeFYC3QrJUM6Dk8k4zRpQ6v0U=
X-Received: by 2002:a05:6512:1152:b0:5ae:a536:3733 with SMTP id
 2adb3069b0e04-5aebdb9ad7fmr982702e87.20.1782824830105; Tue, 30 Jun 2026
 06:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
 <6021784.DvuYhMxLoT@rafael.j.wysocki> <CAMVixxV83tSLEi_o1vmHjqfgPnnXDwo2LjP_m-Y7iEWfvUAP2g@mail.gmail.com>
In-Reply-To: <CAMVixxV83tSLEi_o1vmHjqfgPnnXDwo2LjP_m-Y7iEWfvUAP2g@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 15:06:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=u3dGbujFpU2yObyLXT0ZLZTxpG2+zLZLP7wpKsBvQw@mail.gmail.com>
X-Gm-Features: AVVi8CcY6rkGlx5o1pyPGlP_agrlwjJ1tUDigieSRG0BpjTO4pVCVRKxAjoWu74
Message-ID: <CAJZ5v0h=u3dGbujFpU2yObyLXT0ZLZTxpG2+zLZLP7wpKsBvQw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: Lucas Lima <lucaslnobrega38@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 10:11=E2=80=AFAM Lucas Lima <lucaslnobrega38@gmail.=
com> wrote:
>
> Em seg., 29 de jun. de 2026 =C3=A0s 16:06, Rafael J. Wysocki
> <rafael@kernel.org> escreveu:
> >
> > On Monday, June 29, 2026 5:16:17 PM CEST Rafael J. Wysocki (Intel) wrot=
e:
> > > On Mon, Jun 29, 2026 at 10:36=E2=80=AFAM Lucas de Lima N=C3=B3brega
> > > <lucaslnobrega38@gmail.com> wrote:
> > > >
> > > > EAS currently refuses to enable energy-aware scheduling on a root
> > > > domain unless schedutil is the active CPUFreq governor for all of i=
ts
> > > > CPUs (cpufreq_ready_for_eas()). This requirement exists to protect =
the
> > > > accuracy of the energy estimate: EAS predicts the OPP a CPU will ru=
n
> > > > at from its utilization, which is only meaningful if the active
> > > > governor actually requests OPPs that way, and schedutil is the only
> > > > one that does.
> > > >
> > > > That requirement does not apply to artificial Energy Models
> > > > (EM_PERF_DOMAIN_ARTIFICIAL). An artificial EM is built from a
> > > > get_cost() callback instead of real power numbers, and only encodes=
 a
> > > > cost ranking between CPUs (e.g. P-cores cost more than E-cores at a
> > > > given utilization). It never claims to predict real energy use at a=
ny
> > > > specific OPP, so there is no per-OPP accuracy for the governor
> > > > requirement to protect, regardless of which governor is in control =
or
> > > > whether it tracks utilization at all.
> > >
> > > But it is still about comparing the cost of running on different CPUs
> > > at different performance levels.
> > >
> > > For instance, say the scale-invariant utilization of a task is 256 an=
d
> > > it can run either by itself on a P-core, or with another task whose
> > > utilization is 128 on an E-core, and say the P-core's and E-core's
> > > capacity is 1024 and 512, respectively.
> > >
> > > Say the cost function tells EAS that running a P-core at 1/4 of the
> > > capacity is cheaper than running an E-core at 3/4 capacity, so it wil=
l
> > > pick up the P-core to run that task, but if cpufreq ramps up the
> > > frequency of the P-core to the max when the task gets to it, it may
> > > actually turn out to be more expensive.
> > >
> > > This means that EAS still has an expectation regarding cpufreq which
> > > is that it will generally tend to run tasks at the performance level
> > > corresponding to the sum of their scale-invariant utilization at leas=
t
> > > roughly.
> > >
> > > IIUC this actually has nothing to do with whether or not the energy
> > > model used by EAS is artificial.  The schedutil requirement is about
> > > choosing a performance level proportional to the utilization (which
> > > schedutil generally tends to do by design).
> > >
> > > > intel_pstate registers exactly this kind of artificial EM for hybri=
d
> > > > (P/E-core) systems without SMT, regardless of whether it operates i=
n
> > > > active or passive mode. In active mode it never uses schedutil, sin=
ce
> > > > HWP picks frequency autonomously, so on these systems EAS never
> > > > engages even though SD_ASYM_CPUCAPACITY, frequency invariance and t=
he
> > > > EM are all in place: find_energy_efficient_cpu() is never reached
> > > > because is_rd_overutilized() is hardcoded to true whenever
> > > > sched_energy_enabled() is false. cppc_cpufreq registers the same ki=
nd
> > > > of ranking-only artificial EM and is affected the same way with any
> > > > non-schedutil governor.
> > > >
> > > > Allow EAS to be enabled when every CPU's EM in the root domain is
> > > > artificial, even when schedutil is not the active governor.
> > > >
> > > > Tested on a Raptor Lake-P laptop with nosmt=3Dforce and intel_pstat=
e in
> > > > active/HWP mode: find_energy_efficient_cpu() was never called befor=
e
> > > > this change (confirmed via the sched_overutilized_tp tracepoint and
> > > > ftrace) and is exercised as expected afterwards.
> > >
> > > If this is about allowing EAS to work with intel_pstate running in th=
e
> > > active mode, you may argue that what the processor firmware is doing
> > > when intel_pstate runs in the active mode is not much different from
> > > what schedutil would do.  So a driver implementing an internal
> > > governor (that is, using the .set_policy() callback) would need to
> > > declare that its internal governor is as good as schedutil from EAS'
> > > perspective and so it will pass the "cpufreq readiness" check.
> >
> > And I have a prototype patch (on top of 7.2-rc1) doing this which is
> > appended.
> >
> > I wonder if it works for you (that is, if it allows intel_pstate and EA=
S to
> > work together both with schedutil and when intel_pstate operates in the
> > active mode with the "powersave" policy on your system).
>
> It does work, thank you.

Great, thanks!

So this approach is more straightforward IMV and that's why I prefer it.

I'll need to revise the new flag description so it mentions the need
for a "matching" EM to produce reasonable results and there are a few
intel_pstate patches in-flight, so this one will need to be rebased.
It also needs a changelog, of course.

> >
> > Also I wonder why exactly you want intel_pstate in the active mode to
> > work with EAS.  Do you see any significant improvement in that case?
>
> About that specific topic i do not have any testing data, but it felt
> like schedutil drains more battery than pstate active (likely due to
> worse c-states management) and presents more stutters in general usage
> (I would guess it's slower to react to load changes). After bypassing sch=
edutil
> those very observations were gone, and the responsiveness of the system
> looked very similar to EAS disabled, pstate active. Since EAS does
> prioritize spreading
> onto E cores, which do consume less energy by my testing, IMHO it's
> almost too good
> to be leaving it unused.

Fair enough.

> I also want to point out that gaming (mainly minecraft) stutters a lot mo=
re with
> EAS on, even when pstate is set to active. So i wonder what do you think =
about
> capturing the system power mode (currently only clamps frequency) and
> disabling eas_compatible when set to "performance"? That would need
> updating cpufreq_policy, but feels reasonable to let the user disable EAS
> for latency sensitive tasks, since E cores struggle at those.

Switching the governor (or policy if you will) to "performance" on any
CPU should cause eas_compatible to be cleared for it due to the
cpu->policy !=3D CPUFREQ_POLICY_PERFORMANCE check and then the scheduler
will refuse to use EAS after rebuilding the sched domains.

Or do you mean something else?

> I know that for now, my observations are only anecdotal, but if needed
> I'm eager to test those assumptions!

So it would be good to have some data indicating that it is beneficial
to use EAS when intel_pstate operates in the active mode ("powersave"
policy).

Also, enabling EAS by default for the active mode may be problematic
because people may see (and report) performance regressions due to it.
OTOH, EAS can be disabled via sysctl, so that may not be a big deal.
