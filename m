From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power_supply: ab8500_fg: Simplify creation and
 removal of sysfs entries
Date: Wed, 25 Feb 2015 22:27:10 +0100
Message-ID: <20150225212709.GJ13695@earth>
References: <1422542379-8202-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44529 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbBYV1U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 16:27:20 -0500
Content-Disposition: inline
In-Reply-To: <1422542379-8202-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 29, 2015 at 03:39:38PM +0100, Krzysztof Kozlowski wrote:
> Simplify a little ab8500_fg_sysfs_psy_create_attrs () and
> ab8500_fg_sysfs_psy_remove_attrs() functions because they received
> pointer to power supply device which was then converted into power
> supply instance. Then it was converted into struct ab8500_fg. The path
> looked like:
> 	ab8500_fg->psy.dev -> psy -> ab8500_fg
>=20
> Instead just pass pointer to struct ab8500_fg directly so all
> conversions won't be necessary.

thanks, pulled into battery-2.6.git.

-- Sebastian

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7j4tAAoJENju1/PIO/qaADwQAJD8Gjkt7kvVTZs/WONxolZ0
Z2yrSzaggckGBAoXM8GPmypvafoByGX4wjdh5oo8CiVz2GqnktZYYDOk1DopwLig
ZMf9YffW+wlHVRo0PMXKzfM2d7wSCi/I3kMFtvuDvRYA+pWONzQIGMHA6D9kn3Vf
9Sjg/jS9lfiUYcUR9esXRQxdMv1CC5OA7QWg62HEN/xpeoRObILL92479G6PGU1e
FWntfnqdCEffQpbYOGgv3p0m0VLxKOCPwCkDSpu2OpCnQAglEbSy99tn9910Do0F
CYBjIyCq6bzK50X9HVzefRs40zxaSsJMU1esNY0jwR6K3oNMZdCaNIWHepyedqZh
tkoUg4BDHf99sCtPogPjiFQKIjpR9a/i3FO03L1KCnvtRqMYK6d6caCP18pg0Yku
/nIDTZgakJBLHAKL8y3mXa2kOVwvWxOYnPQqCu5YjFAJJUlA9hqI9ZWK1VsHu1E4
CPRZsUvXmCU4gJPNSyXvmvTLv7BC6zPNc5cWL9vnAAMB99UthN863zkXJgSL6s37
anAb+jKtnrm8oNE8v4HfbzW6Tb1oZntP/bN6WA78UjINBnh+pLexpoPz88i5qlQG
LVOrRRVmIEXx7TnBO/7IZrHvkJAO6UZ8fG9SxOxw20JFRnaPDSaht3zEvCB8hRqg
JHtfMAaTIPRDeaTukPKe
=csEP
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
