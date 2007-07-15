From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 09:38:13 +1000
Message-ID: <200707160938.16037.nigel__35425.671717576$1184542744$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0707151914450.28934-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3846847291659158185=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707151914450.28934-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

--===============3846847291659158185==
Content-Type: multipart/signed; boundary="nextPart1875635.pehxPaokTr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1875635.pehxPaokTr
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 16 July 2007 09:15:47 Alan Stern wrote:
> On Sun, 15 Jul 2007 david@lang.hm wrote:
>=20
> > >> for a pure hibernate mode, you will be powering off the box after=20
saving
> > >> the suspend image. why are there any special ACPI modes involved?
> > >
> > > Because, for example, on my machine the status of power supply (prese=
nt
> > > vs not present) is not updated correctly after the restore if ACPI=20
callbacks
> > > aren't used during the hibernation.  That's just experience and it's =
in=20
line
> > > with the ACPI spec.
> >=20
> > so if a machine is actually powered off the /dev/suspend process won't=
=20
> > work?
> >=20
> > remember that the system may run a different OS between the hibernate a=
nd=20
> > the resume, makeing any assumptions about what state the hardware is in=
=20
> > when you start the resume is a problem.
>=20
> As I understand it, running a different OS between the hibernate and=20
> the resume would violate the ACPI spec.

Well then, I know one or two people who would argue that the ACPI spec is=20
faulty. :\

Regards,

Nigel
=2D-=20
Nigel Cunningham
Christian Reformed Church of Cobden
103 Curdie Street, Cobden 3266, Victoria, Australia
Ph. +61 3 5595 1185 / +61 417 100 574
Communal Worship: 11 am Sunday.

--nextPart1875635.pehxPaokTr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGmq/oN0y+n1M3mo0RAgmVAJ9jz67HS+WaZ2TxiNeDbSVbmcsxawCfSOip
zSF7Cboect+TZCUIRWDPHnE=
=H0PZ
-----END PGP SIGNATURE-----

--nextPart1875635.pehxPaokTr--

--===============3846847291659158185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3846847291659158185==--
