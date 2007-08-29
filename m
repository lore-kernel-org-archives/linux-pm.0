From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Date: Wed, 29 Aug 2007 12:32:18 +0200
Message-ID: <1188383538.19891.8.camel__17395.3640777201$1188383539$gmane$org@johannes.berg>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
	<1188214327.7837.9.camel@johannes.berg>
	<Pine.LNX.4.60.0708290015580.3552@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0008973432943138162=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0708290015580.3552@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0008973432943138162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LYa5Qdaw79xbeo7vSDHy"


--=-LYa5Qdaw79xbeo7vSDHy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-29 at 00:30 +0200, Guennadi Liakhovetski wrote:

> > > +#ifdef CONFIG_PM
> >=20
> > some of those probably want to be CONFIG_PM_SLEEP now.
>=20
> Well, I wasn't sure when PM can be used not meaning PM_SLEEP, so, I left=20
> PM for now. Can certainly change, if it really matters.

You end up compiling more code than necessary if PM_SLEEP is disabled
but PM is enabled (i.e. runtime powermanagement enabled but no sleep
states)

johannes

--=-LYa5Qdaw79xbeo7vSDHy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG1Usy/ETPhpq3jKURAj2bAJ9rcatEc2DlfM7nMUqVSTldOpOB6wCfW/kF
JU4UWPdFXqZg4WkYl4738x0=
=D0k3
-----END PGP SIGNATURE-----

--=-LYa5Qdaw79xbeo7vSDHy--


--===============0008973432943138162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0008973432943138162==--
