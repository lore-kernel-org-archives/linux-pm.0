Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949046EF97
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935324; cv=none; b=f2czF/JAYbqbeQfCxtEu666g3yYu5Qra+DdcX4ZMTCA96ezpWLKFZ337VC2NwEqylLBf3ILYx0X82K1tSe3iQqYUQmeOSg3Q6VDMv9ctJ2hUKyR1cDtw3kvoKBhdASKIKNovlOZ2VFLDzELPdgYrgYG2zEI1lnI+dvUvdnTW6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935324; c=relaxed/simple;
	bh=6dUMIQzJj/gjxFZDPawThVxYqfw6kpsbefTT6E1dAT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJE9L97aKlwyh8B+iGFb5cwUf/28QKcoBuymBvQI+9BCI09+ibmZLnmY0WzFmo0BL129FIe0xNV77ugTeBewJ6Bq13TkUFa5BnXZR92S6BKvjqbrb6XKA2l8F/nD9l0yi0HRp6ybjm5Q6/NQp5EED4C0cTpuzMRRFn/sLVtRwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZojHv2G5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZojHv2G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A934C1F00ACF
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935322;
	bh=rriqBNK6oHvVYqznZx3OyFyQqrBnagP/gYB4IvuW224=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZojHv2G5aY3DwD+8ZzyoYIkGtVhpCWlB7AMfBhbtjF9okbu8HRvnFFJqeNJ/lNeif
	 bRXto/wzSBYinYfgB9VC82Lj9Oxl24v9IB34eoS9/Hk1a1CHT4KWORj3o9Mz8JrWR5
	 8Las6/DaU0DwO+i98hz1+jRR29sL6fow7uzCyF+xWUEKdqyk1DW7X41iy1YIYghHq2
	 DZlaZ2PJvjfrFTEyvE+JeCihqUpKFc22a5PdTlrEBqHuxrndKDALcgvoILKRfbfiYb
	 WYGD3Rg8Mu2at92Y0yV6nG9pcXZK3xxuRnV+iWZcD+qn2kmNlJClPq3ADaCRj+V+ch
	 wWlRGVWii83lA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39ee96f8047so7053401fa.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 06:08:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpYIUjJtScdke0BOyixx8mmYFHLgzYG+d+QhqbkXsmL5aBzMzsa+W0xhiA8Xk+z6f7owl88ILG4QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNUkzNaJqygUg2WKbZbVq/guyvOcUYc2VdGxF2sgCw7XUIrD5
	997xK7oqsZ2SILwh/YJ4mCWkPfc31zgymbH+cZJJ3aYW65nm34H1D8U4R/9vIVcx6RVGojqIweJ
	d6QuhQOvLkysWEwm+Z9H62NbPDdMyLp4=
X-Received: by 2002:a05:6512:61b3:b0:5ae:c063:6397 with SMTP id
 2adb3069b0e04-5b2f4b8f29fmr928934e87.15.1785935321073; Wed, 05 Aug 2026
 06:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803210527.1285229-1-christian.loehle@arm.com> <f48c36fe-446f-4f83-8d2d-0913aafc377e@arm.com>
In-Reply-To: <f48c36fe-446f-4f83-8d2d-0913aafc377e@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 15:08:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdAmDORMeHD5qVpji8vBZpCP-uHJ-bF_7wYxA5f8kKaA@mail.gmail.com>
X-Gm-Features: AUfX_mzpRx3VG1wGIvbulaHf7izF1itLfhxfEyIyhlUMkBZwn6rv-6d431tybeQ
Message-ID: <CAJZ5v0hdAmDORMeHD5qVpji8vBZpCP-uHJ-bF_7wYxA5f8kKaA@mail.gmail.com>
Subject: Re: [RESEND][PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:28=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/3/26 22:05, Christian Loehle wrote:
> > cppc-cpufreq reaches cppc_set_perf() from every target callback.  For
> > direct SystemMemory controls, that path currently does several steps
> > which are unnecessary once the immutable _CPC layout is known:
> >
> >   - a full-width write first reads the access unit and merges the value=
.
> >   - every write takes the descriptor's RMW lock, even when its access u=
nit
> >     is not shared with another _CPC entry.
> >   - cppc_set_perf() evaluates the same three PCC predicates at each pha=
se
> >     of the transaction.
> >
> > Remove those costs while retaining the existing conservative paths for
> > partial fields, overlapping or malformed access units, and PCC controls=
.
> >
> > The series was tested on Arm Power-Orion O6 and AmpereOne systems using
> > cppc-cpufreq and schedutil.  An rt-app task pinned to one CPU ran for
> > 500 us every 2 ms with uclamp.min=3D512, for 5000 periods per run.  sch=
edutil
> > rate_limit_us was 1000.  cppc_cpufreq_fast_switch() latency was measure=
d
> > for 100 ten-second runs.  Each sample is the mean callback latency with=
in
> > one run, and the table reports the median and sample standard deviation
> > of those samples.
> >
> > Orion O6               median       stdev       callbacks
> > baseline               5703 ns      307 ns       188017
> > complete series        5023 ns      240 ns       188209
> > =3D=3D> 680 ns (11.9%) reduction
> >
> > AmpereOne              median       stdev
> > baseline               2090 ns      157 ns
> > complete series      1907.5 ns      140 ns
> > =3D=3D> 182.5 ns (8.7%) reduction
> >
> > The cumulative intermediate results on the Orion O6 attribute roughly h=
alf
> > of the gain to each of the first two patches: avoiding the read reduced
> > the median by 284 ns (5.0%), and avoiding the lock reduced it by anothe=
r
> > 336 ns (6.2%).
> > Together they account for 620 ns of the 680 ns total reduction.
> >
> > With the same arm64 configuration and GCC 11.4, caching the PCC predica=
te
> > also reduces cppc_set_perf() from 1124 to 884 bytes.  The generated
> > function has 60 fewer instructions, 17 fewer loads and 20 fewer branche=
s.
> >
> > This series is based on the CPPC fixes posted at (already queued):
> > https://lore.kernel.org/lkml/20260722093825.1030594-1-christian.loehle@=
arm.com/
> >
> > and the separately posted fix still under review:
> > https://lore.kernel.org/lkml/20260724104042.1481804-1-christian.loehle@=
arm.com/
> >
> > PS:
> > There's a final optimization that I actually wanted to make but decided=
 to
> > split it out for now as it somewhat replicated Sumit's series:
> > Skipping redundant perf ctrl writes in cpufreq-cppc if registers are no=
n-PCC
> > and !shared (because the values are unchanged, the
> > !autonomous-common-case), but that requires the driver to have a more
> > complex caching- and atomic-updating machinery in place, similar to
> > hotplug. As opposed to this series the optimization would be for the
> > microcontroller handling the CPPC requests, which may be shared across
> > many CPUs and therefore redundant requests can increase the dvfs
> > transition latency.
> > That patch will follow once Sumit's is queued:
> > https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com=
/
> >
> > [RESEND] for the new base-commit specifier below
> >
> > Christian Loehle (3):
> >   ACPI: CPPC: Avoid unnecessary reads for full-width writes
> >   ACPI: CPPC: Avoid locking standalone full-width registers
> >   ACPI: CPPC: Evaluate performance-control PCC use once
> >
> >  drivers/acpi/cppc_acpi.c | 135 +++++++++++++++++++++++++++++++--------
> >  include/acpi/cppc_acpi.h |   5 +-
> >  2 files changed, 113 insertions(+), 27 deletions(-)
> >
> >
> > base-commit: 075b74841bd0065a3bda3440873c747938e69b68
>
> Nice, so that worked:
> https://sashiko.dev/#/patchset/20260803210527.1285229-1-christian.loehle@=
arm.com
> Seems no findings on $SUBJECT

Yes, so applied as 7.3 material.

> but the rest of the comments it has look legit to me?

Yes, but please address those on top of the $subject series, thanks!

> I'll go take another look tomorrow:
>
> 1. Using per-CPU cpc_desc->rmw_lock for SYSTEM_MEMORY CPPC control regist=
er that
> may be shared.
> 2. MASK_VAL_WRITE() truncation on 32bit architectures.
> 3. acpi_cppc_processor_exit() calls kfree(cpc_ptr) unconditionally (UAF w=
ith sysfs?)
> 4. cppc_set_reg_val_in_pcc() calls cpc_write() before down_write(&pcc_ss_=
data->pcc_lock)
> 5 & 6 are sanitization of values from FW.

Sounds good to me.
