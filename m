From: Rik van Riel <riel@redhat.com>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on
 4.5-rc4
Date: Tue, 01 Mar 2016 14:22:55 -0500
Message-ID: <1456860175.25322.59.camel@redhat.com>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	 <87a8mv9ujm.fsf@iki.fi>
	 <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	 <87egc6zc2q.fsf@iki.fi>
	 <36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	 <56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	 <20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
	 <20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi>
	 <20160229201946.0bdcc48e@annuminas.surriel.com>
	 <87twkqllst.fsf@kirika.int.wmdata.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-p4nfIFGTQ16lfTEs7FjS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbcCATW6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 14:22:58 -0500
In-Reply-To: <87twkqllst.fsf@kirika.int.wmdata.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--=-p4nfIFGTQ16lfTEs7FjS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-03-01 at 09:06 +0200, Arto Jantunen wrote:
> Rik van Riel <riel@redhat.com> writes:
>=C2=A0
> > What exactly is the problem you are seeing, and on what CPUs?
>=20
> Quoting from the first mail in this thread:
>=20
> When using kernel 4.5-rc4 my Skylake machine runs very warm since all
> cpu cores are always kept at 3.10Ghz (with maximum without turboboost
> being 2.6Ghz), completely regardless of load. Swapping between the
> governors (performance and powersave) doesn't change the result in
> any
> way, frequency remains at a constant 3.10Ghz.

> > What does the cpufreq table for that CPU look like?
> >=20
> > Does HLT (or its equivalent) have a really, really high
> > exit or residency latency?
>=20
> I don't know the answer to either of these questions. How do I find
> out?

Could you run this?

#!/bin/sh
for i in `seq 0 10`; do
	if [ -d /sys/devices/system/cpu/cpu0/cpuidle/state$i ]; then
		echo -n "state $i latency: "
		cat
/sys/devices/system/cpu/cpu0/cpuidle/state$i/latency
	fi
done

--=20
All Rights Reversed.


--=-p4nfIFGTQ16lfTEs7FjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW1ewPAAoJEM553pKExN6D7eMIALBpY6EMHtlGGmqGQ1SFMrYb
RGt1Emz+y89jg870xf0Xhs5IY2udPOs3QFoH4U2Y2UDqWfqVW+DUDh3L/hFG4vEf
CWpXM+Jee8d14tE3nBkj6stbGDxwSvNSh0KUef7PS64NlNxjz+f/bTtoS/WZGb8Y
+zWyeTpgF0VSobkN8knjXoWLRMjiilpN8yc3OUiuGbmRy0ZHTdNdI1knZ1sKmD28
D1Op0lXF+RmVESfY/5kTVlNigqMd8I05XtbQufGUHNbmAuKIUkMsEHiK0NoU7Bjj
MCOIlr1A9Cneqn6ff9y0CN/I+URpBjwnHPbjsQ5q3geHa6rWToQ1W9LCFJTcQiE=
=xXYq
-----END PGP SIGNATURE-----

--=-p4nfIFGTQ16lfTEs7FjS--

