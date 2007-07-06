From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 15:25:16 +1000
Message-ID: <200707061525.18412.nigel__12101.6272031286$1183700043$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707061403.15932.nigel@nigel.suspend2.net>
	<1183696901.3388.119.camel@localhost.localdomain>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8032048617001921520=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183696901.3388.119.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============8032048617001921520==
Content-Type: multipart/signed; boundary="nextPart2227406.DxAaQg50xy";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2227406.DxAaQg50xy
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 14:41:40 Benjamin Herrenschmidt wrote:
>=20
> > I/O from swsusp and suspend2 use bios directly, so the page cache isn't=
 an=20
> > issue for them (apart from the fact that Suspend2 saves the page cache=
=20
> > separately so it can get a full image). Not sure about uswsusp.
> >=20
> > Only having half the amount of memory doesn't sound like a big limitati=
on=20
for=20
> > modern desktops & laptops, but don't forget that there are embedded guy=
s=20
> > wanting to hbernate too :)
>=20
> Wait wait wait ... uses the BIOS ? what do you mean ?

You misread me, Ben. Sorry for not being clearer. bios as in struct bio.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2227406.DxAaQg50xy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjdI+N0y+n1M3mo0RAn+XAKDjmtdqcIfth3ZlY3b3I7ymJJ7SYACgtTQI
m4wU5zhG5dUsnc9DVnm+n3A=
=TxDF
-----END PGP SIGNATURE-----

--nextPart2227406.DxAaQg50xy--

--===============8032048617001921520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8032048617001921520==--
