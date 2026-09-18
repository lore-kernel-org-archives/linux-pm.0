Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF24EB859
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733156; cv=none; b=LbA9F4zRpYFoe1v0bcJTQHrEDY4CF0dE4CIHq540ryVleuW5JbNdO0Xe4DAmL1A42Li6hztByoUXTLX8zwOTgBrpXkrI88oLot7R88jSU5NH1+lQyV4a/vL6EBQEP0H3qdFbtTDEz9Mx13I4hbzIHpy8cJOd4v6bTZ72Ryu9MuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733156; c=relaxed/simple;
	bh=WjS4iYqloPIqkf7IHOORdWhYlYmwsqmF4mHH81An7Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HekrJNeqI62AbYvsgoyJQNMBWdE0psH0eNk8Ps08nU4ln77DDwt1nnLI1f9GiG0cjiL2LZD6P1KjNqHmE+vRJKSpnm77bBILjdp3xRevijAXN41Ki7di4TS8++/Tz9zrFecR5wLFL38UxOAd3kuH5b5LYl4/qBtO39Ybb8bM+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOEJGrV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOEJGrV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A351F0089A
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733154;
	bh=IWYYa+UAbS72IUjF9+i+Q1/L+o2oKKi4MS1tJWitPF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aOEJGrV+ZtckyqbNoZUnhCtlyr36N9IBvlBjeosG1wfVRyMlPuhSid0TuxvFIGohU
	 xP07tXFl4BjR7dKi3Azhx64OicuOY9iA/6Up0H700LxgyoazqHrE5y0wc4dlnSloBM
	 a03bM3W8sTxbK+k5xwaLjulApeKOWC9LyodoIsOqgHqqOwmVx6UGLu6Im3XmwfsWx8
	 ZrEKCCD1op5nRAvEp4+jMbskoQx1EaReHM3S2i33pvED86ePZ6tuM5xhgOEaj7DuYA
	 Q2O3V0lUS/E9xXjOAp78v6pVLSScbr37O/z393FezCWNZ40Xcb3IuG3XmTNuv1TsUz
	 +MXsD4Mx1XgYQ==
Received: by mail-lr2-f23.google.com with SMTP id 38308e7fff4ca-3a306a4f735so5480271fa.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 05:05:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzaotfO0QgdYeGHlacONsZ33AFeS8DG73AjOb+AyqxUfzVPXYaMX8MApiqBkUbOSIL3X5Ldjpb6aA==@vger.kernel.org
X-Gm-Message-State: AFuF++ltONrN+FoLYoFOvHzorJMgjMBbu8c9JBRzq9ZI4nbayrzDL/7v
	CPzbDbnFiMR1MGF8CoMRiUFK4O0y/e/nmS/tUfXpmbl40nz0IOtROi1fRJ9aTTCNHxIkgyjrTvx
	BFi+P1sTpkZ0QgGhRRLw7cnr9MX66ZR0=
X-Received: by 2002:a2e:a812:0:b0:3a3:74b9:8a7f with SMTP id
 38308e7fff4ca-3a5fc089db5mr4946271fa.24.1789733152591; Fri, 18 Sep 2026
 05:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com> <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
In-Reply-To: <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 14:04:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
X-Gm-Features: AcwNN1WfBvyVyvaM-wCoUJMm1MKTK790CejfyL4ye2tj1BaUXJqB90tnLM2yiRc
Message-ID: <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Ananthu C V <ananthu.cv@oss.qualcomm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 8:24=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 17 Sept 2026 at 21:07, Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@oss.qua=
lcomm.com> wrote:
> > >
> > > capacity_freq_ref, the per-CPU frequency-invariance reference used by
> > > schedutil, is seeded from policy->cpuinfo.max_freq at policy creation=
.
> > > If boost frequencies are filtered out of the frequency table because
> > > boost isn't yet enabled at boot, max_freq only reflects the non-boost
> > > ceiling, so capacity_freq_ref never learns about boost frequencies fo=
r
> > > the policy's lifetime. Enabling boost later raises policy->max, but
> > > capacity_freq_ref stays stale, leaving schedutil unable to scale
> > > utilization or target a frequency above the non-boost maximum.
> > >
> > > Track the highest frequency in the table regardless of boost state
> > > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_freq=
,
> > > max_table_freq), so the invariance reference is boost-aware from boot
> > > regardless of whether boost is currently enabled. Runtime enforcement=
,
> > > still handled by policy->max, is unaffected.
> > >
> > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > ---
> > >  drivers/base/arch_topology.c | 3 ++-
> > >  drivers/cpufreq/freq_table.c | 6 ++++++
> > >  include/linux/cpufreq.h      | 1 +
> > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topolog=
y.c
> > > index 8c5e47c28d9a..da94f77441da 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block =
*nb,
> > >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_=
cpus);
> > >
> > >         for_each_cpu(cpu, policy->related_cpus) {
> > > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuinfo.m=
ax_freq;
> > > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->cpuin=
fo.max_freq,
> > > +                                                     policy->cpuinfo=
.max_table_freq);
> >
> > So isn't capacity_freq_ref supposed to correspond to the CPU capacity
> > returned by arch_scale_cpu_capacity()?
>
> capacity_freq_ref is the frequency that has been used when computing
> the capacity at boot

I get it, and so it is what I wrote above: The frequency of the CPU
when running at the arch_scale_cpu_capacity() performance level.
Isn't it?

> and it should not change at runtime wether the
> boost is enabled or not, otherwise you will have some fluctuation on
> the system capacity that will create issue with PELT and scheduler

So the capacity should be constant and consequently, capacity_freq_ref
should be constant.

Also, if boost is not enabled when capacity_freq_ref is set and there
are frequency levels marked as "boost" in the table, it cannot be the
maximum frequency in the table because that's not what is used for
computing the capacity.
