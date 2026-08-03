Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387C369D6A
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768859; cv=none; b=Y9PGkw1ChT33BXMGaKsdoKaD315vxYQnGTSZEyI68NbbZcHiQpRrFpt0radz0/15k1J1fiPwyJq3w5Q3UL9y11zaVostukpnzC5/+UNZb7GPeXL4O9jRFpWgCTyt75fM/JPYEP11/440fZ4rNbpm4g1Io7xFfVgibDJi/Sf1peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768859; c=relaxed/simple;
	bh=3yzxWvETrsnYT4xHWMhYoTAD97GVF8bzp7RYly7/W1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGG1423IyWNqHDef7Mf6nEU9rBb5+6YfDOytuKPbcYOr0Pu6uXbWvGoEL4pQgo8B2jyk+3xN9CxNzfsV2S+MNhf92S7rTpE+2u3wIbkhBHOxrVw4BN+lF31HFNxES4YUmSgpXGIWqtIfUFyISJVyF60SLm+9hc/OTyi9xyWUsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVg3O0Tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVg3O0Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D6F1F00ACA
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768857;
	bh=Ywl5oe623Vpe3tuJANluxXi2/b2rsrMCrnpTFJYzc0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QVg3O0TgZ+zJXKWWL5IxngXLtIUD3zO92M3QPQkZCTA7sPddsVp47U1N/GW9kk5tx
	 0OV9iPasxWm/2eiXCjv+B44hfDDOMmUH+4Ip47CKFgNgSHWTeajalHpU+sZagkdp9Z
	 qR8QMluRzbfjWQYf0CcFVgZ/dmwQwzHXkwpAj4EmsTnQJhMUsHgRKlwTKiFMQWPX1z
	 deCArbBuD8SmlR+frMtEaw6vN2HwqQbxh5jNQIdBd4k4zExTo+oJ7T0sFsgpapS3IZ
	 Su+hqqwVXR6X5H9d/omZHXl4ZxULF2eRMtG7FTHFdU1Jcnl9vsyrCyKiky2vSqUyQ8
	 VN97DpWu+pkJw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39faa67fabaso3309251fa.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 07:54:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGYIQoybfI0LN8mIYzExWmfvT5ZZdvPRkmzv080Fkb49JW2SG3CMH6i90BkFJ7AXfDn268sEe0gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9P6mRKlQjlQoJ3BaFSspjEiCYbI6vo5GbPCZ3DkAcPvLXQYx
	wBp3cGJzb+gm6RXa+53erGr+WrrYpceJTsSkg4HJT5C9Tb+wkxpfWoSn7Gh02aerolZzyEAEbaJ
	vhhPbB5nh0cWQ4vn+smv97+lJ28Q6rYc=
X-Received: by 2002:a05:6512:669a:10b0:5b2:b6a4:707 with SMTP id
 2adb3069b0e04-5b2e4fa0f67mr1228384e87.63.1785768856144; Mon, 03 Aug 2026
 07:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724134251.1632824-1-christian.loehle@arm.com> <033eb158-936a-4f79-a134-80402fb018e8@arm.com>
In-Reply-To: <033eb158-936a-4f79-a134-80402fb018e8@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 3 Aug 2026 16:54:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFvXKTO7MnC5GHYo85E6NwXQUXRDmmkq1i9BtSbQueAg@mail.gmail.com>
X-Gm-Features: AUfX_mxrWwuFwnt0mThMwbZPh5Am2hnR2yvkfgnKMGv2aZ7g-dd2tOgpUyzqSRU
Message-ID: <CAJZ5v0jFvXKTO7MnC5GHYo85E6NwXQUXRDmmkq1i9BtSbQueAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:07=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/24/26 14:42, Christian Loehle wrote:
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
> > base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> > prerequisite-patch-id: 4c1f4063800e3658717eb77e43af13dad52d55cc
> > prerequisite-patch-id: 5c40d9f099543123c9b904d18ce651e740fbefb8
> > prerequisite-patch-id: 7202391dca8f31f9eb8f6d59fc753b3ce665e103
>
>
> I was about the rebase and resend this series but noticed it still applie=
s cleanly
> on 7.2-rc6 + ACPI: CPPC: Avoid Desired Performance reads on ACPI 6.6+
> https://lore.kernel.org/all/cover.1785749175.git.christian.loehle@arm.com=
/
>
> Any comments on this?

Sashiko says that it couldn't apply this series:

https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40=
arm.com

Would it apply on top of plain 7.2-rc6?  If so, can you please rebase
and resend it?  Or is it linux-next-only?
