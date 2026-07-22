Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A18367F58
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732266; cv=none; b=M5f8i8mUW5gv139ooNoqqooQyyaG3qzHvD96Acp6Llk0iPlc4I6bMaM/rxhqDKot2cXpFn4SS4HQ5yuvZJ1uga+AwitMVbZf7qFQrlVM8+HXNJZ9rpuI7Sx9di0v8nNWaLOh4cp27wugIE41WW09/8ureemlbO4GALlAbg3bi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732266; c=relaxed/simple;
	bh=x01gOdSAVBG/JXUmB8lqiA+DCQezffFucL8Q6INmBJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5/fj4YM7sv4NHuET5RBoIpVMtIUC6QyLpdXxin3Tuf8rLv78vg7UWxPcGtsvrAIaf5YjVkvBZAWwSs1fQB9E1DlzTMpyeJafjzGp3NZIB895TC9iMhtwOXWF64phWQl+YW6dbuH2E1rrmYPI3Zt13d1QjfJTymUQFEw3vkjdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boh/VowD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boh/VowD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BFA1F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732265;
	bh=1zAPNhcKC/QKO76XoSh16NKEgtof+Blw7m0BVxdTB9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=boh/VowDr2UYOCyX2MhtoNCWrNIHhdmkpV2evLElg1LDmpXz5iS+3d1NyS0r911XT
	 h3rNeHfhBywv2BAJ5piDxygA6mBgXVGEtTKKCFUgCTuGEhAwR9yWYYNhaBMJmOwZ9T
	 DayJ3tVy1Pe4wJBFAgsl0HYRae3qXHB2DuyDh9lNCco78ZsbPHTxsP6UrhmN7TJNyr
	 RpcH903Z8jF2E7AqI69xq/Ettqezr47/Io5sdo9ywSfevg1GvZaX7gYYpwLiv/8KKj
	 3NfKauj23rDl139plY0H65jXD8xGX8aRVAsPzXW7np8POC2HO8f7YZdfeZ9BeGOFpv
	 6ClibyA8rYSpQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so8234599e87.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+ecjYSTYyJ0+ndMG/KDG7TO3ftdqJARJSkyCbg5GDvFIAhlFqwUg2MDGEmTmHChNqoZw32YAsHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0Mwu2jJZ8Hfu+focJo85H9/958iM7AuS5xHns4BJK7i1BBsr
	7/FmMLaCopTUurAFaQkoM6IIh9/MexcBhlFa80DZA5oB3EiA5ryXloIVn2OschNtUzhkkqjMnZE
	jJoR9XNJoGREj3gGveTVFQ1QdjAwjh4M=
X-Received: by 2002:ac2:4c46:0:b0:5ae:c239:6a2c with SMTP id
 2adb3069b0e04-5b28f9b02c7mr4659700e87.53.1784732264218; Wed, 22 Jul 2026
 07:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709023048.599150-1-panchuang@vivo.com> <20260709023048.599150-11-panchuang@vivo.com>
In-Reply-To: <20260709023048.599150-11-panchuang@vivo.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 16:57:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPcw66dpA+jJh3p3h5piYo1-znSLgfwTmQUrQGO=30KA@mail.gmail.com>
X-Gm-Features: AUfX_mwgU8at6U_EHVc1KK4NbSTwzG3ZtrSvFyninvxS6hQWWMjizjRMWx3HdNw
Message-ID: <CAJZ5v0iPcw66dpA+jJh3p3h5piYo1-znSLgfwTmQUrQGO=30KA@mail.gmail.com>
Subject: Re: [PATCH 10/18] thermal: intel: int340x: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:32=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wrot=
e:
>
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device_pci.c  | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index c693d934103a..c5131423ec9b 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -308,10 +308,8 @@ static int proc_thermal_setup_msi(struct pci_dev *pd=
ev, struct proc_thermal_pci
>                 ret =3D devm_request_threaded_irq(&pdev->dev, irq, proc_t=
hermal_irq_handler,
>                                                 proc_thermal_irq_thread_h=
andler,
>                                                 0, KBUILD_MODNAME, pci_in=
fo);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Request IRQ %d failed\n", ir=
q);
> +               if (ret)
>                         goto err_free_msi_vectors;
> -               }
>
>                 proc_thermal_msi_map[i] =3D irq;
>         }
> @@ -394,10 +392,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pd=
ev, const struct pci_device_
>                 ret =3D devm_request_threaded_irq(&pdev->dev, irq, proc_t=
hermal_irq_handler,
>                                                 proc_thermal_irq_thread_h=
andler, irq_flag,
>                                                 KBUILD_MODNAME, pci_info)=
;
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Request IRQ %d failed\n", pd=
ev->irq);
> +               if (ret)
>                         goto err_ret_tzone;
> -               }
>         }
>
>         ret =3D thermal_zone_device_enable(pci_info->tzone);
> --

Applied as 7.3 material, thanks!
