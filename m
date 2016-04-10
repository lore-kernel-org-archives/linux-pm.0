From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: fix power status when battery charging near
 dry
Date: Sun, 10 Apr 2016 18:28:17 +0200
Message-ID: <20160410162817.GD25923@earth>
References: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57945 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbcDJQ2V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 10 Apr 2016 12:28:21 -0400
Content-Disposition: inline
In-Reply-To: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 06, 2016 at 10:32:25AM +0800, YH Huang wrote:
> POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> battery not charging (e.g. because battery temperature is out
> of acceptable range).
>=20
> When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
> it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
> Just use BATTERY_DISCHARGING to decide the power supply status is
> discharging or charging.

Thanks, queued.

-- Sebastian

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXCn8hAAoJENju1/PIO/qaYYwP/3hB+Zh6xtG81oiWh5NycmEk
CSsK9OMysG8rb0uskACzY3O9vQJa4DFDTT+IW1OGW4wPIsJpq109PAUJjf/qHDJA
oDelePozOTs/1BLhI8NIuo7GxeV4UhszWn20L6y/2UOFmPNcFjfjny7PTXoj89nc
JFtWrVrZrED0z+yLozlC7lW2uI5lih33+0qoBsZXjaZnjHmXP6AOHHO/FV8Kk5tl
zDaTES2P79gjANhLZ27jj5KIFmVmzZ3ZXcauPMbSEDT0FWJ9/Q+rxXbCovs2lxLO
SxVQWTECXOD8nv/BUStdM/jbJc8dEF3JW6+SWJHJ4SYGTq9I7O6CuaxTy+Kl1xcN
4taK1GsGtekfHUfaWrF1cRuYiDgnbnStXJ/cXDxP5jSdAGS3rwRYXxWxusmt8cFM
6vMRHKxNhsogvy3JSvk8dgBnGQxwjrwgzTtM+XxgJSoOakjH9+Yp3+Ey0i9KlnmR
anxoxF5irFRrxNWnjzPAk02vQlpp/ALFai2g9ixjrdnX5Sizvipjc03uoJ+qi+AB
riuDEWisTKhKS0GR/zYhl+BrHO/fikOAUhid0MZ9cO0vBRL5yYU20EpXvboYkNKv
tD6M1bR39Jr6ifdl1ztFVCMyGBh1QB/O/5njKcplz81UUVih12aq9nceMopi+GVq
BeD453g8A4h20ZRrIe7Y
=yyDM
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
