From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 18:18:32 +0100
Message-ID: <1174583912.3588.25.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<200703211625.23253.david-b@pacbell.net>
	<1174557785.3944.74.camel@johannes.berg>
	<200703221010.59040.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1990318773=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221010.59040.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org


--===============1990318773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aLRfOU8gBzGDzxk0bPw6"


--=-aLRfOU8gBzGDzxk0bPw6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 10:10 -0700, David Brownell wrote:

> Seems kind of temporary, so long as pm_set_ops() doesn't
> enforce that as a requirement ...

I just sent a patch to akpm to do exactly that :)

> > we can add an=20
> > arbitrary amount of them if we wish :>
>=20
> For as many as can be #defined, yes.  But such #defines will
> be rare; adding a new one would mean updating pm_states[]
> plus maybe other code, and there are other structural issues
> with that notion ...=20

True. I think pm_states is the only thing that would need to be changed,
but I don't really advocate changing it and introducing dozens of new
states.

> especially the way suspend() methods
> have no way to determine the semantics of the target state.

I can't parse that.

johannes

--=-aLRfOU8gBzGDzxk0bPw6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGArpn/ETPhpq3jKURAi3BAJkBVFl6jXMKUlfpwTxwUweGQZ4TRACeOzvN
EQe4ctPE5yt+tPlHQwdV5Ew=
=gueK
-----END PGP SIGNATURE-----

--=-aLRfOU8gBzGDzxk0bPw6--


--===============1990318773==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1990318773==--
