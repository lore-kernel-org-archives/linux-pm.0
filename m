From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Date: Wed, 9 Jan 2019 15:14:17 +0100
Message-ID: <20190109141417.GA8529@amd>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, len.brown@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support to check if platform's power will be cut off in suspend.
> This will help drivers shared by multiple platforms to take only the
> necessary actions while suspending/resuming (some platform may not need
> to save/restore all the registers if platforms remains powered while
> suspended). In this way suspend/resume time could be improved.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/linux/suspend.h |  6 ++++++
>  kernel/power/suspend.c  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 3f529ad9a9d2..21f19b167fe2 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_=
stat_step step)
>   *	Called by the PM core if the suspending of devices fails.
>   *	This callback is optional and should only be implemented by platforms
>   *	which require special recovery actions in that situation.
> + *
> + * @off_in_suspend: Returns wether the platform's power will be cut off =
at

wether -- spelling?

> @@ -185,6 +188,7 @@ struct platform_suspend_ops {
>  	bool (*suspend_again)(void);
>  	void (*end)(void);
>  	void (*recover)(void);
> +	bool (*off_in_suspend)(suspend_state_t state);
>  };

Dunno, should it be per-regulator? SoCs commonly have more than one
power supply, with some of them off during suspend...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2AbkACgkQMOfwapXb+vLmQgCgqAUamz2/knUA9Lf1Tl4BAceL
vXEAoIbw66S7wi6alwJxvhCaPmHDkJyA
=BZfz
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
