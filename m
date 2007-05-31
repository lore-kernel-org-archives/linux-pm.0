From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Fri, 01 Jun 2007 07:56:17 +1000
Message-ID: <1180648577.17682.13.camel__25774.9808872633$1180648621$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<200705310744.44488.rjw@sisk.pl> <20070531142357.GK27309@elf.ucw.cz>
	<200705312202.53945.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5366502485704371906=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705312202.53945.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============5366502485704371906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZGjxkAdMCOV084VoiF5p"


--=-ZGjxkAdMCOV084VoiF5p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Thu, 2007-05-31 at 22:02 +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Thursday, 31 May 2007 16:23, Pavel Machek wrote:
> > Hi!
> >=20
> > > > > I'll post revised patches in a new thread.
> > > >=20
> > > > I haven't been giving this much attention, so forgive me if I'm abo=
ut to
> > > > ask a silly question... which notifiers would you see the avenrun
> > > > saving/restoring using?
> > >=20
> > > I'm not sure what you mean.  Could you please clarify?
> >=20
> > Remember that patch about saving/restoring "load average"? I guess
> > Nigel asks where to hook it.
>=20
> Ah, okay, thanks.
>=20
> Hmm, that would be PM_PRE_HIBERNATION, I think.

Yeah. Okee doke.

Thanks!

Nigel

--=-ZGjxkAdMCOV084VoiF5p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGX0SBN0y+n1M3mo0RAmqdAKC+fQ6fS4cSx690mdlCvU7u1NzANwCeNGvb
/rIjw4g91Z08laHa0PthHv4=
=Ccx1
-----END PGP SIGNATURE-----

--=-ZGjxkAdMCOV084VoiF5p--


--===============5366502485704371906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5366502485704371906==--
