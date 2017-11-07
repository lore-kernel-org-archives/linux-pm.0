From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert
 from i2c-smbus to i2c-core-smbus
Date: Tue, 7 Nov 2017 08:22:55 +0100
Message-ID: <20171107072254.s43mwpyplx3hdkyo@ninjato>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
 <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
 <1397131b-c22d-9872-dbe0-9b691553cb9e@electromag.com.au>
 <20171106213646.2h3zsitnlablblli@ninjato>
 <2eaccb51-62cf-b764-d313-84008c6c8f87@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bikpymgkkwmtznnd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54768 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755205AbdKGHW5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Nov 2017 02:22:57 -0500
Content-Disposition: inline
In-Reply-To: <2eaccb51-62cf-b764-d313-84008c6c8f87@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Jean Delvare <jdelvare@suse.de>, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--bikpymgkkwmtznnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I was just thinking that all that's in the file now is smbus-alert code.
> The other smbus (host notify) code was moved to i2c-core
> So maybe i2c-core-smbus-alert and as you say use makefile to include it.

Aaaah, i2c-core-smbus-alert.c. Yes, that probably makes sense. I was
wondering about i2c-smbus-alert.c (without -core)...

> I've tried this and it seems to work for the various combinations.
> I'll wait a bit for Jean to offer an opinion.

Well, if you have code already, can you post it as RFC and CC Jean?
It usually is easier to talk over code, even if it is not perfect yet...


--bikpymgkkwmtznnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloBX0oACgkQFA3kzBSg
Kbb6nhAAiTjcLEHcmWcnWXLWm52v1eFi99WAwm3ONH6wlmWdT1WK/4ktJ6X3bx2Z
XSVGvELMjeuFY2khXNmrM08pNu/ceNVBcBAuOhxDg9PeKLsBuRlPm6/38GIkKy9t
IJbAz4+VJ1hqtpFNyOKuafvmcIwAYfdAeNOz5nqqiGGqZbHA3qMwLBxRvt3oupMB
0ngTY/unB/x1tvhnXKAI73gq+I2S3OLM+SifwD+x84N8curvQ/oCtfhQ5WS+fuUW
6FF/BeyE5qH0wN4LfDtap1LdIiiZnaHoI709hF8AGtJiLxmu4OeO+Jph5jiV6AOj
mUCK4OoDDowHSsbvd7xNPE5FuPPNWpF6V1CnjZrV4zeN9QwP2DSlFwdZNkaCynGy
V70sxrj1d2alD+YIWctu1iBuG7OiFus0wDvfpsUX9ZH0JQ0KSmtnZjjepaaQ3x/+
XydRjM18OgGL7t28J4qb4sH36j8p1sGc04NMQokLwnh0zuR6+6e+qBTOYqQFtW5d
8svTp8j7fRHdAwth57vAqRZx+qvUZtKH6f/BXhOEBsYQqnmeQfAjb78Q3+2XNdEY
3sD3Bp0r5CUxKc+t3UZHP50NlPB6lm8i2ihu3kEqIqV6x/R1ESGP8PdznrbnGiNF
om2OMPnFwWfeuAbiKvhpQt+J78nc+y9r06E+39vS1Fs4LI9QdUc=
=j7zL
-----END PGP SIGNATURE-----

--bikpymgkkwmtznnd--
