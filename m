Return-Path: <SRS0=e+u9=DB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA1C4727E
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05634206B8
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgIXMAo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:00:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35190 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgIXMAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 08:00:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F2AD51C0BCB; Thu, 24 Sep 2020 14:00:41 +0200 (CEST)
Date:   Thu, 24 Sep 2020 14:00:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] leds: Add driver for Acer Iconia Tab A500
Message-ID: <20200924120041.GB3933@duo.ucw.cz>
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20200906195103.1347-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-09-06 22:51:02, Dmitry Osipenko wrote:
> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
> embedded into the Power Button. Orange LED indicates "battery charging"
> status and white LED indicates "wake-up/charge-done" status. The new LED
> driver provides control over both LEDs to userspace.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thanks, applied.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2yKaQAKCRAw5/Bqldv6
8h7KAJ9RHZ0L+HYBj60LPGu9PNZjMYFyOwCffFDh8TOvkbAqDobirABHaaRTQ9w=
=6kM8
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
