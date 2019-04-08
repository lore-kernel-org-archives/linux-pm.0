Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233AC10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977920883
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDHME2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:04:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43519 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHME1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 08:04:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B713806AB; Mon,  8 Apr 2019 14:04:17 +0200 (CEST)
Date:   Mon, 8 Apr 2019 14:04:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 6/7] power: supply: cpcap-battery: Fix pointless
 EPROBE_DEFER warnings
Message-ID: <20190408120428.GD19749@amd>
References: <20190407181254.64537-1-tony@atomide.com>
 <20190407181254.64537-7-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-7-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-04-07 11:12:53, Tony Lindgren wrote:
> With loadable modules we may get the following during init:
>=20
> could not initialize VBUS or ID IIO: -517
>=20
> Let's not print any pointless error messages for deferred probe.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

6,7: Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrOMwACgkQMOfwapXb+vIESACgt5pGTQ2ZIhDLfuhTbsxjGVyR
DQkAnRDFnz6AN4X5sp+1+usUFbv6wVC5
=5F4W
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
