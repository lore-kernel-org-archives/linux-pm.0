From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:24:57 +1000
Message-ID: <200707031524.57572.nigel__32590.8849052668$1183440667$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031454.42078.nigel@nigel.suspend2.net>
	<20070703052130.GA17605@srcf.ucam.org>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1272455890214694759=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703052130.GA17605@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============1272455890214694759==
Content-Type: multipart/signed; boundary="nextPart2457010.14VC3PiVMA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2457010.14VC3PiVMA
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 03 July 2007 15:21:30 Matthew Garrett wrote:
> On Tue, Jul 03, 2007 at 02:54:41PM +1000, Nigel Cunningham wrote:
>=20
> > Note, though, that this won't help at all when people use=20
the "suspend-to-ram=20
> > instead of powering down after writing a hibernation image" feature in=
=20
> > (uswsusp | tuxonice). Fuse is just a broken idea in the first place, bu=
t=20
> > given that it exists, we still need to find the underlying cause.
>=20
> If / is on fuse it's unlikely that hibernation is high on your list of=20
> priorities right now.

Yeah, well... what can you say to that? :)

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2457010.14VC3PiVMA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGid2pN0y+n1M3mo0RAmg9AJ9/zdXo11SYrq8FEYbkaJIF81BiKACeNyYv
NLrrYA9cmsw4R1bdi1Ka8Xo=
=3P8T
-----END PGP SIGNATURE-----

--nextPart2457010.14VC3PiVMA--

--===============1272455890214694759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1272455890214694759==--
