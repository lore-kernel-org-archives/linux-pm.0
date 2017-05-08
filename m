From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 9 May 2017 00:17:44 +0200
Message-ID: <201705090017.44210@pali>
References: <20170412230854.GA11963@fury> <201705082259.51850@pali> <77e4e46f58354e10874ed0515f514fc2@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13844783.DTLmW68vB7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77e4e46f58354e10874ed0515f514fc2@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart13844783.DTLmW68vB7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 08 May 2017 23:18:11 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Monday, May 8, 2017 4:00 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.net;
> > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> > platform- driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: RFC: WMI Enhancements
> >=20
> > On Monday 08 May 2017 21:21:45 Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > > > Sent: Monday, May 8, 2017 12:18 PM
> > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > Cc: dvhart@infradead.org; rjw@rjwysocki.net;
> > > > luto@amacapital.net; len.brown@intel.com;
> > > > corentin.chary@gmail.com; luto@kernel.org;
> > > > andriy.shevchenko@linux.intel.com;
> > > > linux-kernel@vger.kernel.org; platform-
> > > > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org Subject:
> > > > Re: RFC: WMI Enhancements
> > > >=20
> > > > On Friday 05 May 2017 23:55:46 Mario.Limonciello@dell.com wrote:
> > > > > Unfortunately the MOF data that comes out of wmi-mof is so
> > > > > called "Binary MOF" which has been pre-compiled to an
> > > > > intermediate format with mofcomp.exe on Windows. The format
> > > > > of binary MOF is not documented and the only known way to
> > > > > get text mof back out is by using mofcomp.exe with some
> > > > > esoteric arguments.
> > > > >=20
> > > > > mofcomp.exe -MOF:recovered.mof -MFL:ms_409.mof
> > > > > -Amendment:MS_409 binary_mof_file
> > > >=20
> > > > Looks like that binary MOF file has "well-known" file extension
> > > > .bmf. File itself starts with magic hader "FOMB" which is in
> > > > reverse BMOF (binary mof). But I was not able to find any
> > > > specification nor any other details. As this binary format is
> > > > dated back to Win9x I guess data would compressed by some old
> > > > MS compression algorithm (CAB?).
> > >=20
> > > Actually comparing a couple of binary MOF files the first 8 look
> > > like the header to me.
> > >=20
> > > 0x46, 0x4f, 0x4d, 0x42, 0x01, 0x00, 0x00, 0x00
> > >=20
> > > On a compiled Dell binary MOF the next are:
> > >=20
> > > 0xed, 0x04, 0x00, 0x00,
> > >=20
> > > This looks like the size of the remaining data after taking out
> > > 16 for the headers 4ed =3D 1261
> > > Total size is 1277
> > >=20
> > > 0xd8, 0x15, 0x00, 0x00
> > > Maybe a checksum?
> > >=20
> > > But that first 16 bytes does look like the header structure to
> > > me.
> >=20
> > Good catch! Your observation for first 12 bytes passes also for my
> > checks.
> >=20
> > Next 4 bytes (after possible checksum) at 0x10 are always same:
> > 0x44 0x53 0x00 0x01.
> >=20
> > And I guess this should be compression header. In time of Win9x
> > Microsoft had own non-standard compression for disks called
> > DoubleSpace. IIRC it was some modification of LZ77 algorithm. And
> > 0x44 0x53 0x00 0x01 is DS01. Maybe it is really DoubleSpace
> > compression used for binary MOF?
> >=20
> > I'm going to find specification of that old compression
> > algorithm...

I found dmsdos implementation of that DS compression at:
http://cmp.felk.cvut.cz/~pisa/dmsdos

Then took relevant decompression code and it really decompressed that=20
binary MOF WMI buffer. But still decompressed format is binary, but I=20
now see all WMI GUID encoded in UTF-16. Decompressed BMF file has again=20
"FOMB" magic header.

I pushed my decompression utility here:
https://github.com/pali/bmfdec

So next step is to decode that decompressed binary MOF file.

> 44 53 looks promising to be quantum compression.
> https://en.wikipedia.org/wiki/Quantum_compression
>=20
> That=E2=80=99s also what 'file' magic detects from it too.
> $ file mof.stripped
> mof.stripped: Quantum archive data

Hm... so that Quantum compression is also modification of LZ77. And=20
probably it is same as DoubleSpace format (or use it).

> > > > Moreover via tool wmiofck.exe it is possible to generate header
> > > > file for
> > > >=20
> > > > WMI driver from binary mof file:
> > > >   wmiofck.exe -hfile.h -m -u file.bmf
> > > >=20
> > > > And what is interesting that in this file are also comments
> > > > which looks like comes from that binary mof file.
> > >=20
> > > Ah interesting.  The "comments" that come out of that are
> > > actually what's mapped to the "Description" field in the WMI
> > > repository when the binary MOF is loaded.
> > >=20
> > > They are not the developer comments that were placed in the
> > > original MOF data.  I would suppose those are lost when
> > > compiling to binary MOF.
> >=20
> > Hm.. right they are present in decompiled MOF file in Description
> > field.
> >=20
> > > > When I looked into output from mofcomp.exe with above args,
> > > > that MOF output did not contain comments, so looks like we
> > > > still can miss something.
> > > >=20
> > > > See: http://blog.nietrzeba.pl/2011/12/mof-decompilation.html
> > >=20
> > > Actually I see wmimofck output to be missing some important bits.
> > > For example on a Dell system You'll get a class BFn declared from
> > > mofcomp output, but nothing from wmimofck output.
> > >=20
> > > The most important thing that you're really getting out of this
> > > MOF is the size, structure and format of the buffer that you
> > > would be sending to ASL.
> > >=20
> > > Back to the point we were discussing of a potential filter, the
> > > information in the MOF could possibly be very useful to declaring
> > > what is going into the filter.
> >=20
> > In that header file generated by wmiofck.exe I see definitions for
> > BFn.
>=20
> There is a definition but it's missing the format of the argument
> from what I can tell.
>=20
> In any case, this will be tangential to this discussion, but useful
> for reverse engineering the binary mof format.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart13844783.DTLmW68vB7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkQ7ogACgkQi/DJPQPkQ1J+IgCcDz0l9TBba43cM9bTNCmkqW1m
n5EAmgPAtppO9mob0SU0X5/TYZA9Jpnw
=Gvm8
-----END PGP SIGNATURE-----

--nextPart13844783.DTLmW68vB7--
