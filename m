From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] fix handling bq27xxx_read result
Date: Mon, 28 Sep 2015 18:34:22 +0200
Message-ID: <20150928163419.GC3660@earth>
References: <1443430287-575-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41283 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933821AbbI1Qec (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 12:34:32 -0400
Content-Disposition: inline
In-Reply-To: <1443430287-575-1-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 28, 2015 at 10:51:27AM +0200, Andrzej Hajda wrote:
> The function can return negative value.
>=20
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>=20
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, queued with some bits from Dan Carpenter's patch
description.

-- Sebastian

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWCWwLAAoJENju1/PIO/qadSMP/33joNGT7ktLzYKtYrPoR6/s
z+UL8IMmE64Of8x2NXjuyaxZp6sYvEQWY8Kzvg8iGFynPpyfsoVKuegj7yGdnN+Q
39mEWtZOaJVQJJid/lf1FpTzeQE0R1nse7TidA+CpHgYGiZWt/tPeZ83wXWGQcK0
Vmtcpz0uC0/c01sFcQRa5YZZJX5TLYedyksz2qVhc+UFQPe2EipiK6CqaP7rG63s
MTKnkCIpNxal7HR5vPuuAYVKehlGkjO3K5qNrS/0EmkWZJCB6wNIaqv2fcSho++k
tGFrkCHhxVu2SJ3PldCvNga6ynxxi6T3Lj2C2KgHfqPnFhKZPl8ts16CXOYr6paI
NSPzS8e5B9Eiyr2RYU7hQbreKMo5iem99ncRU4sfpFfqPcDf/Vr86F4sutNa4lfQ
/03dXB/k2/T/J1ykgc7T7Txp9e7JTyrJT+A7kwvz3CMKQGs57wwpLg587risvVRw
FYfsRKJmADRymAIdFyLGArKQVPJBuK3LQL3gGlUdWrGeA4FlFyKXs6Q8EvrDPJtu
5BaeqMSanduqGRr+x3+EmHrM+R6U7zfAp0c25MDEKLuu5/2Mr73mQUw/Qx+uieOa
2+z5C1QIuQ4cIYlKz2ltXEAcXAdaQjmyFobQrc4wU5bsrUnHNFUlts6x82fmURnr
1/5amEalcZ72Siz8vE4Y
=UHkN
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
