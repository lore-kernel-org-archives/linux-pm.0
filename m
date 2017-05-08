From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Mon, 8 May 2017 19:17:34 +0200
Message-ID: <201705081917.34242@pali>
References: <20170412230854.GA11963@fury> <20170420204436.GC3209@fury> <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4069339.OeqetiiWL2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33270 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdEHRRi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 13:17:38 -0400
In-Reply-To: <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

--nextPart4069339.OeqetiiWL2
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 05 May 2017 23:55:46 Mario.Limonciello@dell.com wrote:
> Unfortunately the MOF data that comes out of wmi-mof is so called
> "Binary MOF" which has been pre-compiled to an intermediate format
> with mofcomp.exe on Windows. The format of binary MOF is not
> documented and the only known way to get text mof back out is by
> using mofcomp.exe with some esoteric arguments.
>=20
> mofcomp.exe -MOF:recovered.mof -MFL:ms_409.mof -Amendment:MS_409
> binary_mof_file

Looks like that binary MOF file has "well-known" file extension .bmf.=20
=46ile itself starts with magic hader "FOMB" which is in reverse BMOF=20
(binary mof). But I was not able to find any specification nor any other=20
details. As this binary format is dated back to Win9x I guess data would=20
compressed by some old MS compression algorithm (CAB?).

Moreover via tool wmiofck.exe it is possible to generate header file for=20
WMI driver from binary mof file:

  wmiofck.exe -hfile.h -m -u file.bmf

And what is interesting that in this file are also comments which looks=20
like comes from that binary mof file.

When I looked into output from mofcomp.exe with above args, that MOF=20
output did not contain comments, so looks like we still can miss=20
something.

See: http://blog.nietrzeba.pl/2011/12/mof-decompilation.html

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4069339.OeqetiiWL2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkQqC4ACgkQi/DJPQPkQ1LN+ACfbct5S0mkwzCw/nD1v6hGHa2y
zZ4An0UO6x9kfPY8l+47AOLRf/kQ/nAB
=ohuJ
-----END PGP SIGNATURE-----

--nextPart4069339.OeqetiiWL2--
