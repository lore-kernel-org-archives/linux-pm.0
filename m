From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: hibernate: constify attribute_group structures.
Date: Thu, 29 Jun 2017 13:59:41 +0200
Message-ID: <20170629115941.GA11525@amd>
References: <06cb04785b169107e86016267fd52b414e46efaa.1498735541.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34124 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbdF2L7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 07:59:44 -0400
Content-Disposition: inline
In-Reply-To: <06cb04785b169107e86016267fd52b414e46efaa.1498735541.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-06-29 16:58:40, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
>=20
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    6332	    488	    308	   7128	   1bd8	kernel/power/hibernate.o
>=20
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    6396	    424	    308	   7128	   1bd8	kernel/power/hibernate.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllU660ACgkQMOfwapXb+vLowwCgu8FTHom7u1QI+7FaO9Jm2n4k
opwAn1QlDvvQ4FkmME3D3eA+SwvC+W4C
=KC1y
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
