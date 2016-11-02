From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: fix device reference leak in test_suspend
Date: Wed, 2 Nov 2016 09:52:30 +0100
Message-ID: <20161102085230.GB23350@amd>
References: <1477997396-29476-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41483 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbcKBIwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2016 04:52:33 -0400
Content-Disposition: inline
In-Reply-To: <1477997396-29476-1-git-send-email-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-11-01 11:49:56, Johan Hovold wrote:
> Make sure to drop the reference taken by class_find_device() after
> opening the rtc device.
>=20
> Fixes: 77437fd4e61f ("pm: boot time suspend selftest")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/suspend_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
> index 084452e34a12..bdff5ed57f10 100644
> --- a/kernel/power/suspend_test.c
> +++ b/kernel/power/suspend_test.c
> @@ -203,8 +203,10 @@ static int __init test_suspend(void)
> =20
>  	/* RTCs have initialized by now too ... can we use one? */
>  	dev =3D class_find_device(rtc_class, NULL, NULL, has_wakealarm);
> -	if (dev)
> +	if (dev) {
>  		rtc =3D rtc_class_open(dev_name(dev));
> +		put_device(dev);
> +	}
>  	if (!rtc) {
>  		printk(warn_no_rtc);
>  		return 0;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgZqU4ACgkQMOfwapXb+vILNgCeI30Zed1gpnDudJf4Lp1oXI5T
oTAAn1H+Bexs1WlbuEqwVSOydurzYGCF
=vLFV
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
