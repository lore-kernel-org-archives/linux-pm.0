From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] time: rtc-lib: Add CONFIG_RTC_SHOW_TIME_RTC
Date: Thu, 20 Jul 2017 10:26:20 +0200
Message-ID: <20170720082620.GB14149@amd>
References: <20170719195012.30187-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719195012.30187-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, prarit@redhat.com, andy.shevchenko@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +#if defined(CONFIG_RTC_SHOW_TIME_RTC)
> +	{
> +		struct rtc_time tm;
> +
> +		rtc_time64_to_tm(ts.tv_sec, &tm);
> +		pr_info("%s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
> +			prefix_msg ? prefix_msg : "Time:",
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +	}
> +#else


This was NAKed before. Are you even listening, or are you trying to
flood us with enough mail so that someone applies your patches by
mistake?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwaSwACgkQMOfwapXb+vIFlgCgxDtK+Jtp1i2XAI6AbY/EfR9r
ndQAoLtvZpWyASjMc04hkeojHB0H1G4m
=FKHI
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
