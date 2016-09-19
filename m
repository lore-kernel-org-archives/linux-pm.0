From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: bq27xxx_battery: allow kernel poll_interval
 parameter runtime update
Date: Mon, 19 Sep 2016 21:49:31 +0200
Message-ID: <20160919194930.ki7u5levbc4mnjvm@earth>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-3-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nkuf52fx6fjs4i6m"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbcISTti (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:49:38 -0400
Content-Disposition: inline
In-Reply-To: <1474083775-30185-3-git-send-email-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>


--nkuf52fx6fjs4i6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 16, 2016 at 08:42:55PM -0700, Matt Ranostay wrote:
> Fix issue with poll_interval being not updated till the previous
> interval expired.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 38 ++++++++++++++++++++++++++++=
+++++-
>  include/linux/power/bq27xxx_battery.h  |  1 +
>  2 files changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 955424e10ae2..96fd3eec98da 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -39,6 +39,7 @@
> =20
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/param.h>
>  #include <linux/jiffies.h>
>  #include <linux/workqueue.h>
> @@ -390,8 +391,35 @@ static struct {
>  	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
>  };
> =20
> +static DEFINE_MUTEX(param_lock);
> +static LIST_HEAD(bq27xxx_battery_devices);
> +
> +static int poll_interval_param_set(const char *val, const struct kernel_=
param *kp)
> +{
> +	struct bq27xxx_device_info *di;
> +	int ret;
> +
> +	ret =3D param_set_uint(val, kp);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&param_lock);
> +	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
> +		cancel_delayed_work_sync(&di->work);
> +		schedule_delayed_work(&di->work, 0);
> +	}
> +	mutex_unlock(&param_lock);
> +
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops param_ops_poll_interval =3D {
> +	.get =3D param_get_ushort,

param_get_uint?

> +	.set =3D poll_interval_param_set,
> +};
> +
>  static unsigned int poll_interval =3D 360;
> -module_param(poll_interval, uint, 0644);
> +module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval,=
 0644);
>  MODULE_PARM_DESC(poll_interval,
>  		 "battery poll interval in seconds - 0 disables polling");
> =20
> @@ -1011,6 +1039,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_in=
fo *di)
> =20
>  	bq27xxx_battery_update(di);
> =20
> +	mutex_lock(&param_lock);
> +	list_add(&di->list, &bq27xxx_battery_devices);
> +	mutex_unlock(&param_lock);
> +
>  	return 0;
> =20
>  err_out:
> @@ -1036,6 +1068,10 @@ void bq27xxx_battery_teardown(struct bq27xxx_devic=
e_info *di)
> =20
>  	power_supply_unregister(di->bat);
> =20
> +	mutex_lock(&param_lock);
> +	list_del(&di->list);
> +	mutex_unlock(&param_lock);
> +
>  	mutex_destroy(&di->lock);
>  }
>  EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index b50c0492629d..e30deb046156 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -58,6 +58,7 @@ struct bq27xxx_device_info {
>  	unsigned long last_update;
>  	struct delayed_work work;
>  	struct power_supply *bat;
> +	struct list_head list;
>  	struct mutex lock;
>  	u8 *regs;
>  };

Looks fine otherwise. When you redo the patch it would be nice to
rename param_lock into something like bq27xxx_list_lock instead,
though.

-- Sebastian

--nkuf52fx6fjs4i6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4EFKAAoJENju1/PIO/qaM8wQAJxgErBD2oebCbC8Ss0TluU3
zieD9i3Gs90pJbS5Ww3m+8kkK7+6Z9f3rfLFGdyFw78Lfb77ICTMUa3cNbfyf04s
pwugjFnH2kGWA8Ow1bxYbfU5OQTu5CRpwhCFTg8BpkZw1/E/35J6Tup+u19hiAnF
UOTy5KYhSwLGK1Cvu8tx6lT1hVYhBsafqvdMfN1sncW92idaUHzK9b6yq7/PwiUI
iPaT5Ks4038uH5oN04paMLvWdGZ9vUt2qx94SV7/aibCZcUH5fP1jSXlqCo+L5sY
eJN8IeXOnz2Qqw2JM/CgFnV2L2Cn6eQWW3J8sCFdhTNMzs4UEIBjM6satczAYyd+
Bm+YBF0Qw2/TVjpUz6ZfQN04rI2oumQDkR6QAxpcXDfPdw/xaMViwHSFNAz9NHHE
sOzrEEsSK5IASDOhontvy9Pv3WgK2G2SU3xBtm34fx+pWjTLfxpZnKuJnDXGwBUL
5TeZRo+H4SpAq8MGQdrBx07QUlaADIRPuw3hi63z14rdcK78oYm8QB+04DPj9R+0
Clkjt7gfLEH6myP4cdxYoldgSTMuJKgLOXIzTHdaA5GK9WhwFnMAcmAEMQedkKFP
7RC3jMwSL7Cbt38olKGtp3c42vOYlq7wCtu+8ALOkpKPrQkFJCG8AoOT2TPMRzlk
4Ot8OigaUOv3pA2Lhcur
=2V6i
-----END PGP SIGNATURE-----

--nkuf52fx6fjs4i6m--
