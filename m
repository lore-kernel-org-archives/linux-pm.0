From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 15:53:50 +1000
Message-ID: <200707061553.51036.nigel__21967.8282541738$1183701280$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707061403.15932.nigel@nigel.suspend2.net>
	<CF605B91-2425-4FC2-9434-5F8877EEEEEB@mac.com>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4987726140288199541=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CF605B91-2425-4FC2-9434-5F8877EEEEEB@mac.com>
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
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4987726140288199541==
Content-Type: multipart/signed; boundary="nextPart7541905.DmvDLvAnoK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7541905.DmvDLvAnoK
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kyle.

On Friday 06 July 2007 15:01:48 Kyle Moffett wrote:
> On Jul 06, 2007, at 00:03:15, Nigel Cunningham wrote:
> > The kind of thing Linus was talking about would limit you (as =20
> > swsusp and uswsusp do now) to only half the amount of memory.
>=20
> How so?  Suppose hibernate is implemented like this:

You're not talking about the same thing Linus was suggesting. He was just=20
wanting a result =3D sys_snapshot() sort of call. That would limit us to ha=
lf=20
the amount of memory.

I've looked over what you've written below and want to consider it in detai=
l.=20
Right now though, I don't have the time. I'll try to get back to you=20
promptly.

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart7541905.DmvDLvAnoK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjdjvN0y+n1M3mo0RAnciAKDWR3LtY9IPQr7wEtSuzcvDMpnJnQCg9QKI
EHjZuAo5lsdesim/eT0ANNg=
=ptAy
-----END PGP SIGNATURE-----

--nextPart7541905.DmvDLvAnoK--

--===============4987726140288199541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4987726140288199541==--
