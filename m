From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Mon, 14 Mar 2016 13:45:12 -0400
Message-ID: <1457977512.8898.13.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <97183685.ubU62sp0PR@vostro.rjw.lan> <001001d17cfc$67721e70$36565b50$@net>
	 <3851575.bLxYIFy0zG@vostro.rjw.lan> <001901d17dbc$3788f060$a69ad120$@net>
	 <CAJZ5v0g68mq0bKy5UTzh8qM7fFC0a0SY9+EA2GsDhCVUcSLD1g@mail.gmail.com>
	 <1457965862.8898.4.camel@redhat.com>
	 <CAJZ5v0iuLP6b3LHY_BVmAQ12qeeVWhVUPnBh=F4-nFuFr_73DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-R3FOy547eWlXY2MKdXtD"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbcCNRpq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Mar 2016 13:45:46 -0400
In-Reply-To: <CAJZ5v0iuLP6b3LHY_BVmAQ12qeeVWhVUPnBh=F4-nFuFr_73DQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-R3FOy547eWlXY2MKdXtD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-03-14 at 16:21 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 14, 2016 at 3:31 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=C2=A0
> > Maybe something like 2x the exit latency (or target
> > residency?) of C1?
>=20
> If the goal is to avoid entering C1 if the exit latency is too high,
> we should be checking the exit latency IMO.

I agree with that, but doesn't the current code already
do that?

The code currently checks against both the latency_req
and the expected sleep time. What is the rationale for
adding another latency to check against?

I am trying to understand what the goal is here, and
under what circumstances the logic in the main selection
loop needs to be overridden.

What is the main selection loop doing wrong?

When is it causing bad outcomes?

Is it causing other bad outcomes beyond C0/C1 selection?

Can we just ignore polling and always go to HLT, leaving
out this (somewhat kludgy feeling) part of the code?

If HLT is sometimes too slow on Atom, is it also too slow
for certain workloads on faster CPUs? (say 10Gbps ethernet?)

A lot of the logic (especially the load correction) in
menu.c was last fine tuned before several bugs in the
corresponding measuring code were fixed.

I don't understand your patch well enough to object to
it, but the "start the loop at poll instead of HLT"
logic is becoming rather convoluted...

--=20
All Rights Reversed.


--=-R3FOy547eWlXY2MKdXtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW5vioAAoJEM553pKExN6DsTwH/0sqGEx+7H1M8UuOLuqa0u0Q
wH/SpIJakjTOTEX2BB1yXMgb2CUTYwEFC4Se2XFuJ0vU8fL4ebL52AzEnToXPJW9
O343mhsx4bO7DEvjKF2hh8JZDGN8W+c6HTnd5NLgWbXUHQoc+7k+kC3CCKfscc0M
JRGT/yVSxZDDtUCOomERCCvIMUTenffdB0HB8OGmW0aF9vVv+TUoqRi8X92F14ei
XFZB+lpcvXNlC+8OagqgGXCoe4uwNxiDr3achUajuyyM+/nrAMrCCadsHLeFg08/
1/CnNV6/BHM19HjpfLUcO84f+aKr+kld5Jl0yXuvIaH7sCs16O/ftl/UKgwKyS8=
=oTSg
-----END PGP SIGNATURE-----

--=-R3FOy547eWlXY2MKdXtD--

