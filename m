From: Rik van Riel <riel@surriel.com>
Subject: Re: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Fri, 09 Mar 2018 10:19:20 -0500
Message-ID: <1520608760.4638.14.camel@surriel.com>
References: <2450532.XN8DODrtDf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kivsYyhsThfbxsTVQyQ+"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2450532.XN8DODrtDf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--=-kivsYyhsThfbxsTVQyQ+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-03-09 at 10:34 +0100, Rafael J. Wysocki wrote:
> Hi All,
>=20
> Thanks a lot for the discussion and testing so far!
>=20
> This is a total respin of the whole series, so please look at it
> afresh.
> Patches 2 and 3 are the most similar to their previous versions, but
> still they are different enough.

This series gives no RCU errors on startup,
and no CPUs seem to be getting stuck any more.

I will run some performance tests with these
patches.

--=20
All Rights Reversed.
--=-kivsYyhsThfbxsTVQyQ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqipfgACgkQznnekoTE
3oPL3Qf9Ft0ww8bRf9/uOXj457aBHCKjX53DXAYmZRAAwyutPzaMUxHSadRoc5Db
vJZJ5bu3pPYbgCu7b7+rJMxoF86A0M8cHrr4YTJsGwsmUDTXQzsm14VJGamELqOI
aiOpc4zg/hEISdx/4bpSCvwBmXxwptnUnrnwcO1lJXfiBB/H+jIGaR69rBekARx7
juIQa02Ahb6bTes2tR2jGUFofWDs+dle+9xa8HRs2t5fU4Z3nKmxu7L1G3gaEt5f
3SCfDE81CdWrhtJG7DIW8P5Y94Xh34x/VV4dGN+mLoHs6Gc2Pi8oxKliZAjVc7WN
n1Xh2e7WkBcbE1Z+phvZ2BBOY7pj8Q==
=6ZIb
-----END PGP SIGNATURE-----

--=-kivsYyhsThfbxsTVQyQ+--
