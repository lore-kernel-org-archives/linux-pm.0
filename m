Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD2246784
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152327; cv=none; b=ASx3XobtE3D+lzEnZysYvukhmOsWq5OcPqB8JasQ+lOA0GqEIH1958p+cm/MQkaNgSoYtiPPA200YbeflCGKJgDy7PcNBJT95mrSSt+kLbY2DjeJPKRuJzBIKuyXRqmY9bLrISeyXZ2Oq/1mFd2GLMs24aF9SoZh8qH4ifCsHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152327; c=relaxed/simple;
	bh=ZT4UWgyvQV2vX7ps7s0MEnfrc/x35JSD0OOc3762CgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ5DHrdFXIhQqpakCwGvL7d3Jf4loNO1bliFFOGmbnAYGLFdtXQGGuc5hXv/kdN3Aq77sO80t0sQ9NX8nFt/cuGeiRwhl2iswzzTVmrcjsmra1UF/OWDuSUq7iEBRtBXzMgbwqM+lvUHWXQRmcqvFVCsiTcKe7U65nNZxi4hE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/r1TTiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/r1TTiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C5A1F000C4
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792152325;
	bh=6Tp/it52Kj0+X1xNDwfnJi2g8xLLZd1hA0zwEBNXg0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A/r1TTiU2mQivtZ9P1k66LqOcQW4IHdtcv5FPO8OkqQU5j+RKUCsZmK7XwSlJppP3
	 WjPDTv4LLThSFV6mTtmvFivF6dXZruvVMHjHMBZgxGjD/AIkH/sKkuUXmk6AhyPT9n
	 IIDedwKSfCOCB9g7321qJMDL+tjr/9+PJHHqoCExKXorjBSsjRXbKtt7OvExs7xEgr
	 dqD6eYWQcmn3H1fYSzMhPg8lZettUihKZ6UkNWcwo5N8hUKpM8ydgr9skZDBD7x0kP
	 4w0Ak94bGFzt5mtqEB3cww73tKoPqmhU/ZQc2/gZPpq+LE2gAdHF+SG/b6WC8B5Q9k
	 7sZkw/t57pdxg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be42ae8eb1so1043831e87.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfoId0yzEiUeqyGImSlBmrZqGDnlTNIIBxsGQKNvgOU3zXjphMP5cGISjohHlR5A6ze2Dzjp/ONA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKC3ClN+nsFnDR7DKZ/H0elZWJKUYuth/B1VndEn2tF04y9gtGW
	cxIEqjBx40N7lA1WoqSPJKl3O295DyGIKscYavINNOQ6NmLrgytn5JIAgat84AGTz+bBOFHrVEC
	5n55nItDIQNEFO58jFZ/dK8x/rj6oPFs=
X-Received: by 2002:ac2:4f0f:0:b0:5be:4e1b:5f96 with SMTP id
 2adb3069b0e04-5be4e1b609dmr265012e87.58.1792152324261; Fri, 16 Oct 2026
 05:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <atHBZAGuEvFABQxV@vireshk-B250M-D3H>
In-Reply-To: <atHBZAGuEvFABQxV@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 16 Oct 2026 14:03:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hANP5fuhyOvW4tWXwvv=PVq2=34xzRgPeEjBH00UzRAQ@mail.gmail.com>
X-Gm-Features: AclHuK-nVbIQQpfPsV2RZEtJXTiAGQ7eT51biJIzFRZ6vEGv9eeyJ7TMF8z1oN0
Message-ID: <CAJZ5v0hANP5fuhyOvW4tWXwvv=PVq2=34xzRgPeEjBH00UzRAQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.4
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 8:17=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b9=
35:
>
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-7.4
>
> for you to fetch changes up to 81792daacfb41ca07b04bd3956ea9e672080cc98:
>
>   cpufreq: loongson3: Replace IOCSR read/write with MMIO ones (2026-10-16=
 11:12:33 +0530)
>
> ----------------------------------------------------------------
> CPUFreq arm updates for 7.4
>
> - Minor fixes to in various cpufreq drivers (Alexander Koskovich, Daniel
>   Schwierzeck, Frank Zhang, Haotian Zhang, Kathiravan Thirumoorthy,
>   Sumeet Pawnikar, and Xueqin Luo).
>
> - Fix wrong behaviors on multi-node servers in Loongson driver (Huacai Ch=
en).
>
> - Reject NULL from cpufreq_cpu_get() in the Rust code (Mehmet Koseoglu).
>
> - Add suspend OPP to mediatek driver and DT (Ryan Brue).
>
> ----------------------------------------------------------------
> Alexander Koskovich (1):
>       cpufreq: Add Milos to cpufreq-dt-platdev blocklist
>
> Daniel Schwierzeck (1):
>       cpufreq: airoha: fix probe failure with correct error check
>
> Frank Zhang (1):
>       rust: rcpufreq_dt: add module alias
>
> Haotian Zhang (1):
>       cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle =
parsing
>
> Huacai Chen (5):
>       cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
>       cpufreq: loongson3: Adjust the width of id and val in smc_message
>       cpufreq: loongson3: Replace per-package mutex with per-node
>       cpufreq: loongson3: Use global physical CPU ID in get/target callba=
cks
>       cpufreq: loongson3: Replace IOCSR read/write with MMIO ones
>
> Kathiravan Thirumoorthy (1):
>       cpufreq: qcom-nvmem: Add IPQ9650 support
>
> Mehmet Koseoglu (1):
>       rust: cpufreq: reject NULL from cpufreq_cpu_get()
>
> Ryan Brue (2):
>       cpufreq: mediatek: Enter system sleep at the suspend OPP
>       arm64: dts: mediatek: mt8173: Mark the lowest CPU OPPs for suspend
>
> Sumeet Pawnikar (1):
>       cpufreq: Use %pe to print error pointers symbolically
>
> Xueqin Luo (3):
>       cpufreq: sparc-us2e: fix frequency table index copy-paste error
>       cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
>       cpufreq: sti: avoid NULL dereference in dev_err()
>
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |  2 ++
>  drivers/cpufreq/Kconfig                  |  1 +
>  drivers/cpufreq/airoha-cpufreq.c         |  2 +-
>  drivers/cpufreq/bmips-cpufreq.c          |  4 ++--
>  drivers/cpufreq/cppc_cpufreq.c           |  4 ++--
>  drivers/cpufreq/cpufreq-dt-platdev.c     |  2 ++
>  drivers/cpufreq/loongson3_cpufreq.c      | 73 ++++++++++++++++++++++++++=
++++++++++++++++++++++-------------------------
>  drivers/cpufreq/mediatek-cpufreq.c       |  2 ++
>  drivers/cpufreq/qcom-cpufreq-hw.c        |  3 +++
>  drivers/cpufreq/qcom-cpufreq-nvmem.c     |  9 +++++++++
>  drivers/cpufreq/qoriq-cpufreq.c          |  3 +--
>  drivers/cpufreq/rcpufreq_dt.rs           |  1 +
>  drivers/cpufreq/s3c64xx-cpufreq.c        |  5 ++---
>  drivers/cpufreq/sparc-us2e-cpufreq.c     | 11 +++++------
>  drivers/cpufreq/sti-cpufreq.c            |  4 ++--
>  drivers/cpufreq/tegra194-cpufreq.c       |  2 +-
>  rust/kernel/cpufreq.rs                   | 22 ++++++++++++++++------
>  17 files changed, 100 insertions(+), 50 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
