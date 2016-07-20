From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Wed, 20 Jul 2016 12:50:14 +0200
Message-ID: <20160720105014.GA17170@ulmo.ba.sec>
References: <57726196.5060909@free.fr>
 <578CC9C9.3050806@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36280 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcGTKuS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2016 06:50:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so6384356wma.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2016 03:50:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <578CC9C9.3050806@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>, Sebastian Frias <sf84@laposte.net>, Arnd Bergmann <arnd@arndb.de>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 02:21:29PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>=20
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. And there is
> no context to save for this particular block.
>=20
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
>=20
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes in v3
> Drop the DEV_PM_OPS macro, which caused some confusion.
> Note: tango_thermal_pm struct only exists when CONFIG_PM_SLEEP is defined
> @Kevin, can I add your Reviewed-by tag back?
> ---
>  drivers/thermal/tango_thermal.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXj1diAAoJEN0jrNd/PrOhh4YQAJMAi3c/8YQN741olyQbdy9n
UIis3NDwVnoTh+lL4oTWrT8ZpSx8zl28hvmm6iPV2DqoU6LoFxhoz4voILCdGOw5
0b0aPFEoU+MNhgHwtnWYnRJWfLdcyPrdo0shnF5yglYpMlksR6l6p3cUVOobMsO9
GGjBwjQy253z5qefUUTthAD/RL6JGHTGtKtNPBo/vSIraLLIAw2CM+Yvvwy7dava
WTdMPxFhKrSCl2hpSRfnFdjqtfRa3um4qV+WKkMBvtX5rx0jEm9CFsdRS5HNy3Nk
x20zCVjX1q3U1TEEoIeBOndy/kxj5yHIak4pVdnXr3EknbhYzVLBDNVjh83eDVAA
XjSwB0S8UiAUojQYMILrgVIyWy/xK6z6dG8a/BsYLHjTTC20CVRqd+ujhtTldEzV
wyYwZUwznraH3gGrvwGNTDZQuy7h2FBotpgnuQ4tueUJlr6SwKwPJ0VPqHZiV/ZL
bfDbneZj/RQC4vsZGmERA9UNjSOLSEQcW1odlhjc90rXXX/sMtMSkZXa1GEc+HnP
Yvvc04yynymQYY/QR4cEW4zEFD4CxmCvfxuVuvMzv5ONEHH+PqLY5xC3paAxL/DH
EWIAvK1KWo1ufaNgAFG/AN0QgpjHfLvuaX7Im1C78Myx+AJUasugCovv+XTH9T/M
9HX2Gid24td2M1v2zQVG
=XPQ6
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
