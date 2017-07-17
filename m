From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / suspend: Add suspend_target_state()
Date: Mon, 17 Jul 2017 22:16:32 +0200
Message-ID: <20170717201631.GA13024@amd>
References: <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170717200628.7018-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717200628.7018-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via suspend_target_state() in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().

Do we really want to have variable + inline functions that just read
that variable?

> +static inline suspend_state_t suspend_target_state(void) { return  -ENOS=
YS; }

I'm pretty sure -ENOSYS is not compatible with suspend_state_t ...

> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 3ecf275d7e44..a296d6e25d52 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -47,6 +47,7 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
> =20
>  suspend_state_t mem_sleep_current =3D PM_SUSPEND_FREEZE;
>  static suspend_state_t mem_sleep_default =3D PM_SUSPEND_MEM;
> +static suspend_state_t pm_suspend_target_state;

Is there disadvantage of just having this variable non-static?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlltGx8ACgkQMOfwapXb+vKBPACbBfD+Uj52yvD9uV4ArztTqMlz
I90AniLU3N5mNCUSw61bodAy3/iVZkzi
=Bbqa
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
