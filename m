Received: from mail-ej2-f23.google.com (mail-ej2-f23.google.com [74.125.228.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE43A5E77
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712656; cv=pass; b=Kd7mZJrR4s/suEXOGEYAo65Z07Bih2RPLfeoSFVOxYDMAdyKAR4NFGPheotNXtRgNEjXfG6xwPTg2koLoCD6QkQN6eX6hZmy3gf/pcZq6Ix0z3m7wKjfss/6XfPbtPDCVlI/8oqdFr0pU7M38eT1eFL8q62pD73jLEplE82seHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712656; c=relaxed/simple;
	bh=gKWw9x8JTodOcnvmRxh+PRPQHGvF1rrY+vB8Pdy4+pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWzPcSH1FFJdkNfHbiFTACk0Db7AAuV2OI+WedLLWemM8dKWbr/Rg6vQ/0rjRlctrqWH0Y5aTQSyhnBAEtbgsSjMXOKXpEeztBt56NL+VU2jrUgNKP9CFzOTvZoBc4t1F+UFy94GX+i41cJ8KTje9ni8dZGNrz6bfktcK1P0YSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzYkELJX; arc=pass smtp.client-ip=74.125.228.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzYkELJX"
Received: by mail-ej2-f23.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so46619566b.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 23:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789712651; cv=none;
        d=google.com; s=arc-20260327;
        b=JHxs3xmVq8m1B+6jKuwt4ATXQFNkD8ySLpXqQ91PaDmJ7D/tTU6ZHj7AG/vxyb9q8C
         hJXOgDjgeAtGBJzMj7vISDUeSojm7Dhl/ngXNYB3FY0MIsAKYN6yBdTjxlPWkVvLw7SJ
         KNcJshoupavQseo1Fjd09u+j/4MXpLli9k5GWzu1OqQghDFrpg/v48v3IWopA1LOvXtX
         6cegDBTRZLR3TLB+SqB2xhnjxJv091aNxmcDcwYkWrNItE7yRd//yXM8/BAvaxKKk8xj
         pu0B7hJ1Jx9kEZalpEf/5BrZYmdQ0iwm6UirMOIreFGpCclIPz8LclGRLOQNav/AnIbg
         6Y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdsDMzj/jYDg+/+97ftsy96QA9ZEuHC8rFxTpWMNjyk=;
        fh=EtHJu2/b27GCINlWSw6DkJ6uTUvxq5Vydbotw0cOY0c=;
        b=SekFA2pT9AjT29d4peF6iP6vOsfO7UTAT4FBMC3D5yU2R5l6C8ktnwRyxbUpniIVyA
         c9Lop83cYY8e4xQX4RVXlNI2grXf1lW5fsEb8v1ZT7XyTQKdCws5Zc+mO8OiSotsTCqv
         SpwCSFQ2JNZDOXy8MTk1Q1xcoYtDbxYm2D2WpZHctuVxPTL655akD8bGQoGzjW0QnxfJ
         IXbYnrXq0UblnRhBF/ueqQA+3kjz77pwUUsiLdzz+fLeuO1NlOHuOOjImpGURhkcP97V
         JKAWwKUM2iFJPs5t4qfnvKDTajyOgtK674ZrAPL1XcZVq913XBU7kLa9irCtRqcaRBOC
         zTXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789712651; x=1790317451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdsDMzj/jYDg+/+97ftsy96QA9ZEuHC8rFxTpWMNjyk=;
        b=AzYkELJXtqynOSkGa0/V2EVsLrAPAZrtPmIJBdmZO77ekW6x8SGL+VQcQjedUrF5eo
         mNiKafs/Q61Kr+6p2YeQSXg7zchHN9OaIXNnniU4cwjKKHd00fmUgQDoaTgVK5RZ/6Cg
         fdEbFfLnhk+19zvedSOVo5DxkGvRJYzUrIwSCO8uIfpz3rwDOqXjuracyQgDsypzxLLI
         xZNJxZgJLiOU9dWZ1TVeQfHFykP7wmB1Jx5xrticS9yYNKyRa+cvyC2um0m/9ML+wtZX
         qV8CHaajkgJG5dboEbyKuPIFFfySDR9Ivp63xplp+0xvS2YdXGPWgl9xS6KwwSBnpLBk
         BjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789712651; x=1790317451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdsDMzj/jYDg+/+97ftsy96QA9ZEuHC8rFxTpWMNjyk=;
        b=hGyxA4KLkxpZCxr/f28a2He2Bg4LjiBrON/XghVtjl+HASPKlcg2K9pAeldehLEU1P
         5hky6JhMxdaiTWtkaeHvv00YpXZA7AO/g4BRtDEO2yyc3ngTTlouxm0n00u1SWTgtTzs
         nhGWVGwFDtay46QOw+jJZ8Cy3kIxiCq4ZAFcTs5fUWYIRKzgIPEA48boYuU+886MaY4p
         FUY1hnRV+25ELjg6osEPUoud6Qk5PUXGJUuB75eWnhMZzArovt3goALVDX5z2VQc7Tl1
         qCNd5EUcMM/c5+COxsMMhAg3ToZnXS/too+omzluyqWR+bM1gaO17ON+zp1dM7I7c5sU
         74jQ==
X-Forwarded-Encrypted: i=1; AKwUvByJCizqpn9qUxRS5raFcvl8zHCsMY3ONGSsZDt6UXMYLS33plUqRvICO0fzyd6ogSYkByE1T/8Mdg==@vger.kernel.org
X-Gm-Message-State: AFuF++lPHez7C4iVFZMZuBXI/uyKvbhRkMmeIQdMkFX5zhLXfvrvCkpo
	edXHYO/wSpCEs0dYo5Tg4cA5UjhYFvjHRzzLUVLRunWLJr6ihP9INwyxvHSPL9CQWiUFIGH2RlM
	C0PPD1w4yW3nr2z8z4PStMdGQwuIVhb+pnNy/AycXsZhTG4exRy2ucbs=
X-Gm-Gg: AYBFou2mXp5prnDhSIEa1v8wl4HvlLIjdKF19REaCCebDiRRCSkQETQ0TZVHMf4pXJA
	AiwDg5kfleeU0vPZU1PmDDJ7549JbtPmcUorx3LHsnCgmWpkLG8bDjO0Yzdz7RcEszVuUiycCiE
	9K3X8gXyKL/0bVxZXH4ZX0MrARCgjewsnFHTmMmEyRU11O0UmwPqF+QkY6KGjudHCfLxqyYhNN2
	PAcJwuBrfiRhXFBOKA+SSQUUki88l9EVpfQovtMKf+o5qVh3JWGlBBVFyrS0xMAIbeJtbv5mBup
	on98jZtlw/aYlpyhvmAGADcWIhAV3ezhG/oPBHwetMkUoDdY5RCZ2AB/z6DI+vGL53tADDIEvgB
	D9MPKkidv+HGpyvENf23DgLM=
X-Received: by 2002:a17:907:80a:b0:c29:41d1:a0d5 with SMTP id
 a640c23a62f3a-c2a157da402mr160549766b.18.1789712651224; Thu, 17 Sep 2026
 23:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 18 Sep 2026 08:23:59 +0200
X-Gm-Features: AcwNN1WhgIxSpocDyghjtGrojLm9grxaZjWOAuwhdngiTrD_2aaRj1QPhPIvXvw
Message-ID: <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ananthu C V <ananthu.cv@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sept 2026 at 21:07, Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@oss.qualc=
omm.com> wrote:
> >
> > capacity_freq_ref, the per-CPU frequency-invariance reference used by
> > schedutil, is seeded from policy->cpuinfo.max_freq at policy creation.
> > If boost frequencies are filtered out of the frequency table because
> > boost isn't yet enabled at boot, max_freq only reflects the non-boost
> > ceiling, so capacity_freq_ref never learns about boost frequencies for
> > the policy's lifetime. Enabling boost later raises policy->max, but
> > capacity_freq_ref stays stale, leaving schedutil unable to scale
> > utilization or target a frequency above the non-boost maximum.
> >
> > Track the highest frequency in the table regardless of boost state
> > (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_freq,
> > max_table_freq), so the invariance reference is boost-aware from boot
> > regardless of whether boost is currently enabled. Runtime enforcement,
> > still handled by policy->max, is unaffected.
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > ---
> >  drivers/base/arch_topology.c | 3 ++-
> >  drivers/cpufreq/freq_table.c | 6 ++++++
> >  include/linux/cpufreq.h      | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.=
c
> > index 8c5e47c28d9a..da94f77441da 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block *n=
b,
> >         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cp=
us);
> >
> >         for_each_cpu(cpu, policy->related_cpus) {
> > -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuinfo.max=
_freq;
> > +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->cpuinfo=
.max_freq,
> > +                                                     policy->cpuinfo.m=
ax_table_freq);
>
> So isn't capacity_freq_ref supposed to correspond to the CPU capacity
> returned by arch_scale_cpu_capacity()?

capacity_freq_ref is the frequency that has been used when computing
the capacity at boot and it should not change at runtime wether the
boost is enabled or not, otherwise you will have some fluctuation on
the system capacity that will create issue with PELT and scheduler

>
> If that's the case and boost was disabled when the CPU capacity was
> computed, how can cpuinfo.max_table_freq correspond to that capacity?
>
> >                 freq_inv_set_max_ratio(cpu,
> >                                        per_cpu(capacity_freq_ref, cpu) =
* HZ_PER_KHZ);
> >         }
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.=
c
> > index ea994647abc8..4984142dc08a 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -33,11 +33,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_=
policy *policy)
> >         struct cpufreq_frequency_table *pos, *table =3D policy->freq_ta=
ble;
> >         unsigned int min_freq =3D ~0;
> >         unsigned int max_freq =3D 0;
> > +       unsigned int max_table_freq =3D 0;
> >         unsigned int freq, i;
> >
> >         cpufreq_for_each_valid_entry_idx(pos, table, i) {
> >                 freq =3D pos->frequency;
> >
> > +               if (freq > max_table_freq)
> > +                       max_table_freq =3D freq;
> > +
> >                 if ((!cpufreq_boost_enabled() || !policy->boost_enabled=
)
> >                     && (pos->flags & CPUFREQ_BOOST_FREQ))
> >                         continue;
> > @@ -57,6 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
> >         if (policy->cpuinfo.max_freq < max_freq)
> >                 policy->cpuinfo.max_freq =3D max_freq;
> >
> > +       policy->cpuinfo.max_table_freq =3D max_table_freq;
> > +
> >         if (min_freq =3D=3D ~0)
> >                 return -EINVAL;
> >         else
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 35ce665edfd8..3f3b1380251a 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -45,6 +45,7 @@ enum cpufreq_table_sorting {
> >  struct cpufreq_cpuinfo {
> >         unsigned int            max_freq;
> >         unsigned int            min_freq;
> > +       unsigned int            max_table_freq; /* Highest valid freque=
ncy in the table */
> >
> >         /* in 10^(-9) s =3D nanoseconds */
> >         unsigned int            transition_latency;
> >
> > --
