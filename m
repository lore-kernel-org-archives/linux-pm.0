From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Thu, 20 Jul 2017 10:20:56 +0200
Message-ID: <20170720082056.GA14149@amd>
References: <20170718211930.123077-1-salyzyn@android.com>
 <alpine.DEB.2.20.1707182338470.2425@nanos>
 <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56297 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933731AbdGTIU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 04:20:58 -0400
Content-Disposition: inline
In-Reply-To: <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >
> >       pr_info("My so important log message %lld\n", ktime_get_real_seco=
nds());
>=20
> Legacy (these prints have been in Android tree since 2013) for all our
> battery and power analysis tools are keyed off RTC format. There is some
> momentum, default should be epoch seconds/nanoseconds as that is a good
> example; and another option can select RTC (the option can be an internal
> patch to alter the format ... ick)

Yes, android development is broken. Please fix it, rather then trying
to break kernel to match.

Thank you,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwZ+gACgkQMOfwapXb+vIVfwCePk4KpuLs/i0zZy9OPlVmW1m3
63cAoLdybneTlT37SgH41azZUEDtbI8Z
=dL6m
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
