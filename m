From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power_supply: rt9455_charger: Properly notify
 userspace about charging events
Date: Thu, 9 Jul 2015 05:27:51 +0200
Message-ID: <20150709032751.GA13805@earth>
References: <1436271953-24564-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41752 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902AbbGID14 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jul 2015 23:27:56 -0400
Content-Disposition: inline
In-Reply-To: <1436271953-24564-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: k.kozlowski.k@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 07, 2015 at 03:25:53PM +0300, Anda-Maria Nicolae wrote:
> Charging events this patch refers to are:
> - charger is connected to/disconnected from the power source
> - battery is reconnected to the charger, after it was absent.
>=20
> When the charger is connected to/disconnected from the power source, CHRV=
PI
> interrupt occurs and PWR_RDY bit is either set or cleared. PWR_RDY bit is
> updated after 1-2 seconds CHRVPI interrupt has occurred.
> power_supply_changed() should be called after PWR_RDY bit is updated.
> /sys/class/power_supply/rt9455-charger/online file displays the value of
> PWR_RDY bit.
> This way, if the userspace is notified that a charging event has occurred
> and the userspace reads /sys/class/power_supply/rt9455-charger/online fil=
e,
> this file is properly updated when the userspace reads it.
> This is the reason why power_supply_changed() is called in
> rt9455_pwr_rdy_work_callback(), instead of being called in interrupt
> handler.
>=20
> Since no interrupt is triggered when the battery is reconnected to the
> charger, the userspace is never notified that the battery is reconnected.
> This is why power_supply_changed() is called in
> rt9455_max_charging_time_work_callback(), so that the userspace is notifi=
ed
> that the battery is reconnected.
>=20
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>

Thanks, queued with Kzrysztof's Reviewed-By.

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVneozAAoJENju1/PIO/qaEncP/3LXei9uEIJZaGDT5t2q0cgz
uIZcpTTOWzLp1sXb6ZmLpddqjykfiwtLUnXF9k1tHy0RxlmqCD37QDZt3t+QgpyM
ewP89J66W+BBJi5zT24UH+8om4xW6czen+RBRdADBKegaNeWp9sXLF13oOpu1Vuv
bV2iqmoaXnsoL27nu0DO+r0bEkthd9AOh76niU9W/6OAobRHiJkIIEgYjEnETLHf
W8Iu0pCuOxdfI6k2jto3BeuAAZU82N41LqrbTUGze1z+RTKs0AKEJEP078QyUNEd
VgiWuBjTd8sM3Z3F1frvkcebvtdyfch3bVMyM6Fy3WxNnfEv+JLeJh8DP6ybXWwD
1/sQyGiqJQXqtXXpVh21fJQAAplvkjRW1AKBAAxyhIVqYCtw4n1Pi011VQx4PfUG
jlEpfv96jIEZq58Wtq/wrUyXbtutdbBRxR7GPBDLhSK1cmTOTEU6sDFwmCCvs1DR
YOelaiT7kugt/jMPndifXQaHu3P/NGnyUhHWZ9rkmHaf6re5TvAq5tuvuzDz/gsL
5oe1m5GUp76S3S7V4tE3HgnXnSOy8N6ULHm03XJguIjd1C2v5/CA81ULHNkWLEhC
VZkNb9U+9CMOOxp79+SONaDG1PJG7nWu46GUEbxEl2JnQ3Muq2FnQ07tqqde5be4
xlZf5DaXk5Nspu6t7Qkz
=IW4j
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
