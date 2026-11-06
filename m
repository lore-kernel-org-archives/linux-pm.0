Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984480;
	b=sLzeUIdaD2cJq99da1oiee0FJs4J8L2ukan6669Y2JOC9qv1oC/ZVWcXgcCq2dP4sXI0
	 Ks7ciNfU7xC91mhNYNcrp3c0mdc4WWfvLT8BDfn6FPVt5tbWnneObyBWv0M1vV1uWBses
	 6mdQSwWT9JlKvWQBZl1Hu6F1aXlOcc/G2wfB1Y0nXkU4cYma/13rtC12mImiuF5neh0Gi
	 Gw+/MaHkqbJo7H/ZTr44dB5LGPDXIG8HBw8jzbixtK9EN8Rv387S8/yXmxc6kFsYRffUp
	 9wcS5N/R1v9E710VjCYLTk+KzqOBoRsUomnJkIbHZP76GEu0J+gzx7Gx1tDCFBLs4mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984480;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BN97gF7QYz3XCGGA/85Pdog3mwPsMOhrMb974nuHM04=;
	b=GKPC+IpLzTj4jYEhlG1JsBgW/y7gbsd+FdP/Gvx46mtIDebxpdvbDt+D5yBOk4uCZp9F
	 qQqQot5Bi6tiSSbrzi3CE7pSKDYHd8bSd7MWErkbPjiFhTmaRJVipO15tgEBrI4dmproL
	 2PkGAd7nWr7ZjVjwosozznZELsa8rD2ZYtbf79Wiw+nZMi7foiAUyQREe14ejAPOaWHrq
	 hGtvWL6sxky/WOLxBYPKD0un/6iW5pFgVfIVDPNXI+SsZu78eZ5g8OGIv2JdYcI3Dhnvy
	 Eiq9h+38Iv7q7tYcoyYTOqS64fVI+LMRFwHF2lOsH0d+sFR4toiUXLYBmmYb7BR9efw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J05iHxb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FA606A332
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J05iHxb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BD21F00922
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984480;
	bh=BN97gF7QYz3XCGGA/85Pdog3mwPsMOhrMb974nuHM04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J05iHxb82hwKC6d7cq94/xG61kvCDjT03AoTQksVf29Ch+qaGsI7gq+B/b32uYer8
	 4hjiYauXXoAb9nZXehaIjdh07iud3pwvahOuRtkqqdHUCNk+TH0MZ67oR7aIFtH3wQ
	 CJ4rDLj3qaBeiQGb89w4zQe5k+OsZsVvNBs5q5sIqpmSKCkxeqWiU6Xrb9v80FsZhG
	 6psTOWsuH/Jtr9iTfRNFHKY/ox/JDsU+t6Q+8R5EIyHF8uxdReZRaFwxiIfJZseeCc
	 VppunKgSfhRL0ICiIjF2t7bwYgYkPekztqFd9hC3UEfZb5vyWAKYSfMzn6/z8pbkdL
	 pD/tiRy1yO6rw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4d648aacso685271e87.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 09:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHyz7tmyXuBi3e+t8fTRNSIEFQi1myAGTMGtmsHe6xegZVZQK6VMx7c17rH1/NFC1HDvCQYmiFAYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DWpd2V2nfJ4zh4L5JT3otu8gZ4v4LPFnjQetaQeHljyf22A27
	8kWDNWGaD7CagS7T1mlsR5ULn4tmSZ+PuqrZjXMpfRhFIJs14745pceAdCmm1+7BNNMjPBd4n2m
	C/lGH6HaLZQS2APd0JSAn9icSLcWmVh8=
X-Received: by 2002:ac2:5690:0:b0:5bf:d29f:20b with SMTP id
 2adb3069b0e04-5c003ac45cdmr1049767e87.11.1793984478465; Fri, 06 Nov 2026
 09:01:18 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030172745.2045743-1-sumitg@nvidia.com> <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
 <5089e131-c904-471e-a078-5df7cc664372@arm.com>
In-Reply-To: <5089e131-c904-471e-a078-5df7cc664372@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 18:01:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jP-z=zu=S_aBc3JpocRWJXcjzB8WnXu2UHd3WBf9cE3g@mail.gmail.com>
X-Gm-Features: AclHuK8wXaZq1Hr_UP644JEalxKPoT-S2zkrDebm7nAdRRzHx52J1jQGBBEt_ME
Message-ID: <CAJZ5v0jP-z=zu=S_aBc3JpocRWJXcjzB8WnXu2UHd3WBf9cE3g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, viresh.kumar@linaro.org, 
	pierre.gondois@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, lenb@kernel.org, mario.limonciello@amd.com, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:59=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/6/26 16:08, Rafael J. Wysocki (Intel) wrote:
> > Hi Sumit,
> >
> > On Fri, Oct 30, 2026 at 6:28=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com>=
 wrote:
> >>
> >> This series adds support for the OSPM Nominal Performance register
> >> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
> >>
> >> Unlike the read-only Nominal Performance register, OSPM Nominal
> >> Performance is writable and lets OSPM request a nominal level below
> >> the platform-reported nominal. The platform treats performance above
> >> this level as boost and below as throttle.
> >>
> >>  - Patch 1: adds ACPI helpers to write the register and to check that
> >>    the platform supports it.
> >>
> >>  - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz. Th=
e
> >>    value is kept across CPU hotplug and suspend/resume. The register
> >>    cannot be read back, so a read returns the last value written.
> >>
> >>  - Patch 3: uses the OSPM nominal as the maximum frequency while boost
> >>    is off. Lowering the nominal creates a boost range on a platform
> >>    that has none, and boost can then be enabled.
> >>
> >> This series applies on top of v7 of:
> >>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
> >>   https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.=
com/
> >>
> >> v7 -> v8:
> >>  - Rebase on Christian's CPPC fixes series.
> >>  - Patch 1:
> >>    - use cpc_is_writable() from that series and drop cpc_reg_writable(=
).
> >>    - add the register to the list of controls the driver writes.
> >>    - take cpc_desc_lock in cppc_ospm_nominal_perf_supported(), so the
> >>      descriptor cannot be removed during the check.
> >>  - Patch 2:
> >>    - make ospm_nominal_freq read-write. A read returns the last value
> >>      written, or "<unset>" before the first write. (Christian, Mario)
> >>    - keep saving the values in the store handler, not at init(), so
> >>      the driver writes the register only after the OS sets it. (Pierre=
)
> >>  - Patch 3:
> >>    - document in the ABI file how the OSPM nominal sets cpuinfo_max_fr=
eq
> >>      and caps scaling_max_freq.
> >>
> >> Sumit Gupta (3):
> >>   ACPI: CPPC: Add ospm_nominal_perf support
> >>   cpufreq: CPPC: Add ospm_nominal_freq attribute
> >>   cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
> >>
> >>  .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
> >>  drivers/acpi/cppc_acpi.c                      |  44 +++++
> >>  drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++=
-
> >>  include/acpi/cppc_acpi.h                      |  10 +
> >>  4 files changed, 248 insertions(+), 10 deletions(-)
> >>
> >> v7: https://lore.kernel.org/lkml/20260807214837.863209-1-sumitg@nvidia=
.com/
> >> v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidi=
a.com/
> >> v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidi=
a.com/
> >> v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia=
.com/
> >> v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidi=
a.com/
> >> v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia=
.com/
> >> v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia=
.com/
> >>
> >> --
> >
> > This would be good to go except that it doesn't apply for me on top of =
7.4-rc1.
> >
> > Can you please rebase it and resend, with Christian's tags included?
> >
> > Thanks!
>
> It's based on the hotplug/resume series, I guess Sumit could post them as=
 a combined patchset

That would help.
