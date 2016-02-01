From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] PM: Avoid false-positive warnings in dev_pm_domain_set()
Date: Mon, 01 Feb 2016 16:15:44 +0200
Message-ID: <1454336144.32507.15.camel@linux.intel.com>
References: <80793506.EZRY3UmSeu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80793506.EZRY3UmSeu@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2016-01-30 at 12:54 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> There is a WARN_ON() in dev_pm_domain_set() that triggers on attempts
> to set the pm_domain pointer for devices with a driver bound.
>=20
> However, that WARN_ON() triggers on attempts to clear the pointer
> too and the test it uses is based on checking the device's
> p->knode_driver pointer which still is set when the device bus
> type's/driver's ->remove callback has been executed.=C2=A0=C2=A0This
> leads to false-positive warnings when bus type code calls
> dev_pm_domain_set() to clear the pm_domain pointer after
> invoking the driver's ->remove() callback.
>=20
> To avoid those false-positives, make dev_pm_domain_set() check
> if the pointer passed to it is NULL and skip the warning in
> that case.

Tested on Intel Braswell where modprobe -r sdhci-acpi caused a warning
before this patch.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>=20
> Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/base/power/common.c |=C2=A0=C2=A0=C2=A0=C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-pm/drivers/base/power/common.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/power/common.c
> +++ linux-pm/drivers/base/power/common.c
> @@ -146,7 +146,7 @@ void dev_pm_domain_set(struct device *de
> =C2=A0	if (dev->pm_domain =3D=3D pd)
> =C2=A0		return;
> =C2=A0
> -	WARN(device_is_bound(dev),
> +	WARN(pd && device_is_bound(dev),
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"PM domains can only be changed =
for unbound
> devices\n");
> =C2=A0	dev->pm_domain =3D pd;
> =C2=A0	device_pm_check_callbacks(dev);
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
