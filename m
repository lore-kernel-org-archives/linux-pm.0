From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: gpio-poweroff: let devm_gpiod_get set
 direction of gpio
Date: Sun, 24 May 2015 21:44:37 +0200
Message-ID: <20150524194437.GG11066@earth>
References: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54531 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbbEXTpA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:45:00 -0400
Content-Disposition: inline
In-Reply-To: <1431981907-32578-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 18, 2015 at 10:45:06PM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.

Thanks, queued.

-- Sebastian

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYiolAAoJENju1/PIO/qaStwP/1IBnYuMdkAEesMHQf59itgx
wpAnnu3eGYXfKRr9uypEhFBGUZ+T9O6MvZUUNx8cuCMFtYVkcU5m1Pw+ovWft/PM
VciZMR6yXJOaPN70LEJa/dkMQRevjxff8/Mt6K99fZ5j06t246bl/SrcVylkvOYz
/ns+06IS3h2vdJAgOvaDvYUfufQ4dAsWLxE56ePOEdvnmhz6kDdw6xrOJfZAgHsC
zcEXPTUcdlOHNVsUdxiKEO39k3WwXVrgjtS3LBrQdq7Kz8xbPQ71JHxg1V6rUYVY
/tMBmJNEtMiK2vXeikS1SkSME9WneTOHKFEp3DGi/t7/aJ1Lt2bJj1T9+lOqc+nn
VlvvEixMeBXYXc3zMX4zDTylU0OSnEfLhA7BKFPh4fpkIUOtFm3Ke2HEmdsAyMmn
fKq44Ekqr6cR2HMv13Jvrr7OxpB99b5QocfLpb8ce/NxAhiM9lwQm9YGRFgzNa7C
2tI1koWBHhw1L0tcfe+S1iS41iLWJkKYADoeJnrYLBTPpa3v/qFjxVlB97eWSDi+
is3lkPzxCO2FStkXUUxn61mlmUDsIUQxGrHctIU5C6r5JJ/ABDo2wKnLaE3xoy1t
WSa9EjYAE+K4E62VgeoqEXQ8iTAfEuqGmTQ1iatiPGelk3svwIQ6M1D3Q5ifuQBY
JNa0nOhbsopbndsMSm4p
=KPJH
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
