From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Fri, 26 Jan 2018 11:26:04 +0100
Message-ID: <20180126102604.GB13775@amd>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40767 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeAZK0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jan 2018 05:26:06 -0500
Content-Disposition: inline
In-Reply-To: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-01-26 16:38:19, Jia-Ju Bai wrote:
> After checking all possible call chains to genpd_dev_pm_detach() and
> genpd_dev_pm_attach() here,
> my tool finds that these functions are never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> Thus mdelay can be replaced with msleep to avoid busy wait.
>=20
> This is found by a static analysis tool named DCNS written by
myself.

Well, cond_resched() just after msleep certainly looks like that.

Did the patch receive any testing?

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0c80bea..f84ac72 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device *dev,=
 bool power_off)
>  		if (ret !=3D -EAGAIN)
>  			break;
> =20
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
> =20
> @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  		if (ret !=3D -EAGAIN)
>  			break;
> =20
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
>  	mutex_unlock(&gpd_list_lock);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlprAjwACgkQMOfwapXb+vJlYACcCZMDA5fnbjAcpcs14r+abqYK
05oAnA+nCUBwmKUNZqAD1OtDU9otgPVV
=1yYv
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
