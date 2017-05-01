From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 06/14] power: max17042_battery: Add support for the
 STATUS property
Date: Mon, 1 May 2017 13:38:05 +0200
Message-ID: <20170501113805.tcdiaq2qamie2g7d@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwqrbnefgec4qwuz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57717 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756725AbdEALiJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:38:09 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--vwqrbnefgec4qwuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:51PM +0200, Hans de Goede wrote:
> Userspace prefers the driver having a status property over having to guess
> itself. Specifically this will properly make the GNOME3 UI (and likely
> others) properly show discharging / charging / full status, instead
> of always showing discharging as status.
>=20
> Note that in the case there is no charger driver supplying the max17042,
> then a status of unknown will get returned. At least upower treats
> this the same as not having a status attribute, so in this case nothing
> changes from a userspace pov.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--vwqrbnefgec4qwuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHh0ACgkQ2O7X88g7
+prKoBAAkKLrHHDu1+lOcVNs4O1vHRkzv3JKY8JVw/CWmqCFaSfn6B8R4sW+XK10
uXowdodiQjDLP8aEtavWcUTcvFXIKNhG8Z4NS+95srpbnSImGrEcYvDfOpP+z0IC
0ih2Y/8PQ7u+RM3ieDU0224uAgDSTx30B8nXIqQLqqworue+g+SBtEKugJMkPODz
w0vnhw3QxgDW5h2dcTa998ZSE83hEMsslCFDrTxrOGGab5hOiHqRzBlmgbNNXcc1
t1J0CzzVX16c3/4sbPW+nAd9JemKYyhFYBAooylhltT4bmSFR/atFJDDye0ot4QC
6RBKJ5Oc7S9CVYJgGEMECcLvW3eedmeR0VagmvWPktZsyjqiUdN8HMF234SL+zIt
5fRgQBkBpr80EgblOeYx1TUtttEh/Gpx63odauhlLXBufIyhxvT/youqLfhyHrip
+baBmJsgmh7e80dzrlIl7QaO7lOY7c7fNZ0qCaeYsLmBt6+UUGRWzNEwkByXxAHX
Zl6vswZgc352h+Mr+iK1e28awa8AHRd4hbmJxs9b92zeBTb7GiVwA4mwBUdzEAHJ
Ll2RqkjGNQ0brqNFkW0ky5JLKpHgYOaduuqkMMVEJdOY6hoEKvN+d1w7Vt/YEKQj
v6jH+3gnll6mR2zbPcdJhIFacASgWjorui6dnlfm9zpcpGGnV4c=
=4tnx
-----END PGP SIGNATURE-----

--vwqrbnefgec4qwuz--
