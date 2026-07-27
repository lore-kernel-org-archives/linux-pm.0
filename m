Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BA412BFC
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158893; cv=none; b=XmuERH2XZws09clmPWAHYulC9aZgBw0WC7BALaq8OsjPhTjc3330bespsZdc39JyJU5ksKdDroXUZdxSd+510gzM6Vw+/t/+K/WQtcsf08j7SVcSBTZWMPaWDR7PrPhrM1wDelvZbGy6TbK3+Pbx9Q+2btVhMRiNegQGXEVGddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158893; c=relaxed/simple;
	bh=MjOLtdbnHINQiZsUbyUdq0JT2ExAvNVto4UrqMDkKXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLMdg6V3qVKGa3Br5sTBXq7ve02BzpZqw64LDMfxYxr6qep+x9FY/c9LMm05NRgZiYWm1KUdME5IZ2AEQKyvudz8MNMyQ/C2oP1CPuePMivbouvQHU5k7tqx+6q0af6L5UAOo1hj146SiwM8XEgNLDcl6uxHGnXnWxx6HoAeacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0wXjZON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0wXjZON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F41F00ACA
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158877;
	bh=jo1uDciI4hvqGlusKkjXRbJpZ2yEY32stvntK0agl24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a0wXjZONqRUfwF8IFBW1Ed9ylkWDBJ9tPy5PYtFwEfD3Uv6ER6mE+dBgq7qI/q7PM
	 pulbUIOQeQdzm7Vi1em59Iuq+Py1wCXD1h2iFuw5B3yPorb6Osv3Q3qgiXkXq0rb/j
	 UVih/N/2Cj706niYtyRU9eq/ozayy5lTjiPcq78EzMtxyKxztX0xlaAw6PwGMbQXa+
	 X/BYZJE0DEiQHKoEsVz4ZFW4NOQLsQealE/fxQboeY8dy+GCCKFoW/np3IeLK22Bda
	 L1BkrOpTgw8/Z1eaG9Dspl6L3QIZTw2yjNOv9OZpKEFOPMyPPjxXvn5/y7K1jLGi+X
	 8VGFQ0HTx1kFw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so3171343e87.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 06:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWTMBLKzYJ7BBfVMG8m4VlLz2dMlzCMKyOymzbvvTKtFOCeBR4DMn1ShbnhqZe9mj04fKRphDPEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZd/pGeihP4kMt47SOEVEBhntpP7g9/zNGDsBRPRgr6Cpi4yeK
	i/HwMLKF9WLcSbnmhHjvrmfTqIClTWLdePUgwso5Zi7t967VWEP1AFhCgZxnfcBK9rBK9QGfpbd
	yjNXXy9ntlhf800iwLlq1lWrze4cTLyI=
X-Received: by 2002:a05:6512:3d21:b0:5b2:b08a:ef9 with SMTP id
 2adb3069b0e04-5b2c19a2600mr1455909e87.0.1785158875656; Mon, 27 Jul 2026
 06:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717215330.2215058-1-sumitg@nvidia.com>
In-Reply-To: <20260717215330.2215058-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 15:27:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdF+PYjxTqUSp_oJiCcPR4UUrQdBPt0K3f08BLRB4L4g@mail.gmail.com>
X-Gm-Features: AUfX_mziGygpLsC-M2M15skm83Ku8CRgNdaAig39SbPrrccs_TRF337AG_LqlDs
Message-ID: <CAJZ5v0jdF+PYjxTqUSp_oJiCcPR4UUrQdBPt0K3f08BLRB4L4g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, christian.loehle@arm.com, pierre.gondois@arm.com
Cc: viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:54=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> This series adds support for the OSPM Nominal Performance register
> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>
> Unlike the read-only Nominal Performance register, OSPM Nominal
> Performance is writable and lets OSPM request a nominal level below
> the platform-reported nominal. The platform treats performance above
> this level as boost and below as throttle for its power and thermal
> decisions.
>
> Patch 1: adds the cppc_{get,set}_ospm_nominal_perf() helpers, a
> per-policy cpufreq sysfs attribute (ospm_nominal_freq, in kHz), and
> hooks the register into the OSPM-set save/restore table.
>
> Patch 2: reflects the OSPM nominal in the cpufreq policy so that boost
> and the frequency limits stay consistent with the register.
>
> This series applies on top of the series
> "cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload",
> which provides the save/restore table that patch 1 hooks into:
> https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
>
> v5[5] -> v6:
> - New patch 2: reflect the OSPM nominal in the policy's boost state
>   and frequency limits.
> - Patch 1:
>   - write only policy->cpu instead of looping over policy->cpus with
>     rollback. the register is treated as shared across a policy's CPUs.
>   - add the register to the OSPM-set save/restore table.

Christian, Pierre, any chance to have a look at this, please?

> Sumit Gupta (2):
>   ACPI: CPPC: Add ospm_nominal_perf support
>   cpufreq: CPPC: Reflect ospm_nominal_perf in boost and limits
>
>  .../ABI/testing/sysfs-devices-system-cpu      |  26 +++
>  drivers/acpi/cppc_acpi.c                      |  32 ++++
>  drivers/cpufreq/cppc_cpufreq.c                | 166 +++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  10 ++
>  4 files changed, 226 insertions(+), 8 deletions(-)
>
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
