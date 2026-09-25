Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B043F4DA
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364319; cv=none; b=Ram6/G+jd1hzIGxRVNcMsRhEKyCKssqquQ/KStrHyo9Etj5zCN628uVodVXAUdqpgkeD2WpDmrLWCY3jYDsZwudcaEk2LQzncbf9lUNmZU29oCSFrouhMHJ1+d1Y5XKXi9ncIhGBD6Wtt6uTV2xxoulAgnQgQYONQYlrajwptp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364319; c=relaxed/simple;
	bh=orOQIuMWgmNfpyVvSBIiKDXXIfxlvVwi1uDc6JpnOnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOdFzBCQDisqbc69DuiicR3EppWngj8A6FjPU8f3u9kCe8NLmv+KcxxZdaodu6/QRQdzb2/49/75j44dnDhSw5er5C6o7IBtGspUUj7HFXicCZ3RXgFra4PUnAjXAxTbaCkj0LJtrMCRl9ekMnyg9ZcL3e9qkNapdIhxGhKGCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgMhPCgS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgMhPCgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FDD1F008A0
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364317;
	bh=nBf4LR0QybGxODUVGWLYzoR9YycS12OFozmgvcTcyzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SgMhPCgS1g/SBrRAXC8/7WLHaXSM2aK4ZHjIgziO+Y1yxNb0kRKuGqhqLKFt4ivnU
	 ESvmWhh8cb3ASdcq9bciF2ZUUCnRpAJ+osXj13vUizJB8bBqrCyj+MYcXwsF50SOFh
	 eYIUau2uDrZQrg9AigBLcithA5eKQWoCmSHzA4LoSXR8C/Xo/9DKbTteAl6ZuHpk3j
	 Hhm7ReTPekFizzh+KnWlu7NscYt5+j4GIbyDURUfiVvDrnlUzbAQuQI7mJzQJonR1G
	 wkXhIwRaPfL6f7SLxQ3InNFxsXbBdfhAcaT28SkpfgUgQq9fRokW1pK44HuKIAtqkv
	 uOvEYVmuAC0iQ==
Received: by mail-lr2-f28.google.com with SMTP id 38308e7fff4ca-3a659495608so2060971fa.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:25:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzz82NeKljXZ0if2z0R0EHew07ApE+DGynNzN3nnk8oS1y+vZDheWwyrTgs+luo26fTozfOoDSXpw==@vger.kernel.org
X-Gm-Message-State: AFuF++lj0My301ZnQ64PnkFS4dXfXOcorQNhlg3Y6Eu5ps3XLLI4YQ1h
	IMhK1ANyn9gNT3i3NugmsRJ8bLOgZWis8gB/6PcN7vGVM+5nMzrBD19ZyATZMd1hEI8X5sBHlfe
	HCOOq8ZcHmTeSSQnmrjEKRX28jxQ/9H8=
X-Received: by 2002:a05:651c:418e:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3a6553dce4cmr4861551fa.12.1790364316036; Fri, 25 Sep 2026
 12:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916103820.1760297-1-sumitg@nvidia.com>
In-Reply-To: <20260916103820.1760297-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:23:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXcRSj5ufpLTAgTSYtFDCXRQL3bJ5wNLtfRMrvHfo9ow@mail.gmail.com>
X-Gm-Features: AclHuK9qDYz-k5dcjQxp54XHZKMEw0rv2InbPBzQTUFY63R1_VmtSqKrupNEn6Q
Message-ID: <CAJZ5v0hXcRSj5ufpLTAgTSYtFDCXRQL3bJ5wNLtfRMrvHfo9ow@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com
Cc: viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com, 
	ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:39=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
> preserves the OSPM-set CPPC registers (Energy Performance Preference,
> Autonomous Activity Window, Autonomous Selection - set via sysfs).
>
> Without online()/offline() callbacks, the core tears a policy down when
> its last CPU goes offline and rebuilds it on the way back, re-reading the
> CPPC capabilities each time. The values written to these registers can
> be lost:
>
>  - Across CPU hotplug or suspend/resume: the platform may reset them
>    while the CPU is offline.
>  - On driver unload: the driver-written value is left in the register
>    instead of returning to its pre-driver state.
>
> Handle these with:
>
>  - Patch 1: adds online()/offline() callbacks so the core keeps policy
>    alive across CPU hotplug instead of tearing it down and rebuilding it.
>  - Patch 2: makes the autonomous selection register helpers take a u64.
>  - Patch 3: adds a table-driven mechanism that captures each register's
>    firmware value at init(), restores it from offline(), and reapplies
>    the OSPM-set value from online().
>  - Patch 4: extends the same save/restore to system suspend/resume.
>
> v4[4] -> v5:
>  - Patch 1:
>    - offline() stops the frequency invariance updates and online()
>      restarts them, replacing the resync that raced with tick. (Sashiko)
>    - reorder the functions to match cppc_cpufreq_driver. (Jie Zhan)
>  - Patch 3:
>    - reapply the OSPM-set registers even when the performance control
>      write fails. (Sashiko)
>  - Patch 4:
>    - suspend() stops the frequency invariance updates too, completing the
>      patch 1 change for a policy whose CPUs stay online.
>
> Sumit Gupta (4):
>   cpufreq: CPPC: Keep the policy across CPU hotplug
>   ACPI: CPPC: Make autonomous selection helpers take a u64
>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>   cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
>
>  drivers/acpi/cppc_acpi.c       |  20 +-
>  drivers/cpufreq/amd-pstate.c   |   2 +-
>  drivers/cpufreq/cppc_cpufreq.c | 378 ++++++++++++++++++++++++++++++++-
>  include/acpi/cppc_acpi.h       |   8 +-
>  4 files changed, 381 insertions(+), 27 deletions(-)
>
> [1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvid=
ia.com/
> [2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvid=
ia.com/
> [3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvid=
ia.com/
> [4] v4: https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidi=
a.com/
>
> --

Dear CPPC cpufreq driver reviewers, I need your input on this series.

It is not going to be applied without any input from anyone.

Thanks!
