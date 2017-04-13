From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 17:39:57 +0200
Message-ID: <201704131739.57956@pali>
References: <20170412230854.GA11963@fury> <20170413073228.GB1462@ozzy.nask.waw.pl> <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2985883.uJ7eagEnOa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34604 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdDMPkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 11:40:01 -0400
In-Reply-To: <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>, Darren Hart <dvhart@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--nextPart2985883.uJ7eagEnOa
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 13 April 2017 17:32:48 Andy Lutomirski wrote:
> On Thu, Apr 13, 2017 at 12:32 AM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@ke=
mpniu.pl>
> wrote:
> > What we still need, though, is an open source version of
> > wmiofck.exe.  I am unaware of anything like that existing and
> > installing the Windows Driver Kit just to run one command which
> > spits out a single *.h file is not something I would describe as
> > convenient (been there).
>=20
> I haven't tried to see whether they do what's needed, but there's
> OpenWBEM and OpenPegasus.
>=20
> Anyway, if such a tool exists, it would be handy to expose the binary
> MOF data to userspace so the tool could be used to help get WMI
> working on new platforms.

In this case, when WMI stay in kernel, MOF data could be exported via=20
debugfs? I think there is no need to have them in sysfs stable ABI. As=20
above usage (get WMI working on new platforms) looks like for debugging=20
purpose.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2985883.uJ7eagEnOa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAljvm80ACgkQi/DJPQPkQ1Ji+wCdFUc+ec7gIavOZ+jOb16sdk2N
tJQAn39/V1XeBAeaByvM5FixlX34Sq3N
=f40N
-----END PGP SIGNATURE-----

--nextPart2985883.uJ7eagEnOa--
