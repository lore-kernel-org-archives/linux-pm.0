From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Sat, 28 Apr 2007 08:09:32 +1000
Message-ID: <1177711773.4737.178.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
	<20070427123615.GF22250@elf.ucw.cz>
	<Pine.LNX.4.64.0704271551250.12688@sbz-30.cs.Helsinki.FI>
	<20070427125734.GK22250@elf.ucw.cz>
	<1177708919.4737.145.camel@nigel.suspend2.net>
	<20070427220554.GB2994@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6206449637203490362=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427220554.GB2994@elf.ucw.cz>
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


--===============6206449637203490362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eHRH8bGRiDIhjFFpYwEQ"


--=-eHRH8bGRiDIhjFFpYwEQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 00:05 +0200, Pavel Machek wrote:
> On Sat 2007-04-28 07:21:59, Nigel Cunningham wrote:
> > Hi.
> >=20
> > On Fri, 2007-04-27 at 14:57 +0200, Pavel Machek wrote:
> > > On Fri 2007-04-27 15:52:12, Pekka J Enberg wrote:
> > > > On Fri, 27 Apr 2007, Pavel Machek wrote:
> > > > > 1. This should not be a config option
> > > >=20
> > > > Ok.
> > >=20
> > > Unfortunately, we loose dmesg from the state saving this way, so I do
> > > not think it can be hardcoded, either. Best way would be to somehow
> > > preserve both dmesg buffers.
> > >=20
> > > Other way is to just control it by the define in the .c file; person
> > > using this is by definition kernel hacker, anyway. Or this can simply
> > > live like debugging patch, interested parties can apply.
> >=20
> > That's why I made it a config option - so you can choose whether you
> > want it or not.
>=20
> Yes, and having it as a config option is completely wrong. There's no
> good value for that config option, how is poor user going to answer
> it. That config option is evil.

It's an option for developers, and what's appropriate depends on which
part of the resume you're trying to debug. That said, I do agree that
preserving both buffers would be nicer.

Nigel

--=-eHRH8bGRiDIhjFFpYwEQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMnScN0y+n1M3mo0RAvmlAKDsEM5qNizeWRR5eDP69/JIoRmJuACgqNp5
7JtdBmFVq7CIHg2yB4Od/Og=
=FBjL
-----END PGP SIGNATURE-----

--=-eHRH8bGRiDIhjFFpYwEQ--


--===============6206449637203490362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6206449637203490362==--
