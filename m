From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 10:53:35 +1000
Message-ID: <200707111053.36590.nigel__10942.5669223585$1184115257$gmane$org@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707110816.42114.nigel@nigel.suspend2.net>
	<20070711004549.GA30249@srcf.ucam.org>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7813279520033845338=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711004549.GA30249@srcf.ucam.org>
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
Cc: rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, nigel@suspend2.net, Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============7813279520033845338==
Content-Type: multipart/signed; boundary="nextPart10679470.A35lehf7Q7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart10679470.A35lehf7Q7
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 11 July 2007 10:45:50 Matthew Garrett wrote:
> On Wed, Jul 11, 2007 at 08:16:40AM +1000, Nigel Cunningham wrote:
> > Yeah, the bit I consider to be ugly is opening the files from within th=
e=20
> > kernel, but it seemed to be necessary in order to provide the=20
functionality=20
> > without having to rely on userspace or do some sort of messy work to=20
figure=20
> > out how to access the lid button and so on.
>=20
> How are you going to shift into suspend to disk without going via=20
> userspace? It's quite plausible that people will want different=20
> configuration at that point (or, realistically, need a different set of=20
> workarounds...)

This is done after writing the image, from kernel space. We do the=20
suspend-to-ram, and if/when we wake from that, we look at the lid switch=20
state before removing the image. If it's still closed, the kernel code powe=
rs=20
down again (this time properly) without userspace ever seeing the light of=
=20
day.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart10679470.A35lehf7Q7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlCoQN0y+n1M3mo0RAoNtAJ9/z8VRmnUWWO4pBlN1/aouAG4TCQCgyypW
BuxTN7+HFRgEkgtWxq7TzSI=
=rtHQ
-----END PGP SIGNATURE-----

--nextPart10679470.A35lehf7Q7--

--===============7813279520033845338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7813279520033845338==--
