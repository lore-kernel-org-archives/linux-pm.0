From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] i386: Do not restore reserved memory after
	hibernation
Date: Sat, 02 Jun 2007 15:01:20 +1000
Message-ID: <1180760480.4361.13.camel@nigel.suspend2.net>
References: <200706012158.32832.rjw@sisk.pl>
	<200706020850.28299.arvidjaar@mail.ru>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8509610502945983109=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706020850.28299.arvidjaar@mail.ru>
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
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-pm <linux-pm@lists.osdl.org>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============8509610502945983109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k9nrwbu+ERh9GEBtKyNg"


--=-k9nrwbu+ERh9GEBtKyNg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-06-02 at 08:50 +0400, Andrey Borzenkov wrote:
> On Friday 01 June 2007, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This patch is designed to fix
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D7995
> >
> > Unfortunately, the reporter is unresponsive,=20
>=20
> well, we have our life too ...
>=20
> I confirm that this patch works. Unfortunately 2.6.22-rc here tends to ha=
ng on=20
> resume from STD often enough to be annoying so I tend to avoid it for dai=
ly=20
> use. It just sits there with cursor in upper left corner, no output on=20
> screen, nothing. I believe to have seen discussion about USB deadlock dur=
ing=20
> resume but cannot find it anymore. The problem is sporadic enough to rend=
er=20
> bisect useless.
>=20
> -andrey

I believe the thread you're thinking of had the subject line:

regression 2.6.22-rc2 suspend to ram broken ( usb_hcd_pci_suspend
+0x0/0x170() returns -16 )

The associated patch was merged prior to 2.6.22-rc3.

Regards,

Nigel

--=-k9nrwbu+ERh9GEBtKyNg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYPmgN0y+n1M3mo0RAlh/AKD3Wf4Ei6JP/rDFbYeDTExSdm2iaACg8VMU
KACipyYFnnGOcBWObXWwr5A=
=WT4U
-----END PGP SIGNATURE-----

--=-k9nrwbu+ERh9GEBtKyNg--


--===============8509610502945983109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8509610502945983109==--
