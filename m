From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 00/17] thermal: add COMPILE_TEST (on drivers)
Date: Thu, 10 Sep 2015 07:56:43 -0700
Message-ID: <20150910145640.GA32748@localhost.localdomain>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
 <CAMuHMdVRztDtqDU6j6UBmGy4Z3Sm=QtCr0rrPwxrV+axTw17iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32880 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbbIJO4r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 10:56:47 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVRztDtqDU6j6UBmGy4Z3Sm=QtCr0rrPwxrV+axTw17iA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2015 at 08:23:45AM +0200, Geert Uytterhoeven wrote:
> Hi Eduardo,
>=20
> On Thu, Sep 10, 2015 at 6:10 AM, Eduardo Valentin <edubezval@gmail.com> w=
rote:
> > This is a simple series to add the COMPILE_TEST on thermal drivers.
> > The idea is to help compiling and maintaining.
>=20
> Thanks, good idea!
>=20
> > Split into smaller patches so people can have their own voices on their=
 drivers.
> >
> > Let me know if this is a problem.
>=20
> Have you compile-tested this?
> I'm seeing too many failures.

Yes I did, but apparently I missed some drivers in my test. I had x86
target while compile arm drivers, thats probably why I did not see the
cpuid problems. I am trying again, as I really did not see all errors
you mentioned on arm drivers.

That generating errors will need to be left out of the series and should
have its own set of changes to allow compile test.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV8ZodAAoJEMLUO4d9pOJWeMoH/1YYIEz5cPXGPQ5TjDh6VSZ5
iNTlFuSGAx5jyx6c0O2Lm1eo5ec6fPR6NSI/EXjUXQ6eWEI0BhK5GeM70DyZvVCa
rZKOIxoTOGRhf9VLBhPRUP8iX2+M4Xj/NddhsUQedms51wdFkk2KSYgfubSILHll
hCblkqc4czdhTkRs1Xl2qhZOoopLEB8rQfLpb3Ar8K6Crd8k6hWhmWaSthXB2LBG
HvpfB8HNV9olP3xAPupDV5yF7g+YfqUvYGCuiEVoxViLuIRm1EB+pM+GE1yaeRUw
zy1oPiUW0DeA1YV8b1LfStTdpISb5/bNCIg5RMyAzlsQa8No36uoIwoJcwZEm/0=
=JAEx
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
