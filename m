From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: invoke suspend notifications after
	console switch
Date: Thu, 24 Jan 2008 19:32:11 +0100
Message-ID: <1201199531.3454.141.camel@johannes.berg>
References: <1197853799.4885.7.camel@johannes.berg>
	<1199970876.3861.66.camel@johannes.berg> <20080111182042.GC4016@ucw.cz>
	<1201135592.6815.14.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939398537922100142=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201135592.6815.14.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============1939398537922100142==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ELfdYUUiM902NlBMmf+b"


--=-ELfdYUUiM902NlBMmf+b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Thu, 2008-01-24 at 11:46 +1100, Benjamin Herrenschmidt wrote:
> > Its pretty intrusive I'd say. And it is wrong; we'd prefer userspace
> > to know what we are doing; if they are told we are suspending,
> > userspace may be able to do something more clever than long console
> > switch.
> >=20
> > I'd prefer this not to go into mainline.
>=20
> So you'd prefer mainline to be broken and X to lock up ? nice !
>=20
> The console switch happens -anyway- with the current code right ? So we
> aren't changing that.

Mind you, that's the (only!) other alternative: removing the in-kernel
console switch completely which is the only way to allow userspace to do
something "more clever than long console switch".

> However, (even today I believe), users of /dev/apm_bios, such as X, will
> deadlock the VT subsystem if they get notified of the suspend before the
> kernel initiated console switch happen (which can happen today if the
> suspend is triggered by an APM application I -think- (to be verified)

Yeah I'm pretty sure that can happen, but in fact, that will happen
regardless of this patch until my other patch is applied.

johannes

--=-ELfdYUUiM902NlBMmf+b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR5jZqqVg1VMiehFYAQLcRBAArFTRdsLWZTCFAI7c5CO0ZddB/y5cil8m
8h2lKRL7QfF20xcDMC/JCZcCZXsfMiQKrA1zUy+UXlGvDl9yH+fK+RWYSsC172k2
5BIipVyfD6xsTpLgk8KeqHBYaPrkXbDO2gD/v17WbAtG/b7Cs6Fj5AKSmeY6/WjH
POAJLPghyOVmzUlkNUhVIZRCXCaMn+ZYwNY1w27Zuhhn1Q0pWZ89FS16fEjhlRcR
VoKFycFmFKriCAAsZ2MShxtb7nZ4DCUoXPiwL/XpMzmbpaDmlQ+822QBUsPEcXzd
bu1wKn0eAXblWAg4mIrrqNFIvwAhJdWg0+V556UsDADXEJXm8Oaq9RI1+QRpe6XI
E5o9ui9TJj2F0t+OlWzwLiokHX6/KT1P2N8n0cLLJHP/A2+HRZo1XUQiemgONf1l
LLnwn2bXefxUzAxo6bhP3KfpEzRlPS898EqTdy0Qa19IT7Df125TZ+yFhN56TPwj
AC8DOumjs2dDQ7ESGpBGwgJejpCkh3LN1xmJNN4H8Pt0H+xfSIN5M7j+puP66Wsb
70t2WFSc/qwhaBjsQbY3PvCKJEUsOnJoQ9RSVGKKec3tDD1BuR9PvH9kQBxLJBa2
Jx8CtZ8QCFinq8i2f+qgG/u0ZVL01g5YLTshS8+jQlXkCDkiOpUj+KmzdS7tt6BP
EbS/sIaRj0o=
=4Mek
-----END PGP SIGNATURE-----

--=-ELfdYUUiM902NlBMmf+b--


--===============1939398537922100142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1939398537922100142==--
