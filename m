From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Sat, 7 Mar 2015 20:26:11 +0100
Message-ID: <20150307192610.GC5233@earth>
References: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55279 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbCGT00 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 7 Mar 2015 14:26:26 -0500
Content-Disposition: inline
In-Reply-To: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, todd.e.brandt@intel.com, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, lee.jones@linaro.org, david.woodhouse@intel.com, jic23@kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 04, 2015 at 04:24:35PM -0800, Todd Brandt wrote:
> New power_supply driver at driver/power which interfaces with the
> axp20x mfd driver as a cell. Provides battery info, monitors for
> changes, and generates alerts on temperature and capacity issues
>=20
> Sebestian, please review the patch set and consider it for 3.20 rc1.
> I've applied it over git.infradead.org/battery-2.6.git/master and
> verified that it works. Thanks.
>=20
> Todd Brandt (3):
>   mfd/axp20x: change battery cell name to fuel gauge
>   mfd/axp20x: add support for fuel gauge cell
>   X-Power AXP288 PMIC Fuel Gauge Driver

Thanks, queued for 4.1:=20

http://git.infradead.org/battery-2.6.git/commit/5a5bf49088f4c92f36786a2e4c2=
0e17f715f0827

-- Sebastian

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+1DMAAoJENju1/PIO/qa7bcP/2ZBBv9t8uZhQ9FZIu3G0I9f
Ak+ZV3eJ+4NYRHFrkV/cWded4/c4SJdBU4GsfGN5kPUUBlUrAvbRIrDVNaV+o0AR
U6pxKgX5ZZ4BbD4ebohrQ7/rd2ETj5u0rEqGRDS1gSdp9cH2BdhfZcaU+K2XrOU0
vxJDXRZnzYmR5zMZOQCxqUGAx0ggvlJfh25/0ceS6PvjSLpRxinybBW+5s7hqcRa
zKI0eNAco0IldjVx25MH407pOI/D1xLWnAn3xdFzyZvbEOXjr9nHWqdmIRcNPKfm
xvT+3mizhG3ALZCz5+UqYXVWJ6qhtfV6Xkanjtnfk5cHzn0xkbwxzZBsSw7Nzk2h
/k/MjUgIUKDasxMQhszEahGjoldOEW54R8PXZLAHwTwd2zeN2EPIousdq6eCzviX
AYjxC2s15Exc8T6ZmWuv+V4VcuBG4pcdMF3B9VGaP6vWy0va+Cixg2yygi5XW6JC
le5RkFAeAQm6h4Nlu0ukcFPnPuHUSL/7w2JkR/UECyIR5nnIfYyPtxkw+Ietn6MO
wEbqMWAGidMJ8l5PJOZyyjdeqq2utylgN5sqB1lQQbo7xGsgVrP/Y4o5Vjx/CqNY
rhfal79jU4HzCDlTiIIKrw2dAvd8TCa05UsuCS05Yaj473uHjm7yKGvKFZ4pOBfh
OYbzvPsfr+H6T4oyHTb/
=5wJh
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
