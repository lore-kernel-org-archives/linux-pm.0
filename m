From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 9 May 2017 21:19:52 +0200
Message-ID: <201705092119.52738@pali>
References: <20170412230854.GA11963@fury> <46fe1658d33647559b46c3a390a581ed@ausx13mpc120.AMER.DELL.COM> <CAHp75VfxVeBvo5bXjusi-ANNDEdCG0KAWrr2udu_GueQkhcd+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14377497.FOfpOojoKK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfxVeBvo5bXjusi-ANNDEdCG0KAWrr2udu_GueQkhcd+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, "Brown, Len" <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--nextPart14377497.FOfpOojoKK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 May 2017 21:04:15 Andy Shevchenko wrote:
> On Tue, May 9, 2017 at 9:10 PM,  <Mario.Limonciello@dell.com> wrote:
> >> > > Then took relevant decompression code and it really
> >> > > decompressed that binary MOF WMI buffer. But still
> >> > > decompressed format is binary, but I now see all WMI GUID
> >> > > encoded in UTF-16. Decompressed BMF file has again "FOMB"
> >> > > magic header.
> >> >=20
> >> > Well that's great.  Is it possible that this compression is used
> >> > for every time a class was declared?
> >>=20
> >> Looks like not. That decompressed output seems to be not
> >> compressed anymore. Just use same magic header.
> >=20
> > Actually it looks like a new magic header to me after decompressed.
> >=20
> > 46 4f 4d 42 54 15 00 00  01 00 00 00 01 00 00 00
> > That's now FOMBT
>=20
> I think you just mistakenly take 0x54 as letter when it looks more
> like
>=20
> 0x00001554
> 0x00000001
> 0x00000001
>=20
> from the above dump.

I looked at more decompressed BMF dumps from ACPI WMI and they have=20
different 5th and 6th bytes. So they are really not FOMBT.

46 4f 4d 42 26 35 00 00 01 00 00 00 01 00 00 00
46 4f 4d 42 fa 17 00 00 01 00 00 00 01 00 00 00
46 4f 4d 42 8e 11 00 00 01 00 00 00 01 00 00 00
46 4f 4d 42 ac 1b 00 00 01 00 00 00 01 00 00 00

So magic is only FOMB.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart14377497.FOfpOojoKK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkSFlgACgkQi/DJPQPkQ1L84gCfckzVeAl3XQvwSe6hEF3cfxe7
S6UAnjM2/4/xx0iFnBd45B7rJ1BwYqnO
=EKrN
-----END PGP SIGNATURE-----

--nextPart14377497.FOfpOojoKK--
