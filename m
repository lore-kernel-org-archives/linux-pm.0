From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: smb347_charger: Use device managed API's
Date: Thu, 8 Dec 2016 05:42:50 +0100
Message-ID: <20161208044249.iifzjwqi6mensl5l@earth>
References: <1481109502-23232-1-git-send-email-atul.r@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7kelzkuefjqxkif"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752871AbcLHEm4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Dec 2016 23:42:56 -0500
Content-Disposition: inline
In-Reply-To: <1481109502-23232-1-git-send-email-atul.r@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Atul Raj <atul.r@samsung.com>
Cc: linux-pm@vger.kernel.org, vidushi.koul@samsung.com, atulraj.nith@gmail.com, pankaj.s4@samsung.com


--s7kelzkuefjqxkif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 07, 2016 at 04:48:22PM +0530, Atul Raj wrote:
> Using device manaeged API to make the code simpler
>=20
> using devm_gpio_request_one in place of gpio_request_one
> using devm_request_threaded_irq in place of request_threaded_irq
> using devm_power_supply_register in place of power_supply_register
>=20
> Signed-off-by: Atul Raj <atul.r@samsung.com>

Patch looks fine. It will have to wait for 4.11, though.
Would be nice, if you could provide a second patch, which
converts the driver to the newer gpiod API.

-- Sebastian

--s7kelzkuefjqxkif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhI5McACgkQ2O7X88g7
+pqpKA/9HoCe+Z03qfxKwgX2BmqMpQA/sBddqBMtuvSYeA4jFx6X2rKiBxIjdF8C
eExzATQtCkmlStXNOOBPynpd2HDBq9qjl9EwZDFA3QRUGdHDphDVxSSFWVo6ofya
QvUj0en0y+uiZxZJbjBOYtV49n9yeDr3U1pXvuC3nhaUluNPG+a1yza3AqUSlwzx
rqVOHpRn+f610CRopF3mWIesZ0C9XQXhTK/1Q5rlkwAfrvFoxLm5R/XITqgVAQBj
Xfjxz1z4XWX9xy7rmQx2i7QDjL/Q82vp5jqcuhBkBnTpsTaUfOX5ccnI2S5UPuIo
yw6xd+mwtS5uIYbL+f9TFzwBnlXVw/DFs3eP/CdWbhpr+mcjS11dEHY6cyymElsi
2VW4/zcAKB1lpBXDYwFvIclZLgn6Gztd3eyVUNRfUvVgOxj3HFuVYVnavZNUVV/S
ao4NaDxQ3d5UHFlhUCUgQKEvD/FRB1mi5FdIRynZCUrWbOxbAT96KEVqASsCCdNS
cB+QlH+bLFrnxNIocGcuvnfMSftA+/sOkM0NSHlsjNMJKZWClj8cflCP/kimg1eF
JJAJau2Td4lub1VzBqVcaFGRi2fp6Xra81AWrRI3ydMfonmcfY4L29W3hcFmp6Bt
f170X1UfSTy82IVtNpRhHl+5mUcDJZdy+QTM833XKzNSvdtMSBs=
=+IDC
-----END PGP SIGNATURE-----

--s7kelzkuefjqxkif--
