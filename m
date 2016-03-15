From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 22:03:15 -0400
Message-ID: <1458007395.8898.19.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <97183685.ubU62sp0PR@vostro.rjw.lan> <001001d17cfc$67721e70$36565b50$@net>
	 <3851575.bLxYIFy0zG@vostro.rjw.lan> <001901d17dbc$3788f060$a69ad120$@net>
	 <CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
	 <1457965862.8898.4.camel@redhat.com>
	 <CAJZ5v0iuLP6b3LHY_BVmAQ12qeeVWhVUPnBh=F4-nFuFr_73DQ@mail.gmail.com>
	 <1457977512.8898.13.camel@redhat.com>
	 <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2BnX2F4RaWcr6DOI26bX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934291AbcCOCDU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Mar 2016 22:03:20 -0400
In-Reply-To: <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-2BnX2F4RaWcr6DOI26bX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-03-14 at 23:55 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 14, 2016 at 6:45 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=C2=A0
> > A lot of the logic (especially the load correction) in
> > menu.c was last fine tuned before several bugs in the
> > corresponding measuring code were fixed.
> >=20
> > I don't understand your patch well enough to object to
> > it, but the "start the loop at poll instead of HLT"
> > logic is becoming rather convoluted...
>=20
> That logic has been there for quite a while, though.
>=20
> Really, the choice is between a simple revert of commit
> a9ceb78bc75ca47972096372ff3d48 and doing something in addition to it
> to mitigate the "C1 is hopelessly slow" issue.

That is fair. =C2=A0I suspect your patch will be better than
a revert on systems where C1 is really slow, and just as
good as a revert on systems where C1 is fast.

We can worry about the choices between deeper C states
in a future version, but for 4.5 your patch would be the
way to go.

--=20
All Rights Reversed.


--=-2BnX2F4RaWcr6DOI26bX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW521jAAoJEM553pKExN6DBXYH/1egLwtn7OA+9VE1svnTQVPk
A2QopnmA3JaOY6Ux6ywqqw+UIxoh5DT+fuQfs7g8hd6PiysiixdEWi12jpnGzLVN
VUDGlSYGLCyA6V/h4svIhEwUcvwE2JtJ0m6AQBf+SNvKqAqHRMF/GzyxcRG9dqMd
uY7d7IyN3IcraUiR+KAsFKEV7Qwsp2oHgCRt/Zn+wSXSfaGJwcO0jOs2FYM40Zhx
EQQ0E2cnR7ORu2xECDdEVhWRssnt13MTrBQZuKViJ0CnpOgkXKzj+MewLLuAGieS
xatTlFkK/+GnQ6xRVhSLgPPGLGRVOOpP+Zr6a0HKbfn2iLVKiVAS4ozUumWybVQ=
=5XYs
-----END PGP SIGNATURE-----

--=-2BnX2F4RaWcr6DOI26bX--

