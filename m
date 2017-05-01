From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 12/14] power: max17042_battery: Add support for the
 CHARGE_NOW property
Date: Mon, 1 May 2017 13:40:53 +0200
Message-ID: <20170501114053.mqd6hqw4gnfumjnd@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uzc2ctgxx4vn5dym"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57743 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932951AbdEALk4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:40:56 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-12-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--uzc2ctgxx4vn5dym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:57PM +0200, Hans de Goede wrote:
> Atleast upower prefers the more precise charge_now sysfs value over
> capacity and the max17042 has the info, so lets export it.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--uzc2ctgxx4vn5dym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHsQACgkQ2O7X88g7
+ppfPxAAmujXG4qSz9F1cHXDcyYwcV+uZQcnmohpSlxH/RjCGUAhGyPht9W5oBHc
P2ASKP2h9VYGbqOoh2yl9dGOtjOxnsc82KJis2z8zjJqFe04xaGouadza6Mrysc6
osfsY3OraH8BTVVR/YpjDLhpCH0uiP40+/mgkkaFqEdvsG0kq2bXp6azHPBdSZBL
oalTOX4+qfp4kciqSyF6J2ERuBT8wwH9l56avzCjThPl9vt31XRI0p7Wl61Bp76A
Jx2tkBZg+LptC7dGVxiTCz2uHUzRn+yI+XDzkaRLtsJVPLkEx1L8HYOC9q0QBv+m
zXtFivb7zFiZzn/vRRmMbTcGYp/+5meSYvfEo00RZX7zRE7qh3MyXzpTi/ot2tlW
79V1OfGCj9fZ3vP3kak3sbxikmSV8uPMhBr7fSiNwTsj14+fQUHgEeiqZ2NprKg+
QJk5rKUtmfkdv/f5QS/ZGNQ5FDS8Cdupb6ddZ0DFzn07n5HGLz2ceywCJjWZUH59
31KmMNTW9xPNeb3nr3FeX3TDASs7583MMlmlMGJfpdqvNp8VOVkhY1vSV3pGJPlm
dGuKwVtlqH/zOtGVF0UARhWmDewbt6iFVjskuvqrX8l2v6TFQFz1Zkea2qmkMk2O
RR41Pvb4kRjzQGcNJ4xJJEDFCqula7mVaO2Rrk5JLz5pRDEo6ac=
=FY+x
-----END PGP SIGNATURE-----

--uzc2ctgxx4vn5dym--
