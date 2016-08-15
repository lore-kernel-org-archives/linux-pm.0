From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: tps65217-charger: fix missing
 platform_set_drvdata()
Date: Mon, 15 Aug 2016 23:11:43 +0200
Message-ID: <20160815211143.rg5rfydyaujfuvze@earth>
References: <1469544544-31749-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ahcpbxtagbp4jmu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49666 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcHOVLv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 17:11:51 -0400
Content-Disposition: inline
In-Reply-To: <1469544544-31749-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--3ahcpbxtagbp4jmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 26, 2016 at 02:49:04PM +0000, Wei Yongjun wrote:
> Add missing platform_set_drvdata() in tps65217_charger_probe(), otherwise
> calling platform_get_drvdata() in remove returns NULL.
>=20
> This is detected by Coccinelle semantic patch.
>=20
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Thanks, queued into power-supply's -fixes branch.

-- Sebastian

--3ahcpbxtagbp4jmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsjAPAAoJENju1/PIO/qa8cwP/AreytEYgw7zZYaoZcp+QgQe
CauzuqPYmL+uui7E9RDi3qD7/YIjmLQLiFDokmgOfAFxM1HOYnIytdpBGZtB6EAO
tVyxA9C2yra+4C1lXsy3oL3mFnvl01xOcW23Vu9YlxRv10Nzq95bkdOhEXXIV2Hj
PLgsypRlR0C77z6uvkxlu0TRvhglL9yZrlM1Ivg4rM5H9CRADHJ5UtA5i3e0INLd
HDlMLlsv/6EWwHJy19rtb3G+tXlOFzMOdCD7GbiyeMdiV+xQEWrBhNPu1auHK1Yl
ZHAUB2MVC4GzDjqZMQw2lriMbVZv6umChRwILy+/cZjq9zewNCIknKyFT/7QzfMg
cA+Si9JqdD7BiYk3D+xEqXrqjnTY3/YbQvy1unnCtSiI1mEWS9yWvmLdSITzbtn8
t3y8uAJXsZHkrD1ZRVpD6IXD3hreb7O19tXlS+nr2OQuMaFBqqbhEnidoCqZl++O
gySlc/rzQwtLxSaONW1EdflANRbfLvsq9a+40MOpR2wRmVlz+vkIDACJJ8mCDPp+
wdkuOmWkOi8f5YrJO47cXNuxbf7RvNyp5vt9ytl63jwoN7CThQunrTyHNFKt6gIu
ucEMjunvor9O7EAjZsukmXjfmsbvsYxPvGzacBAtht9GO+LriJVRcVM6QrYd+/Di
LMjV/f+yoVN5IqvgwNN7
=egbP
-----END PGP SIGNATURE-----

--3ahcpbxtagbp4jmu--
