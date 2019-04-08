Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6CC10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303D120880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHMDB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:03:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43421 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHMDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 08:03:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 539BB808A0; Mon,  8 Apr 2019 14:02:51 +0200 (CEST)
Date:   Mon, 8 Apr 2019 14:03:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/7] power: supply: cpcap-battery: Fix signed counter
 sample register
Message-ID: <20190408120302.GB19749@amd>
References: <20190407181254.64537-1-tony@atomide.com>
 <20190407181254.64537-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-4-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-04-07 11:12:50, Tony Lindgren wrote:
> The accumulator sample register is signed 32-bits wide register on
> droid 4. And only the earlier version of cpcap has a signed 24-bits
> wide register. We're currently passing it around as unsigned, so
> let's fix that and use sign_extend32() for the earlier revision.
>=20
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrOHYACgkQMOfwapXb+vIWqACdHD0J9RovG7Ey3ofIE7ula8LH
lwIAnAz/Q+zxQ0n/cWeth41BaajRZubz
=idUb
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
