From: Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Tue, 27 Mar 2018 13:59:20 -0400
Message-ID: <1522173560.6308.66.camel@surriel.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <1521736343.6308.25.camel@surriel.com> <4731938.EeADOapqQb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Onh9PnjSnstD/olei6UC"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4731938.EeADOapqQb@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--=-Onh9PnjSnstD/olei6UC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:

> Does it improve if you do something like the below on top of it?

First off, apologies for doing my testing wrong.
There was an error, which was cleverly hidden by
scripts, and things were not running the way they
should.

After running the tests right, I have seen some
results. My own test patch of disabling polling,
and always dropping into at least C1, resulted in
a CPU use increase of 0.4%.

Your patch below, with a single cpu_relax(), and
the local variable to not read the TSC too often,
seems to give the best performance here, with a
0.2% reduction in CPU use.

Again, apologies for messing up the testing.

I will kick off proper tests for that other patch
series right now.

> > Let me go test the nohz idle series by itself,
> > without this patch.
>=20
> OK
>=20
> ---
>  drivers/cpuidle/poll_state.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> Index: linux-pm/drivers/cpuidle/poll_state.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched/idle.h>
> =20
>  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
> +#define POLL_IDLE_COUNT		1000
> =20
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int
> index)
> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
> =20
>  	local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> +		unsigned int loop_count =3D 0;
> +
>  		while (!need_resched()) {
>  			cpu_relax();
> +			if (loop_count++ < POLL_IDLE_COUNT)
> +				continue;
> =20
> +			loop_count =3D 0;
>  			if (local_clock() - time_start >
> POLL_IDLE_TIME_LIMIT)
>  				break;
>  		}
>=20
>=20
--=20
All Rights Reversed.
--=-Onh9PnjSnstD/olei6UC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq6hngACgkQznnekoTE
3oPIpwf+MfZDkVm3CN/aLediDInXMv8AoW1maIo6h/kSd35OqqP6F4royk/cxxKQ
sDCrhJhciLJi+W6QNzJCV4vuS4howGuzeepeJABXbMgChsTYVnP539ZjSezU/20J
HvkaU6J5KTsgQh5RqgTPBaDNaheprWLOWZHeddaBieJyD55u9vCYg5o5dDvhjNvn
wjtbSNr66JEDjd4fOeo3PihK0vO45dFqZb23Acyr0K4xM2nI2zsuYT67fRux0qLQ
TFdmp3SwbDe5SoiZWMpJzvoP0bHQDOrx88tOq1o767IUMFoNGuTcicS61WCnV+4T
a2gB3HDIhVmAbN6yb8ojW7U8G2/O0Q==
=lcJq
-----END PGP SIGNATURE-----

--=-Onh9PnjSnstD/olei6UC--
