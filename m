Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DB40F727
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732057; cv=none; b=ckiCABEuHWuKTjKotya0ZVJWgPk5xZc/MtaKmO4CFhev/FYERJb46ndJTJr3eSRXEYqnYak5jbMLZ0cD2TcoaQJ+PDxNwjCcHKaAjbqe18q3wrRXwsgppbduPyN2N+e60MDG7581q7wvKcInYj7xB4sfLiE8QF0TkzEco3xY/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732057; c=relaxed/simple;
	bh=BF/7/Y7jW7oN5PDK7b5DdfNkvh82/y+i1JXP2HcRn7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOl3frObRA13JjIYk93mhU8+KhgGs2THJ9aYcZ29CmmvO0dTupPgzSEJ5LE8gA5/SqSTK2XdL5utktTQcaQrR3AgrJslmJAMFh0jrl2R3WwsJMIRIRH66rmX3IZLmVmWrKVeali2R7vxmplRsT1jmup/U1keKG0P3Z65Wnw3R90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvXFdVqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvXFdVqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FFA1F00A3F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732055;
	bh=rB6dSmF/Ms+yKDipyXAeWRZEO1IFePs1yvMjwRt6mxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gvXFdVqi8sVLlwMV/hYIHjLdfTu2lqzjEHTN0BT090Ss6OgRYVTLbUwWC6Ye23Lab
	 sPlar8keZ/caUDauRtFeMPzD+qqC1IaMuW56LnClQqdIE0qWgTaAzveT1eyYtfvdXv
	 Nf5kpn35P6OKfHD5s8FKrlSeWbXPl5PMDEJl7eUCsdpm/UF3LnKBHANfRsRLSZp04n
	 7Cx+e6cYYKC9LH/qu4ujm161Po/L3ZMMvxtcR0sWSchZ2tPQwI+HO6Zor8ZJTKh7Ik
	 ddfvk+4FbEZs0qEisTUnpTVifuV7F0b4RdBLTykV0qfzcQmqEMO6WxHVE1bnz/j2S9
	 I5L3BzWzr307w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so8924132e87.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:54:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpgsX3cNSItCk3vATOgccg9hqJCViznpZ9jM7s+4KEfuiiHjkzdDkI/Sh4+j6ksf6qSOuqPXISxJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtbqj3WQq9Q3r8y9IDkdZ/pS2Tu4YWUj80019lqrjIqTCqsqw
	/V3zob/q3sbzX3YARG421CzqeXw0Npv5hP95gb4RfICmDSHcvHbzSkjzU/QsqVWikdV3Vy97Rex
	QEDdHNM9tLDkhKBnfyJFRoIIamo1OEJQ=
X-Received: by 2002:ac2:482f:0:b0:5ae:ba8f:f9fa with SMTP id
 2adb3069b0e04-5b28f88317fmr3446365e87.18.1784732054341; Wed, 22 Jul 2026
 07:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623015140.19300-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260623015140.19300-1-pengpeng@iscas.ac.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 16:54:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJr0mLVVFWQHLrzXiu4NZuKzy8X=Q24G_9rENCUA4K6g@mail.gmail.com>
X-Gm-Features: AUfX_mwWbsMTjFm8OO_wLw-fZ1pVqEIBOfGR8GfoMHydQKtmtiHv4RQEMu7EgRk
Message-ID: <CAJZ5v0hJr0mLVVFWQHLrzXiu4NZuKzy8X=Q24G_9rENCUA4K6g@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: intel: int3400: clean up ODVP on probe failures
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Matthew Garrett <mjg59@google.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:51=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> evaluate_odvp() creates per-ODVP sysfs files before the thermal zone
> and later probe resources are registered. The current unwind path only
> calls cleanup_odvp() from the late sysfs failure path, so failures after
> evaluate_odvp() but before that label, including
> thermal_tripless_zone_device_register() failures, leave the ODVP files
> and storage behind.
>
> Move the ODVP cleanup to the common ART/TRT unwind path so every failure
> after evaluate_odvp() releases the ODVP state. Also clear the cached
> ODVP pointers in cleanup_odvp(), because evaluate_odvp() can already call
> it for partial setup failures while probe continues.
>
> Fixes: 006f006f1e5c ("thermal/int340x_thermal: Export OEM vendor variable=
s")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v2: https://lore.kernel.org/all/20260622153306.79258-1-peng=
peng@iscas.ac.cn/
> - move cleanup_odvp() to the common free_art_trt unwind path so it also
>   covers thermal_tripless_zone_device_register() failures
> - drop the unrelated data_vault cleanup change from v2
> - make cleanup_odvp() idempotent by clearing the cached ODVP pointers
>   after freeing them
>
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index d200734625ee..5d70301d4a3d 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -356,8 +356,10 @@ static void cleanup_odvp(struct int3400_thermal_priv=
 *priv)
>                         kfree(priv->odvp_attrs[i].attr.attr.name);
>                 }
>                 kfree(priv->odvp_attrs);
> +               priv->odvp_attrs =3D NULL;
>         }
>         kfree(priv->odvp);
> +       priv->odvp =3D NULL;
>         priv->odvp_count =3D 0;
>  }
>
> @@ -635,7 +637,6 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
>         acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY=
,
>                                    int3400_notify);
>  free_sysfs:
> -       cleanup_odvp(priv);
>         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
>                 device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
>                 kfree(priv->data_vault);
> @@ -649,6 +650,7 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
>                 acpi_thermal_rel_misc_device_remove(priv->adev->handle);
>         thermal_zone_device_unregister(priv->thermal);
>  free_art_trt:
> +       cleanup_odvp(priv);
>         kfree(priv->trts);
>         kfree(priv->arts);
>  free_priv:
> --

Applied as 7.3 material, thanks!
