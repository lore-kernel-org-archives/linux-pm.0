Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A443659FD
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381203; cv=none; b=McekKCVS5xthIyExhx7RuP4xpUlqZ48NFOovi5aIMyRrgqh7eZF924qSnJJIHYe/4lcMUH8zeI53vTDOHMfSOb3mmbf0I0PYvf9m53oSOZTdmFbBBHRTnyOgwLSoUffrvMGQbe50kMlznCz0YgNtbR7bIpYra4mVFSPJSRbvaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381203; c=relaxed/simple;
	bh=s1e/ociTMdVHbodmHGbhf8inhat519yZqvJY0OKPe8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh3Eogqpd9PA/gb+Y6D5F/DVcfdbnexgt9R/I/0MqkclBjo5RdsiHcABEzbO7mSP9IQKXeSTJGQPfEA2EiRgtS3Q5T4+u1dIzwznGUWRUcSZ6RbDru1APe/Fn751rC6pU5KiwjQQQGqr/IBjTghl6gE4YtGSODIgUJUJr4d/r78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvuH/rMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvuH/rMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9211F000FF
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789381200;
	bh=w4e/SHlDd98D9BE8dWRPoAwVK/lCQ3ruuHyE9FBfpjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lvuH/rMnftdqPCCblgZ9w8GJvrhbvk3kRlhXnAXrc+KA8P57DmNuTKK/AC9+yNKBn
	 n7oWGpoEWJsnxJ2WnC/RP99X6QntnnoFQvC9Q511d8OWFuTkc+a3mlUf5qLh2SIlVC
	 G/bdMtmtbuHB5MCxGXzVZDQOK0kjTYRZGlh7tPvb69a/odAC3WClrgnnPVQM4jX4uE
	 7FTgGd9RwWoL2T2zCZVcQkemtDKarGXlouJazGmipLrRMzrD9LC3GTvFz3HgEyUu8L
	 4YyN8aW3wi2KnB3rrvmGyX2yo/AJDm2TmEE3+Fx3FDN+L1vI8+NA5F0SGRB61VriZ5
	 dIOekFh8v5VCQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f16so1927076e87.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 03:19:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4nsSMKnBrWapgZTXtmIBq9JOR/EhwXu36a7rFjDq2l91/123HNXqlhhPTAgUHlO5vwb/PHLVuhA==@vger.kernel.org
X-Gm-Message-State: AFuF++le9OUnXS6d0Bcv501IOdDY9KR6NeKs8HOOg6YbTeA6HORVhCAF
	UsNnArsG9MIiVW56m0ySHfU5FGXcKSVG/ocuWPDmb/Nh2BHspvKfhqR/6nkkbE2I7GIdEy/1oQC
	XMGWP1fQB95LOWB/DFVAJTrbAYYRZ2Q0=
X-Received: by 2002:a05:6512:1153:b0:5b8:9ee1:10fd with SMTP id
 2adb3069b0e04-5b8ae8a9343mr1043238e87.32.1789381198380; Mon, 14 Sep 2026
 03:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <8729484.T7Z3S40VBb@rafael.j.wysocki>
 <7ef819c3-5155-48fb-828a-48d9bd72e54b@gmx.de>
In-Reply-To: <7ef819c3-5155-48fb-828a-48d9bd72e54b@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 14 Sep 2026 12:18:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icBLqUiU4ZF=iY6TB92syM_c7xGBJ7Ag7DGt+f7THHRA@mail.gmail.com>
X-Gm-Features: AcwNN1XkyKQvZYUoFYUG8vIqH7KV6lfSfcLng61fglctFWAGn98xXh1evhvoXMY
Message-ID: <CAJZ5v0icBLqUiU4ZF=iY6TB92syM_c7xGBJ7Ag7DGt+f7THHRA@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] thermal: core: Introduce thermal_cooling_device_create()
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:04=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 11.09.26 um 15:02 schrieb Rafael J. Wysocki:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Currently, thermal cooling devices have no parents, but it would be
> > generally useful to be able to create them under specific parents in
> > the device hierarchy (for instance, it may help to identify the device
> > representing the actual cooling hardware).
> >
> > To make that possible, add thermal_cooling_device_create() that will
> > work like thermal_cooling_device_register() except that it will take
> > an additional parent argument (which may be NULL).
> >
> > Redefine thermal_cooling_device_register() as a static inline wrapper
> > around thermal_cooling_device_create().
>
> Hi,
>
> i like your idea with the new registration function, this gives us more t=
ime
> for migrating the other drivers. Should we mark the original function as
> deprecated?

Well, it's not a big deal if somebody uses it in new code IMV.

> For the patch itself:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you (and thanks for all the reviews)!

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c | 28 ++++++++++++++++------------
> >   drivers/thermal/thermal_core.h |  3 ++-
> >   drivers/thermal/thermal_of.c   |  2 +-
> >   include/linux/thermal.h        | 19 ++++++++++++++-----
> >   4 files changed, 33 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 82e2f0d8a26d..ac928c199829 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1005,7 +1005,8 @@ thermal_cooling_device_alloc(const char *type, co=
nst struct thermal_cooling_devi
> >       return ERR_PTR(ret);
> >   }
> >
> > -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, vo=
id *devdata)
> > +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
> > +                            struct device *parent, void *devdata)
> >   {
> >       unsigned long current_state;
> >       int ret;
> > @@ -1013,6 +1014,7 @@ int thermal_cooling_device_add(struct thermal_coo=
ling_device *cdev, void *devdat
> >       mutex_init(&cdev->lock);
> >       INIT_LIST_HEAD(&cdev->thermal_instances);
> >       cdev->updated =3D false;
> > +     cdev->device.parent =3D parent;
> >       cdev->device.class =3D &thermal_class;
> >       cdev->device.release =3D thermal_cdev_release;
> >       device_initialize(&cdev->device);
> > @@ -1062,21 +1064,23 @@ int thermal_cooling_device_add(struct thermal_c=
ooling_device *cdev, void *devdat
> >   }
> >
> >   /**
> > - * thermal_cooling_device_register() - register a new thermal cooling =
device
> > + * thermal_cooling_device_create() - register a new thermal cooling de=
vice
> > + * @parent:  parent device (optional).
> >    * @type:   the thermal cooling device type.
> >    * @devdata:        device private data.
> >    * @ops:    standard thermal cooling devices callbacks.
> >    *
> > - * This interface function adds a new thermal cooling device (fan/proc=
essor/...)
> > - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to b=
ind itself
> > - * to all the thermal zone devices registered at the same time.
> > + * Allocate and register a new thermal cooling device under the given =
parent (if
> > + * not NULL) and with the given type, device data, and operations.  Du=
ring the
> > + * registration, it will be matched against all of the registered ther=
mal zones
> > + * and it will be bound to the matching ones.
> >    *
> > - * Return: a pointer to the created struct thermal_cooling_device or a=
n
> > - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> > + * Return: A pointer to the created struct thermal_cooling_device or a=
n ERR_PTR.
> > + * Callers must use IS_ERR*() helpers to check the return value.
> >    */
> > -struct thermal_cooling_device *
> > -thermal_cooling_device_register(const char *type, void *devdata,
> > -                             const struct thermal_cooling_device_ops *=
ops)
> > +struct thermal_cooling_device *thermal_cooling_device_create(
> > +                     struct device *parent, const char *type, void *de=
vdata,
> > +                     const struct thermal_cooling_device_ops *ops)
> >   {
> >       struct thermal_cooling_device *cdev;
> >       int ret;
> > @@ -1085,13 +1089,13 @@ thermal_cooling_device_register(const char *typ=
e, void *devdata,
> >       if (IS_ERR(cdev))
> >               return cdev;
> >
> > -     ret =3D thermal_cooling_device_add(cdev, devdata);
> > +     ret =3D thermal_cooling_device_add(cdev, parent, devdata);
> >       if (ret)
> >               return ERR_PTR(ret);
> >
> >       return cdev;
> >   }
> > -EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
> > +EXPORT_SYMBOL_GPL(thermal_cooling_device_create);
> >
> >   static void thermal_cooling_device_release(void *data)
> >   {
> > diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_c=
ore.h
> > index e98b0aa5aacc..7ef7c6cab437 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -270,7 +270,8 @@ void thermal_governor_update_tz(struct thermal_zone=
_device *tz,
> >   struct thermal_cooling_device *
> >   thermal_cooling_device_alloc(const char *type, const struct thermal_c=
ooling_device_ops *ops);
> >
> > -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, vo=
id *devdata);
> > +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
> > +                            struct device *parent, void *devdata);
> >
> >   /* Helpers */
> >   #define for_each_trip_desc(__tz, __td)      \
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0217a49b08ae..14dfac9359b8 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -561,7 +561,7 @@ thermal_of_cooling_device_register(struct device_no=
de *np, u32 cdev_id,
> >       cdev->np =3D np;
> >       cdev->cdev_id =3D cdev_id;
> >
> > -     ret =3D thermal_cooling_device_add(cdev, devdata);
> > +     ret =3D thermal_cooling_device_add(cdev, NULL, devdata);
> >       if (ret)
> >               return ERR_PTR(ret);
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 083b4f533933..306ad17aed89 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -293,8 +293,9 @@ struct device *thermal_zone_device(struct thermal_z=
one_device *tzd);
> >   void thermal_zone_device_update(struct thermal_zone_device *,
> >                               enum thermal_notify_event);
> >
> > -struct thermal_cooling_device *thermal_cooling_device_register(const c=
har *,
> > -             void *, const struct thermal_cooling_device_ops *);
> > +struct thermal_cooling_device *thermal_cooling_device_create(
> > +                     struct device *parent, const char *type, void *de=
vdata,
> > +                     const struct thermal_cooling_device_ops *ops);
> >
> >   struct thermal_cooling_device *
> >   devm_thermal_cooling_device_register(struct device *dev, const char *=
type, void *devdata,
> > @@ -340,9 +341,9 @@ static inline void thermal_zone_device_update(struc=
t thermal_zone_device *tz,
> >                                             enum thermal_notify_event e=
vent)
> >   { }
> >
> > -static inline struct thermal_cooling_device *
> > -thermal_cooling_device_register(const char *type, void *devdata,
> > -     const struct thermal_cooling_device_ops *ops)
> > +static inline struct thermal_cooling_device *thermal_cooling_device_cr=
eate(
> > +                     struct device *parent, const char *type, void *de=
vdata,
> > +                     const struct thermal_cooling_device_ops *ops)
> >   { return ERR_PTR(-ENODEV); }
> >
> >   static inline struct thermal_cooling_device *
> > @@ -391,4 +392,12 @@ static inline void thermal_pm_prepare(void) {}
> >   static inline void thermal_pm_complete(void) {}
> >   #endif /* CONFIG_THERMAL */
> >
> > +static inline struct thermal_cooling_device *thermal_cooling_device_re=
gister(
> > +                             const char *type, void *devdata,
> > +                             const struct thermal_cooling_device_ops *=
ops)
> > +{
> > +     return thermal_cooling_device_create(NULL, type, devdata, ops);
> > +}
> > +
> > +
> >   #endif /* __THERMAL_H__ */
