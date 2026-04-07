Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998E3D1CCC
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581845; cv=none; b=ms0PeGmJv/LJoSye8o+RzfyJS7nAGcRUTohUFON1shm5Y1lo85m+Vci+JuDW8PQAlBP0N11Hmq28HnkZjJDFVxKimQg16D17JKaKZNEl4ckaST09P0Hp7Ebo+QbNJm7XstaXccR+UHU9XinUI9eDJlVfWzUH7Kh2ETQ4ArpFiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581845; c=relaxed/simple;
	bh=fvkfv57tTAC8i+GCR9UdNimEIIeDOUvMomEjqtn5K/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDjoUhDadGOXT3llyl9febNp5zkYMDMcMsE1XxWhkKosqa0K2m8sO+HjCxJsBKSqHECOBqNk6btWI56pj502ULeXVJpTHeXc+1bCedaH0ClXX1PQ85x6/i/lspqne6WzJjzsdgbnF+KkSqoHAe3Tt4B8qITpTgwtVvyz2ezNvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxDO02oD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxDO02oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9F9C19424
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775581844;
	bh=fvkfv57tTAC8i+GCR9UdNimEIIeDOUvMomEjqtn5K/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxDO02oDxrBtqf6Nazzpzzr873+HeLSSnCbo80R2AMfART6SIr3KYKaN0vEkislQK
	 kMK6cKL3PqfEqyzZYM6bzSh+GUXEt04y4ZeJQ7K4E+FjLvOI+g46H0QYGowRwHFhEB
	 vRsp01nOq/PFEzNj5MaNUaUG81CJZ4vlochgtoF2NQ56PXwj0pc5S30kTnLaiZpFvf
	 8e/EjzCleV4bqm71cVNQMXdyiTFZy2mbvWh2EzJXet+xYYTVJWFRwJ7K2bhrwyBey+
	 4UGCF3w5GNXMxUHjjrOpBjFO0FJo37thVGTyK2fvm6N9nVUkak8pc8D1eQb9mfISyr
	 NHTSA3BXNMzyA==
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12bfa7fe691so3245335c88.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 10:10:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTqMYy5jGiNplEeh96ayik2VRJxPVazsO9VRCTOWzmy6N05rMD+nysKefyo4flOus4a+XJR6aLEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AxSrDxIaFsYHvPBCKzADtT+BRDSEL4o+rwvSLzURuwafE3Lg
	yziWEvBo1DT2/5QFj7i8KeFU6osdR7JAb3B1aSjaxKZYVnqNTgYiluVV7Fkn3O8utue18TJFnvA
	OVhjgMRE+qsPYye16fqMEuiD73BGM2+o=
X-Received: by 2002:a05:7022:e02:b0:12a:68cc:3f08 with SMTP id
 a92af1059eb24-12bfb6e9821mr9356717c88.8.1775581840123; Tue, 07 Apr 2026
 10:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407155110.3920703-1-daniel.lezcano@kernel.org>
In-Reply-To: <20260407155110.3920703-1-daniel.lezcano@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 19:10:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQyyQxGi3Zv9_asMhbKG-eki+4D=mzXBzwuf5x-AZQeQ@mail.gmail.com>
X-Gm-Features: AQROBzBQXuLJ-Bld63xLasvOABjurU6lcjjCqWM7S7qEPN-X53pDCE1Rexd1vE8
Message-ID: <CAJZ5v0hQyyQxGi3Zv9_asMhbKG-eki+4D=mzXBzwuf5x-AZQeQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Move OF code where it belongs to
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 5:51=E2=80=AFPM Daniel Lezcano <daniel.lezcano@kerne=
l.org> wrote:
>
> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>
> The functions:
>  - thermal_of_cooling_device_register()
>  - devm_thermal_of_cooling_device_register()
>
>  are related to thermal-of but they are implemented in
>  thermal-core. Move these functions to the right file.
>
> Pure move patch.
>
> No functional change intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> ---
>  drivers/thermal/thermal_core.c | 75 +---------------------------------
>  drivers/thermal/thermal_core.h |  5 +++
>  drivers/thermal/thermal_of.c   | 72 ++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index b7d706ed7ed9..f0049cff1128 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1054,7 +1054,7 @@ static void thermal_cooling_device_init_complete(st=
ruct thermal_cooling_device *
>   * Return: a pointer to the created struct thermal_cooling_device or an
>   * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
>   */
> -static struct thermal_cooling_device *
> +struct thermal_cooling_device *
>  __thermal_cooling_device_register(struct device_node *np,
>                                   const char *type, void *devdata,
>                                   const struct thermal_cooling_device_ops=
 *ops)
> @@ -1162,79 +1162,6 @@ thermal_cooling_device_register(const char *type, =
void *devdata,
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>
> -/**
> - * thermal_of_cooling_device_register() - register an OF thermal cooling=
 device
> - * @np:                a pointer to a device tree node.
> - * @type:      the thermal cooling device type.
> - * @devdata:   device private data.
> - * @ops:               standard thermal cooling devices callbacks.
> - *
> - * This function will register a cooling device with device tree node re=
ference.
> - * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> - * to all the thermal zone devices registered at the same time.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
> -struct thermal_cooling_device *
> -thermal_of_cooling_device_register(struct device_node *np,
> -                                  const char *type, void *devdata,
> -                                  const struct thermal_cooling_device_op=
s *ops)
> -{
> -       return __thermal_cooling_device_register(np, type, devdata, ops);
> -}
> -EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> -
> -static void thermal_cooling_device_release(struct device *dev, void *res=
)
> -{
> -       thermal_cooling_device_unregister(
> -                               *(struct thermal_cooling_device **)res);
> -}
> -
> -/**
> - * devm_thermal_of_cooling_device_register() - register an OF thermal co=
oling
> - *                                            device
> - * @dev:       a valid struct device pointer of a sensor device.
> - * @np:                a pointer to a device tree node.
> - * @type:      the thermal cooling device type.
> - * @devdata:   device private data.
> - * @ops:       standard thermal cooling devices callbacks.
> - *
> - * This function will register a cooling device with device tree node re=
ference.
> - * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> - * to all the thermal zone devices registered at the same time.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
> -struct thermal_cooling_device *
> -devm_thermal_of_cooling_device_register(struct device *dev,
> -                               struct device_node *np,
> -                               const char *type, void *devdata,
> -                               const struct thermal_cooling_device_ops *=
ops)
> -{
> -       struct thermal_cooling_device **ptr, *tcd;
> -
> -       ptr =3D devres_alloc(thermal_cooling_device_release, sizeof(*ptr)=
,
> -                          GFP_KERNEL);
> -       if (!ptr)
> -               return ERR_PTR(-ENOMEM);
> -
> -       tcd =3D __thermal_cooling_device_register(np, type, devdata, ops)=
;
> -       if (IS_ERR(tcd)) {
> -               devres_free(ptr);
> -               return tcd;
> -       }
> -
> -       *ptr =3D tcd;
> -       devres_add(dev, ptr);
> -
> -       return tcd;
> -}
> -EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> -
>  static bool thermal_cooling_device_present(struct thermal_cooling_device=
 *cdev)
>  {
>         struct thermal_cooling_device *pos =3D NULL;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index d3acff602f9c..bdd59947b24f 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -269,6 +269,11 @@ void thermal_zone_device_critical_shutdown(struct th=
ermal_zone_device *tz);
>  void thermal_governor_update_tz(struct thermal_zone_device *tz,
>                                 enum thermal_notify_event reason);
>
> +struct thermal_cooling_device *
> +__thermal_cooling_device_register(struct device_node *np,
> +                                 const char *type, void *devdata,
> +                                 const struct thermal_cooling_device_ops=
 *ops);
> +
>  /* Helpers */
>  #define for_each_trip_desc(__tz, __td) \
>         for (__td =3D __tz->trips; __td - __tz->trips < __tz->num_trips; =
__td++)
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 99085c806a1f..398157e740fc 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -510,3 +510,75 @@ void devm_thermal_of_zone_unregister(struct device *=
dev, struct thermal_zone_dev
>                                devm_thermal_of_zone_match, tz));
>  }
>  EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
> +
> +/**
> + * thermal_of_cooling_device_register() - register an OF thermal cooling=
 device
> + * @np:                a pointer to a device tree node.
> + * @type:      the thermal cooling device type.
> + * @devdata:   device private data.
> + * @ops:               standard thermal cooling devices callbacks.
> + *
> + * This function will register a cooling device with device tree node re=
ference.
> + * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> + * to all the thermal zone devices registered at the same time.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +struct thermal_cooling_device *
> +thermal_of_cooling_device_register(struct device_node *np,
> +                                  const char *type, void *devdata,
> +                                  const struct thermal_cooling_device_op=
s *ops)
> +{
> +       return __thermal_cooling_device_register(np, type, devdata, ops);
> +}
> +EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> +
> +static void thermal_cooling_device_release(struct device *dev, void *res=
)
> +{
> +       thermal_cooling_device_unregister(*(struct thermal_cooling_device=
 **)res);
> +}
> +
> +/**
> + * devm_thermal_of_cooling_device_register() - register an OF thermal co=
oling
> + *                                            device
> + * @dev:       a valid struct device pointer of a sensor device.
> + * @np:                a pointer to a device tree node.
> + * @type:      the thermal cooling device type.
> + * @devdata:   device private data.
> + * @ops:       standard thermal cooling devices callbacks.
> + *
> + * This function will register a cooling device with device tree node re=
ference.
> + * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> + * to all the thermal zone devices registered at the same time.
> + *
> + * Return: a pointer to the created struct thermal_cooling_device or an
> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + */
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +                                       struct device_node *np,
> +                                       const char *type, void *devdata,
> +                                       const struct thermal_cooling_devi=
ce_ops *ops)
> +{
> +       struct thermal_cooling_device **ptr, *tcd;
> +
> +       ptr =3D devres_alloc(thermal_cooling_device_release, sizeof(*ptr)=
,
> +                          GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       tcd =3D __thermal_cooling_device_register(np, type, devdata, ops)=
;
> +       if (IS_ERR(tcd)) {
> +               devres_free(ptr);
> +               return tcd;
> +       }
> +
> +       *ptr =3D tcd;
> +       devres_add(dev, ptr);
> +
> +       return tcd;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> --

Applied as 7.1 material, thanks!
