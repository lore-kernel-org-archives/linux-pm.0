From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: rt9455_charger: Fix error reported by
 static analysis tool
Date: Sat, 13 Jun 2015 04:40:32 +0200
Message-ID: <20150613024032.GD17513@earth>
References: <1434111951-9378-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50430 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbbFMCkh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 22:40:37 -0400
Content-Disposition: inline
In-Reply-To: <1434111951-9378-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jun 12, 2015 at 03:25:51PM +0300, Anda-Maria Nicolae wrote:
> The result of container_of macro cannot be NULL, so there is no need to
> check whether info is NULL.

Thanks, queued for 4.2.

-- Sebastian

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVe5ggAAoJENju1/PIO/qaEKoP/32p3nujIy1UKhB0aYaqmRnw
i3UP40Yo8F8kDtxWfHtcSWxZVaK5TtR3c0kwWsKkt/bjryilpiCjMmu3VQn74SlX
CrwgZr1cZalnkhxROaJrbJD99Q0UBabJWUgCvC9Ves0U+J7A+Prah03HU6zCeCWo
nl4ZenSY52Hdi4iM7GW75vlKAM4Budopx7c/3wR0JwU492hcMzzcXEWCSEVTUAuH
Z0UglsxNItyKsSxvxTuIdjeSlrZ1xbIhv11glaCoDrdURuInjK46cEbqGdDbzhol
oyPu83tNYMP4q/BWG5j1iWvhxfn+7PJjqiXT/qjIB7+TW4azMAXnmNzfO3UB40o3
yx2sAahC2KMKnqKpUULF2ZvxO9sTB8BgzaO3X60nXe54VkFpZbFa/X3q4BpkI46m
daEAoMK4CUMEzHxHNRXLR0kEdfrnF4qTDnQPczcrX8o8V45xTLh9HoVFs6DkRRlQ
yF2XgZjkV1V0ivWWAVgOkyegHhcr6TmoCZ+k4DxSnfcLhLTjKWx2N1wsWdXGV6s5
3SeUgztfwAxrEf2IlTh4OTPcI9z1jPRq6/b0oC41UJWDLuRQHMgVEne1Dz1Wh82P
MkvAMZbt+DZXkyMocjg6Nz3zmXgRpHCiokFuXk4n8UwxmC+C+LkkkonXwNqhv7KV
yjWR+o7nKUxeiKNFNjAb
=vNjQ
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
