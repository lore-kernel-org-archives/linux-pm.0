From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 11:39:37 +1000
Message-ID: <200707111139.38667.nigel__30437.4431296766$1184118021$gmane$org@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707111053.36590.nigel@nigel.suspend2.net>
	<20070711012301.GA30596@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1383326622871593427=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711012301.GA30596@srcf.ucam.org>
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

--===============1383326622871593427==
Content-Type: multipart/signed; boundary="nextPart2118737.UVkYT3uRbr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2118737.UVkYT3uRbr
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 11 July 2007 11:23:02 Matthew Garrett wrote:
> On Wed, Jul 11, 2007 at 10:53:35AM +1000, Nigel Cunningham wrote:
> > On Wednesday 11 July 2007 10:45:50 Matthew Garrett wrote:
> > > How are you going to shift into suspend to disk without going via=20
> > > userspace? It's quite plausible that people will want different=20
> > > configuration at that point (or, realistically, need a different set =
of=20
> > > workarounds...)
> >=20
> > This is done after writing the image, from kernel space. We do the=20
> > suspend-to-ram, and if/when we wake from that, we look at the lid switc=
h=20
> > state before removing the image. If it's still closed, the kernel code=
=20
powers=20
> > down again (this time properly) without userspace ever seeing the light=
 of=20
> > day.
>=20
> Yes. I'm sort of struggling to see how this is done especially reliably=20
> - if we have separate hibernation and suspend to ram pathways, which is=20
> executed in this scenario?

Yeah, that is a bit confusing. At the moment, I'm doing the suspend to ram=
=20
platform dependent preparation and cleanup in this scenario. That's=20
definitely the right thing to do in the case where we write an image, then=
=20
suspend to ram, wake and continue working without running running out of=20
battery (writing the image is redundant in that case). Where we end up=20
properly powering down after suspending to ram, I believe we don't run the=
=20
pm_ops->finish after doing the atomic restore when resuming the image.

I haven't looked at what uswsusp does (I'm just looking at Suspend2 code=20
above), but it will have similar issues as it also has support for suspendi=
ng=20
to ram after writing an image.

Regards,

Nigel
=2D-=20
Nigel Cunningham
Christian Reformed Church of Cobden
103 Curdie Street, Cobden 3266, Victoria, Australia
Ph. +61 3 5595 1185 / +61 417 100 574
Communal Worship: 11 am Sunday.

--nextPart2118737.UVkYT3uRbr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlDTaN0y+n1M3mo0RAnNTAJ9nExw22TI7XX9cFbuOLB+faDdX0wCdFSjc
PH/8PuW5F6zokM+KL5lz7a0=
=EZtE
-----END PGP SIGNATURE-----

--nextPart2118737.UVkYT3uRbr--

--===============1383326622871593427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1383326622871593427==--
