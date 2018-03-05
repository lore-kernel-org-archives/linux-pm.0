From: Rik van Riel <riel@surriel.com>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
Date: Mon, 05 Mar 2018 18:27:01 -0500
Message-ID: <1520292421.6857.22.camel@surriel.com>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
         <2048240.1dZKXsSxFh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ntQ751av5UwqXDAdVQ+Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2048240.1dZKXsSxFh@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--=-ntQ751av5UwqXDAdVQ+Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-03-04 at 23:28 +0100, Rafael J. Wysocki wrote:
>=20
> +++ linux-pm/kernel/sched/idle.c
> @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
>  	} else {
>  		unsigned int duration_us;
> =20
> -		tick_nohz_idle_go_idle(true);
> -		rcu_idle_enter();
> -
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient
> idle state.
>  		 */
>  		next_state =3D cpuidle_select(drv, dev, &duration_us);
> +
> +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC /
> HZ);
> +		rcu_idle_enter();
> +
>  		entered_state =3D call_cpuidle(drv, dev, next_state);

When the expected idle period is short enough
that the timer is not stopped, does it make
sense to still call rcu_idle_enter?

Should rcu_idle_enter also be conditional on
the expected idle period?

--=20
All Rights Reversed.
--=-ntQ751av5UwqXDAdVQ+Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqd0kUACgkQznnekoTE
3oMX/wf/ZHGboeDGsR+H3JXX2WfdaH2aP/pz85X5CT06+5APrBQRwD+xqU8judhU
iicFAAkX8ZTYiq7BNSd7Ak7tu+fYKsmPuIBg4e4a4pRH2BJMh87fweneM7Fi4IoF
xAzdPNcBsXdgGQmrRmY9a2bpGiG3raYl36vSAV5re5eu69UZmDkNPYXphVRfwavs
pPILQV7uPHoLGg4blxzEP/sccJI8PpMLFlyewWGWMUEHQ0g0UeRvOyKQ1emd3ol6
OwBa4OKdUostc2O04eepAE7ItADlILIT2yJVuXaU3hWSScBm5ia1fCC6WXcfh/f6
wJi+DxxAxhBDajP508vIDVLeeObXbw==
=Qnmi
-----END PGP SIGNATURE-----

--=-ntQ751av5UwqXDAdVQ+Q--
