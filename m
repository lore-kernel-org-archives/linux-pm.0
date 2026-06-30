Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662171C84CB
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822619; cv=none; b=HQdQhvCEh82eMdeboqBE/O1W8s2De8SOp9Qsbl/05pMTqr3Eshk2cYtHQKsZgg5FY0x/QMhUih62SjRk9ojtl/QT2K5NdgxwNnWqbd8nQ9vzMduO/B5ntdgN/eoeO2yp+vs0VbOXxze3yGn7F4cCOXM/HWz5MAw2kZwg3y1m1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822619; c=relaxed/simple;
	bh=hfXqEewk93D+FUsbaofsNn0qomDopXQdfOzQlurkq7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdQ8l1JKxJ+TMf7p/ESW3ETiB/KEHHI6Pg20cqUzuUsSI8ghVaW3s7EOfIImLMlMS2KXbs80fTPpyLH1ROupdZgIkpW+PsOfKRuJWYXNCKngbBg8VwkwzoYy1FVzNIAxSOqUn39acrOhV0j4TUABsBCTSYUxOLKbI01WtZaVYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmg3siW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmg3siW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3479F1F01558
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782822618;
	bh=9hQC8Wii73PuGExlNBe2LNpXMvG2fDQ4U9dsJbeQgOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kmg3siW6U2d+O4kZoft69jjTTkb4RR7Zumef+GKFriWZO3jfnNeYrKTd33ob2TCql
	 UzZ+Roeo54yeRwf9qhKXAkwTC59Sgz9BSub5vudcKI3JQKmdIxt+j+jMNs/OcSwRCo
	 ND+xFW5Qg+B7yHKfewZHB3bpZ7ZPpfgLqK6pj8fWb9uuPLCansph8hgE/YXXEP46H0
	 ipQNAdvAXoBnECioyibd8iXfTqMLWpRxytnfRTEV23D9dip8yVFRz2d9Zrf+eEFRkg
	 g9y+FAw/YtGOaTjalMogjhkpUkqpd7/NrOZXOQD1SQhTsvWtrLX9H0z8N7N2lr5XnJ
	 V2ZNlrCgIls9w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b293079d1so999861fa.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 05:30:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrJB7huMekDwalGRpjf9Wury2p1+bcfDuc8WHwrZct9R1IpCqRxH7oUFxnu8ZP9sIKPyy0LX74NIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuczc9g13jhPgDdRv0I9+0XlcBxxFPyqD8ljAM0/0ona5H+da
	sh3uT28jkEfnqpeSi5LY8eb4W8zjHFufYWOUl9Y+Y60qj/uhBFo0Qn+UFp6TVgAdmV8i9sxsq7z
	jo+fmBVEQqcDd2aFqxP9A+PVMoBjjWbc=
X-Received: by 2002:a05:6512:1593:b0:5ae:aaba:ad28 with SMTP id
 2adb3069b0e04-5aebdb9b8b0mr1009924e87.18.1782822616554; Tue, 30 Jun 2026
 05:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <20260629060526.3638272-5-jgross@suse.com>
In-Reply-To: <20260629060526.3638272-5-jgross@suse.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 14:30:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
X-Gm-Features: AVVi8CcZ-j7ZEcr0YN-CV6kjjpEG6COZMEpi7vzFNh0Cr5CIdXZ0IOyveije_5E
Message-ID: <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:05=E2=80=AFAM Juergen Gross <jgross@suse.com> wro=
te:
>
> The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> wrmsr_safe() are planned to be removed. Use the related 64-bit variants
> instead.
>
> In processor_throttling.c drop needless initializers.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

LGTM overall.

Do you want me to pick it up or do you prefer to route it along with
the rest of the series?

> ---
>  arch/x86/kernel/acpi/sleep.c        | 20 ++++++++------------
>  drivers/acpi/processor_perflib.c    | 11 ++++++-----
>  drivers/acpi/processor_throttling.c | 14 ++------------
>  3 files changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 91fa262f0e30..8dfe98784bf9 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -61,6 +61,7 @@ int x86_acpi_suspend_lowlevel(void)
>  {
>         struct wakeup_header *header =3D
>                 (struct wakeup_header *) __va(real_mode_header->wakeup_he=
ader);
> +       struct msr val;
>
>         if (header->signature !=3D WAKEUP_HEADER_SIGNATURE) {
>                 printk(KERN_ERR "wakeup header does not match\n");
> @@ -82,13 +83,10 @@ int x86_acpi_suspend_lowlevel(void)
>          * with 2-MB L2 Cache and Intel=C2=AE Processor A100 and A110 on =
90
>          * nm process with 512-KB L2 Cache Specification Update".
>          */
> -       if (!rdmsr_safe(MSR_EFER,
> -                       &header->pmode_efer_low,
> -                       &header->pmode_efer_high) &&
> -           !wrmsr_safe(MSR_EFER,
> -                       header->pmode_efer_low,
> -                       header->pmode_efer_high))
> +       if (!rdmsrq_safe(MSR_EFER, &val.q) && !wrmsrq_safe(MSR_EFER, val.=
q))
>                 header->pmode_behavior |=3D (1 << WAKEUP_BEHAVIOR_RESTORE=
_EFER);
> +       header->pmode_efer_low =3D val.l;
> +       header->pmode_efer_high =3D val.h;
>  #endif /* !CONFIG_64BIT */
>
>         header->pmode_cr0 =3D read_cr0();
> @@ -96,14 +94,12 @@ int x86_acpi_suspend_lowlevel(void)
>                 header->pmode_cr4 =3D __read_cr4();
>                 header->pmode_behavior |=3D (1 << WAKEUP_BEHAVIOR_RESTORE=
_CR4);
>         }
> -       if (!rdmsr_safe(MSR_IA32_MISC_ENABLE,
> -                       &header->pmode_misc_en_low,
> -                       &header->pmode_misc_en_high) &&
> -           !wrmsr_safe(MSR_IA32_MISC_ENABLE,
> -                       header->pmode_misc_en_low,
> -                       header->pmode_misc_en_high))
> +       if (!rdmsrq_safe(MSR_IA32_MISC_ENABLE, &val.q) &&
> +           !wrmsrq_safe(MSR_IA32_MISC_ENABLE, val.q))
>                 header->pmode_behavior |=3D
>                         (1 << WAKEUP_BEHAVIOR_RESTORE_MISC_ENABLE);
> +       header->pmode_misc_en_low =3D val.l;
> +       header->pmode_misc_en_high =3D val.h;
>         header->realmode_flags =3D acpi_realmode_flags;
>         header->real_magic =3D 0x12345678;
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
> index fdf55c285c9a..9e25d6124efd 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -287,7 +287,8 @@ static int acpi_processor_get_performance_control(str=
uct acpi_processor *pr)
>   */
>  static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
>  {
> -       u32 hi, lo, fid, did;
> +       struct msr val;
> +       u32 fid, did;
>         int index =3D px->control & 0x00000007;
>
>         if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> @@ -295,16 +296,16 @@ static void amd_fixup_frequency(struct acpi_process=
or_px *px, int i)
>
>         if ((boot_cpu_data.x86 =3D=3D 0x10 && boot_cpu_data.x86_model < 1=
0) ||
>             boot_cpu_data.x86 =3D=3D 0x11) {
> -               rdmsr(MSR_AMD_PSTATE_DEF_BASE + index, lo, hi);
> +               rdmsrq(MSR_AMD_PSTATE_DEF_BASE + index, val.q);
>                 /*
>                  * MSR C001_0064+:
>                  * Bit 63: PstateEn. Read-write. If set, the P-state is v=
alid.
>                  */
> -               if (!(hi & BIT(31)))
> +               if (!(val.h & BIT(31)))
>                         return;
>
> -               fid =3D lo & 0x3f;
> -               did =3D (lo >> 6) & 7;
> +               fid =3D val.l & 0x3f;
> +               did =3D (val.l >> 6) & 7;
>                 if (boot_cpu_data.x86 =3D=3D 0x10)
>                         px->core_frequency =3D (100 * (fid + 0x10)) >> di=
d;
>                 else
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor=
_throttling.c
> index c0f92b93747d..d1605e0ab61f 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -698,20 +698,13 @@ static int acpi_processor_get_throttling_fadt(struc=
t acpi_processor *pr)
>  #ifdef CONFIG_X86
>  static int acpi_throttling_rdmsr(u64 *value)
>  {
> -       u64 msr_high, msr_low;
> -       u64 msr =3D 0;
>         int ret =3D -1;
>
>         if ((this_cpu_read(cpu_info.x86_vendor) !=3D X86_VENDOR_INTEL) ||
>                 !this_cpu_has(X86_FEATURE_ACPI)) {
>                 pr_err("HARDWARE addr space,NOT supported yet\n");
>         } else {
> -               msr_low =3D 0;
> -               msr_high =3D 0;
> -               rdmsr_safe(MSR_IA32_THERM_CONTROL,
> -                       (u32 *)&msr_low, (u32 *) &msr_high);
> -               msr =3D (msr_high << 32) | msr_low;
> -               *value =3D (u64) msr;
> +               rdmsrq_safe(MSR_IA32_THERM_CONTROL, value);
>                 ret =3D 0;
>         }
>         return ret;
> @@ -720,15 +713,12 @@ static int acpi_throttling_rdmsr(u64 *value)
>  static int acpi_throttling_wrmsr(u64 value)
>  {
>         int ret =3D -1;
> -       u64 msr;
>
>         if ((this_cpu_read(cpu_info.x86_vendor) !=3D X86_VENDOR_INTEL) ||
>                 !this_cpu_has(X86_FEATURE_ACPI)) {
>                 pr_err("HARDWARE addr space,NOT supported yet\n");
>         } else {
> -               msr =3D value;
> -               wrmsr_safe(MSR_IA32_THERM_CONTROL,
> -                       msr & 0xffffffff, msr >> 32);
> +               wrmsrq_safe(MSR_IA32_THERM_CONTROL, value);
>                 ret =3D 0;
>         }
>         return ret;
> --
> 2.54.0
>
>
