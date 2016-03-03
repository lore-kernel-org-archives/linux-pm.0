From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 04/14] power: pm2301-charger: use __maybe_unused to hide
 pm functions
Date: Thu, 3 Mar 2016 15:23:42 +0100
Message-ID: <20160303142342.GG29689@earth>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35413 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169AbcCCOXq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 09:23:46 -0500
Content-Disposition: inline
In-Reply-To: <1456934350-1389172-5-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 02, 2016 at 04:58:56PM +0100, Arnd Bergmann wrote:
> The pm2301 charger driver uses nested #ifdefs to check for both
> CONFIG_PM and CONFIG_PM_SLEEP in an attempt to hide its
> suspend and runtime-pm operations when they are unused, but
> it does not hide the clear_lpn_pin() function in the same
> way, so we get a build warning when everything is
> disabled:
>=20
> drivers/power/pm2301_charger.c:123:13: error: 'clear_lpn_pin' defined but=
 not used [-Werror=3Dunused-function]
>=20
> This removes all the #ifdef and instead uses __maybe_unused
> annotations to let the compiler know it can silently drop
> the function definition.
>=20
> For the PM2XXX_PM_OPS, we can use an IS_ENABLED() check
> to avoid defining the structure when CONFIG_PM is not set without
> the #ifdef.

Thanks, queued.

-- Sebastian

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2EjuAAoJENju1/PIO/qaAyUP/02c9XWhvC9CfhRD+Zvzt5CA
U1aixemVD/0c+2Sg7corQ7XaXFVaHB5sBCDPAo3dK248J7ITJYyOC/GpfELeoOkf
ey8QsPo4rICp8VjRQEkFKFaEgoPyCLEUBEd9JmLKloy2Jipz1ufqMAQhUuI6U9yF
sW7DalV01LdZEnC0lD8nRFUExZ7HKdUCyGBqOh6mAwilA+cjMZ9Wp1/4bQ3gAcz+
od2Gu5ZKHAtiQDL/w7qNJ2oSaVCk1ekrH+IrvQUSMQZNdORV6zu0fd735ZEAH+kF
fwZfUv0wkdIngcpf6s/u5KCvCbb/LjmMNKqLdus3DlwyqCATMLx5FwT1GfKctYSe
U4kvmzOE28Sd8VUV+/g7sOgwhLD6toeIqLpoAjDDj7ChGbVmk1l2D8IUcTN12SJF
VDM5ywDg664hfDgna7Y2mpSGT8AHiBm3l2gDSlCgkCRlhPuN2JNrxjJipNejZYfu
t7e4vTFY2yUc+yzfzBh9KlxgGLHBr8byvTs2cKFpO1Mx1aZZIWlOrBIaJAJERp25
JID8HcrrKIKPSBFzBnJBgQBpGRT/8JhN2tBZbov/JbWZ/OAR5WBSLKOs2cjbI5G2
muAAUBhW8VB0q9KXPc/wijxmzW2dD4JTC3+u5hcM72p7yB92DQFj235n1Y35Cpo3
3xM05rBMpk+LuFUiy+f/
=bemN
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
