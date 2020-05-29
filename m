Return-Path: <SRS0=SRLr=7L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85844C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 29 May 2020 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625282075A
	for <linux-pm@archiver.kernel.org>; Fri, 29 May 2020 16:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgE2Q1I (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 29 May 2020 12:27:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35142 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Q1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 12:27:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8F4971C0385; Fri, 29 May 2020 18:27:05 +0200 (CEST)
Date:   Fri, 29 May 2020 18:27:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
Message-ID: <20200529162704.GA3709@amd>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patchset improves support for SBS compliant batteries. Due to
> the changes, the battery now exposes 32 power supply properties and
> (un)plugging it generates a backtrace containing the following message
> without the first patch in this series:
>=20
> ---------------------------
> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0=
x104
> add_uevent_var: too many keys
> ---------------------------
>=20
> For references this is what an SBS battery status looks like after
> the patch series has been applied:
>=20
> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D10800000

Is that correct, BTW? sounds like these should not be equal...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7RN9gACgkQMOfwapXb+vJsVwCgpHjzsBvFVswrLrtJc0NNZQMo
BMYAniyjyZf3dR0x51pP7eY2lzcXk4Uy
=8ya5
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
