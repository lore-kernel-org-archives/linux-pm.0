From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/8] power_supply: Add types for USB Type C and PD
 chargers
Date: Tue, 16 Feb 2016 17:59:17 +0100
Message-ID: <20160216165917.GA17290@earth>
References: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
 <1455281825-23526-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47968 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223AbcBPQ7W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 11:59:22 -0500
Content-Disposition: inline
In-Reply-To: <1455281825-23526-3-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomeu,

On Fri, Feb 12, 2016 at 01:56:59PM +0100, Tomeu Vizoso wrote:
> From: Benson Leung <bleung@chromium.org>
>=20
> This adds power supply types for USB chargers defined in
> the USB Type-C Specification 1.1 and in the
> USB Power Delivery Specification Revision 2.0 V1.1.
>=20
> The following are added :
> POWER_SUPPLY_TYPE_USB_TYPE_C,	/* Type C Port */
> POWER_SUPPLY_TYPE_USB_PD,	/* Power Delivery Port */
> POWER_SUPPLY_TYPE_USB_PD_DRP,	/* PD Dual Role Port */
>=20
> Signed-off-by: Benson Leung <bleung@chromium.org>
> [tomeu: remove the mention to Type C from the comments]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Alec Berg <alecaberg@chromium.org>
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
> Reviewed-by: Todd Broch <tbroch@chromium.org>

I queued this patch for 4.6.

-- Sebastian

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWw1VgAAoJENju1/PIO/qamgIQAJn8zGn38gXUmGglN2tGigV/
U91Ji04CLsA2TPB5TOEhMpZU7d/euJrs+rOFhYDaDvv5yeaf3xSb0j1xCKE5dseF
ICigGkF4N6ahVLsSGxilhZvmRy9SssjAMOK4MIBzBaj53VtOFwz0PbvcSaE930nR
wzLpHYgdFbpWh2BO/hmEes5vnXN9N1PseSXTdS7NvNMMjZzBuqNQw5yh06keRHpu
wLTSG4zBFlI5fd8GXUc7vfW1d5CZeyywY/FKeiu03P83FjjeuujHs8+f2z3OeXUF
UWbVwK/EgWBqn2cmcP4Wb3UJbkkmIZMOGIoU8FVjcyNb9OKAhLdFAkXyre0h8Zu+
tBd/IYI7FT9Kp3/m4JrR31SRfBKmOL3AnfsLx4ojmNS2g8jdpW4GFGT7QcbSnG1l
4YZLwSPlewAtq9XxlGqXgrQvtzeAZWYAzZpnrJmBiqbHCnUXmXUP2uztjHhOHx9H
3w3uyKrC+sKy629GyLzVytPZOZ4XUjN1cSP3QLuYKs2J3XJJQ50Aoy3qrs4s1wf6
hiqVG86arZIBgmG2ANANTSUm4uhqgz1MAnOtSEGUBxCs7ctl2e6IxRitj5MlI0bs
+/N7mJ6HJ6OJaQRVT1w3SFTYv7UeUakTkl/AW2p5MdhM0+pPqZOCebUs9xGsPQ4H
nDQnJLl/bNhH3okx3BAo
=HQRO
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
