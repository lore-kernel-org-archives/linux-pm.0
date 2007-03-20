From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 12:48:20 +0100
Message-ID: <1174391300.22188.2.camel@johannes.berg>
References: <20070320015821.782406000@sipsolutions.net>
	<20070320015846.636692000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165275117=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320015846.636692000@sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Nicolas Pitre <nico@cam.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0165275117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NZqjbfYRHYAcgEEZuqxt"


--=-NZqjbfYRHYAcgEEZuqxt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'll repost these three patches for inclusion once I've gotten some more
feedback, ok?

The three patches currently are:
 * rework pm_ops pm_disk_modes foo
   The pm_ops.pm_disk_mode is used in totally bogus ways, this fixes it,
   clarifies the description and kills all the users that wrongly think
   they can veto suspend to disk that way.
 * remove firmware disk mode
 * implement pm_ops.valid for everybody

After that I can go back to actually making it work on powermac...

johannes

--=-NZqjbfYRHYAcgEEZuqxt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/8oE/ETPhpq3jKURAoQtAJ9Dgo2XMfNC/UDFZ9iyg270x5JCMQCfdUEp
kfHwzYZ9jJwPudMLxp7++fs=
=qKRj
-----END PGP SIGNATURE-----

--=-NZqjbfYRHYAcgEEZuqxt--


--===============0165275117==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0165275117==--
