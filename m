From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/3] drivers:power:twl4030-charger: remove nonstandard max_current sysfs attribute
Date: Fri, 12 May 2017 10:07:21 +0200
Message-ID: <DB043E86-278D-44FB-A23E-1E8A0DA24BE1@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com> <38afc4e7faaeabb32f153a0956899fa8e97c1b3a.1492194356.git.hns@goldelico.com> <20170511223545.GB6780@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_2B5A6969-C748-476D-9B40-3B3D635CFCE7"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170511223545.GB6780@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail=_2B5A6969-C748-476D-9B40-3B3D635CFCE7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 12.05.2017 um 00:35 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> On Fri 2017-04-14 20:25:57, H. Nikolaus Schaller wrote:
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> You should explain how to obtain equivalent functionality without that
> attribute.

By using the standard attribute as defined here:

=
http://elixir.free-electrons.com/linux/latest/source/Documentation/power/p=
ower_supply_class.txt#L125

It was introduced by 6bb1d272d7c9f.

This patch 3/3 here was intended to follow right after the one that adds =
the
input_current_limit property where it is (partially) described.

=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3D3fb319c2cdcd10f775f4d4a05a7d12fa1a5679c1

But since the patches are broken apart now, we should indeed document =
this
explicitly in the commit message to avoid any confusion. I had already
planned that for the next patch version.

BR,
Nikolaus

>=20
> 									=
Pavel
>=20
>> ---
>> drivers/power/supply/twl4030_charger.c | 63 =
----------------------------------
>> 1 file changed, 63 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/twl4030_charger.c =
b/drivers/power/supply/twl4030_charger.c
>> index e70c4ed..e02e150 100644
>> --- a/drivers/power/supply/twl4030_charger.c
>> +++ b/drivers/power/supply/twl4030_charger.c
>> @@ -624,63 +624,6 @@ static irqreturn_t twl4030_bci_interrupt(int =
irq, void *arg)
>> 	return IRQ_HANDLED;
>> }
>>=20
>> -/*
>> - * Provide "max_current" attribute in sysfs.
>> - */
>> -static ssize_t
>> -twl4030_bci_max_current_store(struct device *dev, struct =
device_attribute *attr,
>> -	const char *buf, size_t n)
>> -{
>> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
>> -	int cur =3D 0;
>> -	int status =3D 0;
>> -	status =3D kstrtoint(buf, 10, &cur);
>> -	if (status)
>> -		return status;
>> -	if (cur < 0)
>> -		return -EINVAL;
>> -	if (dev =3D=3D &bci->ac->dev)
>> -		bci->ac_cur =3D cur;
>> -	else
>> -		bci->usb_cur_target =3D cur;
>> -
>> -	twl4030_charger_update_current(bci);
>> -	return n;
>> -}
>> -
>> -/*
>> - * sysfs max_current show
>> - */
>> -static ssize_t twl4030_bci_max_current_show(struct device *dev,
>> -	struct device_attribute *attr, char *buf)
>> -{
>> -	int status =3D 0;
>> -	int cur =3D -1;
>> -	u8 bcictl1;
>> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
>> -
>> -	if (dev =3D=3D &bci->ac->dev) {
>> -		if (!bci->ac_is_active)
>> -			cur =3D bci->ac_cur;
>> -	} else {
>> -		if (bci->ac_is_active)
>> -			cur =3D bci->usb_cur_target;
>> -	}
>> -	if (cur < 0) {
>> -		cur =3D twl4030bci_read_adc_val(TWL4030_BCIIREF1);
>> -		if (cur < 0)
>> -			return cur;
>> -		status =3D twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
>> -		if (status < 0)
>> -			return status;
>> -		cur =3D regval2ua(cur, bcictl1 & TWL4030_CGAIN);
>> -	}
>> -	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
>> -}
>> -
>> -static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
>> -			twl4030_bci_max_current_store);
>> -
>> static void twl4030_bci_usb_work(struct work_struct *data)
>> {
>> 	struct twl4030_bci *bci =3D container_of(data, struct =
twl4030_bci, work);
>> @@ -1118,14 +1061,10 @@ static int twl4030_bci_probe(struct =
platform_device *pdev)
>> 		dev_warn(&pdev->dev, "failed to unmask interrupts: =
%d\n", ret);
>>=20
>> 	twl4030_charger_update_current(bci);
>> -	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
>> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
>> 	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
>> 		dev_warn(&pdev->dev, "could not create sysfs file\n");
>> 	if (device_create_file(&bci->ac->dev, &dev_attr_mode))
>> 		dev_warn(&pdev->dev, "could not create sysfs file\n");
>> -	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
>> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
>>=20
>> 	twl4030_charger_enable_ac(bci, true);
>> 	if (!IS_ERR_OR_NULL(bci->transceiver))
>> @@ -1157,9 +1096,7 @@ static int __exit twl4030_bci_remove(struct =
platform_device *pdev)
>>=20
>> 	iio_channel_release(bci->channel_vac);
>>=20
>> -	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
>> 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
>> -	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
>> 	device_remove_file(&bci->ac->dev, &dev_attr_mode);
>> 	/* mask interrupts */
>> 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
>=20
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


--Apple-Mail=_2B5A6969-C748-476D-9B40-3B3D635CFCE7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZFW06AAoJEIl79TGLgAm6RGIQAJkhPKAH8rAhY2TAKaGJdvvG
RMErAs1APjh86CYrFJD+3z5tCi+t3bSrvcy68lcjb6bu9VdGgCuuKPfmRm+rbbPt
Rk6Uz3yGokORIRcBCh8yi+yDbwJgn9gtlBOz13EjW+i7ynmUpnqHejVF/59KGKzo
qYnyDDqBa12q+0CxvJRcbIlDZMCTBGBKdo4bBxUjvweudPRJKQmQuDiyrCIyES+P
f7T+r/9VFrixfdmXvWqBhXakjHfcrnaD01L5tUo8EJ0xxHk1Hk2k4Mz8nPiNvo9A
/D6afIzR3BeHUePGPTm9U2TK3IYTW7ln1jJFsOUvkbiXxnxAp1DXip6T3Qpx31VH
LZwjFsRVxMU/rEEqnZW82pVF4f9gCBu4H9Dx+u/63Xuk+eP9Ii6YK+8LgpyBHVAW
GaNKsX92CeOguaamT/BZDPSuo9JsYGumbn1/d1j4guWuUJzMmgCJRYE1Xx+pXlR/
S9StE5LzZU5S8b4/LCmKTDCPzY16h70g/HB/YJFwyexGahoWeXYVDCJd7wqmBJD4
tqInxyafvQBmyMJV0aOeV7zpHSLEnEPg84Qu2GTMtIbUAIAOxmF5QJSkjavvDIKF
N15Wy4w7EAxQn523/bBXzht4pYQV9wJEWZef0r2L1OiIMevmZK8jDHL3nGY7Gaa9
QXRLjO6e7K4qMlpoy9T4
=rsHw
-----END PGP SIGNATURE-----

--Apple-Mail=_2B5A6969-C748-476D-9B40-3B3D635CFCE7--
