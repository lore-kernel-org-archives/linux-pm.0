Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CD14AD20
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463269; cv=none; b=loZE1M/yxmKz477tcFq2AzmBBY9r1y+G/4U5NPe46s+hssooHJzDyqPjHDkqNW8pu/KWjQ1s9ff/10oILuqXfpfBX9f4lObw9z4ZoxA7H7b6Kybh2FCBWpWwqAL4q8XlsBBH8DY0Cy8Ybs5QLw3Dkbrjkmrz/hiq8e+H2BaDDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463269; c=relaxed/simple;
	bh=5xFHGBRbywrK3orjfvH32Ls1Bvk3SOOaLtPGOBIsfBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcsQpprGR3qEt/U5uUhtT6u+/rkFr3kZ/4dpXg8jXzEwTiErscQ5CaaAiQrgwV1usCYPlS9OWzGSKdOt+UoTtdLZe3ZBM57FkNqBwAMKBlamZ2tTL+xbXi+xSeK76AwFoHkTMMWRguUk9vqOhCel42A+K3iVXEWKXcLcKvnEbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzyHXuzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzyHXuzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D51D1F0155D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463261;
	bh=gaEtROh73Cill3kqhz1D6wXSSuz9oRfum/ypnPqlCug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BzyHXuzna6nP6mQrn9e8CyVzXj2asjT72WoG1A12bwH/eU5Qydwo5F5yBE+tcKRBO
	 b5kbPWZgkxODXFpJDEBBJl/Pq6w/d3NPz85ZMqlZ0vxGSyLvY1TlDO7EQexs2NTYEU
	 K2tY/Z+oUdh3UhBcGWftoP/LJxXvpmV4yKg2A9wiu5de3fE5EnORw4j4Vt70ic46tF
	 cKNN264iX9qEnroS6su8RKDKzN//2mIOILxcBz9LSrxYkA7J9Ex3L1BxiKtlFuaHBj
	 EfRB9ZWrgue+FweH37AjSCUD1+rTaAyiHz8nkSwGweyJnPmtFUudGCoMN/3WjknVvp
	 CpWFO29HprAQw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso5177705e87.3
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:21:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+bUHexJzqxYazIDjx4qsTb+a9pxVNgli7yzHCwRSateoWko1Mqbl2KTR7wWi1JLhBJw8byTTLd+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh43bCHYEmRuH7wTlkqZ+WD4/cChgEPUmXOxIoJtc9JlS0/343
	e2+q5zzKdojNPVevSGTnpYT2pUSLPhpQHB2vHT91fINX31Cq1G4KqwRj1Elb+F6gXcWN5e+ePuQ
	6VYlSxc1g/ED4iDV9rzLwfMZ6HfxkDiU=
X-Received: by 2002:a05:6512:1106:b0:5aa:1192:676f with SMTP id
 2adb3069b0e04-5aa32377c46mr1208427e87.20.1779463259631; Fri, 22 May 2026
 08:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417230652.305414-1-julianbraha@gmail.com> <c135b5b8-90d8-43ca-9017-96fcffd747c2@kernel.org>
In-Reply-To: <c135b5b8-90d8-43ca-9017-96fcffd747c2@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 17:20:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJB_TyHf-wtmJjzQcoXApTgtctSMdHPSxueZ_M4tmmQw@mail.gmail.com>
X-Gm-Features: AVHnY4Kh9MD2uNmHP4NcO5OEg9iqWkrWdMUmFJ06PbOx2Zo66Vcns0jYAY_aKZs
Message-ID: <CAJZ5v0jJB_TyHf-wtmJjzQcoXApTgtctSMdHPSxueZ_M4tmmQw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: clean up dead dependencies on X86 in Kconfig
To: Mario Limonciello <superm1@kernel.org>, Julian Braha <julianbraha@gmail.com>
Cc: viresh.kumar@linaro.org, gautham.shenoy@amd.com, Perry.Yuan@amd.com, 
	skhan@linuxfoundation.org, ray.huang@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 6:09=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 4/17/26 18:06, Julian Braha wrote:
> > The Kconfig in the parent directory already has an 'if X86'
> > condition wrapping the inclusion of this file, meaning that each of the
> > individual 'depends on' statements in this file is a duplicate dependen=
cy
> > (dead code).
> >
> > I propose leaving the outer 'if X86...endif' and removing
> > the individual 'depends on X86' statement from each option.
> >
> > This dead code was found by kconfirm, a static analysis tool for Kconfi=
g.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > ---
> >   drivers/cpufreq/Kconfig.x86 | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > index 027e6ea2e038..9afceb1143df 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -5,7 +5,6 @@
> >
> >   config X86_INTEL_PSTATE
> >       bool "Intel P state control"
> > -     depends on X86
> >       select ACPI_PROCESSOR if ACPI
> >       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> >       select CPU_FREQ_GOV_PERFORMANCE
> > @@ -36,7 +35,7 @@ config X86_PCC_CPUFREQ
> >
> >   config X86_AMD_PSTATE
> >       bool "AMD Processor P-State driver"
> > -     depends on X86 && ACPI
> > +     depends on ACPI
> >       select ACPI_PROCESSOR
> >       select ACPI_CPPC_LIB if X86_64
> >       select CPU_FREQ_GOV_SCHEDUTIL if SMP
> > @@ -84,7 +83,7 @@ config X86_AMD_PSTATE_DYNAMIC_EPP
> >
> >   config X86_AMD_PSTATE_UT
> >       tristate "selftest for AMD Processor P-State driver"
> > -     depends on X86 && ACPI_PROCESSOR
> > +     depends on ACPI_PROCESSOR
> >       depends on X86_AMD_PSTATE
> >       default n
> >       help

Applied as 7.2 material, thanks!
