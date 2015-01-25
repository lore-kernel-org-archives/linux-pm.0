From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/6] power/reset: restart handler patch series
Date: Sun, 25 Jan 2015 22:44:57 +0100
Message-ID: <20150125214456.GA20695@earth.universe>
References: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34982 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbbAYVpD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Jan 2015 16:45:03 -0500
Content-Disposition: inline
In-Reply-To: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sun, Jan 25, 2015 at 12:30:39PM -0800, Guenter Roeck wrote:
> Register with kernel restart handler instead of setting arm_pm_restart
> directly, plus some other cleanup.
>=20
> v2: Rebased to master branch of battery tree

Thanks, series applied.

-- Sebastian

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxWPWAAoJENju1/PIO/qaCyUP/iRu84q6Zh41fjFYCPAiyc3M
fgNZqeaz/B74rB+rTApP4O+k4qw/qwTBsd9IBylhjNn8P3Q1nAZLLXVZYHZfHzZW
IWjHSU+RvPL29xjqKOO3RWR1UGCm83omI7vkvYp3Ivntc40/UPxgiu4SIJyZ46CE
gaC2d4F1J891ef+p6m44+R5pBTTuAya7HcyNPDtpactrMrZjhvjx3e7ir1WGXXW9
/4QGYY4HiB+j5DTuUZDxihhtepF8p0+zxmM/T71/isk053Fr9H+LWvubjbFYnxRD
WQyFUt1VCi6MosN2Plh8Y72CddyLN+NA1AST2lXoFDK2/6uZR6J7qkwqzTouZmzN
ny8fC1yWFD3uS8LlJxDJprKdGM5jB6Hz0ERjwXokqz9jpX6H1BHJHBjz6K8yhakL
yFKoTBM5hOlOAhMZaIBW20hlaDTxI/WECMQbBSFkHi4GwrVlS2oClJCiz2BuNjBq
NX4sGUyM3fFep42m3Cyas86iHx49H3Qrrgc11RGZ5GstFdAE9/f3E6sJ1Mlr+FKV
32+HpIdqDNui4rCTspEeTR4uh7teqZykijE+gVC6IVEYe1jxg4IfHv7oJhMIwj9w
OrYJpibaIg6RnXHEMICCbk8UBgPo9DPyfexnZNozrxldxV/NELCoHv9DphWaPEoV
2PSRSCAcbZR1kc1mvOZR
=Udyf
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
