From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 01/11] dt: power: bq24257-charger: Cover additional
 devices
Date: Tue, 22 Sep 2015 18:24:48 +0200
Message-ID: <20150922162448.GE4235@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-2-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53740 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbbIVQYw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 12:24:52 -0400
Content-Disposition: inline
In-Reply-To: <1442612399-341-2-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 18, 2015 at 04:39:49PM -0500, Andreas Dannenberg wrote:
> Extend the bq24257 charger's device tree documentation to cover the
> bq24250 and bq24251 devices as well feature additions.

The binding looks fine to except for:

> +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> +    also be defined through the standard interrupt definition properties (see
> +    optional properties section below). Only use one method.

Why do you expose two ways for this?

-- Sebastian

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAYDNAAoJENju1/PIO/qabwcP/RgyDAy7vFAHbO3QZ69kDJzG
mVkNLkc7dkT2LV0V32a5pLCI4HObctAVkq5lzlruXIsGE8uYoPz+p5Szg9saRFTk
+tzJXU+lqNpNlERrKX7lsPVJQNL4ILrNcU5L30NgCH/mWn/AdPGxd+aTKjTL2oA6
pxy/vkW2uldpHtDrYk/CuhdSY7w3AhEAjlPVd0+aGd0dA/XEGhpIBv1MMHhw1ATZ
qSP71amNo9/eSaulRnO7bIkwfJHu3uWjmM/1zKrrUYB/a831eCVWUhNpEv+bQ0B0
ZP8u6WfYyZsD2a/y6c6BlOdLlqt/0hNvfv3X8xWuL9Qa9Xot5iNwjinlRGSmenm/
QkYWeLpyRoENtdbza1eMMDMbbr01XJ26QCF+8ob3QH2YaQRXhKQuWTzAxGH8aSV2
DzgwHKML18T90NXRyRyxAZAHiuZg6C+oEkfuc+yw2Ac6KS4m1JCT4EwSIBdkv6DU
Y1VAOGEQichjC++aT5PUa00E7R+ouJukw1HHjyzlUzaoz1B3SD0tEkCP0AwhUDI6
AB9EXTlehXITaYT3onUo0N6RQLwxR6w9Lr7YR65lqSU5T3QMxtE9f9qJFjRiY7xY
aXmM1y3F7K3wv/bqtha6rNiXivmkoONS+UXsTdu2wVW4+68fzcrzKEzDjsps8HCO
D8FC0tg5UIsuq30uVnw0
=hiGT
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
