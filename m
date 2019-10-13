Return-Path: <SRS0=qYo0=YG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E47C4CECE
	for <linux-pm@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8713821882
	for <linux-pm@archiver.kernel.org>; Sun, 13 Oct 2019 11:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfJMLmL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:42:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41369 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfJMLmK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 07:42:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6539E80249; Sun, 13 Oct 2019 13:41:53 +0200 (CEST)
Date:   Sun, 13 Oct 2019 13:42:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 3/5] power: supply: cpcap-battery: Simplify short term
 power average calculation
Message-ID: <20191013114205.GG5653@amd>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-4-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 14:06:19, Tony Lindgren wrote:
> We can use sign_extend32() here to simplify things. And let's fix the
> comment for CCM register, that contains the calibration offset.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jDY0ACgkQMOfwapXb+vJ7jgCglNj2f29a+z/PkdFvOYzCINTy
laYAnRdzmnh1+/856hnI7N1xUk0k2QM+
=jY8l
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
