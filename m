Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830EBC10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA5C20880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDHMDf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:03:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43462 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDHMDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 08:03:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E1D8E80859; Mon,  8 Apr 2019 14:03:23 +0200 (CEST)
Date:   Mon, 8 Apr 2019 14:03:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 4/7] power: supply: cpcap-battery: Fix coulomb counter
 calibration register use
Message-ID: <20190408120335.GC19749@amd>
References: <20190407181254.64537-1-tony@atomide.com>
 <20190407181254.64537-5-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-5-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-04-07 11:12:51, Tony Lindgren wrote:
> The coulomb counter calibration is not CCO, it's CCM. And the CCM is
> nine bits wide signed register, so let's use sign_extend32() for it.
>=20
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrOJcACgkQMOfwapXb+vKzbQCgqzi39K3V3O9+rwobHgWVTKI9
susAn2WIeFpJ9hnhaDvq9WzviMegYmTj
=hgRW
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
