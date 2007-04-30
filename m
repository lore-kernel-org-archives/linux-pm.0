From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: do not use pm_ops (was: Re: suspend2
	merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Mon, 30 Apr 2007 16:59:51 +0200
Message-ID: <1177945191.5102.93.camel@johannes.berg>
References: <20070425072350.GA6866@ucw.cz>
	<200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
	<1177921759.5102.24.camel@johannes.berg>
	<200704301651.46376.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298296586920500334=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301651.46376.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0298296586920500334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9n9j4v58Z70rqKCFygNn"


--=-9n9j4v58Z70rqKCFygNn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-30 at 16:51 +0200, Rafael J. Wysocki wrote:

> > That comment doesn't seem right. This is in ->enter so afaict the image
> > hasn't been loaded yet at this point. I don't know if you just moved
> > code but if you did then I don't think it was correct before.
>=20
> It was in your patch, so I kept it, but I don't think it's correct too.

If it was in my patch then it must be there in the original code, iirc I
just shuffled it a bit :)

> Moreover, it seems that acpi_save_state_mem() and acpi_restore_state_mem(=
) are
> only needed by s2ram, so we can safely remove them from the hibernation c=
ode
> path.  Pavel, is that correct?

This I don't know. They seemed to be done on hibernate too.

johannes

--=-9n9j4v58Z70rqKCFygNn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNgRn/ETPhpq3jKURAugaAJ4t6obMauE6e7j3hyBpsjtAoWIB+gCfQpYi
KmgHHeQY2b6M2G2YeFR6XBs=
=BLeo
-----END PGP SIGNATURE-----

--=-9n9j4v58Z70rqKCFygNn--


--===============0298296586920500334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0298296586920500334==--
