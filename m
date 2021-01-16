Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A49C433DB
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C162311F
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 11:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbhAPLib (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Jan 2021 06:38:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhAPLia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 06:38:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 205A81F458E8
Received: by earth.universe (Postfix, from userid 1000)
        id 5C8A33C0C94; Sat, 16 Jan 2021 12:37:46 +0100 (CET)
Date:   Sat, 16 Jan 2021 12:37:46 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ds2780: Switch to using the new API
 kobj_to_dev()
Message-ID: <20210116113746.e7gtlmblvsolygc2@earth.universe>
References: <1607994024-32199-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="whse6vmqu653lut3"
Content-Disposition: inline
In-Reply-To: <1607994024-32199-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--whse6vmqu653lut3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 15, 2020 at 09:00:24AM +0800, Tian Tao wrote:
> fixed the following coccicheck:
> drivers/power/supply/ds2780_battery.c:627:60-61: WARNING opportunity for
> kobj_to_dev()
> drivers/power/supply/ds2780_battery.c:672:60-61: WARNING opportunity for
> kobj_to_dev()
> drivers/power/supply/ds2780_battery.c:640:60-61: WARNING opportunity for
> kobj_to_dev()
> drivers/power/supply/ds2780_battery.c:685:60-61: WARNING opportunity for
> kobj_to_dev()
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ds2780_battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply=
/ds2780_battery.c
> index dd57a47..2b8c90d 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -624,7 +624,7 @@ static ssize_t ds2780_read_param_eeprom_bin(struct fi=
le *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2780_device_info *dev_info =3D to_ds2780_device_info(psy);
> =20
> @@ -637,7 +637,7 @@ static ssize_t ds2780_write_param_eeprom_bin(struct f=
ile *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2780_device_info *dev_info =3D to_ds2780_device_info(psy);
>  	int ret;
> @@ -669,7 +669,7 @@ static ssize_t ds2780_read_user_eeprom_bin(struct fil=
e *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2780_device_info *dev_info =3D to_ds2780_device_info(psy);
> =20
> @@ -682,7 +682,7 @@ static ssize_t ds2780_write_user_eeprom_bin(struct fi=
le *filp,
>  				struct bin_attribute *bin_attr,
>  				char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D to_power_supply(dev);
>  	struct ds2780_device_info *dev_info =3D to_ds2780_device_info(psy);
>  	int ret;
> --=20
> 2.7.4
>=20

--whse6vmqu653lut3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC0AUACgkQ2O7X88g7
+prqlhAAi0RthW4Ac5Mw1MsiSP1Qv1Xm9hxMEshztQd3w0za/AgKTVaHf4QZylrS
Tt08CUwKDF1HDolnQjEtuLi2cLwYMrCbbCuwyUpL7FVexYc3JaiYjd4wrxgU1sN7
U8D4EIr4PZe0mi5joFG3uAPRdW7Xvu49dWZoeVNbdTueBiQwsllXw38lkSPOtbz4
59oASOPiFjJVhdLSEj0tyoUlQw6oEA+niU0d405d38bK14Z4RjjkU4Kfipk/8Pfj
xNz3SuX8xE1OZlH6Qux8YAERFcZOuF864rPMiLlyBHdOxmIUpZBujyko5cSWuB9h
iq/i+26AJOa4A41dRBAwh1hMJA1fyPGdfNW6MN2zawnATdSjovpDdmJ6OKie870q
Ok9tVCPsEGyTKF2iifyJeTDG81L3gNNONbNLpFRdhzeippYaudjUHZuehBKOrHK9
atctXuXSkjBzuUXpBtFdtpkRvV7dlwzuirJ0cpj9vFz7/ZGBhX86rmKZF/xFe9AN
BkFEkIde2aTAhzt3wsATPyYKnNlaCSWOwtET/XxsYm5Ldi4l9b6kj3ui42y0URdf
hq3mF6K2uPw+RfuF5PwAvLapy9cx5PGHf1giaKYYWUjX4Wj6TwHflgQYz9335gio
V+HZKD4lOSqDDq9ZcV/hkcPd21Xf4WYgm4XpR7W9Upo+wze/kQ8=
=woPi
-----END PGP SIGNATURE-----

--whse6vmqu653lut3--
