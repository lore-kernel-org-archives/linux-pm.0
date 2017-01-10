From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 00/11]  power: supply: bq275xx: implement individual
 chip revision support
Date: Tue, 10 Jan 2017 03:49:28 +0100
Message-ID: <20170110024928.khol3nsqnvogqtht@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1483922865-96321-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22ipyufpnze27zy4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932584AbdAJCts (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Jan 2017 21:49:48 -0500
Content-Disposition: inline
In-Reply-To: <1483922865-96321-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--22ipyufpnze27zy4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Jan 09, 2017 at 11:47:34AM +1100, Chris Lapa wrote:
> This patch series separates out support for each revision chip in
> the bq27500, bq27510 and bq27520 family. Each revision has enough
> register address changes to justify individual register mappings.
>=20
> The series also cleans up the large overtemp if statement to
> improve readability and adds devicetree documentation for all
> the support bq27xxx series chips.
>=20
> I had a chance to test the deprecated bq27500/10/20 support which still
> behaves the same. I also tested the new specific bq27510g3 support
> on a custom board I have here and it worked correctly.

I tried to queue the patches, but they do not apply on top of
power-supply's for-next branch [0]. I applied the first one, but
please do the rebasing work for the other patches and resend.
While being at it you can add the following to all patches:

Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>

Ah and last but not least: Please use the following as
patch subject prefix: "power: supply: bq27xxx:"

[0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git=
/?h=3Dfor-next

-- Sebastian

--22ipyufpnze27zy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh0S7UACgkQ2O7X88g7
+ppD8g//Xda51NpWc04aoJC/cQjP5IQV9CeTeWPgAO7CNBLJO9JSfKzuF041e/kH
fUpx2VP+qcA3vTEjN/fTkGwMZvnSBun4xsfccerenrnRshvKElHHd/XmKTmo5gZG
ejZ2WqCln0PUCKHga5bH+e2G0Hrqlg5PWzu0onb0vLbTJSaUnBhFV8eFRrzaqMsS
r89h6gAqt596QAfK/eYr3DCe7a7tHwZbwEnCKbMvmeaV59yP/ikuYXGLDBp/g8xG
MH8sTFbE7s0F+/hqzPJLpq3C4r60UEVLFTff0esCiiK0/eyVtb9SV2JjKc/8UgYy
HmOH/b2Gs9l9do/cr86VHoZ/OPn8GAkiSTpj5NeB1Qtx10oxRNFyRNMDieSOrZN+
npzri+i3E0LJwHJAy5JXMFCaM7xGT3QC3wNpm1vE5NuxOjRJ3ihIAT2rprOz9DQI
mbm1AWhOG6IBxk9W97mItE4CbLDespEKk+qHZzz6DZJknQyHSiyGkwt+acC1bc2B
7Y/118KkK1CbUFB1/WXAPSvGeWprhUo7YCqMkXoe4MQ8UGgmwTtI93oQMAOaxh4V
Devu6dmkMJdnqQt31+xhEg6GXRaz3iu00FPT7iFIs38/Q4Y8T9iMCtTJlrHp19Y4
Tc9HbZk2MsbpiGoLm4q+453y6DZam8unygwrCK6LmNKDojpkOl4=
=5O46
-----END PGP SIGNATURE-----

--22ipyufpnze27zy4--
