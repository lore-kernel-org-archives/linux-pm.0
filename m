From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] bq2415x_charger: Fix null pointer dereference
Date: Wed, 23 Sep 2015 19:04:54 +0200
Message-ID: <20150923170453.GA31150@earth>
References: <1442847500-22435-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58565 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634AbbIWRE7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 13:04:59 -0400
Content-Disposition: inline
In-Reply-To: <1442847500-22435-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Mon, Sep 21, 2015 at 04:58:20PM +0200, Pali Roh=E1r wrote:
> Commit b68c3161430a (bq2415x_charger: Allow to load and use driver even if
> notify device is not registered yet) introduced null pointer dereference =
in
> case bq is NULL. This patch fixes it.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued with proper "Fixes: " tag.

-- Sebastian

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAtuzAAoJENju1/PIO/qa8UAP/iuUsQ5U5Q5GSmiWAJMLX3wo
O7D1AL+xJ1NHGdozrwsnzfI7ZrKjY5lP9RrLn0cQf0+SudIFRbyG02/Ws1XBnEQ2
O0JOCcrAC87xHvOV+FdLvTLzQvGA16bjFujit17LqY7XbKjl09BGX4Ui8R8I/CZA
ZIpP8E7w+i1m+Wtli71SiPCdEr8BBCoKds0A1jBQPK2kD4aFRv5bErAmhPTRJUh9
hZzixaJfEiUhbBmqrquX9uWwz6Z3mj5BywOp90r0Kxf5gwDHZ53vptCamxSX48ou
ojF8mjJRoc0TzGxxaeX06wZ14VuM+Tm9sJha6esNaEjr7OX1NDKB/XH0fWcyCYLW
vd72YBctWZs3ycstf+FzKZ71staAsq9VcWcDdZP3wmAML8kQ87K7gIzmtcHUlyMc
VvY5C3Wy18TSpPA+Hs+Wa87bL0ruKVyeWBk+sD2CPlypNyz+EbumEZXgjVJ1j+nR
llbPyTIC2ByXA+wRT2Gevo61Y9iDSp3Asbur475E5eYhOz7+uOfafENJoTPgXiUt
Livc2zGsZg1P1JJ7IykyxDofA542or1EcGJQG3/z1xiGTf2DANf8i2ofD80VDNsh
3aqEuU1Do7HGXPnceAEYyfmyM56/ahkNnylEnOKjUERf6B9UQFK2WCMmLmeWh2dj
B74IlwtBcxF8iPFfp7oF
=JG0w
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
