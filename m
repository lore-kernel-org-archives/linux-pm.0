From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Mon, 8 May 2017 22:59:51 +0200
Message-ID: <201705082259.51850@pali>
References: <20170412230854.GA11963@fury> <201705081917.34242@pali> <c073b5f67d1e495481613711753356ba@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3264345.fIZSCH1u9c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34415 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdEHU74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 16:59:56 -0400
In-Reply-To: <c073b5f67d1e495481613711753356ba@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

--nextPart3264345.fIZSCH1u9c
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 08 May 2017 21:21:45 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Monday, May 8, 2017 12:18 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.net;
> > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> > platform- driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: RFC: WMI Enhancements
> >=20
> > On Friday 05 May 2017 23:55:46 Mario.Limonciello@dell.com wrote:
> > > Unfortunately the MOF data that comes out of wmi-mof is so called
> > > "Binary MOF" which has been pre-compiled to an intermediate
> > > format with mofcomp.exe on Windows. The format of binary MOF is
> > > not documented and the only known way to get text mof back out
> > > is by using mofcomp.exe with some esoteric arguments.
> > >=20
> > > mofcomp.exe -MOF:recovered.mof -MFL:ms_409.mof -Amendment:MS_409
> > > binary_mof_file
> >=20
> > Looks like that binary MOF file has "well-known" file extension
> > .bmf. File itself starts with magic hader "FOMB" which is in
> > reverse BMOF (binary mof). But I was not able to find any
> > specification nor any other details. As this binary format is
> > dated back to Win9x I guess data would compressed by some old MS
> > compression algorithm (CAB?).
>=20
> Actually comparing a couple of binary MOF files the first 8 look like
> the header to me.
>=20
> 0x46, 0x4f, 0x4d, 0x42, 0x01, 0x00, 0x00, 0x00
>=20
> On a compiled Dell binary MOF the next are:
>=20
> 0xed, 0x04, 0x00, 0x00,
>=20
> This looks like the size of the remaining data after taking out 16
> for the headers 4ed =3D 1261
> Total size is 1277
>=20
> 0xd8, 0x15, 0x00, 0x00
> Maybe a checksum?
>=20
> But that first 16 bytes does look like the header structure to me.

Good catch! Your observation for first 12 bytes passes also for my=20
checks.

Next 4 bytes (after possible checksum) at 0x10 are always same:
0x44 0x53 0x00 0x01.

And I guess this should be compression header. In time of Win9x=20
Microsoft had own non-standard compression for disks called DoubleSpace.=20
IIRC it was some modification of LZ77 algorithm. And 0x44 0x53 0x00 0x01=20
is DS01. Maybe it is really DoubleSpace compression used for binary MOF?

I'm going to find specification of that old compression algorithm...

> > Moreover via tool wmiofck.exe it is possible to generate header
> > file for
> >=20
> > WMI driver from binary mof file:
> >   wmiofck.exe -hfile.h -m -u file.bmf
> >=20
> > And what is interesting that in this file are also comments which
> > looks like comes from that binary mof file.
>=20
> Ah interesting.  The "comments" that come out of that are actually
> what's mapped to the "Description" field in the WMI repository when
> the binary MOF is loaded.
>=20
> They are not the developer comments that were placed in the original
> MOF data.  I would suppose those are lost when compiling to binary
> MOF.

Hm.. right they are present in decompiled MOF file in Description field.

> > When I looked into output from mofcomp.exe with above args, that
> > MOF output did not contain comments, so looks like we still can
> > miss something.
> >=20
> > See: http://blog.nietrzeba.pl/2011/12/mof-decompilation.html
>=20
> Actually I see wmimofck output to be missing some important bits.
> For example on a Dell system You'll get a class BFn declared from
> mofcomp output, but nothing from wmimofck output.
>=20
> The most important thing that you're really getting out of this MOF
> is the size, structure and format of the buffer that you would be
> sending to ASL.
>=20
> Back to the point we were discussing of a potential filter, the
> information in the MOF could possibly be very useful to declaring
> what is going into the filter.

In that header file generated by wmiofck.exe I see definitions for BFn.=20
And there are also sizes for BFn buffers, together with some types.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3264345.fIZSCH1u9c
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkQ3EcACgkQi/DJPQPkQ1L4TQCgqWs0ngw/3AxBGBjxQFgcsRMX
ZCsAoJbDq4RC5ifTAq2k9HWItEVTuTN6
=3t8E
-----END PGP SIGNATURE-----

--nextPart3264345.fIZSCH1u9c--
