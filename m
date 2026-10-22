Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691827;
	b=l4FXqiDGUHroPcW7jjwuHxZtG7Oe8Gby4gz+tvfeONAUt6WyZDxSU7h4v8Gl4DIJKOc7
	 jWAXaXWmVKIGA1GuGOu6P5ckpN4spUk7a/2b5yvUlHHQdW1X8yBYhjtBQ4bKfLugJkkJs
	 k2w3Z/jTEa7ztoqPf5mt4DjlVLSOU/hAnuxMSgHtEWACoalMumSAL5G0LGQ8hU7k4APrz
	 62Hj2iN/OMH+yFm8Ffa9VNEvnqucr8YLlJKv4VbSFKVPXhntWwG/5NbmgAbu78lScPk8H
	 NdNdT0YO/7b6/WfFaJuekabdYLVSS/V7u0D0PTTJlcslc5M5K7AybeRBBP2Y/ya7weg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691827;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xDC2DOeyBzHDwiyIfobG+nl4tjQ7W1bldUlzQQQloY4=;
	b=1nM9xtx1zoSezfcR/bMKeQuWxpPGECMgGB0wcqsaA+eWDQBK1fAQY/qnw5xqfNBf9pYM
	 AZXav6SaQkA51c5bHUrgNCQ/b3TRqKjG+ptJDMOKqmSiPrYGRBjtAbWCeDRiqU1AvvHJr
	 T2z9AUUifrhoqkVkgs0LVG2/qa6fRWgT2BoEo2m1FhMZZBP0j5n4bD8dMqfGiz+0vfG/Q
	 syLIb7KAbVS3zYEUftBJyO7t84brwF3nLGeUGKK7ErI+gnFxb9KFU3WHRuG1ZpUIkE6J5
	 rRshTghyYjVxAznnuhV1J7fregu2dPEfLLVklGSIBh/hPKpK8aGha4xcjjv8knDttLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqHcZ5oe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFA606A31F
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqHcZ5oe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769671F031E1
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691826;
	bh=xDC2DOeyBzHDwiyIfobG+nl4tjQ7W1bldUlzQQQloY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mqHcZ5oeH6bCj1Z9weWbhP6G6W7mkkC5c+Yteh07EZtuWJkkmy599HCl9Tl8ZyA2T
	 G+LRnjcDFHlmhopKG2OLq+saN5JY/kXbJ3S0Lu/gtu4lSh0SnA1MqNmnrt6MZRfQol
	 c8X5CryEAo/O0JVgDmQ4wQE59VD+Qg2F07cuF1/7jY/OcRK4AG0KeUbHtxZJPUe1iC
	 iUO0MZmxmUOAd7tuIJDNdcECHdq1p9YXFUvOiBiPzgsJ8+QonovuyoIjidm+8K2tI6
	 x548DIXRVDS1WzEZvqODBFhXxWUGHomYveDQpEn0NoZxuTWPFeqevpv/BylNQazWny
	 WXZXq8cgy/XWA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bce4e278baso32326e87.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:57:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzGFa3+gjosEKM9/F1c4+jti1NUEMUbiUaQidMLxWxZR1X0tF2FGpGbS+4izqx1xG5cJa8tYPPCnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJd5i10lUeFaHJ0nTg5qQvceO/lwmfdADQIULiya8g+p4bQJITr
	WJaPntkiqRxD8vQrJBQ4f4bdjFsJIUmvsxAxuFULxAQjdmnfTHBvTVO9xgtG2hxjH0DW7o2tHCE
	esRj6IQoy5zzd6nAwCeICyJV+TTjKAWI=
X-Received: by 2002:a05:6512:3d07:b0:5bf:ae14:aaef with SMTP id
 2adb3069b0e04-5bfae14ab6amr784225e87.21.1792691824499; Thu, 22 Oct 2026
 10:57:04 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com> <647d10df-72bc-4c08-96e4-045a387d54f9@app.fastmail.com>
In-Reply-To: <647d10df-72bc-4c08-96e4-045a387d54f9@app.fastmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 19:54:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcSRsWue4FQC+AK7japX-O3qL5xxoU4jd9-q-F1D-bGg@mail.gmail.com>
X-Gm-Features: AclHuK_1VCtT8SJnaGoCa2W8yy4ySBFH_Q3UdhHr9YR0tE-NkfLtyuNGzbFUlj8
Message-ID: <CAJZ5v0jcSRsWue4FQC+AK7japX-O3qL5xxoU4jd9-q-F1D-bGg@mail.gmail.com>
Subject: Re: [PATCH v3] platform profile: Separate handler locking from sysfs lifetime
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Mario Limonciello <superm1@kernel.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, Zhang DM <jixianqiang1540@gmail.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:55=E2=80=AFPM Mark Pearson <mpearson-lenovo@sque=
bb.ca> wrote:
>
> On Tue, Oct 20, 2026, at 10:45 AM, Daniel Lezcano wrote:
> > Registration and removal currently hold profile_lock across
> > device_unregister() and sysfs_update_group(). These operations can remo=
ve
> > sysfs attributes and wait for their active callbacks to finish. The
> > profile read and write callbacks acquire profile_lock themselves, so a
> > concurrent access can deadlock:
> >
> >   Removal/update path             Active sysfs callback
> >   -------------------             ---------------------
> >   acquire profile_lock            hold kernfs active reference
> >   remove a sysfs attribute         wait for profile_lock
> >   wait for its active references
> >
> > The removal path cannot finish until the callback returns, and the
> > callback cannot return until the removal path releases profile_lock.
> > This applies both to per-provider device teardown and to updates of the
> > legacy aggregate attribute group.
> >
> > Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
> > platform_profile_remove()") previously fixed this lock ordering by movi=
ng
> > sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
> > platform_profile: Use guard(mutex) for register/unregister") reintroduc=
ed
> > the issue by extending the mutex guard over sysfs_remove_group(). Later=
,
> > commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> > platform profile") replaced that teardown with device_unregister() and
> > sysfs_update_group(), still under the same mutex, extending the problem
> > to class-device teardown and aggregate attribute updates.
> >
> > Simply dropping profile_lock around these operations is insufficient.
> > Aggregate operations currently discover providers through the class
> > device list. A provider being unregistered could therefore still be
> > selected for an aggregate read, write or cycle while its sysfs files ar=
e
> > being torn down. Concurrent registrations and removals would also race
> > when updating aggregate attribute visibility.
> >
> > Introduce profile_registration_lock to serialize registration, removal
> > and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
> > Retain profile_lock for profile operations and use it to protect an
> > explicit list of handlers participating in the aggregate interface.
> >
> > Add a handler to that list only after device_register() succeeds. On
> > removal, unlink it under profile_lock before calling device_unregister(=
).
> > Acquiring profile_lock first waits for any aggregate operation already
> > using the handler to complete; unlinking prevents later aggregate
> > operations from finding it. Release profile_lock before draining sysfs
> > callbacks, allowing active per-provider callbacks to complete before th=
e
> > device is released. Apply the same unlink-before-unregister ordering to
> > registration error cleanup.
> >
> > Walk this list for aggregate reads, writes and profile cycling, and use
> > its emptiness to determine aggregate attribute visibility. The class
> > devices remain the per-provider userspace interface.
> >
> > There can now be an interval between removing the last handler from the
> > list and removing the aggregate attributes. Explicitly reject choices
> > reads and writes during that interval: the intersection bitmap starts
> > with every bit set, so an empty traversal must not advertise all profil=
es
> > or report a successful write without updating a provider.
> >
> > This separates aggregate membership from class device teardown while
> > preserving the existing class and ACPI sysfs interfaces.
> >
> > Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for
> > register/unregister")
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > ---
> > Changes in v3:
> >   - Send the locking fix as a standalone patch, independently of the
> >     firmware-agnostic extraction and legacy-interface deprecation
> > series.
> >   - Document that profile_lock protects handler-list membership and
> >     serializes profile operations against each other and handler
> > removal.
> >     Explain why it must not be held across sysfs teardown.
> >
> > Changes in v2:
> >   - Expand the deadlock and handler-lifetime explanation.
> >   - Add the Fixes tag and describe the earlier fix, regression and late=
r
> >     extension to class-device teardown and sysfs group updates.
> >
> >  drivers/acpi/platform_profile.c | 80 ++++++++++++++++++++++++---------=
--------
> >  1 file changed, 47 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
> > index 79d2e92e5c28..d79080a20e21 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -8,15 +8,25 @@
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/init.h>
> > +#include <linux/list.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_profile.h>
> >  #include <linux/sysfs.h>
> >
> >  #define to_pprof_handler(d)  (container_of(d, struct
> > platform_profile_handler, dev))
> >
> > +/*
> > + * Protects profile_handlers membership and serializes profile
> > operations
> > + * against each other and handler removal. Never held across sysfs
> > teardown,
> > + * which can wait for callbacks that acquire this lock.
> > + */
> >  static DEFINE_MUTEX(profile_lock);
> > +/* Serialize registration and sysfs updates without blocking sysfs
> > callbacks. */
> > +static DEFINE_MUTEX(profile_registration_lock);
> > +static LIST_HEAD(profile_handlers);
> >
> >  struct platform_profile_handler {
> > +     struct list_head node;
> >       const char *name;
> >       struct device dev;
> >       int minor;
> > @@ -44,6 +54,22 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D
> > PLATFORM_PROFILE_LAST);
> >
> >  static DEFINE_IDA(platform_profile_ida);
> >
> > +static int profile_walk_handlers(void *data,
> > +                              int (*fn)(struct device *dev, void *data=
))
> > +{
> > +     struct platform_profile_handler *handler;
> > +     int ret;
> > +
> > +     lockdep_assert_held(&profile_lock);
> > +     list_for_each_entry(handler, &profile_handlers, node) {
> > +             ret =3D fn(&handler->dev, data);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * _commmon_choices_show - Show the available profile choices
> >   * @choices: The available profile choices
> > @@ -306,20 +332,18 @@ static ssize_t
> > platform_profile_choices_show(struct kobject *kobj,
> >       int err;
> >
> >       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
> > -             err =3D class_for_each_device(&platform_profile_class, NU=
LL,
> > -                                         &data, _aggregate_choices);
> > +             err =3D profile_walk_handlers(&data, _aggregate_choices);
> >               if (err)
> >                       return err;
> >               if (data.count =3D=3D 1) {
> > -                     err =3D class_for_each_device(&platform_profile_c=
lass, NULL,
> > -                                                 &data, _remove_hidden=
_choices);
> > +                     err =3D profile_walk_handlers(&data, _remove_hidd=
en_choices);
> >                       if (err)
> >                               return err;
> >               }
> >       }
> >
> >       /* no profile handler registered any more */
> > -     if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
> > +     if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_=
LAST))
> >               return -EINVAL;
> >
> >       return _commmon_choices_show(data.aggregate, buf);
> > @@ -384,8 +408,7 @@ static ssize_t platform_profile_show(struct kobject=
 *kobj,
> >       int err;
> >
> >       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
> > -             err =3D class_for_each_device(&platform_profile_class, NU=
LL,
> > -                                         &profile, _aggregate_profiles=
);
> > +             err =3D profile_walk_handlers(&profile, _aggregate_profil=
es);
> >               if (err)
> >                       return err;
> >       }
> > @@ -423,15 +446,13 @@ static ssize_t platform_profile_store(struct
> > kobject *kobj,
> >               return -EINVAL;
> >
> >       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
> > -             ret =3D class_for_each_device(&platform_profile_class, NU=
LL,
> > -                                         &data, _aggregate_choices);
> > +             ret =3D profile_walk_handlers(&data, _aggregate_choices);
> >               if (ret)
> >                       return ret;
> > -             if (!test_bit(i, data.aggregate))
> > +             if (!data.count || !test_bit(i, data.aggregate))
> >                       return -EOPNOTSUPP;
> >
> > -             ret =3D class_for_each_device(&platform_profile_class, NU=
LL, &i,
> > -                                         _store_and_notify);
> > +             ret =3D profile_walk_handlers(&i, _store_and_notify);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -450,22 +471,11 @@ static struct attribute *platform_profile_attrs[]=
 =3D {
> >       NULL
> >  };
> >
> > -static int profile_class_registered(struct device *dev, const void
> > *data)
> > -{
> > -     return 1;
> > -}
> > -
> >  static umode_t profile_class_is_visible(struct kobject *kobj, struct
> > attribute *attr, int idx)
> >  {
> > -     struct device *dev;
> > -
> > -     dev =3D class_find_device(&platform_profile_class, NULL, NULL,
> > profile_class_registered);
> > -     if (!dev)
> > -             return 0;
> > -
> > -     put_device(dev);
> > +     guard(mutex)(&profile_lock);
> >
> > -     return attr->mode;
> > +     return list_empty(&profile_handlers) ? 0 : attr->mode;
> >  }
> >
> >  static const struct attribute_group platform_profile_group =3D {
> > @@ -502,8 +512,7 @@ int platform_profile_cycle(void)
> >       int err;
> >
> >       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
> > -             err =3D class_for_each_device(&platform_profile_class, NU=
LL,
> > -                                         &profile, _aggregate_profiles=
);
> > +             err =3D profile_walk_handlers(&profile, _aggregate_profil=
es);
> >               if (err)
> >                       return err;
> >
> > @@ -512,8 +521,7 @@ int platform_profile_cycle(void)
> >                   profile =3D=3D PLATFORM_PROFILE_LAST)
> >                       return -EINVAL;
> >
> > -             err =3D class_for_each_device(&platform_profile_class, NU=
LL,
> > -                                         &data, _aggregate_choices);
> > +             err =3D profile_walk_handlers(&data, _aggregate_choices);
> >               if (err)
> >                       return err;
> >
> > @@ -525,8 +533,7 @@ int platform_profile_cycle(void)
> >                                         PLATFORM_PROFILE_LAST,
> >                                         profile + 1);
> >
> > -             err =3D class_for_each_device(&platform_profile_class, NU=
LL, &next,
> > -                                         _store_and_notify);
> > +             err =3D profile_walk_handlers(&next, _store_and_notify);
> >
> >               if (err)
> >                       return err;
> > @@ -583,7 +590,7 @@ struct device *platform_profile_register(struct
> > device *dev, const char *name,
> >               }
> >       }
> >
> > -     guard(mutex)(&profile_lock);
> > +     guard(mutex)(&profile_registration_lock);
> >
> >       /* create class interface for individual handler */
> >       minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > @@ -604,6 +611,8 @@ struct device *platform_profile_register(struct
> > device *dev, const char *name,
> >               put_device(ppdev);
> >               goto cleanup_ida;
> >       }
> > +     scoped_guard(mutex, &profile_lock)
> > +             list_add_tail(&to_pprof_handler(ppdev)->node, &profile_ha=
ndlers);
> >
> >       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> >
> > @@ -614,6 +623,8 @@ struct device *platform_profile_register(struct
> > device *dev, const char *name,
> >       return ppdev;
> >
> >  cleanup_cur:
> > +     scoped_guard(mutex, &profile_lock)
> > +             list_del(&to_pprof_handler(ppdev)->node);
> >       device_unregister(ppdev);
> >
> >  cleanup_ida:
> > @@ -636,7 +647,10 @@ void platform_profile_remove(struct device *dev)
> >
> >       pprof =3D to_pprof_handler(dev);
> >
> > -     guard(mutex)(&profile_lock);
> > +     guard(mutex)(&profile_registration_lock);
> > +
> > +     scoped_guard(mutex, &profile_lock)
> > +             list_del(&pprof->node);
> >
> >       ida_free(&platform_profile_ida, pprof->minor);
> >       device_unregister(&pprof->dev);
> >
> > base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d
>
> Looks good to me.
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Applied as 7.4-rc material with some minor tweaks:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?id=3Db66621ad2a8fb553c4cb75b9d69fead4f0532933
