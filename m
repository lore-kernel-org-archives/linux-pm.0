Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC472BEFED
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264658; cv=none; b=Toa4nnB9URTKtc2oOiqqaduu2rkhXjrsiRoSlK1JWG4kMG9eUbz4iwbV6baL+xWW1X3wk+ipjwjjdb1mSsN/m0eR6CRfhOPpkH8J2xULVT/Ldq4D3Pbt8Ah+rRKcguLalebR0y5Ed9HY3LzmcJVV5hg2CBdF8NoNkd6yjdD1uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264658; c=relaxed/simple;
	bh=fmM8DFIHbC3QaC5wvFbfqSNNn08F8rFAdy+EOYybKD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRa5+SSDojVqfXDeBQBga/f5kBKg6lcYXR7kGwdXJqR6WkdTuENxOW4zmN6U6apKvODBr8sU1C2Ezl3tzAeufGyD+mHz7yJWPyJs2sy2HfU8ksGuuQJ/GkGZmmJCp/7Z5ozvIF41F1ceMiIa7rbchEdJVFdnvw9SRr4yREFo8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKgn/gcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKgn/gcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6292CC2BCB0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778264658;
	bh=fmM8DFIHbC3QaC5wvFbfqSNNn08F8rFAdy+EOYybKD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qKgn/gcucuJYCJkFbM2BgWgw/jEGEijf6fFYcwzjKCpE4ypoiH3tPFIwuQbXZsXxu
	 Ny3zQIQvdyEYu1q3Ok29HtqEtWdl40xad8Xp21brhoWqaI18M2cymq8DDeORbxjyc4
	 UcRMOJ6tUjrLZWsaW+PAoKXaE4rH14MypKKItKgVk/TmkxXR4i4U/pIqpXP6kXOt7a
	 BD6oPlf7EqwWupzXPs+LK3uTmbAd883+WKfExvNZ0SiNgRDsEWPYu2z+EndAzoNlN7
	 /1VW7CKyfZRlEwqfZXdBd8Nd4H8B12kkATMeN+mazSqlUAH51amTmVHo/+SotcWXeK
	 u/mx43OntHxkg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so20644381fa.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:24:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9mESOFK3Fl3BbCvtoGLYEGLb/cRrcAod9OCEI8kfedzPMbIjl5P84LFs9bVS/GArFGvb1ku3t6yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPJnya1xHiyXDHcVffogCPP7PEZZIr/TmvPWrkkfxBU0auN2g
	bxCBHxRXx5Gt1aWmnkEeVKu3rsTAjSfEzayGN1HjF+9WdogvkBgI+YqyCo6Spi+d6gtJ4kuuh6d
	9vFQh70Jg2/DMeN1fGy8gYcVsh+SRhak=
X-Received: by 2002:a05:6512:3dab:b0:5a4:1198:5016 with SMTP id
 2adb3069b0e04-5a887ae01b0mr4821357e87.11.1778264656813; Fri, 08 May 2026
 11:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com> <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 20:24:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWgoZtuK6nZ+71QbdV96GXq8McQ=azcCuceph3XxBD4w@mail.gmail.com>
X-Gm-Features: AVHnY4I54hGeOJ5pgs4tBL5t2sv_By9Bo4PpiltaN-5u-ccw7dAdRgrBoVfGTEM
Message-ID: <CAJZ5v0gWgoZtuK6nZ+71QbdV96GXq8McQ=azcCuceph3XxBD4w@mail.gmail.com>
Subject: Re: [PATCH 3/4] thermal/core: Allocate the thermal class dynamically
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, rui.zhang@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:05=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Use class_create() instead of a statically allocated struct class.
>
> This allows the thermal class to be managed through a dynamically
> allocated class object and avoids keeping a static class instance
> around.

I changed it the other way around during the last cycle, so is it
really worth changing again?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/thermal/thermal_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index a79fc4cdb078..748ab76823a3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -949,9 +949,7 @@ static void thermal_unbind_cdev_from_trip(struct ther=
mal_zone_device *tz,
>         kfree(pos);
>  }
>
> -static const struct class thermal_class =3D {
> -       .name =3D "thermal",
> -};
> +static struct class *thermal_class;
>  static bool thermal_class_unavailable __ro_after_init =3D true;
>
>  static inline
> @@ -1078,7 +1076,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>         cdev->np =3D np;
>         cdev->ops =3D ops;
>         cdev->updated =3D false;
> -       cdev->device.class =3D &thermal_class;
> +       cdev->device.class =3D thermal_class;
>         cdev->device.release =3D thermal_cdev_release;
>         cdev->devdata =3D devdata;
>
> @@ -1574,7 +1572,7 @@ thermal_zone_device_register_with_trips(const char =
*type,
>         if (!tz->ops.critical)
>                 tz->ops.critical =3D thermal_zone_device_critical;
>
> -       tz->device.class =3D &thermal_class;
> +       tz->device.class =3D thermal_class;
>         tz->device.release =3D thermal_zone_device_release;
>         tz->devdata =3D devdata;
>         tz->num_trips =3D num_trips;
> @@ -1898,15 +1896,18 @@ static int __init thermal_init(void)
>         if (result)
>                 goto destroy_workqueue;
>
> -       result =3D class_register(&thermal_class);
> -       if (result)
> +       thermal_class =3D class_create("thermal");
> +       if (IS_ERR(thermal_class)) {
> +               result =3D PTR_ERR(thermal_class);
>                 goto unregister_governors;
> +       }
>
>         thermal_class_unavailable =3D false;
>
>         return 0;
>
>  unregister_governors:
> +       thermal_class =3D NULL;
>         thermal_unregister_governors();
>  destroy_workqueue:
>         destroy_workqueue(thermal_wq);
> --
> 2.43.0
>
>
