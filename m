Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BCC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 28 Jan 2021 00:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935D064DCC
	for <linux-pm@archiver.kernel.org>; Thu, 28 Jan 2021 00:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhA1Ab3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Jan 2021 19:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhA1Aa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:30:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10AC061573
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 16:30:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 48AEE1F44542
Received: by earth.universe (Postfix, from userid 1000)
        id 135BB3C0C97; Thu, 28 Jan 2021 01:30:12 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:30:11 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jian Dong <dj0227@163.com>
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] power-supply: Constify static psy_tzd_ops struct
Message-ID: <20210128003011.vo5hprxjbyba7xpn@earth.universe>
References: <20210120095427.10592-1-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4luki2y22xgpagsz"
Content-Disposition: inline
In-Reply-To: <20210120095427.10592-1-dj0227@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4luki2y22xgpagsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 20, 2021 at 05:54:26PM +0800, Jian Dong wrote:
> From: dongjian <dongjian@yulong.com>
>=20
> The usage of this struct is to assign operation function's address
> to the field in thermal_zone_device_ops, it is a const pointer.
> make it const to allow the compiler to put it in read-only memory.
>=20
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---

As pointed out by the static checkers, you need to add const support
to the thermal framework first (i.e. making sure, that=20
thermal_zone_device_register takes a const pointer as argument).
Once that has happened I will gladly apply this change.

Thanks,

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 38e3aa64..ae34856 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -952,7 +952,7 @@ static int power_supply_read_temp(struct thermal_zone=
_device *tzd,
>  	return ret;
>  }
> =20
> -static struct thermal_zone_device_ops psy_tzd_ops =3D {
> +static const struct thermal_zone_device_ops psy_tzd_ops =3D {
>  	.get_temp =3D power_supply_read_temp,
>  };
> =20
> --=20
> 1.9.1
>=20
>=20

--4luki2y22xgpagsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASBY0ACgkQ2O7X88g7
+pre2g//fT9/08TrdYZKjwheY1j/P18KjJYcawPQR1F82PNiYdVwTT+J1kbhMATE
IeGL1uh3VcAWAqNA9KYhjYSyG/tl8CA40SG/zNZWUiZpcEwzznWnIfo45lMzCBSO
gEWdKP9XljJRSxp/WyvbJ20ODWZuituErReiehxG28jwyeipK0eJ5JoAth9ijDBM
IsJ/9mwHvFxh6cJDuld5ktTM/+bBYrHUDrjlOMep+9yEskUsOqgXEsvWnp+g4+bj
5An10c0pZ2r/T2tRLe4o+G2lw+MulfNiBjNFTyjf9oDK5mko9PkxGXUcmbWBVPKg
U0gtQh5sn19osEzEAfxkegPoQ8EO+2ZG+ef2Q7xvggzbh2RM6hquhtp/v9MRCHPn
5AOrVU/MQvSpY9SUE129XmCCspX1r1gOK2BsUXp2BZL7VuxjZ5TLa+qyxDDTNzgO
D8BVRfpLj3T1AShB7Eo5HLRCnWq/M7bxe59klipJKZyl2aJnHwxHuekt0g06v9nz
u8mzKgLdYULwjO3dsyWoI2OFx6UD6qJkiRwfVzao2lAdIuZ9E1Swyo+aWrSDRWxu
ve9qLA5+SXRg8E22NngIeKaKaNT8I8INlczl3rIsbmdALQT2veNVCorag0DnGbXU
8SHo3e+FTdo+fpya8kxHz5iQh6gjxumNYU+KQFbDWfe0aGgAulM=
=CuIy
-----END PGP SIGNATURE-----

--4luki2y22xgpagsz--
