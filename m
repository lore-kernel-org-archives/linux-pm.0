From: Pavel Machek <pavel@ucw.cz>
Subject: Re: update-binfmts breaking suspend
Date: Wed, 11 Apr 2018 08:09:49 +0200
Message-ID: <20180411060949.GA4287@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
 <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
 <20180404084905.GA12303@amd>
 <20180405122503.GA28446@amd>
 <20180405203045.GA23313@amd>
 <SN4PR2101MB073673B12998428D48DA62E5CBBA0@SN4PR2101MB0736.namprd21.prod.outlook.com>
 <20180406144355.GA20605@bombadil.infradead.org>
 <20180411043052.GA15171@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180411043052.GA15171@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, jikos@suse.cz, raven@themaw.net, akpm@linux-foundation.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Ping?

See the thread... akpm pointed out fix for autofs, and the problem is
gone with newer -next kernels, so I assume the fix fixes it :-).

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrNpq0ACgkQMOfwapXb+vKZiACffewz3yafxlTeLT/tM5nh4jt3
n/8An0qaz6d2hDQ61Vv86wlSZ76TRsc5
=RzN+
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
