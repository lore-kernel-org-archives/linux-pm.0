From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power/reset: at91: fix return value check in
 at91_reset_platform_probe()
Date: Thu, 30 Apr 2015 17:38:49 +0200
Message-ID: <20150430153848.GC6133@earth>
References: <1429186783-20895-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59396 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbbD3Piz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 11:38:55 -0400
Content-Disposition: inline
In-Reply-To: <1429186783-20895-1-git-send-email-weiyj_lk@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: weiyj_lk@163.com
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Guenter Roeck <linux@roeck-us.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-pm@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wei,

On Thu, Apr 16, 2015 at 08:19:43PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function devm_ioremap() returns NULL
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, queued for 4.1-rc with proper Fixes tag:

http://git.infradead.org/battery-2.6.git/commit/932df43005389300a3336421e4a=
edb25390ae144

-- Sebastian

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQkyGAAoJENju1/PIO/qax+cP/2o8zcLIeoXzBmqlESO76Npl
Fd4Rr66/uTgKp2hQGN5S3Jdwk4saChXWZsX9DkoZHKmHSoB2YmexUsC9P96IbtOd
UnJ89ToOfs2sCGJetqfv0gz4AzcYx8X3et4E+RsqZwsJYhDy99B8Ov3kvg45/l+N
8vWo8mA6hjPBUS7nc+ilHwx6sL70QyFtPw9+ujkDgkqHVH3mnAJ3+7fhQBOlGVJB
JPecurHt/STknBuGcL4VZSZ37eaLdPB+HNyaZ7TM4BrQ40LGi19pnXRZVrWW7qSv
RnC2wtQtzxKY2J4bgMiVRsXJXIkGRFqOnQtMFaf0TR9R+8rosuNcRxch09g8DLy7
IQs1zGsP2LKcgF7HXetTNYAnTSSIaRVF8wcdsPAoe2jDjUsluu22CdpJGqRBQriG
29B6+kB11FMRWNI1cYQiefKxQOlBBL1l2cbYxRElH5kdR045nlZ61Jm3IA6dUzlC
PMJlj1HARWm6rW9Y6T66Na4UcZZO2F6ai9vMNHl+C0wxkT4PIFd9x/eOCgxZcKGf
2KCVWmLnf2b8cE2R04S3t7HTZ0Gzue6a49Bv2ey7z7pmgEzrmGcBrVdnRLkGKexe
Jtqp3tOmpdlEb4HXEuKVsPAk86qQomhvVjfhNvGVFcONcMWQlR3uTFWzeYRe+6kR
GnKMuo4PMhfZz8AIhjwY
=ttw4
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
