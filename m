From: Rik van Riel <riel@surriel.com>
Subject: Re: [RFT][PATCH v7 0/8] sched/cpuidle: Idle loop rework
Date: Wed, 21 Mar 2018 08:31:07 -0400
Message-ID: <1521635467.6308.13.camel@surriel.com>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pOBjBDEiGvoqpx9GdLow"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--=-pOBjBDEiGvoqpx9GdLow
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-03-20 at 16:12 +0100, Rafael J. Wysocki wrote:
> Hi All,
>=20
> Thanks a lot for the feedback so far!
>=20
> Respin after recent comments from Peter.
>=20
> Patches [1-3] unmodified since v5, patch 4 is new and the other ones
> have been updated to address feedback.
>=20
> The previous summary that still applies:

For some reason I see increased CPU utilization
with this patch series (75% -> 85%) with the same
rate of requests being handled by the vanilla
kernel and a kernel with these patches applied.

I am running a bisect in the series to see what
change could possibly cause that, and also digging
through system statistics to see whether it might
be something as perverse as not mistakenly choosing
deeper C-states on one core causing other cores to
miss out on turbo mode...

--=20
All Rights Reversed.
--=-pOBjBDEiGvoqpx9GdLow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqyUIsACgkQznnekoTE
3oN78wf+OJ4QuksPXOz0LCke+Q6pr4fSTjKGqXdHlCRdX+7lF1PuZBiqxkF0S7SJ
ndIKGyTXpsmL03rMtmGY7nWJbC+dO60Xdf+eEWXyYk4Qpjwz/+P6J6Ty75gDJp7h
gwljVEE6aB5dlYvhS9pmdFN8ZKbDAHr2eddyOh5C35HfTuD0Z9NrXknKBl2cGan5
YeE/+tQ7Po0+L419nBmZCEkxnWLCoIcw+rGedo6M1ebum+EK3WBiVrftfgv+At77
vM9bksnc2T+HSdUEGJXOrr87duDpp8PF48QovGlcZGKR8Uh2wf0VQ8k1t3iWoyQK
obG/j+L/UOKwgF3IjI36+VbcsOHAVw==
=DPSM
-----END PGP SIGNATURE-----

--=-pOBjBDEiGvoqpx9GdLow--
