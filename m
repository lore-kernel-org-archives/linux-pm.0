From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] regulator: max77843: Add max77843 regulator driver
Date: Thu, 5 Feb 2015 17:36:53 +0000
Message-ID: <20150205173653.GZ21293@sirena.org.uk>
References: <1423025771-4139-6-git-send-email-jaewon02.kim@samsung.com>
 <1423118158-7266-1-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SusxIpO/K/G//hYA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52038 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbbBERhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 12:37:04 -0500
Content-Disposition: inline
In-Reply-To: <1423118158-7266-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>


--SusxIpO/K/G//hYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 03:35:58PM +0900, Jaewon Kim wrote:
> This patch adds new regulator driver to support max77843
> MFD(Multi Function Device) chip`s regulators.
> The Max77843 has two voltage regulators for USB safeout.

I've already applied the previous version so any further updates needed
should be sent as new patches that apply on top of what's already been
applied.  I've applied this but please in future send incremental
patches.

--SusxIpO/K/G//hYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU06o0AAoJECTWi3JdVIfQCHUH/2LhZjv7UECRwU7t3iqFwYt1
m9r12wejhXBcI7M14Lx4N9+W59RR1zsr3fekBETOwupjIrfZPIuaYy73UDdbas3B
vnia+5/4o1Fjzju58nONx/yfZ76aHxLd0gDI0RA+PCum2I4S+I6QY7XfGc8hI+xN
5ef+O/yjFzT7b1dHnrLGfukPOA7K9N/KZWwSxmBqrAEjXO7oCPM487HJmFn5Ycg3
ynIP8P4gjq5KkUpCy9fsvqJR1DSjWZ3pzY+KxLuMAfVKtKSE+CYPthaSKnPa17hi
eJmmo/tTBnyOTSqZUikglMM9+/L0m0mabDo2a038y9ZBrrLpPwomQdH7YijGPL8=
=pc04
-----END PGP SIGNATURE-----

--SusxIpO/K/G//hYA--
