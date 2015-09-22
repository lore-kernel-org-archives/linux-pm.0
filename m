From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 00/11] power: bq24257: Add support for bq24250/bq24251
Date: Tue, 22 Sep 2015 21:31:14 +0200
Message-ID: <20150922193113.GC9949@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45341 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757828AbbIVTbY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 15:31:24 -0400
Content-Disposition: inline
In-Reply-To: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 18, 2015 at 04:39:48PM -0500, Andreas Dannenberg wrote:
> This patch series extends the driver to also support bq24250/bq24251.
>=20
> The bq24250/251/257 devices have a very similar feature set and are
> virtually identical from a control register point of view so it made
> sense to extend the existing driver rather than submitting a new driver.
> In addition to the new device support the driver is also extended to
> allow access to some device features previously hidden. Basic and
> potentially dangerous charger config parameters affecting the actual
> charging of the Li-Ion battery are only configurable through firmware
> rather than sysfs properties. However some newly introduced properties
> are exposed through sysfs properties as access to them may be desired
> from userspace. For example, it is now possible to manually configure
> the maximum current drawn from the input source to accommodate different
> chargers (0.5A, 1.5A, 2.0A and so on) based on system knowledge a
> userspace application may have rather than rely on the auto-detection
> mechanism that may not work in all possible scenarios.
>=20
> Note that most patches have dependencies on other patches in the series.

Please document the custom sysfs files in Documentation/ABI/.

-- Sebastian

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAayBAAoJENju1/PIO/qaguAQAKGYFTDzoxUXKp6AkaSt6q0G
Z+DYHTQzI78sMhm4XkSC+ZGL7gVpJgIhjG7gwq/8o8kO0tV7+RhW3T8becTKqP/e
UVIqdDGnhZ/IgS6/XExSpuZ8dlT/oGcyMp4+siiBvrXGl55PuWdInXQgmueYTdhm
ngn58i9ITFogbyOu3DEcExrBwCvsVXcqfS8L3eJMQ8boCtsF3Ftx3kWvgck3sHVA
wLs8nzejVBuEAG9DmQVJKjuD+mgAapcduO4ECKto6GXyNuW6ES7g/38t+ZhfKK+y
+XTHFjuk91MirU5HkKgwlB8NalMfRG5yxy1I1BALb/iWJ3sbxiBWB9w8ycrE8vIv
3xhcqxavh0RnDP/zsRB04jVqAoaYWyALqkGyEKz+QAtd9CnygFcmIWemtYfZUgr7
YozsSY4FybtLPjfhn4L3O4LHlNx0UJR0UJugpJBhhJ42PyqB16wQKdnGRXFzKHWW
OPHMVaajncIq0ZQiGICM2f/L5UaicC8hO/lpUojZbFKK3BKc/TJLp62QrwIgT5uy
4naRs3gJFPGiHKYS38DTKty6DS/01be7qOSfPI9H/qUxJGEE3RKsWb2EzMGKiwvQ
JlmvFEA5SoZDCc9tzumOTATDMtsO1rbYLluq/teXxGyZg5xhhf/JMIBT2gXOmG0w
f8jvwP9B4dofHsZN019f
=LQm9
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
