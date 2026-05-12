Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74F357CE7
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612109; cv=none; b=EIVj5nera7oLzqqZHm5wPeSLsMi3ZN5h9qcmXIGxKUsgW+EB0e6DTwt6fhs97dpLH0t5hl+P7GxVaCgY30RefZkU9llLFeqYdJhnaXUauK6Da/3cYSfDeUYyEcSwVzmELPCxwa0ffLbJZOxIHm/3kCGvT6ePkPlM1jooV94GGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612109; c=relaxed/simple;
	bh=b2M4Bs9Hv1b6UoBmB+3vmjIMo28MsoVjaNisWlPy5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okYWtzjTxOIqqJJxU8yYtzcXrwJu4J9S5Juyc+Fn8k/MVwH1g1FFYqMRfOlPNabVsM9HxYgmCqGL1G78kkE/Pvwmdx5LB8yQ7sNFJtEizFyh7a4A7jX8sxpNTFrCbYDvtpjX5a6NGlrCUKfD38WrD9WLGeTplGmrLg6BZ766DBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGElApfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGElApfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F7C2BCB0
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778612108;
	bh=b2M4Bs9Hv1b6UoBmB+3vmjIMo28MsoVjaNisWlPy5DM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KGElApfplQfsSq3uOiQtgyOzMAd3U/6Mwcc7XEeOL4fBTDUxqXi4QeSEx9a95yd0U
	 IKHK0vDlyq8CTD+ekaIkSvnT8CE/1aYa1ANJ40I2Xt8KG5ImNQE0qeqIbao0jycZ4r
	 no5RXR0eyKRmkFE0b1Zq+vI0CVpuJPmocK9iqDb1RYHlFy0as0blLBAB02JsRKDUQ6
	 tJodJH+FAJbtz1we4U2V1BX3yQqFsYWEmjUnufLQXY4Zg6pl+ebImZ2xxkLgqN50jF
	 nPfut6EZZkzPrP36BYjW0E4uIeisw+Ue6XYL+i0gQ9ucfJ0aOBsX5YXnmrq5ZdTiNL
	 USN3598qoD69A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8d648466bso3116586e87.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 11:55:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Chgc/livWBA3m5poqA/Oh0vg0YEN5Kv2V09/0FFmSkgC+r6aLHsCWDvPff88qqfZ/nX6yZxQ4Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTqqlIBHNqKtKC8oG6O50VQqoSttaTkrR0BgxpRip0ZUnNMSn
	yFBNk80fwugA7A3k6FgLzNQDmH/5b3eTWt5zY8nNNaEDYSTJtXUkth4oYw85KJTc8Do6McovrCG
	ARiZJYVYyypmn5E2dH/io8234SuhSUP8=
X-Received: by 2002:a05:6512:65cc:20b0:5a8:f03c:fb1e with SMTP id
 2adb3069b0e04-5a8f03d061emr16991e87.18.1778612107325; Tue, 12 May 2026
 11:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
 <3a6b3499a8f2d39bac2bcf483ee48123823795d9.camel@linux.intel.com>
 <CAJZ5v0imv=-NRy1e1mvEYFcyryr7kqyCu+nEzGW=S+PSzDJHWA@mail.gmail.com> <d2c5b841302df2538ffb634d9a86c5643122a509.camel@linux.intel.com>
In-Reply-To: <d2c5b841302df2538ffb634d9a86c5643122a509.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 20:54:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLkFxf_gN4xYmYfFtedKBqg5RehV_xMO-fKco5KoHvrg@mail.gmail.com>
X-Gm-Features: AVHnY4LHdDS1jSsnTLv3gf1sS_X-dD3hAdVjylB4h-z4_RJrJj1XUWZQdToiAuw
Message-ID: <CAJZ5v0iLkFxf_gN4xYmYfFtedKBqg5RehV_xMO-fKco5KoHvrg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Tseng <henrytseng@qnap.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:45=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2026-05-12 at 14:37 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 12, 2026 at 1:15=E2=80=AFPM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Tue, 2026-05-12 at 12:20 +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 12, 2026 at 1:53=E2=80=AFAM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > Raptor Lake-E processors are not correctly showing cpufreq
> > > > > frequency
> > > > > limits.
> > > > >
> > > > > These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-
> > > > > cores,
> > > > > but
> > > > > P-cores still use hybrid scaling factor.
> > > > >
> > > > > commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> > > > > hybrid-capable systems with disabled E-cores") added support
> > > > > for
> > > > > such configuration. Here using CPPC nominal freq and perf was
> > > > > compared
> > > > > to still return hybrid scaling factor.
> > > > >
> > > > > Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > > > scaling
> > > > > factors") restructured hwp_get_cpu_scaling() and added an
> > > > > explicit
> > > > > check
> > > > > for X86_FEATURE_HYBRID_CPU and when not set returns core
> > > > > scaling
> > > > > factor.
> > > > >
> > > > > To address this remove check for X86_FEATURE_HYBRID_CPU and
> > > > > call
> > > > > intel_pstate_cppc_get_scaling().
> > > > >
> > > > > Ideally this change should be enough. But using CPPC for
> > > > > scaling
> > > > > factor
> > > > > results in rounding error, so still doesn't restore the
> > > > > original
> > > > > behavior.
> > > > >
> > > > > In intel_pstate_cppc_get_scaling() return core scaling factor
> > > > > when
> > > > > ACPI CPPC is not present or when CPPC nominal frequency or
> > > > > nominal
> > > > > performance are invalid.
> > > > >
> > > > > Use hybrid_scaling_factor for P-cores when defined for a CPU,
> > > > > if
> > > > > not
> > > > > calculate from ACPI CPPC nominal frequency and performance.
> > > > >
> > > > > Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > > > scaling factors")
> > > > > Reported-by: Henry Tseng <henrytseng@qnap.com>
> > > > > Closes:
> > > > > https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henryts=
eng@qnap.com/
> > > > > Signed-off-by: Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > >  drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++-----------
> > > > > ---
> > > > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > index 1292da53e5fc..0379efdee5f8 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -421,15 +421,23 @@ static int
> > > > > intel_pstate_cppc_get_scaling(int
> > > > > cpu)
> > > > >  {
> > > > >         struct cppc_perf_caps cppc_perf;
> > > > >
> > > > > +       if (cppc_get_perf_caps(cpu, &cppc_perf) ||
> > > > > !cppc_perf.nominal_freq ||
> > > > > +           !cppc_perf.nominal_perf)
> > > > > +               goto core_scaling;
> > > > > +
> > > > > +       if (cppc_perf.nominal_perf * 100 =3D=3D
> > > > > cppc_perf.nominal_freq)
> > > > > +               goto core_scaling;
> > > > > +
> > > > > +       if (hybrid_scaling_factor)
> > > > > +               return hybrid_scaling_factor;
> > > > > +
> > > > >         /*
> > > > > -        * Compute the perf-to-frequency scaling factor for the
> > > > > given CPU if
> > > > > -        * possible, unless it would be 0.
> > > > > +        * Compute the perf-to-frequency scaling factor for the
> > > > > given CPU
> > > > > +        * from nominal freq and nominal_perf
> > > > >          */
> > > > > -       if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> > > > > -           cppc_perf.nominal_perf && cppc_perf.nominal_freq)
> > > > > -               return div_u64(cppc_perf.nominal_freq *
> > > > > KHZ_PER_MHZ,
> > > > > -                              cppc_perf.nominal_perf);
> > > > > +       return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
> > > > > cppc_perf.nominal_perf);
> > > > >
> > > > > +core_scaling:
> > > > >         return core_get_scaling();
> > > > >  }
> > > > >
> > > > > @@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
> > > > >                  */
> > > > >                 if (hybrid_get_cpu_type(cpu) =3D=3D
> > > > > INTEL_CPU_TYPE_CORE)
> > > > >                         return hybrid_scaling_factor;
> > > > > -
> > > > > -               return core_get_scaling();
> > > >
> > > > Why is this change necessary or even useful?
> > > >
> > > > This is about E-cores (because P-cores have been covered above)
> > > > and
> > > > if
> > > > hybrid_scaling_factor is set, it is known that the processor is
> > > > hybrid
> > > > and E-cores have the "core" scaling factor.
> > > >
> > > > Or is Raptor Lake-E covered by one of the
> > > > intel_hybrid_scaling_factor[] entries and
> > > > hybrid_get_cpu_type(cpu)
> > > > doesn't return INTEL_CPU_TYPE_CORE on it?  This piece of
> > > > information
> > > > is missing from the changelog.
> > >
> > > Raptor Lake-E (Xeon) uses CPU model as Raptor Lake-S, for which
> > > there
> > > is already a hardcoded scaling factor in the driver.
> >
> > This piece of information needs to be added to the changelog in the
> > first place because it is key here.
> >
> > > So this "if" block will enter. But since there is no hybrid CPUID
> > > feature is defined,
> > > hybrid_get_cpu_type(cpu) will return 0 for P-core or E-core. Here
> > > there
> > > are no E-cores. So need to remove core_get_scaling() as this will
> > > return non hybrid factor.
> >
> > Well, what about this:
> >
> > ---
> >  drivers/cpufreq/intel_pstate.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2279,7 +2279,7 @@ static int hwp_get_cpu_scaling(int cpu)
> >           * Return the hybrid scaling factor for P-cores and use the
> >           * default core scaling for E-cores.
> >           */
> > -        if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)
> > +        if (hybrid_get_cpu_type(cpu) !=3D INTEL_CPU_TYPE_ATOM)
> >              return hybrid_scaling_factor;
> >
> >          return core_get_scaling();
> >
> > Or is the original Raptor Lake-S scaling factor unsuitable for Raptor
> > Lake-E?
>
> This will work for RPL-E.

OK

> But the original change also accounted for
> core scaling on hybrid. There was some embedded hybrid capable with P
> core only, used core scaling. Don't find that system details anymore.

It's better to address this one separately IMV.

> But fine, we can live with this change with added Bartlett Lake scaling
> factor.

OK

Let me send a proper patch for the above change and I assume that
there will be a separate patch adding the Bartlett Lake scaling
factor.
