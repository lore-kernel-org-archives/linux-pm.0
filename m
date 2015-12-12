From: Imre Deak <imre.deak@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce
 pm_runtime_get_noidle
Date: Sat, 12 Dec 2015 21:40:45 +0200
Message-ID: <1449949245.2815.20.camel@intel.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	 <2275921.by5gDRlTiV@vostro.rjw.lan> <11905299.HflTrQjrxk@vostro.rjw.lan>
	 <1824809.48ZhrgqXQF@vostro.rjw.lan>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60628 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbbLLTkx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Dec 2015 14:40:53 -0500
In-Reply-To: <1824809.48ZhrgqXQF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>

On Sat, 2015-12-12 at 02:51 +0100, Rafael J. Wysocki wrote:
> On Saturday, December 12, 2015 12:41:06 AM Rafael J. Wysocki wrote:
> > On Saturday, December 12, 2015 12:21:43 AM Rafael J. Wysocki wrote:
> > > On Friday, December 11, 2015 05:47:08 PM Imre Deak wrote:
> > > > On pe, 2015-12-11 at 16:40 +0100, Rafael J. Wysocki wrote:
> > > > > On Friday, December 11, 2015 02:54:45 PM Imre Deak wrote:
> > > > > > On to, 2015-12-10 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > > > > > On Thursday, December 10, 2015 11:20:40 PM Imre Deak
> > > > > > > wrote:
> > > > > > > > On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki
> > > > > > > > wrote:
> > > > > > > > > On Thursday, December 10, 2015 10:36:37 PM Rafael J.
> > > > > > > > > Wysocki
> >=20
> > [cut]
> >=20
> > >=20
> > > Yes, my suggested function can be written like this:
> > >=20
> > > bool pm_runtime_get_if_active(struct device *dev)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned log flag=
s;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool ret =3D fals=
e;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave=
(&dev->power.lock, flags);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev->power.ru=
ntime_status =3D=3D RPM_ACTIVE) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (atomic_inc_return(&dev->power.usage_c=
ount) >
> > > 1)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	ret =3D true;
> > > 		else
> > > 			atomic_dec(&dev->power.usage_count);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqre=
store(&dev->power.lock, flags);
> > > 	return ret;
> > > }
> > >=20
> > > but this is obviously racy with respect to anyone concurrently
> > > changing the
> > > usage counter.
> >=20
> > Somethng like this would be slightly more efficient:
>=20
> And below is a patch to implement the thing, compile-tested only.
>=20
> Please let me know if that's what you need.
>=20
> Thanks,
> Rafael
>=20
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: PM / runtime: Add new helper for conditional usage count
> incrementation
>=20
> Introduce a new runtime PM function, pm_runtime_get_if_in_use(),
> that will increment the device's runtime PM usage counter and
> return 'true' if its status is RPM_ACTIVE and its usage counter
> is greater than 0 at the same time ('false' will be returned
> otherwise).
>=20
> This is useful for things that should only be done if the device
> is active (from the runtime PM perspective) and used by somebody
> (as indicated by the usage counter) already and engaging the device
> otherwise would be overkill.
>=20
> Requested-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0Documentation/power/runtime_pm.txt |=C2=A0=C2=A0=C2=A0=C2=A05 +=
++++
> =C2=A0drivers/base/power/runtime.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A021 +++++++++++++++++++++
> =C2=A0include/linux/pm_runtime.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A05 +++++
> =C2=A03 files changed, 31 insertions(+)
>=20
> Index: linux-pm/drivers/base/power/runtime.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -966,6 +966,27 @@ int __pm_runtime_resume(struct device *d
> =C2=A0EXPORT_SYMBOL_GPL(__pm_runtime_resume);
> =C2=A0
> =C2=A0/**
> + * pm_runtime_get_if_in_use - Conditionally bump up the device's
> usage counter.
> + * @dev: Device to handle.
> + *
> + * Increment the device's runtime PM usage counter and return 'true'
> if its
> + * runtime PM status is RPM_ACTIVE and its usage counter is already
> different
> + * from zero at the same time.=C2=A0=C2=A0Otherwise, return 'false'.
> + */
> +bool pm_runtime_get_if_in_use(struct device *dev)
> +{
> +	unsigned long flags;
> +	bool retval;
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	retval =3D dev->power.runtime_status =3D=3D RPM_ACTIVE ?
> +		!!atomic_inc_not_zero(&dev->power.usage_count) :
> false;
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
> +

To me this looks ok:
Acked-by: Imre Deak <imre.deak@intel.com>

The original idea for this logic came from Chris so he may have some
comments.

Thanks,
Imre

> +/**
> =C2=A0 * __pm_runtime_set_status - Set runtime PM status of a device.
> =C2=A0 * @dev: Device to handle.
> =C2=A0 * @status: New runtime PM status of the device.
> Index: linux-pm/include/linux/pm_runtime.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -39,6 +39,7 @@ extern int pm_runtime_force_resume(struc
> =C2=A0extern int __pm_runtime_idle(struct device *dev, int rpmflags);
> =C2=A0extern int __pm_runtime_suspend(struct device *dev, int rpmflag=
s);
> =C2=A0extern int __pm_runtime_resume(struct device *dev, int rpmflags=
);
> +extern bool pm_runtime_get_if_in_use(struct device *dev);
> =C2=A0extern int pm_schedule_suspend(struct device *dev, unsigned int
> delay);
> =C2=A0extern int __pm_runtime_set_status(struct device *dev, unsigned=
 int
> status);
> =C2=A0extern int pm_runtime_barrier(struct device *dev);
> @@ -143,6 +144,10 @@ static inline int pm_schedule_suspend(st
> =C2=A0{
> =C2=A0	return -ENOSYS;
> =C2=A0}
> +static inline bool pm_runtime_get_if_in_use(struct device *dev)
> +{
> +	return true;
> +}
> =C2=A0static inline int __pm_runtime_set_status(struct device *dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0unsigned int status) {
> return 0; }
> =C2=A0static inline int pm_runtime_barrier(struct device *dev) { retu=
rn 0;
> }
> Index: linux-pm/Documentation/power/runtime_pm.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/Documentation/power/runtime_pm.txt
> +++ linux-pm/Documentation/power/runtime_pm.txt
> @@ -371,6 +371,11 @@ drivers/base/power/runtime.c and include
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- increment the device's usage counter,=
 run
> pm_runtime_resume(dev) and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return its result
> =C2=A0
> +=C2=A0=C2=A0bool pm_runtime_get_if_in_use(struct device *dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0- increment the device's usage counter and r=
eturn 'true' if its
> runtime PM
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status is 'active' and its usage=
 counter is greater than 0 at
> the same
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0time; return 'false' otherwise
> +
> =C2=A0=C2=A0=C2=A0void pm_runtime_put_noidle(struct device *dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- decrement the device's usage counter
> =C2=A0
>=20
