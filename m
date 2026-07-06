Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888E4302E9
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342047; cv=none; b=l4WdpMQMkpm2oN/X30MOgvpIOvS76IpbdeJIWbepPiUKRqa9L1wUcKnwgU/4c/vxNDoq+J2BWCmSk35G4GRMQ0Igce8gxLfcnyyR3fz2ASQKtXwqFKbkv2fiCj9hrC34H3B8RHiVImRqpO8VSSFvQbtNBB+tqykQDkX8Sd1fUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342047; c=relaxed/simple;
	bh=LXnHR24uH2Dltrfy2vdk+2eFnsYFGJVRl5ffypnHPDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfwpMzcW3VvudrqHY4g+2FQggZ2YrC11unFGzaFkkgjPFlQC661faJ7t9SayJFtzLsLCrtUyYImzSlqleyDTljp7SiNAgrloZ1b1Xpq3rGbOmolBL7jE+UftoFkb6VYdpL8LxYAWYlTQJfHJZGZ3r2mfxQ73dEuOdy4wcAsFFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH8NKAun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH8NKAun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741101F00A3F
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342045;
	bh=1l1DKR9QY6wo8X1yRm75gBW48ClxqHqsDRBZIZVqnEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TH8NKAunGy8LV40VUtqpscqUpViP0vEtL5l+SZJ0IEyfFeAeaShQ0KjpX9fsWXw9T
	 DbgFw6V98cgHV63dk3gvpSDw1iX4gWC8xnd/ujL1uRFOOKV+XIT5+T7+wdK/BGwqdZ
	 339jpKtTyfAfItZ+VRt1dE948PMWbBOlSB/PNH0hWJLpu4Ip1K73smjO1LLrsj8SMi
	 yORDXynaVwoZb/DMqEWJs48xIO2mcsuGTVK0q0HRLNlSAubIUQcm13nZ6pN2HFPWt+
	 hH6uK9HZfUW0D9MEYoF0EvC8lmIC+pSxWPF9fJPGJFmc6hLi24PIklHD5MGazrfKx9
	 BrCcICo9ak0WA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb2b17167so3463259e87.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:47:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqifhJTcoP/eMWaXKfbHrLYU2q/b5qZSAraqO0HrQnD45tesyyukShwQnGDBlpy9y4sOn02rrcjKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUmm4vJVrByie/8ztLVWOesWuqnk4uUFHEl0gTbFdTPy4HHYp
	l6lPIxsFbhi8B0rE09TpxxoM4drHPb5Qu8dWkzZPkiSDkW/wYs43j4S4v1lYxE/+LKvAxZLV6ho
	88SWGqAaT3sKneOTLU3r01V+69SMduL8=
X-Received: by 2002:a05:6512:2c04:b0:5ae:c542:3416 with SMTP id
 2adb3069b0e04-5b0077af742mr135186e87.0.1783342043796; Mon, 06 Jul 2026
 05:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629060526.3638272-2-jgross@suse.com> <20260703112232.1762925-1-jgross@suse.com>
In-Reply-To: <20260703112232.1762925-1-jgross@suse.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 14:47:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3f4ANJYK908G2-nyAzZ=5vRrniwTzpQPny4sDXHa8YA@mail.gmail.com>
X-Gm-Features: AVVi8Cc2uMNEpKDcCKK5DER6eZC9ZQPm3dRdv2Kvy845rK_omEpc6YNGJhQHgHM
Message-ID: <CAJZ5v0h3f4ANJYK908G2-nyAzZ=5vRrniwTzpQPny4sDXHa8YA@mail.gmail.com>
Subject: Re: [PATCH v2 01/32] thermal/intel: Stop using 32-bit MSR interfaces
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 1:22=E2=80=AFPM Juergen Gross <jgross@suse.com> wrot=
e:
>
> The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> wrmsr_safe() are planned to be removed. Use the related 64-bit variants
> instead.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> V2:
> - make bit modifications more readable (Ingo Molnar)
> ---
>  drivers/thermal/intel/intel_tcc.c            | 10 +--
>  drivers/thermal/intel/therm_throt.c          | 76 ++++++++++----------
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 32 ++++-----
>  3 files changed, 56 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/in=
tel_tcc.c
> index 59f70bb5ffa5..d1fa3c63d554 100644
> --- a/drivers/thermal/intel/intel_tcc.c
> +++ b/drivers/thermal/intel/intel_tcc.c
> @@ -185,7 +185,7 @@ int intel_tcc_get_tjmax(int cpu)
>         int val, err;
>
>         if (cpu < 0)
> -               err =3D rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &msrval.l=
, &msrval.h);
> +               err =3D rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &msrval.=
q);
>         else
>                 err =3D rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARG=
ET, &msrval.q);
>         if (err)
> @@ -212,7 +212,7 @@ int intel_tcc_get_offset(int cpu)
>         int err;
>
>         if (cpu < 0)
> -               err =3D rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &=
val.h);
> +               err =3D rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &val.q);
>         else
>                 err =3D rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARG=
ET, &val.q);
>         if (err)
> @@ -245,7 +245,7 @@ int intel_tcc_set_offset(int cpu, int offset)
>                 return -EINVAL;
>
>         if (cpu < 0)
> -               err =3D rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &=
val.h);
> +               err =3D rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &val.q);
>         else
>                 err =3D rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARG=
ET, &val.q);
>         if (err)
> @@ -259,7 +259,7 @@ int intel_tcc_set_offset(int cpu, int offset)
>         val.l |=3D offset << 24;
>
>         if (cpu < 0)
> -               return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, val.l, val=
.h);
> +               return wrmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, val.q);
>         else
>                 return wrmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGE=
T, val.q);
>  }
> @@ -288,7 +288,7 @@ int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
>                 return tjmax;
>
>         if (cpu < 0)
> -               err =3D rdmsr_safe(msr, &val.l, &val.h);
> +               err =3D rdmsrq_safe(msr, &val.q);
>         else
>                 err =3D rdmsrq_safe_on_cpu(cpu, msr, &val.q);
>         if (err)
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/=
therm_throt.c
> index 45a8ef4a608b..1dfd4491c9f6 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -722,8 +722,8 @@ void __init therm_lvt_init(void)
>  void intel_init_thermal(struct cpuinfo_x86 *c)
>  {
>         unsigned int cpu =3D smp_processor_id();
> +       struct msr val;
>         int tm2 =3D 0;
> -       u32 l, h;
>
>         if (!intel_thermal_supported(c))
>                 return;
> @@ -733,9 +733,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
>          * be some SMM goo which handles it, so we can't even put a handl=
er
>          * since it might be delivered via SMI already:
>          */
> -       rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> +       rdmsrq(MSR_IA32_MISC_ENABLE, val.q);
>
> -       h =3D lvtthmr_init;
> +       val.h =3D lvtthmr_init;
>         /*
>          * The initial value of thermal LVT entries on all APs always rea=
ds
>          * 0x10000 because APs are woken up by BSP issuing INIT-SIPI-SIPI
> @@ -746,11 +746,11 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
>          * BIOS has programmed on AP based on BSP's info we saved since B=
IOS
>          * is always setting the same value for all threads/cores.
>          */
> -       if ((h & APIC_DM_FIXED_MASK) !=3D APIC_DM_FIXED)
> +       if ((val.h & APIC_DM_FIXED_MASK) !=3D APIC_DM_FIXED)
>                 apic_write(APIC_LVTTHMR, lvtthmr_init);
>
>
> -       if ((l & MSR_IA32_MISC_ENABLE_TM1) && (h & APIC_DM_SMI)) {
> +       if ((val.l & MSR_IA32_MISC_ENABLE_TM1) && (val.h & APIC_DM_SMI)) =
{
>                 if (system_state =3D=3D SYSTEM_BOOTING)
>                         pr_debug("CPU%d: Thermal monitoring handled by SM=
I\n", cpu);
>                 return;
> @@ -759,59 +759,55 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
>         /* early Pentium M models use different method for enabling TM2 *=
/
>         if (cpu_has(c, X86_FEATURE_TM2)) {
>                 if (c->x86 =3D=3D 6 && (c->x86_model =3D=3D 9 || c->x86_m=
odel =3D=3D 13)) {
> -                       rdmsr(MSR_THERM2_CTL, l, h);
> -                       if (l & MSR_THERM2_CTL_TM_SELECT)
> +                       rdmsrq(MSR_THERM2_CTL, val.q);
> +                       if (val.l & MSR_THERM2_CTL_TM_SELECT)
>                                 tm2 =3D 1;
> -               } else if (l & MSR_IA32_MISC_ENABLE_TM2)
> +               } else if (val.l & MSR_IA32_MISC_ENABLE_TM2)
>                         tm2 =3D 1;
>         }
>
>         /* We'll mask the thermal vector in the lapic till we're ready: *=
/
> -       h =3D THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
> -       apic_write(APIC_LVTTHMR, h);
> +       val.h =3D THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
> +       apic_write(APIC_LVTTHMR, val.h);
>
>         thermal_intr_init_core_clear_mask();
>         thermal_intr_init_pkg_clear_mask();
>
> -       rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
> -       if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
> -               wrmsr(MSR_IA32_THERM_INTERRUPT,
> -                       (l | (THERM_INT_LOW_ENABLE
> -                       | THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE=
, h);
> -       else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
> -               wrmsr(MSR_IA32_THERM_INTERRUPT,
> -                       l | (THERM_INT_LOW_ENABLE
> -                       | THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), =
h);
> +       rdmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
> +       if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable) {
> +               val.l |=3D THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
> +               val.l &=3D ~THERM_INT_PLN_ENABLE;
> +       } else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
> +               val.l |=3D THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE |
> +                        THERM_INT_PLN_ENABLE;
>         else
> -               wrmsr(MSR_IA32_THERM_INTERRUPT,
> -                     l | (THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE),=
 h);
> +               val.l |=3D THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
> +       wrmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
>
>         if (cpu_has(c, X86_FEATURE_PTS)) {
> -               rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> -               if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
> -                       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -                               (l | (PACKAGE_THERM_INT_LOW_ENABLE
> -                               | PACKAGE_THERM_INT_HIGH_ENABLE))
> -                               & ~PACKAGE_THERM_INT_PLN_ENABLE, h);
> -               else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
> -                       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -                               l | (PACKAGE_THERM_INT_LOW_ENABLE
> -                               | PACKAGE_THERM_INT_HIGH_ENABLE
> -                               | PACKAGE_THERM_INT_PLN_ENABLE), h);
> +               rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
> +               if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable) {
> +                       val.l |=3D PACKAGE_THERM_INT_LOW_ENABLE |
> +                                PACKAGE_THERM_INT_HIGH_ENABLE;
> +                       val.l &=3D ~PACKAGE_THERM_INT_PLN_ENABLE;
> +               } else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
> +                       val.l |=3D PACKAGE_THERM_INT_LOW_ENABLE |
> +                                PACKAGE_THERM_INT_HIGH_ENABLE |
> +                                PACKAGE_THERM_INT_PLN_ENABLE;
>                 else
> -                       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -                             l | (PACKAGE_THERM_INT_LOW_ENABLE
> -                               | PACKAGE_THERM_INT_HIGH_ENABLE), h);
> +                       val.l |=3D PACKAGE_THERM_INT_LOW_ENABLE |
> +                                PACKAGE_THERM_INT_HIGH_ENABLE;
> +               wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>
>                 if (cpu_has(c, X86_FEATURE_HFI)) {
> -                       rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> -                       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -                             l | PACKAGE_THERM_INT_HFI_ENABLE, h);
> +                       rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
> +                       wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +                              val.q | PACKAGE_THERM_INT_HFI_ENABLE);
>                 }
>         }
>
> -       rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> -       wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
> +       rdmsrq(MSR_IA32_MISC_ENABLE, val.q);
> +       wrmsrq(MSR_IA32_MISC_ENABLE, val.q | MSR_IA32_MISC_ENABLE_TM1);
>
>         pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
>                       tm2 ? "TM2" : "TM1");
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/therm=
al/intel/x86_pkg_temp_thermal.c
> index 688e04c63761..43fd5bdf1d8d 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -51,8 +51,7 @@ MODULE_PARM_DESC(notify_delay_ms,
>  struct zone_device {
>         int                             cpu;
>         bool                            work_scheduled;
> -       u32                             msr_pkg_therm_low;
> -       u32                             msr_pkg_therm_high;
> +       u64                             msr_pkg_therm;
>         struct delayed_work             work;
>         struct thermal_zone_device      *tzone;
>         struct cpumask                  cpumask;
> @@ -186,28 +185,28 @@ static bool pkg_thermal_rate_control(void)
>  static inline void enable_pkg_thres_interrupt(void)
>  {
>         u8 thres_0, thres_1;
> -       u32 l, h;
> +       struct msr val;
>
> -       rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +       rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>         /* only enable/disable if it had valid threshold value */
> -       thres_0 =3D (l & THERM_MASK_THRESHOLD0) >> THERM_SHIFT_THRESHOLD0=
;
> -       thres_1 =3D (l & THERM_MASK_THRESHOLD1) >> THERM_SHIFT_THRESHOLD1=
;
> +       thres_0 =3D (val.l & THERM_MASK_THRESHOLD0) >> THERM_SHIFT_THRESH=
OLD0;
> +       thres_1 =3D (val.l & THERM_MASK_THRESHOLD1) >> THERM_SHIFT_THRESH=
OLD1;
>         if (thres_0)
> -               l |=3D THERM_INT_THRESHOLD0_ENABLE;
> +               val.l |=3D THERM_INT_THRESHOLD0_ENABLE;
>         if (thres_1)
> -               l |=3D THERM_INT_THRESHOLD1_ENABLE;
> -       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +               val.l |=3D THERM_INT_THRESHOLD1_ENABLE;
> +       wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>  }
>
>  /* Disable threshold interrupt on local package/cpu */
>  static inline void disable_pkg_thres_interrupt(void)
>  {
> -       u32 l, h;
> +       struct msr val;
>
> -       rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +       rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>
> -       l &=3D ~(THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABL=
E);
> -       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +       val.l &=3D ~(THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_E=
NABLE);
> +       wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>  }
>
>  static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
> @@ -357,8 +356,7 @@ static int pkg_temp_thermal_device_add(unsigned int c=
pu)
>                 goto out_unregister_tz;
>
>         /* Store MSR value for package thermal interrupt, to restore at e=
xit */
> -       rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_lo=
w,
> -             zonedev->msr_pkg_therm_high);
> +       rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm);
>
>         cpumask_set_cpu(cpu, &zonedev->cpumask);
>         raw_spin_lock_irq(&pkg_temp_lock);
> @@ -426,8 +424,8 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
>         if (lastcpu) {
>                 zones[topology_logical_die_id(cpu)] =3D NULL;
>                 /* After this point nothing touches the MSR anymore. */
> -               wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> -                     zonedev->msr_pkg_therm_low, zonedev->msr_pkg_therm_=
high);
> +               wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +                      zonedev->msr_pkg_therm);
>         }
>
>         /*
> --
> 2.54.0
>
