From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] sbs-battery: add ability to get battery capacity
Date: Mon, 15 Aug 2016 23:16:00 +0200
Message-ID: <20160815211559.7wr633at523pdxcx@earth>
References: <1470934752-22719-1-git-send-email-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jeruisovivvznbim"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50020 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232AbcHOVQG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 17:16:06 -0400
Content-Disposition: inline
In-Reply-To: <1470934752-22719-1-git-send-email-stillcompiling@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--jeruisovivvznbim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2016 at 09:59:12AM -0700, Joshua Clayton wrote:
> Battery capacity level is a standard feature of sbs battery
> That can be used to tell what the remainig battery capacity is, and
> can tell if the battery has not been calibrated/initialized, which makes
> the capacity and charging/discharging percentages invalid.

Patch looks fine to me. I queued it in power-supply's for-next
branch.

-- Sebastian

--jeruisovivvznbim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsjEPAAoJENju1/PIO/qauB0P/0s98mquO9Hq9N8UKxGBprW1
uVyzxDspguvGimehd0lNj9Kf28fv92KVg1gNswztqqPA/2b8Rvz8TsxsHnjN2NcA
gfsA86zkH6mlkAA1qCqaQ144NZ5Zcfa4C88QPOQCO5nMqc7Z7LzTRwuxp+b7AWwh
0KRLXQuQOC2CHNsmH9RhT+1mkRkA22uEY8zZ0C6eGmf7rdvO5aMQY1ulLT4UUfrt
a1LAHVerIqwNXcOVsC8YbXAj18XF6kDMng6hCYfuz3VMv9jSOee7CM1UdQJuZiTH
Uudrrntdm97+T2V3teTWkHaygRtkvWFi/a77Z8ysRXZ7Xbis0C2H1GHmSf541tE5
xnPxri9eYGKPClyobMNPUQ06e0uiY9egjK7yXqK9m1ZU6daYnY54sHC2Z9ZZcMdP
hqEsfjZ+xdWrYZY05bZsvXoPRK0ub9Ifk3sKeYr/41G4KIugblbybTUp2HZwKvLW
d9A/PpU14F2ABdv/wycQoEWIeMOflMMeG+KmETs6GhmfaOxN9w5evLkr4a4yXTGt
luF/H/v++GYD1L3z7DOu8xRdALTTQlFkLGJIDtrQWc3wtHwGEOJT00Nvwv90KoBh
Q09eD20POV3SF03w0mBj62GbR5hjmpGIbwVos+T7AmOVQeQ1wlEC/Bd2XuwFxOr5
mnqpkE7iEoUaAotQj8Dc
=zR4y
-----END PGP SIGNATURE-----

--jeruisovivvznbim--
