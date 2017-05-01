From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3] power: Make power_supply_am_i_supplied return -ENODEV
 if there are no suppliers
Date: Mon, 1 May 2017 13:28:34 +0200
Message-ID: <20170501112834.n3k7jyp4imnrb6wa@earth>
References: <20170416153031.11531-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ipzz3ffnu2hwsodx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57638 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbdEAL2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:28:37 -0400
Content-Disposition: inline
In-Reply-To: <20170416153031.11531-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--ipzz3ffnu2hwsodx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 16, 2017 at 05:30:31PM +0200, Hans de Goede wrote:
> It is sensible to assume that the hardware actually always has a
> way of charging the battery so when power_supply_am_i_supplied does not
> find any suppliers, that does not mean that there are none, but simply
> that no power_supply-drivers are registered / bound for any suppliers for
> the supply calling power_supply_am_i_supplied.
>=20
> At which point a fuel-gauge driver calling power_supply_am_i_supplied()
> cannot determine whether the battery is being charged or not.
>=20
> Allow a caller of power_supply_am_i_supplied to differentiate between
> there not being any suppliers, vs no suppliers being online by returning
> -ENODEV if there are no suppliers matching supplied_to / supplied_from,
> which allows fuel-gauge drivers to return POWER_SUPPLY_STATUS_UNKNOWN
> rather then POWER_SUPPLY_STATUS_DISCHARGING if there are no suppliers.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--ipzz3ffnu2hwsodx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHG+EACgkQ2O7X88g7
+pqOZBAAqTu5eTEFT1wNb3SlrNLolNsQb987/Y/0WnaVz6LfeFrWHi7wtq2h/Tlc
HIrkaubGKQFcEXP0zOybNR/VFxbjR6YaAkvwXNHInxTBzNuyuVlsCSLHuVRoHJol
7KUlRC4Cu5ews74pmo50jUyzATlcatVXY3ajWemP6zQmvBGeVEWBgZkDWoTm/YPs
ESp5EG4nNV/LoDDRMq2DcNlDxcyxwuTzQ+FRwG92rZToEygnYLhWaKseZIiILvX5
aZejra5ul7UzWa/ZKk8W0HdXeHYdbqkOKHgBPwt7RWxzadj13LmiIOx+kZKvXr1j
WORLReyQlXoWRoRfUqEMP644fcfA3yyJS8HriHtU/8qKuGGAEnx6Fy4s9VHq2GV0
S5Jnmvx3jNeX6aC+l0i3rYKaa2zKEoRNEmUZbfcWAeyDJYZ50ZMG7PTKh/M2Wy21
1W/QmFpspfQvjQOtmOKnDH9mIfL1LG1NLxWCSluwnQure1Em0fGv2SIEF5gV79uJ
Rx5h5AwNfcy+D5Yj2HX+rdMYY8P+MR1eUQMf0pii9PnPjGQuBC5EWrpPqQeZyb+r
2gPHEHK6nua4ngDfL2Eo/NFkfcFVDBrA6/dIs6KVJ/ForW5G9tTSOu/zp6co1r1e
ig6QC+IMrmxkSjCFd/RTFhI9kyEZZ1oxcdkY1Vuqmja0wnT2JnY=
=FX0/
-----END PGP SIGNATURE-----

--ipzz3ffnu2hwsodx--
