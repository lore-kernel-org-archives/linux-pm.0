From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate
 definitions
Date: Tue, 24 Nov 2015 14:26:34 +0100
Message-ID: <20151124132634.GA21070@katana>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33234 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbbKXN0n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Nov 2015 08:26:43 -0500
Content-Disposition: inline
In-Reply-To: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hock Leong Kweh <hock.leong.kweh@intel.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2015 at 07:59:29PM +0200, Andy Shevchenko wrote:
> The read and write opcodes are global for all units on SoC and even across
> Intel SoCs. Remove duplication of corresponding constants. At the same ti=
me
> convert all current users.
>=20
> No functional change.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Hock Leong Kweh <hock.leong.kweh@intel.com>
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVGWKAAoJEBQN5MwUoCm26woP/0+KF8jCJNSgwkJ1CG8nhzrF
rar+5x4MleyaaCWi2jXcRy5Bk1IoZeqyTUjutlks5seJaYkeZ/hIdaBD9YGFi45L
/+knUXKfD9D6CW6Zn+Bu4h6EqgnmTwXNrs8kRRwjnbhxQgAQ+yEXWMTv+0Ks3kZg
BY3jLzKJEJr41UkGDmrhxOXK2bFPmoO0xtKyf3DFm5kkPK0/OJhvXfk3OSuDU0VE
NQwgCxXJd6x4UR8YCuq+EDSO3OQNRUx/kxvj2WJAvOOjuSUqr0TMFU+E/O7pOAb4
sKkwz5dGJyjKEkqvf2rv8vvHoevfRL0pMYfyQ8YI3maR+cCy9ZlXoeT6isSnFJR1
YwXBlR04G/vxrIAaYkeHFgXBGpQghpYUbMyHvNiae/TFwoW/1Ex7sM6ZSC+WCaqW
o/3IffOf4vWBdIch01sU83TdfZvXsw6GPvaJtpEnpHkyZ8QSd7xV0O1JzY/llzQM
AUsPY+gfFjqly0AjOEo1EGP6pwtY47LMsLh6R0iyViEZYPo8d+0DJWpOoV9mV5PM
6vKFHwOqOItciuWrTJno5sZb7OD6Sc9AwpNeMASE/Ddvox9z/T/A3fBEE+BJNqqp
ZsNDKrxb6HPxcTylevTS6GznHRI2nz4dM1FB86BUJQPaW3na6PCIh7n2J1LSjduM
WIcv8Opp/H1UDtLyx2rQ
=JXJS
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
