Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69223806DD
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303447; cv=none; b=gotPQeou8wmLO9y2+VyjBAKFjy9nSzVNJsaH86M4j0oYa310uDaMIwnpmUjxrS/AVaAHPZzTh4NHnLWIRCPrlSt0GQpIHWJvLt1335nWB101YC8KJMhWKnW32R5xg2WdjvA5GfHAkDI4TDRJKENLE9QgOI0vKWdZJccEPUOF2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303447; c=relaxed/simple;
	bh=q/pf5xoZ9+hBDP52dCq4UCvWDArlFghqr3mYICxIyW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umP0s4h4bVtJKAhqNAIDQg3GXUrQT3uye5tSPBLF/2PGDl7azzPsfXcP1ECKZC97uT3HgEX3zmZr3CRyaguIZ3psSUTCKZyK62C2V0e0+zxVLWGajsD1THgpadh0gEmYi3VfSZvPbu/qx7ZPScZtLzmnH6vxmZVjZ5XW82rMwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG/EiYpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG/EiYpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A731F00ACF
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303445;
	bh=EHDC924WzuugWYq6WN9HR9C8ZjxUGwSnvZmU9V66qvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iG/EiYpTPcOfdPPxe4hlDTD6fm1DAJCywg61Kpp2znoX7A1wPRp2m0RASHvU62r3E
	 R8n29ze/lS1BiFhquO/dlxQid9g8EoPHUIYFlAoaUNHr8qS9us1+gkGwt3oRLVrxPJ
	 kJ9xlYlm7ekX5zFq7hS0yaWDoYMcM8XmxlL/x2mzvRJAXq6jabwFB2CFArgXcFJ7VE
	 LfUMHOeLVCNlWGm5A0LjPjX7vuvFUNQdENgzLqeQ5YZplppGevbSFgNl5rd8jDTBzy
	 5xQjiEl65MK6dlHZOUyzNZYG+gqj6ANmotqrKFycut+v0Xi0BrkZTwNPs84puQepTb
	 GwIZJM48xaF5g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec405a6ea5so219652366b.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 15:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/6jLQck9cBNPRTu0mLhirhptvG+COjA3rl71yLlkKO8nKTRieW/+0d3CGe3DcQ50A364Om8wwjtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynmfvx+vTf5k+yHM4lZYicJ5ixC/JgqrN+yT6bBzmW+5iWtp6m
	tqwn40pCupp/snT3vQWI3N252mjSgF3ZGpYuiM6MpF+ccYw1w4prT3n7OdKj178PbmGf+p8QBbY
	rtOo5qQU78bvwdptJ9J3Jq5ifiZi7nRc=
X-Received: by 2002:a17:907:6886:b0:bfa:544b:162 with SMTP id
 a640c23a62f3a-bfe29329c6fmr136055566b.36.1781303444633; Fri, 12 Jun 2026
 15:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com> <20260612215729.1532175-2-jmattson@google.com>
In-Reply-To: <20260612215729.1532175-2-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 12 Jun 2026 15:30:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMmmHXbrKKfZOEwggSRHrd8Am5+wko4riVM4Yz-12vbFg@mail.gmail.com>
X-Gm-Features: AVVi8CfYHIjPN805g7xsJy9ygMP1BghNREMJ_ZQlmvSvzJcVa0q-hMYd5BzgHPU
Message-ID: <CAO9r8zMmmHXbrKKfZOEwggSRHrd8Am5+wko4riVM4Yz-12vbFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
To: Jim Mattson <jmattson@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:57=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> Since msr_set_bit() and msr_clear_bit() perform a non-atomic update to an
> MSR, they can race with a write to the same MSR from interrupt context.
>
> On AMD CPUs, set_cpuid_faulting() uses these functions to modify
> MSR_K7_HWCR from process context, with preemption disabled but interrupts
> enabled. The acpi-cpufreq driver's boost_set_msr() modifies HWCR from
> interrupt context. If a crosscall IPI arrives between
> set_cpuid_faulting()'s read and write of MSR_K7_HWCR and toggles the Core
> Performance Boost disable bit (CPB_DIS), the IPI's update is lost.
>
> This race has been observed empirically on a Turin system running the
> acpi-cpufreq driver with a synthetic test. One thread repeatedly toggles
> /sys/devices/system/cpu/cpufreq/boost and verifies CPB_DIS on CPU0 after
> each write. A second thread pinned to CPU0 calls arch_prctl(ARCH_SET_CPUI=
D,
> <val>), with alternating <val>s of 0 and 1. CPB_DIS bit changes are
> sometimes lost.
>
> Introduce amd_update_hwcr() to perform an interrupt-safe
> read-modify-write of MSR_K7_HWCR, and use it in set_cpuid_faulting() to
> prevent races with HWCR updates in interrupt context. Note that when
> set_cpuid_faulting() is called from __switch_to_xtra(), interrupts are
> already disabled, so the race is only possible on the arch_prctl()
> paths.
>
> Reported-by: Sashiko (gemini/gemini-3.1-pro-preview)
> Closes: https://lore.kernel.org/all/20260609211611.466231-1-jmattson@goog=
le.com/
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Fixes: 65f55a301766 ("x86/CPU/AMD: Add CPUID faulting support")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/include/asm/processor.h |  2 ++
>  arch/x86/kernel/cpu/amd.c        | 42 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/process.c        |  4 +--
>  4 files changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 86554de9a3f5..18c4be75e927 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -899,6 +899,7 @@
>  #define MSR_K7_HWCR_IRPERF_EN_BIT      30
>  #define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT=
)
>  #define MSR_K7_HWCR_CPUID_USER_DIS_BIT 35
> +#define MSR_K7_HWCR_CPUID_USER_DIS     BIT_ULL(MSR_K7_HWCR_CPUID_USER_DI=
S_BIT)
>  #define MSR_K7_FID_VID_CTL             0xc0010041
>  #define MSR_K7_FID_VID_STATUS          0xc0010042
>  #define MSR_K7_HWCR_CPB_DIS_BIT                25
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 67dd932305db..d2ad7ac24e02 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -716,9 +716,11 @@ static __always_inline void amd_clear_divider(void)
>  }
>
>  extern void amd_check_microcode(void);
> +extern int amd_update_hwcr(u64 clear, u64 set);
>  #else
>  static inline void amd_clear_divider(void)             { }
>  static inline void amd_check_microcode(void)           { }
> +static inline int amd_update_hwcr(u64 clear, u64 set) { return -ENODEV; =
}
>  #endif
>
>  extern unsigned long arch_align_stack(unsigned long sp);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 31f01e9c7114..abb6f755be98 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1319,6 +1319,48 @@ void amd_check_microcode(void)
>                 on_each_cpu(zenbleed_check_cpu, NULL, 1);
>  }
>
> +/**
> + * amd_update_hwcr - Update MSR_K7_HWCR on the executing CPU
> + * @clear: Bits to clear
> + * @set: Bits to set
> + *
> + * MSR_K7_HWCR is written from both process context (e.g. CPUID faulting
> + * updates via arch_prctl(ARCH_SET_CPUID)) and interrupt context (e.g.
> + * Core Performance Boost updates IPI'd by the acpi-cpufreq driver), so
> + * a read-modify-write of the MSR must be performed with interrupts
> + * disabled to avoid losing an update made by an intervening interrupt.
> + * All runtime (non-initialization) updates of MSR_K7_HWCR should go
> + * through this helper.
> + *
> + * Bits in @set take precedence over bits in @clear.
> + *
> + * Context: Any context except NMI. Disabling interrupts does not
> + *          serialize against an NMI, so NMI handlers must not write
> + *          MSR_K7_HWCR.

Might be more useful to WARN if in_nmi()?

> + *
> + * Return: 0 on success, negative error code if an MSR access faults.
> + */
> +int amd_update_hwcr(u64 clear, u64 set)
> +{
> +       unsigned long flags;
> +       u64 oldval, newval;
> +       int ret;
> +
> +       local_irq_save(flags);
> +       ret =3D rdmsrq_safe(MSR_K7_HWCR, &oldval);
> +       if (ret)
> +               goto out;
> +
> +       newval =3D (oldval & ~clear) | set;
> +
> +       if (newval !=3D oldval)
> +               ret =3D wrmsrq_safe(MSR_K7_HWCR, newval);

Can we reuse msr_set_bit() and msr_clear_bit() here?

> +out:
> +       local_irq_restore(flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(amd_update_hwcr);
> +
>  static const char * const s5_reset_reason_txt[] =3D {
>         [0]  =3D "thermal pin BP_THERMTRIP_L was tripped",
>         [1]  =3D "power button was pressed for 4 seconds",
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 4c718f8adc59..08ef205f6b7f 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -355,9 +355,9 @@ static void set_cpuid_faulting(bool on)
>                 wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
>         } else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD) {
>                 if (on)
> -                       msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_D=
IS_BIT);
> +                       amd_update_hwcr(0, MSR_K7_HWCR_CPUID_USER_DIS);
>                 else
> -                       msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER=
_DIS_BIT);
> +                       amd_update_hwcr(MSR_K7_HWCR_CPUID_USER_DIS, 0);
>         }
>  }
>
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
