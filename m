Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0C3845D5
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567487; cv=none; b=GOoFcGBCa9PbFpBGBO1uW5Mfrb1/kwRJPawkquwxypBdfZwov3sftPet8TiuIf3+sigDmFak/cfrwr7xAjk/eA4uD6w6nuiwXHlZ464XRahpTSC0YdLfZg85Y0GqKnfnhvg+tBGdv2NqsxVM9zoVSwdV4i9WvrX7FWNQvAccP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567487; c=relaxed/simple;
	bh=97qht0VSPclh2jfvCYKsb9HY6Jg+kX97joSQ/dpqcrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVwijEb+0f1ABjo+33NrsddndSXtnslavpkQXmTa+9vYfdFuXQ3QMU8aOR1URhYLOH4K4hymDH+Gfw5cyCQfIHKWQZxvOw/Gu+r9s9V+sCVNb8Y4LKIa5TcZt6M82LQp+tn+SZNQl/V9JYcsG0QvSuVf3epj6UqIKCEfnG5qBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy0bz81f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy0bz81f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ADA1F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786567485;
	bh=a2HwOrWbYV21vmm25vN7HnI+FZl++WM5Q7n6oQOswLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Uy0bz81fjPJ9vcn2DmayoQIUCRzL/QYhwnSdHKsoXQ5fwdOBuSGoWVrKGGZoLIexS
	 Tfaw/V7p0uvOgnCh7rDJEy+vieSxAdyHyKDP9wtRK+lAp+chKxw+8l5gdDCsZps/zh
	 rDk8Zo39T4RGNUYWFEuukEfoXi3iXSCnHt/W56mC0JUrrW3FU6fvhExQ0fg8nU+PVR
	 LoaDqPFya9A068HKfmLZaMSABDGzAablUESmPh2RcYzG8bNvpjXsoo4e+MXKEuju0h
	 GhZ4XqJxGnZzXWV9bm62UZivhX8KmweIJBnOoL/mf3mhBxoBKQmJZhHHNG/GdNEhXs
	 HLHs4teGhbW+g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39f20d19895so516851fa.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 13:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrIt+6BcGDLffybQ460OROcAlWlJuZM9OgvXjYVptN+J6R7pwMz14/GmSgaHh/WqnXyRq961HSlQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKt9Q4lkAPy/J3olbPkzAH56YtabtDNJFisEcjL/6Jj8bkelUs
	F7tz7LwA98e0udtZg/Ej6bR3/nvAXr0Q12Yf3pJOnyJ3gYViiFFiWiJf59hqGxHRkIWlqs6Vwbd
	D7YKuFn18/JfwiZ3n1ZTivP/XdTht5/I=
X-Received: by 2002:a2e:bc07:0:b0:3a1:1882:7406 with SMTP id
 38308e7fff4ca-3a11a680595mr1382691fa.10.1786567484298; Wed, 12 Aug 2026
 13:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202608121937.J7M1vGVB-lkp@intel.com>
In-Reply-To: <202608121937.J7M1vGVB-lkp@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 22:44:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gaAfZFuwze2rU4gACoOE2jjF6dfAOELC2vqBCwV2bhJA@mail.gmail.com>
X-Gm-Features: AUfX_mw9nJN8CrL84lPdWL0yx9XAlkSOSroFbZMr9MseA62Cpw25_GGw3k9RjJA
Message-ID: <CAJZ5v0gaAfZFuwze2rU4gACoOE2jjF6dfAOELC2vqBCwV2bhJA@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS fc02d96a639b5b4ca32bd249e971e5d0aafeb874
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:24=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge
> branch HEAD: fc02d96a639b5b4ca32bd249e971e5d0aafeb874  Merge branch 'test=
/acpi-driver' into testing
>
> elapsed time: 1515m
>
> configs tested: 98
> configs skipped: 2
>
> The following configs have been built successfully.
> More configs may be tested in the coming days.
>
> tested configs:
> alpha                            allnoconfig    gcc-16.1.0
> alpha                           allyesconfig    gcc-16.1.0
> alpha                              defconfig    gcc-16.1.0
> arc                             allmodconfig    gcc-16.1.0
> arc                             allyesconfig    gcc-16.1.0
> arc                  randconfig-001-20260812    gcc-12.5.0
> arc                  randconfig-002-20260812    gcc-10.5.0
> arm                  randconfig-001-20260812    clang-19
> arm                  randconfig-002-20260812    gcc-12.5.0
> arm                  randconfig-003-20260812    gcc-14.3.0
> arm                  randconfig-004-20260812    clang-24
> arm64                randconfig-001-20260812    clang-24
> arm64                randconfig-002-20260812    clang-20
> arm64                randconfig-003-20260812    clang-17
> arm64                randconfig-004-20260812    clang-24
> csky                            allmodconfig    gcc-16.1.0
> csky                 randconfig-001-20260812    gcc-10.5.0
> csky                 randconfig-002-20260812    gcc-16.1.0
> hexagon              randconfig-001-20260812    clang-24
> hexagon              randconfig-002-20260812    clang-17
> i386                            allmodconfig    gcc-14
> i386       buildonly-randconfig-001-20260812    clang-22
> i386       buildonly-randconfig-002-20260812    gcc-14
> i386       buildonly-randconfig-003-20260812    clang-22
> i386       buildonly-randconfig-004-20260812    clang-22
> i386       buildonly-randconfig-005-20260812    gcc-14
> i386       buildonly-randconfig-006-20260812    clang-22
> i386                          randconfig-001    clang-22
> i386                 randconfig-001-20260812    gcc-14
> i386                 randconfig-002-20260812    gcc-14
> i386                 randconfig-003-20260812    clang-22
> i386                 randconfig-004-20260812    gcc-14
> i386                 randconfig-005-20260812    gcc-14
> i386                 randconfig-006-20260812    clang-22
> i386                 randconfig-007-20260812    gcc-14
> i386                 randconfig-011-20260812    gcc-14
> i386                 randconfig-012-20260812    gcc-12
> i386                 randconfig-013-20260812    clang-22
> i386                 randconfig-014-20260812    clang-22
> i386                 randconfig-015-20260812    clang-22
> i386                 randconfig-016-20260812    clang-22
> i386                 randconfig-017-20260812    clang-22
> loongarch                          defconfig    clang-24
> loongarch            randconfig-001-20260812    clang-24
> loongarch            randconfig-002-20260812    clang-24
> nios2                           allmodconfig    gcc-11.5.0
> nios2                            allnoconfig    gcc-11.5.0
> nios2                randconfig-001-20260812    gcc-11.5.0
> nios2                randconfig-002-20260812    gcc-10.5.0
> openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
> parisc                          allmodconfig    gcc-16.1.0
> parisc                          allyesconfig    gcc-16.1.0
> parisc                             defconfig    gcc-16.1.0
> parisc                        randconfig-001    gcc-8.5.0
> parisc               randconfig-001-20260812    gcc-8.5.0
> parisc               randconfig-002-20260812    gcc-8.5.0
> powerpc              randconfig-001-20260812    gcc-14.3.0
> powerpc              randconfig-002-20260812    clang-24
> powerpc64            randconfig-001-20260812    clang-17
> powerpc64            randconfig-002-20260812    clang-24
> riscv                randconfig-001-20260812    clang-20
> riscv                randconfig-002-20260812    gcc-8.5.0
> s390                 randconfig-001-20260812    gcc-9.5.0
> s390                 randconfig-002-20260812    clang-24
> sh                                 defconfig    gcc-16.1.0
> sh                   randconfig-001-20260812    gcc-14.3.0
> sh                   randconfig-002-20260812    gcc-12.5.0
> sparc                randconfig-001-20260812    gcc-15.2.0
> sparc                randconfig-002-20260812    gcc-13.4.0
> sparc64              randconfig-001-20260812    gcc-15.2.0
> sparc64              randconfig-002-20260812    gcc-13.4.0
> um                   randconfig-001-20260812    clang-17
> um                   randconfig-002-20260812    clang-20
> x86_64     buildonly-randconfig-001-20260812    gcc-14
> x86_64     buildonly-randconfig-002-20260812    gcc-14
> x86_64     buildonly-randconfig-003-20260812    clang-22
> x86_64     buildonly-randconfig-004-20260812    gcc-14
> x86_64     buildonly-randconfig-005-20260812    gcc-14
> x86_64     buildonly-randconfig-006-20260812    gcc-14
> x86_64               randconfig-001-20260812    clang-22
> x86_64               randconfig-002-20260812    gcc-14
> x86_64               randconfig-003-20260812    gcc-14
> x86_64               randconfig-004-20260812    clang-22
> x86_64               randconfig-005-20260812    clang-22
> x86_64               randconfig-006-20260812    clang-22
> x86_64               randconfig-011-20260812    clang-22
> x86_64               randconfig-012-20260812    clang-22
> x86_64               randconfig-013-20260812    clang-22
> x86_64               randconfig-014-20260812    gcc-14
> x86_64               randconfig-015-20260812    clang-22
> x86_64               randconfig-016-20260812    clang-22
> x86_64               randconfig-071-20260811    clang-22
> x86_64               randconfig-072-20260811    gcc-14
> x86_64               randconfig-073-20260811    gcc-14
> x86_64               randconfig-074-20260811    gcc-14
> x86_64               randconfig-075-20260811    clang-22
> x86_64               randconfig-076-20260811    gcc-14

I'm wondering why we don't do "x86_64 allmodconfig" and so we don't
catch failures like this one in linux-next:

https://lore.kernel.org/lkml/annVRNepH48qe6b8@sirena.org.uk/

Honestly, doing "i386 allmodconfig" without doing "x86_64
allmodconfig" is somewhat couter-intuitive IMV.

> xtensa               randconfig-001-20260812    gcc-15.2.0
