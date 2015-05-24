From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: at91-reset: Constify platform_device_id
Date: Sun, 24 May 2015 21:41:13 +0200
Message-ID: <20150524194112.GD11066@earth>
References: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495204-31363-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430495204-31363-2-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, May 02, 2015 at 12:46:44AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses
> it as const.

Thanks, queued.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYilYAAoJENju1/PIO/qat+oQAKHh4nRGTPYjTi0TPNkckEM4
NP5YP9C1y+8hGhLnOUijQVrZtF4lKPqLsppzdhBAShJHmIPGIYnccabUJAEs7kfQ
kytKXI67CeW57kgOwNp7t8Wqb9sSoSmp8ug2zxj1t3qXLv8JAJ4znuOoK/1L6KL6
1nj0y0genxm5RMH3NW8+OGRkkGL/TwhNxn4LNw5dm+EiIhjxiAfm6VZll3sqt3dA
A/WRBlnS1/wX6mLkeRxVV/fQQevA6RqthXH92XmyojZy1CutO9klpgWxX6jHRfWu
f2A7ZMb7sKAYx8vPou4GEYsYix022yt/r1cItcGIzp8ET3UUh/kffgqtb2Ez3p7F
djdccp5I1YCQc07NcmFk2K4lkG3JLZVoQruxSieXiFI5FXTMTQfH2yuH6yVLSib8
Khy4ztLUHBYCuw7x/WvaKZFBtIOpvWlXo77KnFXPrHPetZivM2ZhIxJGMdc97nDx
J0c3OCD85tIvupiBwHfaF/Uriuoxt2W41yaaHE4fFbGJ02QnAPiX6hWzHNwozT3C
lD6dFVcLiL6Wq3d8qyPsrQk6sfkq0xR18S1QuMtHDUj1KGlT7lcyS0X1apr1Vb83
uCfQgiTZrKj0syxRKI48JZFUM17BuYQSdmJrbpdm8b0Zq7GS71Bb/BmnnLAzShcx
ss4L09nX5OPratI2akhS
=lmTr
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
