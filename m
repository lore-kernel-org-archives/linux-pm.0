From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Mon, 5 Jun 2017 22:07:13 +0200
Message-ID: <20170605200713.GB24496@amd>
References: <20170605193157.59875-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34076 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdFEUHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 16:07:16 -0400
Content-Disposition: inline
In-Reply-To: <20170605193157.59875-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-06-05 12:31:14, Mark Salyzyn wrote:
> Permits power state and battery life diagnosis.
>=20
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>

I don't particulary like it (RTC is slow on PC class machines), but I
guess the information is useful.

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/suspend.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c0248c74d6d4..464175f04bc5 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -26,6 +26,7 @@
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/ftrace.h>
> +#include <linux/rtc.h>
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
> @@ -563,6 +564,18 @@ static int enter_state(suspend_state_t state)
>  	return error;
>  }
> =20
> +static void pm_suspend_marker(char *annotation)
> +{
> +	struct timespec ts;
> +	struct rtc_time tm;
> +
> +	getnstimeofday(&ts);
> +	rtc_time_to_tm(ts.tv_sec, &tm);
> +	pr_info("PM: suspend %s %d-%02d-%02d %02d:%02d:%02d.%09lu UTC\n",
> +		annotation, tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +		tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);
> +}
> +
>  /**
>   * pm_suspend - Externally visible function for suspending the system.
>   * @state: System sleep state to enter.
> @@ -577,6 +590,7 @@ int pm_suspend(suspend_state_t state)
>  	if (state <=3D PM_SUSPEND_ON || state >=3D PM_SUSPEND_MAX)
>  		return -EINVAL;
> =20
> +	pm_suspend_marker("entry");
>  	error =3D enter_state(state);
>  	if (error) {
>  		suspend_stats.fail++;
> @@ -584,6 +598,7 @@ int pm_suspend(suspend_state_t state)
>  	} else {
>  		suspend_stats.success++;
>  	}
> +	pm_suspend_marker("exit");
>  	return error;
>  }
>  EXPORT_SYMBOL(pm_suspend);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlk1ufEACgkQMOfwapXb+vLr8wCfa7K4za3N3ANMo2a7PptnYs2e
658AniJGfQt5PNsW/umHYyI0D7viWbKh
=glsl
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
