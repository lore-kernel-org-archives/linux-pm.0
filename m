From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: does hibernate to disk try hard enough to free
	memory?
Date: Sat, 5 Mar 2011 15:41:44 +0100
Message-ID: <201103051541.45511.Martin__5546.41201529211$1299336199$gmane$org@lichtvoll.de>
References: <201102222159.58546.Martin@lichtvoll.de>
	<201102231511.15683.Martin@lichtvoll.de>
	<201102232106.51980.rjw@sisk.pl>
	(sfid-20110223_224350_865705_574EDBD6)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3396401533414633248=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102232106.51980.rjw@sisk.pl>
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
To: linux-kernel@vger.kernel.org
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============3396401533414633248==
Content-Type: multipart/signed;
  boundary="nextPart1438767.KWHBGXAYfv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1438767.KWHBGXAYfv
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Am Wednesday 23 February 2011 schrieb Rafael J. Wysocki:
> On Wednesday, February 23, 2011, Martin Steigerwald wrote:
> > Am Tuesday 22 February 2011 schrieb Rafael J. Wysocki:
> > > On Tuesday, February 22, 2011, Martin Steigerwald wrote:
> > > > Am Tuesday 22 February 2011 schrieb Rafael J. Wysocki:
> > > > > On Tuesday, February 22, 2011, Martin Steigerwald wrote:
> > > > > > Hi!
> > > > > >=20
> > > > > > Since Radeon KMS I often have it that my ThinkPad T42 with 2
> > > > > > MiB of RAM is not able to allocate memory for the
> > > > > > hibernation image. Before KMS hibernation only very rarely
> > > > > > failed for that reason.
> > > > > >=20
> > > > > > Often I run without compositing at all as I believe this
> > > > > > might spare some pages as well. But this doesn't always
> > > > > > help.
> > > > > >=20
> > > > > > It complains that to less pages could be freed. For example
> > > > > > with kernel 2.6.37:
> > > > > >=20
> > > > > > Feb 16 00:15:00 shambhala kernel: PM: Creating hibernation
> > > > > > image: Feb 16 00:15:00 shambhala kernel: PM: Need to copy
> > > > > > 186577 pages Feb 16 00:15:00 shambhala kernel: PM: Normal
> > > > > > pages needed: 114411 + 1024, available pages: 112767
> > > > > > Feb 16 00:15:00 shambhala kernel: PM: Not enough free memory
> > > > > > Feb 16 00:15:00 shambhala kernel: PM: Error -12 creating
> > > > > > hibernation image Feb 16 00:15:00 shambhala kernel: Extended
> > > > > > CMOS year: 2000 Feb 16 00:15:00 shambhala kernel: ACPI:
> > > > > > Waking up from system sleep state S4
> > > > > > Feb 16 00:15:00 shambhala kernel: PM: early recover of
> > > > > > devices complete after 0.376 msecs
> > > > >=20
> > > > > What's the value in /sys/power/image_size?
> > > >=20
> > > > shambhala:~> cat /sys/power/image_size
> > > > 844206080
> > > >=20
> > > > Should I try with less?
> > >=20
> > > Yes, please.  Try with 700000000 for example.
> >=20
> > I replaced dropping by settings image_size to this valua and the
> > ThinkPad hibernated with KMail open. Thus seems to work, but I will
> > test a bit further.
> >=20
> > Where does the higher value previously set come from? Autotuning?
>=20
> Likely.  The number seems to match at least.
>=20
> > Is there anything that can be improved with autotuning?
>=20
> We can lower the ratio of the image size to the total RAM.
> Alternatively, we can increase SPARE_PAGES.
>=20
> > If yes, I can file a bug report.
>=20
> Yes, please.

Reported-as:

Bug 30482 - try harder to free enough memory / improve image size=20
autotuning

> > Otherwise I just try to find a good value for image size and be
> > done with it.
>=20
> It would be helpful if you could determine the greatest image size
> working for you.

I am at 710000000 at the moment. See bug report.

I got the occassional hang on hibernation that I reported somewhere else.=20
You hinted at that the kernel has problems to free enough memory and takes=
=20
long to do that. I waited for minutes. Will report this as a different bug=
=20
and link it from there.

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart1438767.KWHBGXAYfv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1yS6kACgkQmRvqrKWZhMd9QgCgr+QjjWjeJZAR8eX7IWV5ThSe
P0QAn35dvL6UrtqnMkfThYxcud2iFyNC
=tPyH
-----END PGP SIGNATURE-----

--nextPart1438767.KWHBGXAYfv--

--===============3396401533414633248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3396401533414633248==--
