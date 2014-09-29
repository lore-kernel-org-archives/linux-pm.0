From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / Domains: Move dev_pm_domain_attach|detach() to
 pm_domain.h
Date: Mon, 29 Sep 2014 17:57:09 +0100
Message-ID: <20140929165709.GV16977@sirena.org.uk>
References: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WN2ELtqJJ9aZ3yHj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53111 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbaI2Q5k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 12:57:40 -0400
Content-Disposition: inline
In-Reply-To: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--WN2ELtqJJ9aZ3yHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 01:58:47PM +0200, Ulf Hansson wrote:
> The commit below, started using errno values in pm.h header file. It
> also failed to include the header for these, thus it caused compiler
> errors.

Acked-by: Mark Brown <broonie@kernel.org>

--WN2ELtqJJ9aZ3yHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKY9kAAoJECTWi3JdVIfQMmsH/1Z9s1IqKpBTOvvmlRYsjGsu
Gw/VN8wPZFAPCpcy73wYG3tzkRR0vPpUymKjVLUXgK8n+/7RKohgPA6ErI5Uz6G4
VQtJGNB0DseqUAUEJBfeYYuhR9SNl+Q/hRWM4Tq7zmrkPuioZyTth9vNIJUN/juC
xryNOZZtzDWpj5XiS5qtbg9/Kd44f+9zXQfx/qZ3soqT8wtbd5u6loq2PVKVJQv2
oneeOkE0b5b/vLCFhvK2geyRXoOh5oqH19lEqVeDFVkmD+wF3uzPDfW3rIVV3BA8
wrsnvjt9Vxh2MemDfcCTp4gMyGMVHP3gFnU/gSkNuF3MOZp0NO705vBxnxl+D9w=
=UkIs
-----END PGP SIGNATURE-----

--WN2ELtqJJ9aZ3yHj--
