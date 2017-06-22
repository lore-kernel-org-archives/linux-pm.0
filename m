From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / QoS: constify *_attribute_group.
Date: Thu, 22 Jun 2017 13:28:46 +0200
Message-ID: <20170622112845.GA32083@amd>
References: <572276af30704b5b79cca4e4864a2c3303e4ab4e.1498128683.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40358 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdFVL2s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 07:28:48 -0400
Content-Disposition: inline
In-Reply-To: <572276af30704b5b79cca4e4864a2c3303e4ab4e.1498128683.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-06-22 16:23:32, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    3890	   1152	      8	   5050	   13ba	drivers/base/power/sysfs.o
>=20
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    4250	    800	      8	   5058	   13c2	drivers/base/power/sysfs.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllLqe0ACgkQMOfwapXb+vI+/gCeM2rQEzbtpFlwxyitOOYoUvnA
pboAn1p4+RPUVVUTcC7/bMVdQ+KTSqzg
=WY0+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
