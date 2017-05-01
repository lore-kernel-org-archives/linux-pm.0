From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 08/14] power: max17042_battery: Add support for the
 TECHNOLOGY attribute
Date: Mon, 1 May 2017 13:39:05 +0200
Message-ID: <20170501113905.vz4ls7frtmlhtiku@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrzmi5ll5ifjbp6z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57726 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdEALjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:39:08 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-8-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--nrzmi5ll5ifjbp6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:53PM +0200, Hans de Goede wrote:
> The max17042 is intended for Li-Ion or Li-Po batteries, add a TECHNOLOGY
> attribute to reflect this. Note this is hardcoded to Li-Ion as there is
> no way to tell the difference, and Lithium-Ion Polymer batteries are
> a sub-family of Lithium-Ion so Li-Ion technically is correct for both.
>=20
> Using Li-Ion for both is already done by many drivers and is much
> better then not providing any technology info at all.
>=20
> Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--nrzmi5ll5ifjbp6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHlkACgkQ2O7X88g7
+pqlMw/6AppeH8QKRwP+yuc4bZSOOp8Zta5Vmhy9wmgDiexxoy0x1qsgT3+x8Afd
u9bg/pR7gikXsPyyP/qLOx5Q/TJoixt058swb7bwGq7oh816p5WAuq4xZzAzNu7H
pYdrE85SNJ6TVCwsCgqIMJ/bMIFNA0W33umjn7dgArgRTu3wbN/3hn+dCz2/ksnZ
frPm5eVhwfF7ymlWIwqTxoafM5ROvTQ9O5SIL9x4Eb8SSBamIJYkai82nJIiBDzW
K5nRdnpV8l636VjVBEi3e540vcRzgWVwfUScxmT7MiyqNq3+mudg7SpA/IFB+I1M
Rcw7gSQ7eNE4LcnXTnxKGZrYWY7vp/1WWzr+BZJMN7v2dUvnxISJ+7qyMKvNKPGh
7Z2bo9CkHRkj6o5vR+EkCcSNsT235MAl3eGasDu74M3T21nWekE3xXT1U01lVaIR
fcBP23BMiP7TKlUQeARBaHITYBDCun/zwlGY7MdYAiSYpfvrcv3rlmQmS3waIoY8
Bwuy66QZQHaZQ6RKKgqsORXRcS6HSn9/8O6XVA3OwSXJ02yRgf4eCsGWguEw4YG7
BDUVR6RmtEKBExmNll8AijF/d93XHNwGXFPyLPkgf5Q+OGFqOUvjbaknOePwN2Hc
uxmg40/lNnsgDBgMksXHHLRVpYkYAjxmGD2fFf4GGZmxuQTW1cI=
=cwyc
-----END PGP SIGNATURE-----

--nrzmi5ll5ifjbp6z--
