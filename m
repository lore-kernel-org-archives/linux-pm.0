Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6249D5AB
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672023; cv=none; b=HZL6FniFByiHAfWjlOBgFCGjPKgw5bM9FEhe5d7maC26TvpxbkaR+VR5LDhJZs473BN/pIjTJUCIF2s/DQezBYpaLCYDVRLU44djiPaDREofBPMoB8DI0K44kquOQ0ElvWNri0b9hydON5k/zjg7hTazc0tIXxaYchou9U2RbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672023; c=relaxed/simple;
	bh=3MNB59KuRrONZ1G4/oINcksRsjMdTDrarM9Aa+nyIaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuleCaxBQsD0vYDfFYuCMYfiqsQSfyy80RjWKKp2X+uCBK1boRBg+r3vR3OevaYhzpFsewUGbxXHPJOo3merdb3gy1GuCNBn9zAF2UiccpFCDZv4xGJudYTJPJMzs3nTnDdEElP8C9k8EFZBUDyI0kzdU8hhQcvj4AZFUo9vABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSwDAPK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSwDAPK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D11F00893
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789672021;
	bh=Bm3bnAq+YUUR/05QEONsbFO18RrWasKhSRqIzvk/6E4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KSwDAPK3JMAyE7T3tN1ElaJAZu+35WJEs3GNisrTnhqIIgham/GjyPVadpJ/lpf1G
	 LY/Gce6awif0Yz0lgAfEd/uHnNJ4N3nXGozLh470yrK1UHNMs18Yx3Gt4lbLtJXcag
	 m/5wUROx2UrH6DRpNEECU7iIXksqIg5uOw1K0bF/C/nCETIRiL4P4oJ7fa2nOg3oc7
	 qeXCDXfPdKcp8ZV9MxvEFZUgYNx7rmEVgjCkfc9WGdOpeFvwZxt7N3OZiTt4pWld6y
	 ZJXDf/jzmFfY7bm4EeYTOvttBtDzHNJkMWeMqXnxfTg3kpbUTqLEPGSRgwDs52CQAL
	 I8t3hRgcu8zPg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so1198785e87.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxFZ7mwMSeKCyMO48ZW8otIOxq8ssfgH3keUl3ug90HRLfK4Ujyd8YKDgQV790hPC+osYi5gaAQcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ngbKyvDPIhu6brFZDJxQ1XY9v99bviLFDH6G2UAqncVGgPwreg
	pA88kbSbA09JOrGDQ4tO3FEizTZe/hjfOUxnpStuZecKfd+SEHTI0+e0pIpoiIefxRLWrdwaFSr
	VKnK3Xei98PuaKkHqYJnYQluK3me7UmQ=
X-Received: by 2002:a05:6512:640b:b0:5b6:1603:7c8b with SMTP id
 2adb3069b0e04-5b8b6655c9cmr3287892e87.18.1789672020252; Thu, 17 Sep 2026
 12:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
In-Reply-To: <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 21:05:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
X-Gm-Features: AcwNN1VasRWS8HiJHGDy74pWeVE-itua9NNF64RwExFD0rkuQM7IztWuAAwbQd8
Message-ID: <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:31=E2=80=AFAM Ananthu C V <ananthu.cv@oss.qualcom=
m.com> wrote:
>
> capacity_freq_ref, the per-CPU frequency-invariance reference used by
> schedutil, is seeded from policy->cpuinfo.max_freq at policy creation.
> If boost frequencies are filtered out of the frequency table because
> boost isn't yet enabled at boot, max_freq only reflects the non-boost
> ceiling, so capacity_freq_ref never learns about boost frequencies for
> the policy's lifetime. Enabling boost later raises policy->max, but
> capacity_freq_ref stays stale, leaving schedutil unable to scale
> utilization or target a frequency above the non-boost maximum.
>
> Track the highest frequency in the table regardless of boost state
> (max_table_freq) and seed capacity_freq_ref with max(cpuinfo.max_freq,
> max_table_freq), so the invariance reference is boost-aware from boot
> regardless of whether boost is currently enabled. Runtime enforcement,
> still handled by policy->max, is unaffected.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---
>  drivers/base/arch_topology.c | 3 ++-
>  drivers/cpufreq/freq_table.c | 6 ++++++
>  include/linux/cpufreq.h      | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 8c5e47c28d9a..da94f77441da 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -404,7 +404,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>         cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus=
);
>
>         for_each_cpu(cpu, policy->related_cpus) {
> -               per_cpu(capacity_freq_ref, cpu) =3D policy->cpuinfo.max_f=
req;
> +               per_cpu(capacity_freq_ref, cpu) =3D max(policy->cpuinfo.m=
ax_freq,
> +                                                     policy->cpuinfo.max=
_table_freq);

So isn't capacity_freq_ref supposed to correspond to the CPU capacity
returned by arch_scale_cpu_capacity()?

If that's the case and boost was disabled when the CPU capacity was
computed, how can cpuinfo.max_table_freq correspond to that capacity?

>                 freq_inv_set_max_ratio(cpu,
>                                        per_cpu(capacity_freq_ref, cpu) * =
HZ_PER_KHZ);
>         }
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ea994647abc8..4984142dc08a 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -33,11 +33,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_po=
licy *policy)
>         struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
e;
>         unsigned int min_freq =3D ~0;
>         unsigned int max_freq =3D 0;
> +       unsigned int max_table_freq =3D 0;
>         unsigned int freq, i;
>
>         cpufreq_for_each_valid_entry_idx(pos, table, i) {
>                 freq =3D pos->frequency;
>
> +               if (freq > max_table_freq)
> +                       max_table_freq =3D freq;
> +
>                 if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>                     && (pos->flags & CPUFREQ_BOOST_FREQ))
>                         continue;
> @@ -57,6 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_poli=
cy *policy)
>         if (policy->cpuinfo.max_freq < max_freq)
>                 policy->cpuinfo.max_freq =3D max_freq;
>
> +       policy->cpuinfo.max_table_freq =3D max_table_freq;
> +
>         if (min_freq =3D=3D ~0)
>                 return -EINVAL;
>         else
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35ce665edfd8..3f3b1380251a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -45,6 +45,7 @@ enum cpufreq_table_sorting {
>  struct cpufreq_cpuinfo {
>         unsigned int            max_freq;
>         unsigned int            min_freq;
> +       unsigned int            max_table_freq; /* Highest valid frequenc=
y in the table */
>
>         /* in 10^(-9) s =3D nanoseconds */
>         unsigned int            transition_latency;
>
> --
