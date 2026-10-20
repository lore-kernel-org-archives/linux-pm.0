Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526643;
	b=YAOxlm0ik5RRmKkoY7QdXFF/ErY4YsuE2nesRiMvSyWcUQoVc+gncoMaForHObe8KFhc
	 Cmvy32ZKZ/k2nGl6zGMQdC62I2YOyBk5r67x2otnkbwIsjY0eNJgTE/MoC6LHGnHSJRRk
	 XmQ8MKsc8qYv2HIr9oTu2Th4y1Co0EdTNhMTKzSLox2bPyhrI5dAqsJje7xHoC1j5DiX+
	 WAz/qF/hsGxos9ykppqP5GpjzT8cbGpfczHaujsBzoORyysjAmUYB8srsyJ1pkm6sqD9L
	 XHJ6EI5X559Xj1tG+RPxgxzPhkGB4XHFNQ/08tfCruUxIZvqWLaCw6eqhcIClOqC2/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=wd2FJGlu+0fbyoXhw6VVc5IYaBCU7QVw7dLO30BJWrY=;
	b=mwmSb5ZStWjbjV42EOQgdBXn5+kw/kvjYiDoGN56pSpeYMzdd4EqnHyhBx4uhGy5Pjfz
	 VYGVxC+6iJlQie87qys4Wy2JCdGSWnSF24FqLmCkk2JT40XXVeYLBao3aWTp458FHA9fG
	 KVq1dQqY8BEix07ISTtdhXEGlkvt9SvLM6rxFQhgevv9FPE3Lp6wGS7xdjsAG4eGsFUsz
	 CgwSxNjCVmFO8QGAV+MecJCJtbjX70P5EWAnL7rPP/DlhH1IZWvV3KTEUQSOTxt7IL9KD
	 rCSKqz0RHWeGLLwveYKZ7sUQ6RralKA5/JJ92f4JAvJ/+Y2fUp5DnPhgeti8otgeSuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SfqUfK1s;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58D606A31A;
	Tue, 20 Oct 2026 20:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA58D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SfqUfK1s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792526643; x=1824062643;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SA/hGjNUEOFfDC21kHQf5YbRyqwOcCA3aPR4u9P5bQc=;
  b=SfqUfK1srfp90VoWQfacm6oMsMmSd90fVuiG6z3F9xgp+C6pM7lR86zL
   u5hZ3EABjKVcpx7H3MmSlcDCsLWdaRetwoqOBVtIzT3K7UA9OwoHlfyKn
   7TUPXtxXd/UeiHwcOSLpTeaxjvdJo2CPOMy1t5jFEA8rzGlu6U863UqMs
   m4DficKfQATeSbHYqn6ckU/W2rBoVrEkqrCErMWV5l1le2ogjhtWg6zrD
   WU+q6du6QRXjnDgPdd6SWrQ6UxzNEiS8ag3qXfLFafs3t7zVBhJPLJtwA
   hNW1jnH5NYIg0KUXwRzo7nAknbeAPsfElYSUvf7WGQcmppj4B0UW4xXgX
   g==;
X-CSE-ConnectionGUID: d5vjzSvBSv+kUC1DrvdTag==
X-CSE-MsgGUID: xOTjTFn0Q4uWuVGCtksx5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1252888"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1252888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 13:04:02 -0700
X-CSE-ConnectionGUID: 7k7fX0lLSnS4lEhGF2ANkg==
X-CSE-MsgGUID: RlLF34yrT1unWcayhp536Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2850742"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 13:03:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Oct 2026 23:03:51 +0300 (EEST)
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Mario Limonciello (AMD)" <superm1@kernel.org>, 
    Jack Wu <jackbb_wu@compal.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, 
    linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform profile: Separate handler locking from sysfs
 lifetime
In-Reply-To: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
Message-ID: <97da66c6-a71a-e72a-579f-47dc813b346b@linux.intel.com>
References: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1338216543-1792526631=:1177"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1338216543-1792526631=:1177
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 Oct 2026, Daniel Lezcano wrote:

> Registration and removal currently hold profile_lock across
> device_unregister() and sysfs_update_group(). These operations can remove
> sysfs attributes and wait for their active callbacks to finish. The
> profile read and write callbacks acquire profile_lock themselves, so a
> concurrent access can deadlock:
>=20
>   Removal/update path             Active sysfs callback
>   -------------------             ---------------------
>   acquire profile_lock            hold kernfs active reference
>   remove a sysfs attribute         wait for profile_lock
>   wait for its active references
>=20
> The removal path cannot finish until the callback returns, and the
> callback cannot return until the removal path releases profile_lock.
> This applies both to per-provider device teardown and to updates of the
> legacy aggregate attribute group.
>=20
> Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
> platform_profile_remove()") previously fixed this lock ordering by moving
> sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
> platform_profile: Use guard(mutex) for register/unregister") reintroduced
> the issue by extending the mutex guard over sysfs_remove_group(). Later,
> commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> platform profile") replaced that teardown with device_unregister() and
> sysfs_update_group(), still under the same mutex, extending the problem
> to class-device teardown and aggregate attribute updates.
>=20
> Simply dropping profile_lock around these operations is insufficient.
> Aggregate operations currently discover providers through the class
> device list. A provider being unregistered could therefore still be
> selected for an aggregate read, write or cycle while its sysfs files are
> being torn down. Concurrent registrations and removals would also race
> when updating aggregate attribute visibility.
>=20
> Introduce profile_registration_lock to serialize registration, removal
> and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
> Retain profile_lock for profile operations and use it to protect an
> explicit list of handlers participating in the aggregate interface.
>=20
> Add a handler to that list only after device_register() succeeds. On
> removal, unlink it under profile_lock before calling device_unregister().
> Acquiring profile_lock first waits for any aggregate operation already
> using the handler to complete; unlinking prevents later aggregate
> operations from finding it. Release profile_lock before draining sysfs
> callbacks, allowing active per-provider callbacks to complete before the
> device is released. Apply the same unlink-before-unregister ordering to
> registration error cleanup.
>=20
> Walk this list for aggregate reads, writes and profile cycling, and use
> its emptiness to determine aggregate attribute visibility. The class
> devices remain the per-provider userspace interface.
>=20
> There can now be an interval between removing the last handler from the
> list and removing the aggregate attributes. Explicitly reject choices
> reads and writes during that interval: the intersection bitmap starts
> with every bit set, so an empty traversal must not advertise all profiles
> or report a successful write without updating a provider.
>=20
> This separates aggregate membership from class device teardown while
> preserving the existing class and ACPI sysfs interfaces.
>=20
> Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for regist=
er/unregister")
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
> Changes in v3:
>   - Send the locking fix as a standalone patch, independently of the
>     firmware-agnostic extraction and legacy-interface deprecation series.
>   - Document that profile_lock protects handler-list membership and
>     serializes profile operations against each other and handler removal.
>     Explain why it must not be held across sysfs teardown.
>=20
> Changes in v2:
>   - Expand the deadlock and handler-lifetime explanation.
>   - Add the Fixes tag and describe the earlier fix, regression and later
>     extension to class-device teardown and sysfs group updates.
>=20
>  drivers/acpi/platform_profile.c | 80 ++++++++++++++++++++++++-----------=
------
>  1 file changed, 47 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 79d2e92e5c28..d79080a20e21 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -8,15 +8,25 @@
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/init.h>
> +#include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> =20
>  #define to_pprof_handler(d)=09(container_of(d, struct platform_profile_h=
andler, dev))
> =20
> +/*
> + * Protects profile_handlers membership and serializes profile operation=
s
> + * against each other and handler removal. Never held across sysfs teard=
own,
> + * which can wait for callbacks that acquire this lock.
> + */
>  static DEFINE_MUTEX(profile_lock);
> +/* Serialize registration and sysfs updates without blocking sysfs callb=
acks. */
> +static DEFINE_MUTEX(profile_registration_lock);
> +static LIST_HEAD(profile_handlers);
> =20
>  struct platform_profile_handler {
> +=09struct list_head node;
>  =09const char *name;
>  =09struct device dev;
>  =09int minor;
> @@ -44,6 +54,22 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFOR=
M_PROFILE_LAST);
> =20
>  static DEFINE_IDA(platform_profile_ida);
> =20
> +static int profile_walk_handlers(void *data,
> +=09=09=09=09 int (*fn)(struct device *dev, void *data))
> +{
> +=09struct platform_profile_handler *handler;
> +=09int ret;
> +
> +=09lockdep_assert_held(&profile_lock);
> +=09list_for_each_entry(handler, &profile_handlers, node) {
> +=09=09ret =3D fn(&handler->dev, data);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
>  /**
>   * _commmon_choices_show - Show the available profile choices
>   * @choices: The available profile choices
> @@ -306,20 +332,18 @@ static ssize_t platform_profile_choices_show(struct=
 kobject *kobj,
>  =09int err;
> =20
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09    &data, _aggregate_choices);
> +=09=09err =3D profile_walk_handlers(&data, _aggregate_choices);
>  =09=09if (err)
>  =09=09=09return err;
>  =09=09if (data.count =3D=3D 1) {
> -=09=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09=09    &data, _remove_hidden_choices);
> +=09=09=09err =3D profile_walk_handlers(&data, _remove_hidden_choices);
>  =09=09=09if (err)
>  =09=09=09=09return err;
>  =09=09}
>  =09}
> =20
>  =09/* no profile handler registered any more */
> -=09if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
> +=09if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST=
))
>  =09=09return -EINVAL;
> =20
>  =09return _commmon_choices_show(data.aggregate, buf);
> @@ -384,8 +408,7 @@ static ssize_t platform_profile_show(struct kobject *=
kobj,
>  =09int err;
> =20
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09    &profile, _aggregate_profiles);
> +=09=09err =3D profile_walk_handlers(&profile, _aggregate_profiles);
>  =09=09if (err)
>  =09=09=09return err;
>  =09}
> @@ -423,15 +446,13 @@ static ssize_t platform_profile_store(struct kobjec=
t *kobj,
>  =09=09return -EINVAL;
> =20
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09ret =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09    &data, _aggregate_choices);
> +=09=09ret =3D profile_walk_handlers(&data, _aggregate_choices);
>  =09=09if (ret)
>  =09=09=09return ret;
> -=09=09if (!test_bit(i, data.aggregate))
> +=09=09if (!data.count || !test_bit(i, data.aggregate))
>  =09=09=09return -EOPNOTSUPP;
> =20
> -=09=09ret =3D class_for_each_device(&platform_profile_class, NULL, &i,
> -=09=09=09=09=09    _store_and_notify);
> +=09=09ret =3D profile_walk_handlers(&i, _store_and_notify);
>  =09=09if (ret)
>  =09=09=09return ret;
>  =09}
> @@ -450,22 +471,11 @@ static struct attribute *platform_profile_attrs[] =
=3D {
>  =09NULL
>  };
> =20
> -static int profile_class_registered(struct device *dev, const void *data=
)
> -{
> -=09return 1;
> -}
> -
>  static umode_t profile_class_is_visible(struct kobject *kobj, struct att=
ribute *attr, int idx)
>  {
> -=09struct device *dev;
> -
> -=09dev =3D class_find_device(&platform_profile_class, NULL, NULL, profil=
e_class_registered);
> -=09if (!dev)
> -=09=09return 0;
> -
> -=09put_device(dev);
> +=09guard(mutex)(&profile_lock);
>
> -=09return attr->mode;
> +=09return list_empty(&profile_handlers) ? 0 : attr->mode;
>  }
> =20
>  static const struct attribute_group platform_profile_group =3D {
> @@ -502,8 +512,7 @@ int platform_profile_cycle(void)
>  =09int err;
> =20
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09    &profile, _aggregate_profiles);
> +=09=09err =3D profile_walk_handlers(&profile, _aggregate_profiles);
>  =09=09if (err)
>  =09=09=09return err;
> =20
> @@ -512,8 +521,7 @@ int platform_profile_cycle(void)
>  =09=09    profile =3D=3D PLATFORM_PROFILE_LAST)
>  =09=09=09return -EINVAL;
> =20
> -=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> -=09=09=09=09=09    &data, _aggregate_choices);
> +=09=09err =3D profile_walk_handlers(&data, _aggregate_choices);
>  =09=09if (err)
>  =09=09=09return err;
> =20
> @@ -525,8 +533,7 @@ int platform_profile_cycle(void)
>  =09=09=09=09=09  PLATFORM_PROFILE_LAST,
>  =09=09=09=09=09  profile + 1);
> =20
> -=09=09err =3D class_for_each_device(&platform_profile_class, NULL, &next=
,
> -=09=09=09=09=09    _store_and_notify);
> +=09=09err =3D profile_walk_handlers(&next, _store_and_notify);
> =20
>  =09=09if (err)
>  =09=09=09return err;
> @@ -583,7 +590,7 @@ struct device *platform_profile_register(struct devic=
e *dev, const char *name,
>  =09=09}
>  =09}
> =20
> -=09guard(mutex)(&profile_lock);
> +=09guard(mutex)(&profile_registration_lock);
> =20
>  =09/* create class interface for individual handler */
>  =09minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> @@ -604,6 +611,8 @@ struct device *platform_profile_register(struct devic=
e *dev, const char *name,
>  =09=09put_device(ppdev);
>  =09=09goto cleanup_ida;
>  =09}
> +=09scoped_guard(mutex, &profile_lock)
> +=09=09list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
> =20
>  =09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> =20
> @@ -614,6 +623,8 @@ struct device *platform_profile_register(struct devic=
e *dev, const char *name,
>  =09return ppdev;
> =20
>  cleanup_cur:
> +=09scoped_guard(mutex, &profile_lock)
> +=09=09list_del(&to_pprof_handler(ppdev)->node);
>  =09device_unregister(ppdev);
> =20
>  cleanup_ida:
> @@ -636,7 +647,10 @@ void platform_profile_remove(struct device *dev)
> =20
>  =09pprof =3D to_pprof_handler(dev);
> =20
> -=09guard(mutex)(&profile_lock);
> +=09guard(mutex)(&profile_registration_lock);
> +
> +=09scoped_guard(mutex, &profile_lock)
> +=09=09list_del(&pprof->node);
> =20
>  =09ida_free(&platform_profile_ida, pprof->minor);
>  =09device_unregister(&pprof->dev);
>=20
> base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d
>=20
--8323328-1338216543-1792526631=:1177--
