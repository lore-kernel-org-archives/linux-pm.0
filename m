Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AE424645
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342135; cv=none; b=aqEKPTuYnI5mBtQgZMw2wuVPln+no5AnAXMlAW07ACuvkNIzaxUz/2B243SzIdqAZa3GRiM5GZwYq7/iFho4Xvo1TPKDo1pUqZB+qvv3QXeK/5qb5uYkyn5qIaSs3WcSqde7knSYFsRM7EpN282wyfp+Tj9Mrp1Jhz5EtunQbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342135; c=relaxed/simple;
	bh=lIEWERhnsxN7Qi/PGFRqv7lB50E4tkrkU8iURJ8DQXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/nPsYs/qw90HGG8QSK79UF0/YKvSXIf3u/v8OwnqyLgMbWn/YZD0qhwWXjuooLCDMa7tGcl3PPPeNjl6XoARoeUnKne9o5McXcsErUTQZLS8u6q5Z39EYd5j2R/id0XsPW+aLAVyM4LxzZIs2yjMRrFQt1UNbb9El0r5ECOhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEQHxqcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEQHxqcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9721F00A3A
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342134;
	bh=mLN6L5epv5+bkv1pR3WCrmAyrYPgwiGFNCNtQupoE8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BEQHxqcZeKsqbJYegky/VrG73eh348gpDPPOnrQ/Fypce4ssxGZPHgH4a2nKnPN1S
	 dwIlueQ39asofkOoHQ8VkZDhPF2It0XCVS+/vhzPbmIr/JmOZJ+s5Vdqeq5fZIdCt+
	 OMbE8B3xvybQcgjpxeL9GDkj/cOwKDNPyZEGvIM3HMca5yRc870pyFtT9EgME2mfh4
	 ZDUyUVdw+CjszKqL+Z2191hVa2TjpdOrFtCcdJnT3aq1HQkPuxiExc+n6LvqaL+Eli
	 Fns3QLU/ADrVUo/BKbSt1xsJPFMzwVdXHnJTqmdStkTgcCM5Z4cdGuxDPZjTZ7WZ7+
	 G8N/KENtw3kxw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2394324e87.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro6ef8IUIRbqwQt4Ct+Ljk4GgDf3MnCbtr/uR/+pia96xEEwLjjZ/NQJ2vKqQp09C9bvCUyq86d+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8/G0meDgmBRyi2HmEvIQt5IA3ce8bQxTHkTT4IC9lw5cfWB4
	AEKi7tfrMVXkIycXNsztR6BTA2Qg1/go5zHVXWZYyjYU8yjUPqoo3cn5yFk3yJ8m0+7z+2R7VSq
	ueEUolOtQw0hvkmdZslWRrJyNe0LhQAU=
X-Received: by 2002:a05:6512:1454:10b0:5ae:ab26:12ee with SMTP id
 2adb3069b0e04-5b007c0ba04mr47904e87.14.1783342132879; Mon, 06 Jul 2026
 05:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <20260629060526.3638272-3-jgross@suse.com>
In-Reply-To: <20260629060526.3638272-3-jgross@suse.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 14:48:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0grM1P6Cq7zPbcj=iGyhKs_2-jb1f9Xhc3bVRDWwvGY_A@mail.gmail.com>
X-Gm-Features: AVVi8CfiN1kYRpx43avoEL7_eDNpce-Y6Kakz-Pa8lEzsIFX_OpDQgHwZ5YvsvQ
Message-ID: <CAJZ5v0grM1P6Cq7zPbcj=iGyhKs_2-jb1f9Xhc3bVRDWwvGY_A@mail.gmail.com>
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:05=E2=80=AFAM Juergen Gross <jgross@suse.com> wro=
te:
>
> The 32-bit MSR interfaces rdmsr_safe() and wrmsr_safe() are planned to
> be removed. Use the related 64-bit variants instead.
>
> Drop a pointless initializer.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/powercap/intel_rapl_common.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 1006d183d508..3cee4ccb7997 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -752,17 +752,17 @@ EXPORT_SYMBOL_NS_GPL(rapl_default_check_unit, "INTE=
L_RAPL");
>
>  static void power_limit_irq_save_cpu(void *info)
>  {
> -       u32 l, h =3D 0;
> +       struct msr val;
>         struct rapl_package *rp =3D (struct rapl_package *)info;
>
>         /* save the state of PLN irq mask bit before disabling it */
> -       rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
> +       rdmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &val.q);
>         if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
> -               rp->power_limit_irq =3D l & PACKAGE_THERM_INT_PLN_ENABLE;
> +               rp->power_limit_irq =3D val.l & PACKAGE_THERM_INT_PLN_ENA=
BLE;
>                 rp->power_limit_irq |=3D PACKAGE_PLN_INT_SAVED;
>         }
> -       l &=3D ~PACKAGE_THERM_INT_PLN_ENABLE;
> -       wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +       val.l &=3D ~PACKAGE_THERM_INT_PLN_ENABLE;
> +       wrmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>  }
>
>  /* REVISIT:
> @@ -792,7 +792,7 @@ static void package_power_limit_irq_save(struct rapl_=
package *rp)
>   */
>  static void package_power_limit_irq_restore(struct rapl_package *rp)
>  {
> -       u32 l, h;
> +       struct msr val;
>
>         if (rp->lead_cpu < 0)
>                 return;
> @@ -804,14 +804,14 @@ static void package_power_limit_irq_restore(struct =
rapl_package *rp)
>         if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
>                 return;
>
> -       rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
> +       rdmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &val.q);
>
>         if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
> -               l |=3D PACKAGE_THERM_INT_PLN_ENABLE;
> +               val.l |=3D PACKAGE_THERM_INT_PLN_ENABLE;
>         else
> -               l &=3D ~PACKAGE_THERM_INT_PLN_ENABLE;
> +               val.l &=3D ~PACKAGE_THERM_INT_PLN_ENABLE;
>
> -       wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +       wrmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
>  }
>
>  void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode)
> --
> 2.54.0
>
>
