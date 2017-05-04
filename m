From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v6 8/8] power: supply: sbs-manager: Add alert callback
 and battery change notification
Date: Thu, 4 May 2017 17:21:50 +0200
Message-ID: <20170504152150.4rvnaeyspsstnxoy@earth>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-9-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixpmlwhfzdps7eju"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbdEDPWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 11:22:05 -0400
Content-Disposition: inline
In-Reply-To: <1493716346-58517-9-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com


--ixpmlwhfzdps7eju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 02, 2017 at 05:12:26PM +0800, Phil Reid wrote:
> This adds smb alert support via the smbus_alert driver to generate
> power_supply_changed notifications when either external power is
> removed / applied or a battery inserted / removed.
> Use the i2c alert callback to notify the attached battery driver that a
> change has occurred.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--ixpmlwhfzdps7eju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLRw4ACgkQ2O7X88g7
+prt1g/7BcRw5CZlLwoucXEfQrMPFsCS3MMWppbI58FQodB3/IAr23McyRcADNkG
FpFfflMQYw2WeJ3ZSCPBEVQXl4rEYC+XSJy8s132xY1U1RhSPwIye6wtoMGXLuxc
vqdwMhduN7U032FLbI+F6EeJGrTtvdjjGskYfmLpWgidu/5OHEtW5CBk9Vgtx38N
NR4bXPsazvUzoCLwWCwku+7aNHhIIuwlU4bJCvl0iyCZhMwqze9zfBZNaFM5Kzkg
QpCI8oMoi5o9/DUGAcCRSA8jS2eZHhSTKAB/DJjEYuOAXTstcYEanjeBGsmNbqyv
LKWfTitweTBABaguyVmjvQPsqExc/hljU3vPBIKZ0YMNsicQyMaGAlirQ4hywi0M
h76rjOpLtqi0Wu2BqhnMO0DnUC5Sexjr0i8lFogYiRiubV2uwZoTyErp9qE69kn5
HKQsgC1MpgN47Mtz/QRgB8cOoG5Yn7pBAvxJ1m9SSLiKW5/dbqwkyzK63VRjRuAU
tC3f5XPIoD2bPoPYk3J9ExMb26WSXCv3YExyRcE2V1zXwgvYxuHxz8IF+T89uR9F
/fxLJ53kRomeOZpb2kcY3X66e675rPxacvvjFKszYkrl4tigjTfEvxa8Rd9UZwbP
CT+KV7Bjll9yKDs7qEExzMael0VjP6YA/lbEplDI35GgBRz0ZaU=
=lbfN
-----END PGP SIGNATURE-----

--ixpmlwhfzdps7eju--
