From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] drivers:power:twl4030-charger: remove nonstandard
 max_current sysfs attribute
Date: Fri, 12 May 2017 00:35:47 +0200
Message-ID: <20170511223545.GB6780@amd>
References: <cover.1492194356.git.hns@goldelico.com>
 <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32880 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755850AbdEKWfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 18:35:50 -0400
Content-Disposition: inline
In-Reply-To: <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-04-14 20:25:57, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

You should explain how to obtain equivalent functionality without that
attribute.

									Pavel

> ---
>  drivers/power/supply/twl4030_charger.c | 63 ----------------------------=
------
>  1 file changed, 63 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index e70c4ed..e02e150 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -624,63 +624,6 @@ static irqreturn_t twl4030_bci_interrupt(int irq, vo=
id *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> -/*
> - * Provide "max_current" attribute in sysfs.
> - */
> -static ssize_t
> -twl4030_bci_max_current_store(struct device *dev, struct device_attribut=
e *attr,
> -	const char *buf, size_t n)
> -{
> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> -	int cur =3D 0;
> -	int status =3D 0;
> -	status =3D kstrtoint(buf, 10, &cur);
> -	if (status)
> -		return status;
> -	if (cur < 0)
> -		return -EINVAL;
> -	if (dev =3D=3D &bci->ac->dev)
> -		bci->ac_cur =3D cur;
> -	else
> -		bci->usb_cur_target =3D cur;
> -
> -	twl4030_charger_update_current(bci);
> -	return n;
> -}
> -
> -/*
> - * sysfs max_current show
> - */
> -static ssize_t twl4030_bci_max_current_show(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	int status =3D 0;
> -	int cur =3D -1;
> -	u8 bcictl1;
> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> -
> -	if (dev =3D=3D &bci->ac->dev) {
> -		if (!bci->ac_is_active)
> -			cur =3D bci->ac_cur;
> -	} else {
> -		if (bci->ac_is_active)
> -			cur =3D bci->usb_cur_target;
> -	}
> -	if (cur < 0) {
> -		cur =3D twl4030bci_read_adc_val(TWL4030_BCIIREF1);
> -		if (cur < 0)
> -			return cur;
> -		status =3D twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
> -		if (status < 0)
> -			return status;
> -		cur =3D regval2ua(cur, bcictl1 & TWL4030_CGAIN);
> -	}
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
> -}
> -
> -static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
> -			twl4030_bci_max_current_store);
> -
>  static void twl4030_bci_usb_work(struct work_struct *data)
>  {
>  	struct twl4030_bci *bci =3D container_of(data, struct twl4030_bci, work=
);
> @@ -1118,14 +1061,10 @@ static int twl4030_bci_probe(struct platform_devi=
ce *pdev)
>  		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
> =20
>  	twl4030_charger_update_current(bci);
> -	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(&bci->ac->dev, &dev_attr_mode))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> -	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
> =20
>  	twl4030_charger_enable_ac(bci, true);
>  	if (!IS_ERR_OR_NULL(bci->transceiver))
> @@ -1157,9 +1096,7 @@ static int __exit twl4030_bci_remove(struct platfor=
m_device *pdev)
> =20
>  	iio_channel_release(bci->channel_vac);
> =20
> -	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
>  	device_remove_file(&bci->usb->dev, &dev_attr_mode);
> -	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
>  	device_remove_file(&bci->ac->dev, &dev_attr_mode);
>  	/* mask interrupts */
>  	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkU50EACgkQMOfwapXb+vK4+ACfUgzrL/mWZVEMZWvOR2A+mH5o
EEwAoICA+2YzfcD1MuGbWqy9CkcBvcs2
=FlRo
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
