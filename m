From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Fri, 7 Oct 2016 20:49:10 +0200
Message-ID: <20161007184910.GF19976@amd>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56591 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbcJGStN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 14:49:13 -0400
Content-Disposition: inline
In-Reply-To: <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-09-16 20:42:54, Matt Ranostay wrote:
> Allow the poll_interval to be runtime configurable via an sysfs entry.
> This is needed for udev control of the poll interval.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>

working mail address would be nice here.

sysfs files should be documented.

Also... what is it good for?

Do you have a device that needs non-standard interval?
									Pavel

> ---
>  drivers/power/supply/bq27xxx_battery.c | 48 ++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 3f57dd54803a..955424e10ae2 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -395,6 +395,36 @@ module_param(poll_interval, uint, 0644);
>  MODULE_PARM_DESC(poll_interval,
>  		 "battery poll interval in seconds - 0 disables polling");
> =20
> +
> +static ssize_t show_poll_interval(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", poll_interval);
> +}
> +
> +static ssize_t store_poll_interval(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t size)
> +{
> +	struct bq27xxx_device_info *di =3D dev_get_drvdata(dev);
> +	int tmp =3D poll_interval;
> +
> +	if (sscanf(buf, "%d\n", &poll_interval) !=3D 1)
> +		return -EINVAL;
> +
> +	if (poll_interval < 0)
> +		return -EINVAL;
> +
> +	if (tmp !=3D poll_interval) {
> +		cancel_delayed_work_sync(&di->work);
> +		schedule_delayed_work(&di->work, 0);
> +	}
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR(poll_interval, 0644, show_poll_interval, store_poll_i=
nterval);
> +
>  /*
>   * Common code for BQ27xxx devices
>   */
> @@ -946,6 +976,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info =
*di)
>  {
>  	struct power_supply_desc *psy_desc;
>  	struct power_supply_config psy_cfg =3D { .drv_data =3D di, };
> +	int ret;
> =20
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
> @@ -961,11 +992,19 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  	psy_desc->num_properties =3D bq27xxx_battery_props[di->chip].size;
>  	psy_desc->get_property =3D bq27xxx_battery_get_property;
>  	psy_desc->external_power_changed =3D bq27xxx_external_power_changed;
> +	dev_set_drvdata(di->dev, di);
> +
> +	ret =3D sysfs_create_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
> +	if (ret) {
> +		dev_err(di->dev, "failed to register poll_interval sysfs entry");
> +		return ret;
> +	}
> =20
>  	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(di->bat)) {
>  		dev_err(di->dev, "failed to register battery\n");
> -		return PTR_ERR(di->bat);
> +		ret =3D PTR_ERR(di->bat);
> +		goto err_out;
>  	}
> =20
>  	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
> @@ -973,6 +1012,11 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  	bq27xxx_battery_update(di);
> =20
>  	return 0;
> +
> +err_out:
> +	sysfs_remove_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
> =20
> @@ -988,6 +1032,8 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_=
info *di)
> =20
>  	cancel_delayed_work_sync(&di->work);
> =20
> +	sysfs_remove_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
> +
>  	power_supply_unregister(di->bat);
> =20
>  	mutex_destroy(&di->lock);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf37iYACgkQMOfwapXb+vLvJgCfe4NSLBPrx6x4Nb7S4SShiE8q
3GEAn0LWMIsCW4XyzN+PNSzc+0y8F+mu
=q2Gc
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
