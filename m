Return-Path: <SRS0=Qt2W=TU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA1C04AAF
	for <linux-pm@archiver.kernel.org>; Mon, 20 May 2019 07:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C120851
	for <linux-pm@archiver.kernel.org>; Mon, 20 May 2019 07:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfETH0d (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 May 2019 03:26:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45133 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfETH0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 03:26:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6E3138033F; Mon, 20 May 2019 09:26:21 +0200 (CEST)
Date:   Mon, 20 May 2019 09:26:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] soc: fsl: add RCPM driver
Message-ID: <20190520072630.GA3674@amd>
References: <20190520065816.32360-1-ran.wang_1@nxp.com>
 <20190520065816.32360-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20190520065816.32360-3-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The NXP's QorIQ Processors based on ARM Core have RCPM module
> (Run Control and Power Management), which performs all device-level
> tasks associated with power management such as wakeup source control.
>=20
> This driver depends on PM wakeup source framework which help to
> collect wake information.
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

> +// Copyright 2019 NXP
> +//
> +// Author: Ran Wang <ran.wang_1@nxp.com>,

extra ,

> +	rcpm =3D dev_get_drvdata(dev);
> +	if (!rcpm)
> +		return -EINVAL;
> +
> +	/* Begin with first registered wakeup source */
> +	ws =3D wakeup_source_get_next(NULL);
> +	while (ws) {

while (ws =3D wakeup_source_get_next(NULL))

?

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlziVqYACgkQMOfwapXb+vJYYgCfeELdsln2HAPCMPJgO2RvIdz1
T5EAn0hVPEYV4vYlN3zVpYR6YBxZjFlI
=Gqqe
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
