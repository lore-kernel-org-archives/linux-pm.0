Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CEC10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B720880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDHMBl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:01:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43331 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHMBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 08:01:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8D90380742; Mon,  8 Apr 2019 14:01:31 +0200 (CEST)
Date:   Mon, 8 Apr 2019 14:01:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/7] power: supply: cpcap-battery: Fix division by zero
Message-ID: <20190408120142.GA19749@amd>
References: <20190407181254.64537-1-tony@atomide.com>
 <20190407181254.64537-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-2-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-04-07 11:12:48, Tony Lindgren wrote:
> If called fast enough so samples do not increment, we can get
> division by zero in kernel:
>=20
> __div0
> cpcap_battery_cc_raw_div
> cpcap_battery_get_property
> power_supply_get_property.part.1
> power_supply_get_property
> power_supply_show_property
> power_supply_uevent
>=20
> Fixes: 874b2adbed12 ("power: supply: cpcap-battery: Add a battery driver")
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrOCYACgkQMOfwapXb+vKbzQCgqW5zqfJ/jgPWrlRMsuhdwDl6
S3QAn0tPPQ8hAtqE4tYKVSTI7miJw6m7
=pgG/
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
