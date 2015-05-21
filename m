From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC/RFT v2 0/2] power_supply: Fix NULL pointer dereference from
 uevent
Date: Thu, 21 May 2015 20:03:43 +0200
Message-ID: <20150521180343.GA9094@earth>
References: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56152 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbbEUSEE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 May 2015 14:04:04 -0400
Content-Disposition: inline
In-Reply-To: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 19, 2015 at 04:13:00PM +0900, Krzysztof Kozlowski wrote:
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Patch 2: fix invalid member used for container_of().
> 2. Patch 2: Replace WARN with pr_warn() in __power_supply_register()
>    if parent is missing.
>=20
>=20
> Description:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This is an idea to fix issue in bq27x00 driver (and probably in others)
> reported by H. Nikolaus Schaller [0].
>=20
> The fixes are marked RFC/RFT because:
> 1. I do not have bq27x00-like device. I confirmed this and tested on
>    modified drivers (max77693, ACPI AC). These drivers are not
>    impacted by the issue but one can easily adjust them to reproduce
>    the problem.
> 2. The first uevent coming from power_supply_register() is now
>    different because it won't contain device properties. I am
>    not sure how this impacts userspace.
>=20
> Comments are welcomed.

Queued to for-next and fixes. I will not sent it to Torvalds before
Sunday, so that it gets some testing in next.

-- Sebastian

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVXh38AAoJENju1/PIO/qan4AP/RgNrUrUZRRubtRRNiWmED+w
cVyshfZS48XxWP58o0+WKf7l9qsyesbiClZc7gm4qWRh6xzzGR57x5wCLmpOsUl+
yuLyMlEfv2ilFr972tadeUoQOkuEeaP60wS20S5cu9m61Kg8SYWD7giu2kvbIQ9c
GDU254owW16rC04AP0puhBc7pDW3SOeRIPM63fI3qomjA3Jy9QjKo9IKTqux0M6m
quy2cv7o79o84LsrdwvIBkdSBGCrzBw9+n4XJEXliQvrKyekEb2EiCWJUHPvmdKA
g4Xb7yU6Yp0Z9aveB5OVPEgCH6K5udzl+jXorL0OLj6lw8lAOx6HAOY13fdkWkmI
h1QKtof0emYJB37z+9iyKy7qCmMEBXb+3TDYpHVYOYLehHTKQKoYKhcYzu6Qphot
ENKUvRPcFwsE3u42g5d6PoOGYfyQGEkpG7rRu3pevpakXIiRPMmoENJvwhG9l5Np
3CpstAJQ0SDGurQFBuHTL4GwbtsCvAKwWEEznymXea1nu5vxH1t100At46w+lApH
nsbNKY45gBK+wyELKRsAOzovXXiWj4+gQ7E2TRN2kPzTR/YkOl/yOyu6IFdF3ctE
0uKrav/TJ08Q83Rzw4+ao/OVHFhVxrHcXBCrqM+rxKUrx/34iNbBv5RcbAaSPjRR
2Q4be6WbKEd9mlcWxV0B
=c/+N
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
