From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Wed, 10 May 2017 00:38:47 +0200
Message-ID: <201705100038.47998@pali>
References: <20170412230854.GA11963@fury> <738221cbaca94d10a0de7c03116df60e@ausx13mpc120.AMER.DELL.COM> <CAHp75Vc0rXwYKega9nJMrMe0tua6hrM7GTKOOJNsTNYR7KfGOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38325841.DVDzrorDOI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32941 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdEIWiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 18:38:51 -0400
In-Reply-To: <CAHp75Vc0rXwYKega9nJMrMe0tua6hrM7GTKOOJNsTNYR7KfGOA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, "Brown, Len" <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--nextPart38325841.DVDzrorDOI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I updated my bmfdec.c (git://github.com/pali/bmfdec.git) and here is
guessed header description:

/*
 * BMF file is compressed by DS-01 algorithm with additional header:
 * 4 bytes: 46 4f 4d 42 - 'F' 'O' 'M' 'B'
 * 4 bytes: 01 00 00 00 - version 0x01
 * 4 bytes: size of compressed data (low endian) without this header
 * 4 bytes: size of decompressed data (low endian) without this header
 */

/*
 * Decompressed part of BMF file contains:
 * 4 bytes: 46 4f 4d 42 - 'F' 'O' 'M' 'B'
 * 4 bytes: N =3D size of first part (low endian) since beginning
 * N-8 bytes: first part data
 * 16 bytes: 42 4d 4f 46 51 55 41 4c 46 4c 41 56 4f 52 31 31 - "BMOFQUALFLA=
VOR11"
 * M bytes: second part data of unknown length
 */

=46irst part of decompressed data contains UTF-16 strings terminated by
two zero bytes and between two strings are some binary data. Those
strings are just literals found in decompiled MOF file, so looks like
binary parts just decodes types and MOF language keywords.

And it looks like second part is not required and sometimes missing.
It contains only binary data, no idea what is there.

Now somebody with knowledge of MOF language should be able to describe
what and how is stored in first part.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart38325841.DVDzrorDOI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkSRPcACgkQi/DJPQPkQ1K3lwCdHWmW+L1kdx6iW0IliK4L0iwa
JPQAn1H5WilA/ppCfq8asP5ty65Vi6xE
=qXhu
-----END PGP SIGNATURE-----

--nextPart38325841.DVDzrorDOI--
