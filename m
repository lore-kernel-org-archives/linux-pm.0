Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E24E80CB
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354371; cv=none; b=e3Ht6J1oia0qTM81hkbISuiYJ7gEIRCF1nH811f5s8S2nW6tBlBJLstEx3Fkkcf/Up7JWG78cNlraVz23Pd4MLw2NGKJqnE+XSE4A0hry2GugdpLVy7ULjsCK87lI0IizYSNiGn/M0s0pRzg1/0LOmVMSDK8YOIY1IK4pDqwNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354371; c=relaxed/simple;
	bh=VXvBcHnM4+6Ep/7SdRUR1l/yH/QrZzmxp8xss1L1aTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJBOD7QT6L/bkfVtI1FuFYGrBB+z3Ho8GZNTVAWgSq7SZBjOCxjcf2jL8SIRMbUUC3jf0RXeIqcDbQs4FGOUgdK0AiG5KthfcK7B4g1ESt3Kwq47XXq+vhKXbGZLWogOWRIqHdprB3ANUYfZ3ndvcgsJuoNdONtbjbUuq1+uBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnBTjN/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnBTjN/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9901F0089D
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354351;
	bh=vkRCPkME5XSadj4AHmXSFOzDwTfbfBKlvl6TXo6HoyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XnBTjN/zQu9dwFIYGYkLdWvUer5UkJ9Gd9xVyftCkRhm+UYkuwGAtZB30hVT5A0Tx
	 nY28P9oEzeoaIymoQoAeJnMcVqhhUBoCDK871Vid9WlobUZDEA5ytIUV+XBSidIaPO
	 h173ny/1TgUyzj7B8C+oP7X3nScKNQiaiYqXZ8qkLJBWIAENyzVLwX0SlF2aoqw3/r
	 CSb3F/WJ+MO9wFuKBc7F1CizUg3Ty8l3X8a9tJDwlTzP9fSqZZ/0GeobA1xNx9HCbz
	 Uz5ZrJAM+rv0ypxTCxfAoN1rdX3DTFtxcuM3t4/6E+LffEDx+hDAdadpClDJxuqT8o
	 SRCUnGaY9aC+g==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49c068e85so7872851fa.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 09:39:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzCSOYRMid442aplInC7WFUABH8LToGHY5jxmoytF73UcUVKf8mbpl/xPLIP1XlCDEJYsyTa9Mksg==@vger.kernel.org
X-Gm-Message-State: AFuF++l0vR68+cD7r2QnuDmOmmveeHtzIx9BfvSivoS5cU6DEBvUTVau
	DH5RJzi3eriLoehp3oTE/6XT7+ZzR8VFqXCcONFi5BS7VJcGbAbDAbE+4IuD35HeE+igahRNQYy
	BKODHdZL8FLyq7BSnfuXhJG+idhBjvM8=
X-Received: by 2002:a2e:bc0d:0:b0:3a6:4c3d:976e with SMTP id
 38308e7fff4ca-3a64c3d98afmr7197051fa.18.1790354349866; Fri, 25 Sep 2026
 09:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807214837.863209-1-sumitg@nvidia.com>
In-Reply-To: <20260807214837.863209-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:37:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhQCGmC8CGKdK_dZT6mUMZv29rgt=GbAp2aC06mH2x2Q@mail.gmail.com>
X-Gm-Features: AclHuK8JgmU9wKlzoPxfpY5SooBBwN2lxAQ83ILHIy_wG82UGJTwLeYbKyosu6Q
Message-ID: <CAJZ5v0hhQCGmC8CGKdK_dZT6mUMZv29rgt=GbAp2aC06mH2x2Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, zhanjie9@hisilicon.com, 
	zhenglifeng1@huawei.com
Cc: viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com, 
	mario.limonciello@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:49=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
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
>  - Patch 1: adds cppc_set_ospm_nominal_perf() and
>    cppc_ospm_nominal_perf_supported().
>
>  - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz, and
>    tracks the register in the OSPM-set save/restore table. The register
>    cannot be read back, so the attribute is write-only.
>
>  - Patch 3: reflects the OSPM nominal in the cpufreq policy, so that
>    boost and the frequency limits stay consistent with the register.
>
> This series applies on top of the following series, which provides the
> save/restore table that patch 2 hooks into:
>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>   https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/
>
> v6[6] -> v7:
>  - Split patch 1 into an ACPI patch and a cpufreq patch.
>  - Patch 1:
>    - drop cppc_get_ospm_nominal_perf(), as the register is write-only.
>    - add cppc_ospm_nominal_perf_supported(), sharing the setter's
>      writable check via the new cpc_reg_writable() helper.
>  - Patch 2:
>    - make ospm_nominal_freq write-only, and track the requested value
>      in software instead of reading the register back.
>    - place the register before auto_sel in the save/restore table.
>  - Patch 3:
>    - rename *_reflect_nominal() to *_update_nominal_limits().
>    - do not fail the sysfs write when cppc_cpufreq_update_nominal_limits(=
)
>      fails to update the QoS limit.
>    - skip the limit update while boost is enabled.
>    - make cppc_cpufreq_effective_nominal() take the value from the
>      software-tracked state, so it returns it directly and cannot fail.
>    - init() checks cppc_ospm_nominal_perf_supported() directly, instead
>      of using cppc_cpufreq_effective_nominal().
>
> Sumit Gupta (3):
>   ACPI: CPPC: Add ospm_nominal_perf support
>   cpufreq: CPPC: Add ospm_nominal_freq attribute
>   cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
>
>  .../ABI/testing/sysfs-devices-system-cpu      |  24 ++++
>  drivers/acpi/cppc_acpi.c                      |  48 ++++++-
>  drivers/cpufreq/cppc_cpufreq.c                | 135 +++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  10 ++
>  4 files changed, 208 insertions(+), 9 deletions(-)
>
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

Dear CPPC cpufreq driver reviewers, please let me know what you think.

This is not going to go in without any comments from anyone, as far as
I'm concerned.

Thanks!
