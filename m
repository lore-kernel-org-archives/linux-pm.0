From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: some task not stopped during resume
Date: Wed, 30 May 2007 16:02:29 +0200
Message-ID: <1180533749.1396.7.camel@johannes.berg>
References: <1180442538.1396.3.camel@johannes.berg>
	<200705301550.56257.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6278726911392802544=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705301550.56257.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============6278726911392802544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yOuSBPdiHcEnsdV4EtB/"


--=-yOuSBPdiHcEnsdV4EtB/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-30 at 15:50 +0200, Rafael J. Wysocki wrote:

> The message seems to be a false-positive (this printk has been removed
> recently, in 2.6.22-rc3, IIRC).
>=20
> We don't freeze traced tasks the parents of which have been frozen.  So, =
in
> fact, the evolution wasn't frozen, only the gdb that traced it, and durin=
g the
> resume the gdb was thawed and allowed evolution to run, but it crashed.

Ah, that makes sense, thanks for the explanation.

> Why it crashed is a different problem, actually, and that need not be rel=
ated
> to the freezer.  Still, if that turns out to be reproducible, I'll start =
to worry. ;-)

Well, I suppose it then crashed right before I suspended, gdb attached,
was frozen, and then I only saw that when I resumed. And evolution
really kills itself all the time without the freezer too ;)

johannes

--=-yOuSBPdiHcEnsdV4EtB/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGXYP1/ETPhpq3jKURAlCCAJ97ZbV5bsYq2rQrdcn188sOKrFq9gCeKgUf
H5lsayKoSsPOGc3/OIHkrWU=
=mzCa
-----END PGP SIGNATURE-----

--=-yOuSBPdiHcEnsdV4EtB/--


--===============6278726911392802544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6278726911392802544==--
