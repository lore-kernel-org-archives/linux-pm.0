Return-Path: <SRS0=rzrg=DW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC6C43467
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295852076A
	for <linux-pm@archiver.kernel.org>; Thu, 15 Oct 2020 21:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602796428;
	bh=/Lp70SpYB2ZpR5AyA4e/QMzw1HdIw6aaTEHXz7VfT/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZCbGZGnsHK64b/p9SuLS/bUoFCPJHyhytyv+Nmyfqm3tAySkqJVBn57fb4jRuCBi2
	 2Cay1t/j+5Y2AEOIuORU8iSnghUHTwtx5elkcbi737OuoqcYTerlRtiYbEnSJSE+V5
	 XKXOz8S3y+5k2qGx+idLIXfSXkVBCo8L7Nuh7frQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgJOVNr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgJOVNh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 17:13:37 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FF420759;
        Thu, 15 Oct 2020 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602796416;
        bh=/Lp70SpYB2ZpR5AyA4e/QMzw1HdIw6aaTEHXz7VfT/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWqWKz3WQ30nklXxXTH1J7MDrUHZTBQ3FVzTSan8X3SLlO1xgt6OHapArL6ri5Gvj
         +AO/Im3PtYA6Ms7Lzw03fLIN6uwNR6xkPlIh2chnF5w9olbprKMf6/gfNdLz9dV9nC
         acERTlGlX/Q6XY3k/SQo6U1Dvm0tBH1Lx5cW0Cfw=
Received: by earth.universe (Postfix, from userid 1000)
        id 1BE8B3C0C88; Thu, 15 Oct 2020 23:13:34 +0200 (CEST)
Date:   Thu, 15 Oct 2020 23:13:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: POWER_RESET_OCELOT_RESET should depend on
 Ocelot or Sparx5
Message-ID: <20201015211334.55iyjbo2yh2tzmv4@earth.universe>
References: <20201014131415.14034-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qyhsfhsvtssljobn"
Content-Disposition: inline
In-Reply-To: <20201014131415.14034-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qyhsfhsvtssljobn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 14, 2020 at 03:14:15PM +0200, Geert Uytterhoeven wrote:
> To add support for Sparx5, the dependency on MSCC_OCELOT was removed.
> However, this increases exposure of the driver question not only to
> Sparx5 platforms, but to everyone.  Hence re-add the dependency on
> MSCC_OCELOT, and extend it with ARCH_SPARX5, to prevent asking the user
> about this driver when configuring a kernel without Ocelot and Sparx5
> support.
>=20
> Fixes: ec871696b7776767 ("power: reset: ocelot: Add support for Sparx5")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, queued.

-- Sebastian

>  drivers/power/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 6361569aacb7eedf..d55b3727e00eb768 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -129,6 +129,7 @@ config POWER_RESET_QCOM_PON
> =20
>  config POWER_RESET_OCELOT_RESET
>  	bool "Microsemi Ocelot reset driver"
> +	depends on MSCC_OCELOT || ARCH_SPARX5 || COMPILE_TEST
>  	select MFD_SYSCON
>  	help
>  	  This driver supports restart for Microsemi Ocelot SoC and similar.
> --=20
> 2.17.1
>=20

--qyhsfhsvtssljobn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+Iu3sACgkQ2O7X88g7
+po4thAAml6a90+AAk24CcslNZDXMo0/k7PyCd5Q2PzKxtpllUi36YphYJiO+y/c
TokjiRqzoscM1Om584bYhc9JYRvEX5BnXoRU70cLpeQqpqQ7zC+/09nViYaIK/nK
Oa1MN8jaGW6ed+V9jJ66n0J3pr331k4AWwTlNrDlSNz8MLqPv237Hy3CiYIEp9vy
hWCWty8nWXFAxh/8ue9P1TQNkBzDCffxTgP0TmWXH/rTTAQPfsROLWgg7XLaX4fG
6QJDtYGBaLQXD7MVyBETu8DqqKGcMbWlF0Zu92tVtZ8O3hg9Z5iksY5SmmKZ9/tp
013kolklA2UOIs1iwJr0wwcMMXBJcXPFhAvRlneO+41CS0dQoSBZ7VFtRVRIlScV
Q/VGpmKkNUIJBtQHR1fZvX/cvkgHodm5AldWXNJ71lLwb35GO9HVjEJuZoswduqs
G/lgQigxQH9yKNMUL8Fifs6fHE/rhfyWhB2TWj/ZGZXGBdIxYFSsQvA7qfQZ9vHL
goJnxi+G9N9yORC1zkT3lUYJ+PlbSo9m3Uz8j1EpnadpDZfO578Ib7f9Jy4EKMjy
aFTT/YkRjvP4UKkNEUR7UzngyShqF2T5CyWbwwFBuy5Gxa0BFF0AppahyFNZKfiZ
nNw0mTKlAo7DzS9KuhmqCeY/5cdB4Vifr3SgoqMjxM2YXkksHCc=
=I7mh
-----END PGP SIGNATURE-----

--qyhsfhsvtssljobn--
