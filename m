From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Sat, 28 Apr 2007 07:21:59 +1000
Message-ID: <1177708919.4737.145.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
	<20070427123615.GF22250@elf.ucw.cz>
	<Pine.LNX.4.64.0704271551250.12688@sbz-30.cs.Helsinki.FI>
	<20070427125734.GK22250@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5805052740279161941=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427125734.GK22250@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============5805052740279161941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A5e/5G3hKat+tNt/C+4Y"


--=-A5e/5G3hKat+tNt/C+4Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2007-04-27 at 14:57 +0200, Pavel Machek wrote:
> On Fri 2007-04-27 15:52:12, Pekka J Enberg wrote:
> > On Fri, 27 Apr 2007, Pavel Machek wrote:
> > > 1. This should not be a config option
> >=20
> > Ok.
>=20
> Unfortunately, we loose dmesg from the state saving this way, so I do
> not think it can be hardcoded, either. Best way would be to somehow
> preserve both dmesg buffers.
>=20
> Other way is to just control it by the define in the .c file; person
> using this is by definition kernel hacker, anyway. Or this can simply
> live like debugging patch, interested parties can apply.

That's why I made it a config option - so you can choose whether you
want it or not.

Nigel

--=-A5e/5G3hKat+tNt/C+4Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMml3N0y+n1M3mo0RAi1lAJ41gxwIjg/z2b6mYvIwT+/wBL6T+gCfRfCB
K2ImKzWOEIqkRhgn2/Q4kaI=
=6pL9
-----END PGP SIGNATURE-----

--=-A5e/5G3hKat+tNt/C+4Y--


--===============5805052740279161941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5805052740279161941==--
