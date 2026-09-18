Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024B4F7999
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738458; cv=none; b=h1USatL5xQc0Wl51BXLnShMRLxsqa5+CKRmLsE04jn72SB+s5NWTd3dwc4fGmA4oGSjLQpe1NywnSwbWoocJjfTifQVr3zC8spUP8DQCG7J/3ob2H/9TkxXVVlsJk06uaO5Zxyi5b/Wy8x8rBFxUtUVYbFINENAZ9XkjUSAIqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738458; c=relaxed/simple;
	bh=k5GlwcPiZQbiOPgDsObbZf4/QqzvWAfziIPoY9qNkFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoOzIHI7FvbvNbIS9wqMSAPET8nP4DWbHzFSpouSTjqDDQDGyJxPdlLegzHrc8v+ASFSj/YDVe/v3xGvRYJ+n+Tfs7J5OgGm47NJy01wdwTesrfZ9BgNCHoEO14UZ0WZuHyBLMABaru/CT5LoXI/lxwcgiyj3uJZ6mpY4fDe9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYxDV3OH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYxDV3OH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1EA1F0089E
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789738456;
	bh=G1YFgKdyNJ+gT3w7dpkcKY//HgId1Mzw4yAL0ZxDhE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DYxDV3OH30aJKHeyAM9NTyCso1F1Kkrig6BdgA+KNzdV7iSPGUAZuSKd07pFLjnWG
	 j4TPpH5M3IOfHqYb/WI2xOHqv2qx9tkDWT0cd3JptTUJUYuV0o2xRdBBo670n+XmKv
	 VP1JbNhpU0ERwpKTDwTQI0QaN4s2sX7V2PvdLuso7XlIAScl4k+kUR0pWRjtf8DAVs
	 PReg4TAoeja09u6xg4o3EFoeT3ADab2H9y28aOJs3JS70Z6HTp/XcfHx5rmMVzR+/i
	 /p12cs05uWNsJF5bnKLMxmBKavwc2he0A9/BFV5UTiEqWppmaMAKZE2dowC+eV5F59
	 nxJoIS0X3smtg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so5335151fa.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLZGDue2YfJcad8ytrwLISDnVGf5d/XB/932Jl1ui45aiWG7F56cBu4LmDf6Ooia7BUKTEGedkFQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mFYlr/1H7MTSgoOSFM3Qq/RxTfTuI+pzqapTlubmMWxI4mPEJl
	tqdKX4+1QewSnqNdaYIDLXJTwAR1AsY3/7u4yiO25AR0q3ksDD86dx+Pfg5OrAdhQd70OanQJ5Q
	pQUO6uajMZmiHi8bWI4VwcYI+hX2xWkU=
X-Received: by 2002:a2e:be2a:0:b0:3a1:aab7:9bdf with SMTP id
 38308e7fff4ca-3a5fbe4a9femr5125601fa.5.1789738455130; Fri, 18 Sep 2026
 06:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
 <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
 <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com> <CAKfTPtATz-aToAVh4sGsTRKM+0sOoVW4AC6gjufAjrFyZg1zFA@mail.gmail.com>
In-Reply-To: <CAKfTPtATz-aToAVh4sGsTRKM+0sOoVW4AC6gjufAjrFyZg1zFA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 15:32:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
X-Gm-Features: AcwNN1WDiRtd6pYxIYAs9w04bFnRwBDtc1cstmEmNnmyCSUrRywMAnlfU_pNAYc
Message-ID: <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Ananthu C V <ananthu.cv@oss.qualcomm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:36=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 18 Sept 2026 at 14:05, Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 18, 2026 at 8:24=E2=80=AFAM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 17 Sept 2026 at 21:07, Rafael J. Wysocki (Intel)
> > > <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@oss=
.qualcomm.com> wrote:
> > > > >
> > > > > capacity_freq_ref, the per-CPU frequency-invariance reference use=
d by
> > > > > schedutil, is seeded from policy->cpuinfo.max_freq at policy crea=
tion.
> > > > > If boost frequencies are filtered out of the frequency table beca=
use
> > > > > boost isn't yet enabled at boot, max_freq only reflects the non-b=
oost
> > > > > ceiling, so capacity_freq_ref never learns about boost frequencie=
s for
> > > > > the policy's lifetime. Enabling boost later raises policy->max, b=
ut
> > > > > capacity_freq_ref stays stale, leaving schedutil unable to scale
> > > > > utilization or target a frequency above the non-boost maximum.
> > > > >
> > > > > Track the highest frequency in the table regardless of boost stat=
e
> > > > > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_=
freq,
> > > > > max_table_freq), so the invariance reference is boost-aware from =
boot
> > > > > regardless of whether boost is currently enabled. Runtime enforce=
ment,
> > > > > still handled by policy->max, is unaffected.
> > > > >
> > > > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/base/arch_topology.c | 3 ++-
> > > > >  drivers/cpufreq/freq_table.c | 6 ++++++
> > > > >  include/linux/cpufreq.h      | 1 +
> > > > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_top=
ology.c
> > > > > index 8c5e47c28d9a..da94f77441da 100644
> > > > > --- a/drivers/base/arch_topology.c
> > > > > +++ b/drivers/base/arch_topology.c
> > > > > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_bl=
ock *nb,
> > > > >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->rela=
ted_cpus);
> > > > >
> > > > >         for_each_cpu(cpu, policy->related_cpus) {
> > > > > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuin=
fo.max_freq;
> > > > > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->c=
puinfo.max_freq,
> > > > > +                                                     policy->cpu=
info.max_table_freq);
> > > >
> > > > So isn't capacity_freq_ref supposed to correspond to the CPU capaci=
ty
> > > > returned by arch_scale_cpu_capacity()?
> > >
> > > capacity_freq_ref is the frequency that has been used when computing
> > > the capacity at boot
> >
> > I get it, and so it is what I wrote above: The frequency of the CPU
> > when running at the arch_scale_cpu_capacity() performance level.
> > Isn't it?
>
> Original it was not strictly tight to arch_scale_cpu_capacity but to a
> ref capacity but it ended up being arch_scale_cpu_capacity

OK

> >
> > > and it should not change at runtime wether the
> > > boost is enabled or not, otherwise you will have some fluctuation on
> > > the system capacity that will create issue with PELT and scheduler
> >
> > So the capacity should be constant and consequently, capacity_freq_ref
> > should be constant.
> >
> > Also, if boost is not enabled when capacity_freq_ref is set and there
> > are frequency levels marked as "boost" in the table, it cannot be the
> > maximum frequency in the table because that's not what is used for
> > computing the capacity.
>
> I'm not sure I follow your last point above. It's not because boost
> isn't enabled at boot time that we can't the highest boost OPP in the
> table as a ref freq to compute  arch_scale_cpu_capacity. In this case,
> the CPU will have a pressure on its capacity until the boost is
> enabled. Do I miss something ?

Well, I'm not sure if my understanding is correct.

Suppose that the cpufreq driver has a frequency table which is
processed by cpufreq_table_validate_and_sort(), right after the
driver's ->init() has returned.

That function calls cpufreq_frequency_table_cpuinfo() for the first
time and policy->cpuinfo.max_freq is set.  However, if boost is not
enabled (that is, cpufreq_boost_enabled() returns false or
policy->boost_enabled is false), it only takes frequency table entries
without CPUFREQ_BOOST_FREQ into account, so policy->cpuinfo.max_freq
is one of those frequencies.

I would think that the CPU capacity has already been set at this point
and now the question arises whether or not it corresponds to
policy->cpuinfo.max_freq because that is what is assumed by
init_cpu_capacity_callback() invoked subsequently (via the
cpufreq_policy_notifier_list chain).

The $subject patch seems to suggest that the answer is "no" and the
capacity really corresponds to the highest frequency in the table
which may be flagged with CPUFREQ_BOOST_FREQ.  Is that always the case
though and if not, then how can we tell?

> Can the boost OPP be added later?

Not really.  It is already there in the frequency table, but the
question is if that's the capacity OPP.  I guess we need to assume so?

> We keep taking the max between freq table and cpuinfo.max_freq fo the
> case where the boost freq is not listed is the freq table or there
> isno freq table. Or there is another way to get teh boost freq in thsi
> later case ?

No, I think it's the only way.

So init_cpu_capacity_callback() should find the highest frequency in
the table (regardless of whether or not the "boost" flag is set) and
set capacity_freq_ref to that one for each CPU UUIC.

That's roughly what the patch does, but it can get away without adding
a new field to struct cpufreq_policy.

And the changelog needs to be rewritten to tell the true story.
