From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Sat, 23 May 2015 20:10:05 +0200
Message-ID: <20150523181004.GC16004@earth>
References: <1430782832-16518-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55655 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758059AbbEWSK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 May 2015 14:10:26 -0400
Content-Disposition: inline
In-Reply-To: <1430782832-16518-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 05, 2015 at 05:10:32AM +0530, Ramakrishna Pallala wrote:
> This patch adds the support for following battery properties
> to max17042 fuel gauge driver.
>=20
> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
> POWER_SUPPLY_PROP_TEMP_MIN
> POWER_SUPPLY_PROP_TEMP_MAX
> POWER_SUPPLY_PROP_HEALTH
>=20
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The patch does not work for me:

drivers/power/max17042_battery.c: In function =E2=80=98max17042_get_battery=
_health=E2=80=99:
drivers/power/max17042_battery.c:150:34: error: =E2=80=98MAX17042_VMAX_TOLE=
RENCE=E2=80=99 undeclared (first use in this function)
  if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERENCE) {

-- Sebastian

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYMJ6AAoJENju1/PIO/qa34kQAKh6eT52jj/sVOGUKOy3fJmv
Vbyj2L+WtRkP4neO8CVMR+BAApTkz2/5Uw4LQqItxipV+aDwZcgZ5x/LjSU3FokM
B87puv3qq7aMV3BvXXKr/JPBnYBUsgX23kM+SJU0sYCA9hRP9BQWWS+ERBnGZb/o
dC4xk6NRiiu3AI3Ng142+s2ij931Z7tqYP1G9dIAGAPxRprXo9Kp4YatER4MBkBo
jHoCo7ZNm4Aoq250TIThAzS6jguU5PCJy6QDW11O2P1n4qBZR82gJUvUsVYa1qrq
ZsPPLiPPIKHYuPjuYe4zlAW9TBLjyCKk9Bjo/f4BHThZ1AF4Jd0sRdNqvpCQqyce
sO6kc0+D86VHhnjegLk2x1OBdj/WCuwvWZC6pzTrsNi4cwhSRHk/l4N0EnyPYBXm
+7gj1Fg2KyLI7RTERhLQytH230Cyc8Ey4k+aki5mZhth0XciVWsA/G/3pKLaclmV
7+ViHFY4xb+TgcdJmhqT2eQiYCWAUY3PJdRyisCw+clHkkInQesLoRCr9ScvXJ0M
5ck06OQyndYjyVw+v2E0tG/DyEIQjdCI78nd8lPaCinl7Q1piykqorC/RCG79fWS
S/ZV1+c6x+E2BsQ/bXJP6ZZB+qx2FY1pgTXDQTwokU/NrqYNLWCs8uGrU2amo0zN
oGbU/eRF+X2bl20y/o3C
=ukgy
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
