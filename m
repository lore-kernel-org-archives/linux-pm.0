Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544849550B
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530635; cv=pass; b=d+pTRDwMzxXWAWNed6W285naAfALfgN/hFPIB/9a4lmzxzg0mf5BiDzt/S8o7h2o2mEXvU0MBwyi/ur8s56AnLr+x7GBsZZ2xCQ/HXSMImLz06XDPZbPnHS9Xd2o7jW6ZX2ef/895V+BRg7eIMQozYApj3HGvbgG++s9rknXfuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530635; c=relaxed/simple;
	bh=nLrXdDrb0nyne/TQYCI/4G0d9DCOxawO24KBDUJ5nQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddgyKJd/BUU3LWOmp+kne4XJhu1pIoafn3Fy7/nPxeKX+2CBCgESslO63MpvaxF+5sC3aq/DEpjTXTZjwot1axGoO/l6ztQyBxQzwE2YjyAjBwrgAm9n/j7DOaXD16ebm+EOpMWckvanfPAX8i3wYPVsbnyJmCFxxpPyIHZlscI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPPJJu9J; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPPJJu9J"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3997a448ecbso10668581fa.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 10:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783530629; cv=none;
        d=google.com; s=arc-20260327;
        b=avI/YXHCd0TbRGoREgzSDQHR2jme3bqxJ7K9dn73S3X6A3pwaY2RA4sJEraKt1bflv
         7/g/h0JT2/SHoa9IwFeCZ8voOzhw/7qQ8bw/k9lVO3fB7L6fTQcDm038zMlvNfEO3X5D
         keOkEvIBkZ+/XDeFm1VJBtS1I2zpdQcJMU74aXw9eDyAf7UavAvWDTfQzNA2XuKYm61X
         K5m8TOpr/LHbLobDbz11NoISKLYsSMPVxnzARTvxxgqNvT7098u9xcXCth19pLumbZWR
         XgGiwmZ/8z0dSf8ndKIoxJIb1klj3b7uSqe9iUJ+Nb4K3RWKH6zlnCttc4tPCr3O4a66
         PHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKNYdbS14PoiaCYd8c0Qa4S9RDI1yii1jmGBffqUnvc=;
        fh=cYRPN3DCQwxcwL0biCYFXShuG6TaDCY3B6PFOoS2eKo=;
        b=a0YVDucgoguoCiftLNtV5s2iMcnLfEB2dQA+AaZc1cm7dPLf9tPdV2B+q91x6nRzgz
         +GmFtDkRrrlPWIiHJnfcbMf6iYQV4AirsqpuNnHlQJtgugeHQL9/dxwCF23YVEL/MYHW
         +Iey2GeVW4IamTSLtd+2fOBJdSgwpCR9DcSlD3NOtu/Mxx00s9uDbO+cQWKN31S4wFtS
         9MwuwDz+KVQuUptzJVaJ1YQFNW5heYZQ5Rh787OnzzhZpmV7g6LhMUe62L5JNcuXL2pO
         QIa1eDQfu/bYpbUuwXi/Bs3afM6bCVF2I9MFq2mkq7MVIkQm26E4eoxT06ULD/kzYNAK
         uK2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783530629; x=1784135429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKNYdbS14PoiaCYd8c0Qa4S9RDI1yii1jmGBffqUnvc=;
        b=YPPJJu9JhokUkAGtnyGl0aXkb2kdnISQQ5C2in0ral0v24ScIcoYBJAd7n44rW80AO
         6fijKTzF6a5Ac+ivvJiwkUHdQAXgid5NQSq7lFZyazZvMmBktmaORk2661Vy53KBbq4h
         osptmkOdlzLWb+vB2tYJzoWkrIetuIM2hLHwlHjVHZIrHOj+1SJGuelLqGlQ21Dy+wvc
         k5Qyp8DFcE3OciHH2o3HTE024J19N48F+D97szHvcngKaMiNZqBPhFZdhT/ZhrruX1uq
         s8pvzz5qjb2LcxC2AYpPBouPv4AwVNbQIdULQGs7B2wpoUUH3I4769lc4e7C8jimz7ej
         Kz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530629; x=1784135429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKNYdbS14PoiaCYd8c0Qa4S9RDI1yii1jmGBffqUnvc=;
        b=Rk2LUzrorWzIvLSWgYKYDYKiSmaB8c603qmymbHuWO1TPiYHL8nQAVVSjvfUYnxqcH
         rJnMN9Q5oB7LqHsb9t8wEeGiUUn1LZ2nD7CZzfFeOq5AMh+XQ6bbyLAR4AcCucgpASJj
         mzZICcXwq4Ghk+86/1ZvP3LFYCU6cJMKVw4bQTTwnkzLBnPYpkxmKhnpK7d0W0tHEdsQ
         jdFSrEj6O6D0L009JmC+VXb7wiTUEpC04zcSwkESIR0CEvjPe50MDDniz9Hz9pEUZYEz
         a5UX5FfoMcVWMo8kmRKuSjjWd6N4YAN7VPWOTRvaY7Gxa2hPoAclE8tK94HjEjNn1feN
         2rJA==
X-Forwarded-Encrypted: i=1; AHgh+RrvbAiDNjUYy/6jC6UueHaE5jjDc2hF3lNtKJO3boZtO2SzngB4vIV93C6uB+cWbFWLzb0C15G8hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOs7KRBislBEh3Qv5wAYArQmjRq8sPar8YxslnLQPLXVNnto6
	ZEc6nam/+yAhHUEunUvrMgQFFhHL1lZPoX1ygf21qDRakYpFLquTbUgqEkA/45PTTt6AnNGIdDv
	7jsVPpPOFPs9NTLQ1Dklp11W+urYPZkU=
X-Gm-Gg: AfdE7cnXhaEjOryoSkRaUBczeONJN5EKfIQPcmeQC7rQAEAZaS7rAAWC9suDEdotLRt
	zYNcL6BAwLONJkokwPNWM+d/Ll6FnLD78CIhy60RV8b3eD4JZ7Ym55QKeN74jfcPSGgPk3mPIra
	7vezdD6p2ze0jkCZkw51arCdUDxRdQLiaLimDN150pziCiSSGPKv0z33NfsKJdMU9u/2V+LGWOr
	YaQMdIVd6m5GwcVP/V7RbgQkDDkJP4xPPh7GUKcn2Mhn/77EVvFlG3NCIJu5vGhblCyO1/BTm7V
	D9TxEV7U/21AMKf+llnMRaLYpYhWXZE=
X-Received: by 2002:a05:6512:4507:b0:5ae:b604:4c9 with SMTP id
 2adb3069b0e04-5b0114b4371mr859389e87.65.1783530628850; Wed, 08 Jul 2026
 10:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629083542.10041-1-lucaslnobrega38@gmail.com>
 <CAJZ5v0iVD90XPsWgT8B+fw9vmFRZTVL7MasPP-=Ci0OdUmNR=A@mail.gmail.com>
 <6021784.DvuYhMxLoT@rafael.j.wysocki> <CAMVixxV83tSLEi_o1vmHjqfgPnnXDwo2LjP_m-Y7iEWfvUAP2g@mail.gmail.com>
 <CAJZ5v0h=u3dGbujFpU2yObyLXT0ZLZTxpG2+zLZLP7wpKsBvQw@mail.gmail.com>
 <CAMVixxXpT90bkwGTpL+T-d3ve7BTK3xXwBcaMfhvJ7R+DkxXiw@mail.gmail.com>
 <CAMVixxXCOMb330_rvgbx2Zdy4yufW0BiB5jmv04v_icK-TTVpA@mail.gmail.com> <c21a1bc0-ef6d-4cd3-9575-9dd36e911a3c@arm.com>
In-Reply-To: <c21a1bc0-ef6d-4cd3-9575-9dd36e911a3c@arm.com>
From: Lucas Lima <lucaslnobrega38@gmail.com>
Date: Wed, 8 Jul 2026 14:10:16 -0300
X-Gm-Features: AVVi8CeOZFqAxPo2RdlM2ZkQChmtgbYb68M23B3G6xQ5JyKDwR2NMrbAx7RZ9-Y
Message-ID: <CAMVixxXrbQR9KgKGGfbBarfqTFHTA0z7797q4h4hmacW_fZ-Mg@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Allow EAS without schedutil for
 artificial Energy Models
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 6 de jul. de 2026 =C3=A0s 06:05, Christian Loehle
<christian.loehle@arm.com> escreveu:
>
> On 7/2/26 22:27, Lucas Lima wrote:
> > After some testing I found out schedutil is indeed slower to react to l=
oad
> > changes compared to pstate active.
> >
> > The methodology was to empty a cpu, run a serial float recurrence
> > (kept non-vectorizable
> > on purpose, to isolate frequency ramp-up rather than throughput headroo=
m)
> > and compare the average throughput over several initial time windows
> > against the steady-state throughput in order to measure the CPU frequen=
cy
> > ramp-up delay under pstate active and schedutil.
>
> You might be interested in rt-app for more complex experiments along thos=
e lines.
Will take a look, thanks!
>
> >
> > ### P-core
> >                                   pstate-eas-balanced
> > pstate-eas-performance    schedutil-eas-balanced
> > schedutil-eas-performance
> > -----------------------------------------------------------------------=
-------------------------------------------------------------------
> > Ramp-up (average throughput at time window / steady):
> >     0-0.005s (%)                  70.6                      99.4
> >                59.7                      61.3
> >     0-0.01s (%)                   83.0                      99.5
> >                60.2                      62.1
> >     0-0.02s (%)                   91.3                      99.5
> >                62.9                      65.7
> >     0-0.05s (%)                   96.7                      99.8
> >                74.8                      77.6
> >     0-0.1s (%)                    98.6                      99.9
> >                86.9                      88.7
> >     0-0.5s (%)                    100.0                     100.1
> >                97.4                      97.8
> >     0-1.0s (%)                    100.2                     100.1
> >                98.7                      98.9
> >   Convergence to 95% (ms)         5                         0
> >                52                        47
> > Steady-state:
> >     Throughput (Mops/s)           649.8                     654.4
> >                652.3                     651.7
> > Energy:
> >     Average Power (W)             9.01                      8.98
> >                9.10                      9.07
> >     Efficiency (J/Gop)            13.889                    13.735
> >                14.000                    13.961
> >
> > ### E-core
> >                                   pstate-eas-balanced
> > pstate-eas-performance    schedutil-eas-balanced
> > schedutil-eas-performance
> > -----------------------------------------------------------------------=
-------------------------------------------------------------------
> > Ramp-up (average throughput at time window / steady):
> >     0-0.005s (%)                  75.6                      99.0
> >                62.3                      57.9
> >     0-0.01s (%)                   85.1                      99.1
> >                62.2                      58.8
> >     0-0.02s (%)                   92.4                      99.3
> >                64.5                      61.0
> >     0-0.05s (%)                   97.0                      99.7
> >                72.9                      69.2
> >     0-0.1s (%)                    98.6                      99.9
> >                84.8                      82.1
> >     0-0.5s (%)                    99.8                      100.0
> >                96.9                      96.4
> >     0-1.0s (%)                    100.0                     100.0
> >                98.5                      98.2
> >   Convergence to 95% (ms)         8                         0
> >                67                        72
> > Steady-state:
> >     Throughput (Mops/s)           540.6                     540.8
> >                540.1                     539.7
> > Energy:
> >     Average Power (W)             5.46                      5.47
> >                5.61                      5.51
> >     Efficiency (J/Gop)            10.119                    10.125
> >                10.426                    10.241
> >
>
> Thanks for the data, is this 1000HZ?
Yes.
> Rampup is one thing, the vast difference is obviously when tasks are migr=
ated,
> which EAS is very eager to do on wakeup, sugov 'knows' the right OPP imme=
diately,
> HWP needs to run through the same wakeup again, and during that window yo=
u're
> energy calculations are bogus.

That's a fair point, and worth being explicit about: my ramp-up test pinned
the workload to a single core via taskset for the whole run, so it measures
frequency ramp-up when load appears on a core that's already selected.
Also, I selected performance power profile, which in our current branch,
disables EAS.

>
> > That alone might make it worth it to use pstate active alongside EAS, a=
s
> > responsiveness gains are noticeable while busy energy consumption is si=
milar.
> >
> > Furthermore, I implemented an EPP based EAS compatibility selection: wh=
en
> > EPP is set to 0 (performance), eas_compatible is set to false regardles=
s
> > of the active cpufreq driver mode -- this also overrides schedutil's ow=
n
> > eas_compatible assignment in sugov_init()/sugov_exit() when running in
> > passive mode. IMHO that makes more sense than gating only on the govern=
or,
> > as users selecting the performance power profile are looking for
> > responsiveness above all, independently of intel_pstate or governor set=
tings.
> >
> > It's also worth noting that governors already have the ability to chang=
e
> > EPP on their own (via intel_pstate_hwp_set()'s save/restore logic for
> > CPUFREQ_POLICY_PERFORMANCE), which can lead to a state where the deskto=
p's
> > power profile indicator becomes inconsistent with the actual EPP value:
> >
> >   1. Switch governor: powersave -> performance
> >      (intel_pstate saves the current EPP internally and forces EPP to 0=
)
> >
> >   2. Switch power profile: balanced -> performance
> >      (EPP is explicitly written as 0 again; no visible change, since it
> >      was already 0)
> >
> >   3. Switch governor: performance -> powersave
> >      (intel_pstate restores the EPP to balanced,
> >      because the current EPP still reads as 0 and the
> >      restore heuristic cannot tell that this 0 was an explicit choice
> >      rather than the still-forced value from step 1)
> >
> > After step 3, EAS becomes re-enabled, since EPP is no longer "performan=
ce"
> > -- but the desktop still shows "performance" as the active power profil=
e,
> > since nothing told power-profiles-daemon that the EPP changed underneat=
h
> > it. This isn't something my patch introduces, it's an existing property
> > of intel_pstate's governor-triggered EPP save/restore, but it is releva=
nt
> > here.
>
> I think this is a separate ownership problem, but IMO the user gets a cho=
ice,
> either have a userspace daemon take care of these settings or set it them=
selves,
> i.e. step 1 mustn't happen (I'm reading that correctly that 1. wasn't set
> through power-profiles-daemon? If it was that seems a bug in power-profil=
es-daemon).

Understood. In fact, using only one of the options (either power
profiles or setting governor)
is fine.

>
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
> > index 8f5ab9fa3..6d7133b94 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -791,6 +791,18 @@
> > cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >
> >  static struct cpufreq_driver intel_pstate;
> >
> > +static inline void update_eas_compatibility(struct cpufreq_policy
> > *policy, struct cpudata *cpu)
> > +{
> > + bool eas_compatible_was =3D policy->eas_compatible;
> > +
> > + policy->eas_compatible =3D hwp_is_hybrid &&
> > + cpu->policy !=3D CPUFREQ_POLICY_PERFORMANCE &&
> > + intel_pstate_get_epp(cpu, 0) !=3D HWP_EPP_PERFORMANCE;
> > +
> > + if (policy->eas_compatible !=3D eas_compatible_was)
> > + em_rebuild_sched_domains();
> > +}
> > +
> >  static ssize_t store_energy_performance_preference(
> >   struct cpufreq_policy *policy, const char *buf, size_t count)
> >  {
> > @@ -856,6 +868,8 @@ static ssize_t store_energy_performance_preference(
> >
> >   mutex_unlock(&intel_pstate_limits_lock);
> >
> > + update_eas_compatibility(policy, cpu);
> > +
> >   return ret ?: count;
> >  }
> >
> > @@ -2922,10 +2936,7 @@ static int intel_pstate_set_policy(struct
> > cpufreq_policy *policy)
> >   intel_pstate_clear_update_util_hook(policy->cpu);
> >   intel_pstate_hwp_set(policy->cpu);
> >
> > - policy->eas_compatible =3D hwp_is_hybrid &&
> > - cpu->policy !=3D CPUFREQ_POLICY_PERFORMANCE;
> > - if (policy->eas_compatible)
> > - em_rebuild_sched_domains();
> > + update_eas_compatibility(policy, cpu);
> >   }
> >   /*
> >   * policy->cur is never updated with the intel_pstate driver, but it
> >
>
