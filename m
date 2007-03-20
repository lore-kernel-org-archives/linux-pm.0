From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend to disk modes, default mode
Date: Tue, 20 Mar 2007 10:44:07 +0100
Message-ID: <1174383848.3770.8.camel@johannes.berg>
References: <1174351671.3645.8.camel@johannes.berg>
	<20070320093322.GE3922@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0434366809=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320093322.GE3922@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0434366809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sYDdFSV+B629OFnIq+z2"


--=-sYDdFSV+B629OFnIq+z2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > I also used to think this was for implementing suspend-to-both, is that
> > wrong? In any case, I can't live with it being platform by default
>=20
> No, it is to get ACPI working after resume.

Yeah, I noticed later on. Sorry for the misunderstanding.

> > Maybe we just need a pm_disk_modes bitmap and a default_pm_disk_mode
> > member in struct pm_ops instead? What's firmware vs. platform anyway?
>=20
> bitmap would be nice. Firmware used to mean "let the bios do the whole
> suspend", platform means "linux does the suspend, but we tell bios we
> are doing it", shutdown means "linux does the suspend, does not tell
> anyone".

Well, actually, "let the bios do the whole suspend" should be
implemented by a new PM_SUSPEND_FIRMWAREDISK mode that can be used
instead of "disk" and is invoked through pm_ops directly w/o hitting the
disk.c code. That would be the right way to invoke such a mode, however,
currently, no platforms even have such a mode as far as I can tell.

johannes

--=-sYDdFSV+B629OFnIq+z2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/6zm/ETPhpq3jKURAmJ2AKCUXhqqgKuoPMT6quIgvhNpC+DPpwCgtMyE
6DxVen5c3P2R/qGcEQdQXTo=
=xTcF
-----END PGP SIGNATURE-----

--=-sYDdFSV+B629OFnIq+z2--


--===============0434366809==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0434366809==--
