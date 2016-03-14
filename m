From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 10:31:02 -0400
Message-ID: <1457965862.8898.4.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <97183685.ubU62sp0PR@vostro.rjw.lan> <001001d17cfc$67721e70$36565b50$@net>
	 <3851575.bLxYIFy0zG@vostro.rjw.lan> <001901d17dbc$3788f060$a69ad120$@net>
	 <CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Drpuuu/96OTk1FRNTyWV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965276AbcCNObI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Mar 2016 10:31:08 -0400
In-Reply-To: <CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-Drpuuu/96OTk1FRNTyWV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-03-14 at 13:47 +0100, Rafael J. Wysocki wrote:
>=C2=A0
> Rik, I think what we can do is to put a constant limit on the exit
> latency of C1 like in this patch.=C2=A0=C2=A0I'm not sure if 2 is good en=
ough,
> though.=C2=A0=C2=A0It can't be less than 2, because that's what the major=
ity of
> systems have, but maybe it can be greater?=C2=A0=C2=A0Any ideas?

=46rom Doug's description, it sounds like the problem is not
that we go into idle state 0 too often, but that sometimes
we stay there too long.

I wonder if it makes sense for idle state 0 to promote
itself to idle state 1 after some amount of time?

Maybe something like 2x the exit latency (or target
residency?) of C1?

--=20
All Rights Reversed.


--=-Drpuuu/96OTk1FRNTyWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW5ssmAAoJEM553pKExN6DIzEIAJaiKzYjxha+s3f8Odfrfire
kGJaBC+3YrKXmZgvTaoxvZTu3S2fi1fUVt+G/6jq46+afk0Zo9tF7Mb7Zt4leiur
XX8hU71soCPeL8IJUEmYobAD+BHjWVeqIMq9pSax9KyyRWz/Z6CVqqJqq1B64/zq
L6Uz3O2BDtwnvnLnAQfW97iMj4X6e3dxyfzLuBp2E44TRaa4JpVbB/lDKw0iKrm/
kV3V6hq5tC7i41sAMrgJjwuMr7/lmnQuYJFJSL4Tl9FsGSGfdfPEw4jTCzxZsqh2
Me4zS3AtaZNWksQSDyw4UraZ1RMASb8e/l6BSRXAwYYqP6pZ12vK86I1lCyydF8=
=0S85
-----END PGP SIGNATURE-----

--=-Drpuuu/96OTk1FRNTyWV--

