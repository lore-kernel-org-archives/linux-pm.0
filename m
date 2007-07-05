From: Johannes Berg <johannes@sipsolutions.net>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 15:12:57 +0200
Message-ID: <1183641177.3818.40.camel@johannes.berg>
References: <67670A5CEA5C374B8E7B16D7DC55F9530124744C@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5400648507220473269=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F9530124744C@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============5400648507220473269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pB/DCWYaeHk3b4w9EqbM"


--=-pB/DCWYaeHk3b4w9EqbM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 18:39 +0530, V, Sankara Narayanan wrote:

> Johannes,
> In that case, you need to implement it in every power manager and in
> turn HAL and DBUS get these from the kernel, one more redirection which
> will further reduce the time for the app to do the 'minimal' work.

No, as far as I know it'll actually tell applications *before* telling
the kernel.

johannes

--=-pB/DCWYaeHk3b4w9EqbM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjO5Z/ETPhpq3jKURAtxOAJ4wNAZ4TjFU2c+8pdnFeO3NOivMGgCeKc1L
YVJrZ9kx5rUv2YZrRItEysg=
=EBQ/
-----END PGP SIGNATURE-----

--=-pB/DCWYaeHk3b4w9EqbM--


--===============5400648507220473269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5400648507220473269==--
