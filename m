From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: does hibernate to disk try hard enough to free
	memory?
Date: Tue, 22 Feb 2011 23:07:33 +0100
Message-ID: <201102222307.41499.Martin__28181.4836584546$1298412546$gmane$org@lichtvoll.de>
References: <201102222159.58546.Martin@lichtvoll.de>
	<201102222209.15647.rjw@sisk.pl>
	(sfid-20110222_230528_360254_A6598DE5)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1173869725764495059=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102222209.15647.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============1173869725764495059==
Content-Type: multipart/signed;
  boundary="nextPart5176909.d92r2dqokB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5176909.d92r2dqokB
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Am Tuesday 22 February 2011 schrieb Rafael J. Wysocki:
> On Tuesday, February 22, 2011, Martin Steigerwald wrote:
> > Hi!
> >=20
> > Since Radeon KMS I often have it that my ThinkPad T42 with 2 MiB of
> > RAM is not able to allocate memory for the hibernation image. Before
> > KMS hibernation only very rarely failed for that reason.
> >=20
> > Often I run without compositing at all as I believe this might spare
> > some pages as well. But this doesn't always help.
> >=20
> > It complains that to less pages could be freed. For example with
> > kernel 2.6.37:
> >=20
> > Feb 16 00:15:00 shambhala kernel: PM: Creating hibernation image:
> > Feb 16 00:15:00 shambhala kernel: PM: Need to copy 186577 pages
> > Feb 16 00:15:00 shambhala kernel: PM: Normal pages needed: 114411 +
> > 1024, available pages: 112767
> > Feb 16 00:15:00 shambhala kernel: PM: Not enough free memory
> > Feb 16 00:15:00 shambhala kernel: PM: Error -12 creating hibernation
> > image Feb 16 00:15:00 shambhala kernel: Extended CMOS year: 2000
> > Feb 16 00:15:00 shambhala kernel: ACPI: Waking up from system sleep
> > state S4
> > Feb 16 00:15:00 shambhala kernel: PM: early recover of devices
> > complete after 0.376 msecs
>=20
> What's the value in /sys/power/image_size?

shambhala:~> cat /sys/power/image_size
844206080

Should I try with less?

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart5176909.d92r2dqokB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1kM6YACgkQmRvqrKWZhMeoWwCgiqbO01HcFYpp6067sQEOkrzM
NKEAn0aFZWP8g0qPGbtRur+o0MUDGZFW
=XgYH
-----END PGP SIGNATURE-----

--nextPart5176909.d92r2dqokB--

--===============1173869725764495059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1173869725764495059==--
