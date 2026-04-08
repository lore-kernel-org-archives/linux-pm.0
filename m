Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7D28726E
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644173; cv=none; b=KrEW6Rhqp1y1ICkapbjdcT1o+JcV+kARFtVn4qqiO0SExs3i0xTC40B6YJ/mix198Sr3KYVaK152FSehpERyxAKZ6kazUsx0UU0FZEbl1+Cwl8Ifm220iPVlDeU5lzrzIeyZRfLTh2sUVxFeDlEUxEGDzaZaNA+IRwLkn7Pj374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644173; c=relaxed/simple;
	bh=8SDpG9+LDBS2fVzuQ96RzdUWrK5MtAaHuR09brzZ4W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD5V6Yp1LBSKgQ11bpLp/H8hL6ZJfFWTJtGu077jEa7/ksUVM/x+Q0zfyzd5UnPVP9p+QtI75Og+yofw6wFYJw8JkiHsDIjE6mAcCJy8gUo2OIlCYCiROdS7w8CF4zwMxQP3zN5N0Gys6V152NJk+TgdUx+InRlRHqiUXB63SUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK+2rGiT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK+2rGiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B6C19421
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644172;
	bh=8SDpG9+LDBS2fVzuQ96RzdUWrK5MtAaHuR09brzZ4W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OK+2rGiT3cQtN25gG6e7ohvDnBtyKv2P1d2yc7/G0sCmp7N97hxcJbqRdM/pTizT5
	 PRcSbSGFIeENz2MfepYomswcpXnWg9gd0wY+QZt3s2HJVkie97ZdTQi2ElI1aJqGyH
	 +zgyVhTmbOdiG3BnBPBQIPcaj5oRlFPNRXxtVdCtcoieXTKFBVnARLQqHpn1pPfwdb
	 zMzMRU8tI/FXGRXBwce205IziRXVAfc6hgl1+fxGo4vwflcnE2poVMx+49FybeMJ1Q
	 /dlrzjM/DsTAGQiktwzkfeX/aV7NZk8J14x6MHO9dJ58NgItOajQMIq1uMum4fFKZW
	 pPuXBGzNSItKg==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-464bc03efd8so2874558b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 03:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWN+DefhNb+n6lgV9QNELSqO86yjY1mntHoi3r1zP+QWrffglusR4w+JcHhEZ2xsCzS5+W0fI8flg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDY1ODN+z6XyPNp7t8gKz5DUXd7SYYD9+iqwEWZMo3mdmLjuot
	etxY7VArzQ23fXupzrUpR3H2dcxij7m8pcy49CAP8c9g5g8c0gjNk6AzFkvWYiJmOztKvX8UuMm
	Ouiwb2juWce1cV7kj7wausCsesYauBe8=
X-Received: by 2002:a54:4e8b:0:b0:45f:3592:407 with SMTP id
 5614622812f47-46efc4e2677mr7773609b6e.50.1775644171778; Wed, 08 Apr 2026
 03:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407155110.3920703-1-daniel.lezcano@kernel.org> <CAJZ5v0hQyyQxGi3Zv9_asMhbKG-eki+4D=mzXBzwuf5x-AZQeQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQyyQxGi3Zv9_asMhbKG-eki+4D=mzXBzwuf5x-AZQeQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Apr 2026 12:29:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ik-zi5ePEVaWc+P-iTDhykfNAFXt2nuNriAN-xcrKROA@mail.gmail.com>
X-Gm-Features: AQROBzCun1Ein5Co5ZKEdLBG5poBF8LEsGdqm-xMK-CldmHNw7ZzUQpN_1Jaj_o
Message-ID: <CAJZ5v0ik-zi5ePEVaWc+P-iTDhykfNAFXt2nuNriAN-xcrKROA@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Move OF code where it belongs to
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 7:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Apr 7, 2026 at 5:51=E2=80=AFPM Daniel Lezcano <daniel.lezcano@ker=
nel.org> wrote:
> >
> > From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> >
> > The functions:
> >  - thermal_of_cooling_device_register()
> >  - devm_thermal_of_cooling_device_register()
> >
> >  are related to thermal-of but they are implemented in
> >  thermal-core. Move these functions to the right file.
> >
> > Pure move patch.
> >
> > No functional change intended.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> > ---
> >  drivers/thermal/thermal_core.c | 75 +---------------------------------
> >  drivers/thermal/thermal_core.h |  5 +++
> >  drivers/thermal/thermal_of.c   | 72 ++++++++++++++++++++++++++++++++
> >  3 files changed, 78 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index b7d706ed7ed9..f0049cff1128 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1054,7 +1054,7 @@ static void thermal_cooling_device_init_complete(=
struct thermal_cooling_device *
> >   * Return: a pointer to the created struct thermal_cooling_device or a=
n
> >   * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> >   */
> > -static struct thermal_cooling_device *
> > +struct thermal_cooling_device *
> >  __thermal_cooling_device_register(struct device_node *np,
> >                                   const char *type, void *devdata,
> >                                   const struct thermal_cooling_device_o=
ps *ops)
> > @@ -1162,79 +1162,6 @@ thermal_cooling_device_register(const char *type=
, void *devdata,
> >  }
> >  EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
> >
> > -/**
> > - * thermal_of_cooling_device_register() - register an OF thermal cooli=
ng device
> > - * @np:                a pointer to a device tree node.
> > - * @type:      the thermal cooling device type.
> > - * @devdata:   device private data.
> > - * @ops:               standard thermal cooling devices callbacks.
> > - *
> > - * This function will register a cooling device with device tree node =
reference.
> > - * This interface function adds a new thermal cooling device (fan/proc=
essor/...)
> > - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to b=
ind itself
> > - * to all the thermal zone devices registered at the same time.
> > - *
> > - * Return: a pointer to the created struct thermal_cooling_device or a=
n
> > - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> > - */
> > -struct thermal_cooling_device *
> > -thermal_of_cooling_device_register(struct device_node *np,
> > -                                  const char *type, void *devdata,
> > -                                  const struct thermal_cooling_device_=
ops *ops)
> > -{
> > -       return __thermal_cooling_device_register(np, type, devdata, ops=
);
> > -}
> > -EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> > -
> > -static void thermal_cooling_device_release(struct device *dev, void *r=
es)
> > -{
> > -       thermal_cooling_device_unregister(
> > -                               *(struct thermal_cooling_device **)res)=
;
> > -}
> > -
> > -/**
> > - * devm_thermal_of_cooling_device_register() - register an OF thermal =
cooling
> > - *                                            device
> > - * @dev:       a valid struct device pointer of a sensor device.
> > - * @np:                a pointer to a device tree node.
> > - * @type:      the thermal cooling device type.
> > - * @devdata:   device private data.
> > - * @ops:       standard thermal cooling devices callbacks.
> > - *
> > - * This function will register a cooling device with device tree node =
reference.
> > - * This interface function adds a new thermal cooling device (fan/proc=
essor/...)
> > - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to b=
ind itself
> > - * to all the thermal zone devices registered at the same time.
> > - *
> > - * Return: a pointer to the created struct thermal_cooling_device or a=
n
> > - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> > - */
> > -struct thermal_cooling_device *
> > -devm_thermal_of_cooling_device_register(struct device *dev,
> > -                               struct device_node *np,
> > -                               const char *type, void *devdata,
> > -                               const struct thermal_cooling_device_ops=
 *ops)
> > -{
> > -       struct thermal_cooling_device **ptr, *tcd;
> > -
> > -       ptr =3D devres_alloc(thermal_cooling_device_release, sizeof(*pt=
r),
> > -                          GFP_KERNEL);
> > -       if (!ptr)
> > -               return ERR_PTR(-ENOMEM);
> > -
> > -       tcd =3D __thermal_cooling_device_register(np, type, devdata, op=
s);
> > -       if (IS_ERR(tcd)) {
> > -               devres_free(ptr);
> > -               return tcd;
> > -       }
> > -
> > -       *ptr =3D tcd;
> > -       devres_add(dev, ptr);
> > -
> > -       return tcd;
> > -}
> > -EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> > -
> >  static bool thermal_cooling_device_present(struct thermal_cooling_devi=
ce *cdev)
> >  {
> >         struct thermal_cooling_device *pos =3D NULL;
> > diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_c=
ore.h
> > index d3acff602f9c..bdd59947b24f 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -269,6 +269,11 @@ void thermal_zone_device_critical_shutdown(struct =
thermal_zone_device *tz);
> >  void thermal_governor_update_tz(struct thermal_zone_device *tz,
> >                                 enum thermal_notify_event reason);
> >
> > +struct thermal_cooling_device *
> > +__thermal_cooling_device_register(struct device_node *np,
> > +                                 const char *type, void *devdata,
> > +                                 const struct thermal_cooling_device_o=
ps *ops);
> > +
> >  /* Helpers */
> >  #define for_each_trip_desc(__tz, __td) \
> >         for (__td =3D __tz->trips; __td - __tz->trips < __tz->num_trips=
; __td++)
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 99085c806a1f..398157e740fc 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -510,3 +510,75 @@ void devm_thermal_of_zone_unregister(struct device=
 *dev, struct thermal_zone_dev
> >                                devm_thermal_of_zone_match, tz));
> >  }
> >  EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
> > +
> > +/**
> > + * thermal_of_cooling_device_register() - register an OF thermal cooli=
ng device
> > + * @np:                a pointer to a device tree node.
> > + * @type:      the thermal cooling device type.
> > + * @devdata:   device private data.
> > + * @ops:               standard thermal cooling devices callbacks.
> > + *
> > + * This function will register a cooling device with device tree node =
reference.
> > + * This interface function adds a new thermal cooling device (fan/proc=
essor/...)
> > + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to b=
ind itself
> > + * to all the thermal zone devices registered at the same time.
> > + *
> > + * Return: a pointer to the created struct thermal_cooling_device or a=
n
> > + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> > + */
> > +struct thermal_cooling_device *
> > +thermal_of_cooling_device_register(struct device_node *np,
> > +                                  const char *type, void *devdata,
> > +                                  const struct thermal_cooling_device_=
ops *ops)
> > +{
> > +       return __thermal_cooling_device_register(np, type, devdata, ops=
);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
> > +
> > +static void thermal_cooling_device_release(struct device *dev, void *r=
es)
> > +{
> > +       thermal_cooling_device_unregister(*(struct thermal_cooling_devi=
ce **)res);
> > +}
> > +
> > +/**
> > + * devm_thermal_of_cooling_device_register() - register an OF thermal =
cooling
> > + *                                            device
> > + * @dev:       a valid struct device pointer of a sensor device.
> > + * @np:                a pointer to a device tree node.
> > + * @type:      the thermal cooling device type.
> > + * @devdata:   device private data.
> > + * @ops:       standard thermal cooling devices callbacks.
> > + *
> > + * This function will register a cooling device with device tree node =
reference.
> > + * This interface function adds a new thermal cooling device (fan/proc=
essor/...)
> > + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to b=
ind itself
> > + * to all the thermal zone devices registered at the same time.
> > + *
> > + * Return: a pointer to the created struct thermal_cooling_device or a=
n
> > + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> > + */
> > +struct thermal_cooling_device *
> > +devm_thermal_of_cooling_device_register(struct device *dev,
> > +                                       struct device_node *np,
> > +                                       const char *type, void *devdata=
,
> > +                                       const struct thermal_cooling_de=
vice_ops *ops)
> > +{
> > +       struct thermal_cooling_device **ptr, *tcd;
> > +
> > +       ptr =3D devres_alloc(thermal_cooling_device_release, sizeof(*pt=
r),
> > +                          GFP_KERNEL);
> > +       if (!ptr)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       tcd =3D __thermal_cooling_device_register(np, type, devdata, op=
s);
> > +       if (IS_ERR(tcd)) {
> > +               devres_free(ptr);
> > +               return tcd;
> > +       }
> > +
> > +       *ptr =3D tcd;
> > +       devres_add(dev, ptr);
> > +
> > +       return tcd;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
> > --
>
> Applied as 7.1 material, thanks!

And dropped because of a build issue introduced by it:

https://lore.kernel.org/linux-pm/202604081734.3OJSeExW-lkp@intel.com/
