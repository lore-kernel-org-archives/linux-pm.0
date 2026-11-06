Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981343;
	b=aFleTvb91vGW9ostvn0OpVyXqyKzJiTqzqZgtONVwB1yusW5nSbitGtkRYz1K5ij2j8R
	 nyZgeG+gnF7sM7dD2+A7yoLRlD42SRASpCrZjgFIMsReN1Kzf551blTgABexwbb8L64Mw
	 ugrCWdZqGrKn/fqELYrLWBum0tW/fTz8jKwxGqLg9wjGqS5WJH9Bh+Wi0B2oDFoevMe/+
	 HziWRqBKleFlS637tw8csszEDp4LmBs/MMNz50Sk5OAq6Bjnzbjy++JabnBcVdPjwnhOK
	 krdhgcJ3dPP4vKIaNTyn0cozjMgawM+5s9DZbyq8ufVZOJpYBJiRkdphEOiYwurR62A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981343;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QBFuPA5o7efP4jGw5Uh62IHRMOskGTud10helT98leM=;
	b=nN9N0SrmzQuuhZHjKQwvU8nMDoVsZiutLOU6dQcYLDYONx7ePNsKok128POGb7HZLvnD
	 BtPgaRipZovyYdyAFUpq1eWSaVD+yerRG1YTj+7kCLzBedfshAcmQpibtA3ywF2kn+z75
	 IjD3AFA2nSsZ3F6UPC8xwOmnqodrvovifpwM0soS0ede03rwsT9RoPhbFhPJ0YL0QZ+nu
	 JoGwj74Vw6zU3Q8wbyTVyX9cLFrRax/F/e8A1oVVy3TW9G6NyWnSI3rHZpmImA9RDWxH4
	 Zr/JVpO2EjOJFIoaPIP+knDUD+XuV9C+JhW1MonkvI+uJOGYltUKylkt3wfTn04fvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bnnlk1Xw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D160A5BDA
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bnnlk1Xw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355091F00931
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981343;
	bh=QBFuPA5o7efP4jGw5Uh62IHRMOskGTud10helT98leM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bnnlk1XwsJhM714adLANGjs2OMsx5jXpuOo7Oli6q6eRdY7k/cqevHQ/Tx5uFAJnz
	 PzdPTJxas6XIU8P4M9q/E2al+jaPpJjNVGoFFZeDTIjR7vimPttNIw62OrrY5SZ25x
	 JmvgZ5vZTOySPcn2/YrNYTZKVicMXRNgMpVuQ9Kls6vCWhiDhu5Q8xLXolPqiaRirD
	 sOWNmbLLxdT56ALxGEo+saT3ozxrPQTTMmFbH+lCrTgXJzGI1DAT9Hk3aJob+/m6Oh
	 4gsYvgKkZpio6ITxQ5CSmoXrH0igYZs89xjAmqTpCWCVKQ2I+37mqvQTLryNybhiXX
	 TNpdhS0/qxf6g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4fea434bso1865249e87.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHqNG+/lzQycfs7t+2T7hlIoSMSLzCdpfOEo8d+DVhvHlrKdprT8yEGG7iyg8dlnEYqQ0n8E/vz9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5ZFRTQsrVEHxg2bPzhwKcx9WlHxIwjplMA2i2hQMN/Oa9kERc
	y+Gw4/Wk6YK5iJ0VoMEDJwLONhCvG6Cm15ESgUmXoGmIjobHyVEspTMJpyWeFNlKaSVhx6hGbSz
	Aq1QgSb4Epx1RrsFb7meBnPtvu/e47cg=
X-Received: by 2002:a05:6512:8399:b0:5c0:62:7fe7 with SMTP id
 2adb3069b0e04-5c00062885emr928894e87.43.1793981341359; Fri, 06 Nov 2026
 08:09:01 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030172745.2045743-1-sumitg@nvidia.com>
In-Reply-To: <20261030172745.2045743-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 17:08:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
X-Gm-Features: AclHuK_TjpF2X7DtDNnULSldqJeN07Zp0bFqVqftslA3UX5WlTorGVSf-fIrR3E
Message-ID: <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	christian.loehle@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, lenb@kernel.org, mario.limonciello@amd.com, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Fri, Oct 30, 2026 at 6:28=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> This series adds support for the OSPM Nominal Performance register
> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>
> Unlike the read-only Nominal Performance register, OSPM Nominal
> Performance is writable and lets OSPM request a nominal level below
> the platform-reported nominal. The platform treats performance above
> this level as boost and below as throttle.
>
>  - Patch 1: adds ACPI helpers to write the register and to check that
>    the platform supports it.
>
>  - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz. The
>    value is kept across CPU hotplug and suspend/resume. The register
>    cannot be read back, so a read returns the last value written.
>
>  - Patch 3: uses the OSPM nominal as the maximum frequency while boost
>    is off. Lowering the nominal creates a boost range on a platform
>    that has none, and boost can then be enabled.
>
> This series applies on top of v7 of:
>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>   https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com=
/
>
> v7 -> v8:
>  - Rebase on Christian's CPPC fixes series.
>  - Patch 1:
>    - use cpc_is_writable() from that series and drop cpc_reg_writable().
>    - add the register to the list of controls the driver writes.
>    - take cpc_desc_lock in cppc_ospm_nominal_perf_supported(), so the
>      descriptor cannot be removed during the check.
>  - Patch 2:
>    - make ospm_nominal_freq read-write. A read returns the last value
>      written, or "<unset>" before the first write. (Christian, Mario)
>    - keep saving the values in the store handler, not at init(), so
>      the driver writes the register only after the OS sets it. (Pierre)
>  - Patch 3:
>    - document in the ABI file how the OSPM nominal sets cpuinfo_max_freq
>      and caps scaling_max_freq.
>
> Sumit Gupta (3):
>   ACPI: CPPC: Add ospm_nominal_perf support
>   cpufreq: CPPC: Add ospm_nominal_freq attribute
>   cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
>
>  .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
>  drivers/acpi/cppc_acpi.c                      |  44 +++++
>  drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  10 +
>  4 files changed, 248 insertions(+), 10 deletions(-)
>
> v7: https://lore.kernel.org/lkml/20260807214837.863209-1-sumitg@nvidia.co=
m/
> v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.c=
om/
> v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.c=
om/
> v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.co=
m/
> v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.c=
om/
> v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.co=
m/
> v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.co=
m/
>
> --

This would be good to go except that it doesn't apply for me on top of 7.4-=
rc1.

Can you please rebase it and resend, with Christian's tags included?

Thanks!
