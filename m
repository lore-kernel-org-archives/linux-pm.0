Return-Path: <SRS0=TvHm=YP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F9CA9EA0
	for <linux-pm@archiver.kernel.org>; Tue, 22 Oct 2019 10:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B66E20B7C
	for <linux-pm@archiver.kernel.org>; Tue, 22 Oct 2019 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfJVKjN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:39:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59573 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 06:39:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3ACBD801E4; Tue, 22 Oct 2019 12:38:54 +0200 (CEST)
Date:   Tue, 22 Oct 2019 12:39:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonas Meurer <jonas@freesources.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync()
 before suspend
Message-ID: <20191022103909.GA10573@amd>
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
 <2847488.TR0R5COpHM@kreacher>
 <063b2b9e-19f1-e67a-1d54-b1a813364bb8@freesources.org>
 <3858a5b3-7e62-977e-0292-964c4dcfef5a@freesources.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <3858a5b3-7e62-977e-0292-964c4dcfef5a@freesources.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi Rafael and linux-pm maintainers,
>=20
> sorry for the noise, but again: is there a chance to get a brief review
> of my patchset?
>=20
> Probably it was a bad idea to rename the build-time flag, right? Should
> I revert that part of the patch?

I don't like adding more and more knobs.

We should not have added that compile-time option, either.

Perhaps it is time to declare that if the user wants the data to be
synced, he just does sys_sync() himself?

(Yes, that will mean tiny ammount of dirty data created between
sys_sync() and suspend to be unwritten, but...)

(Besides, if you add a runtime option to avoid deadlocks, you still
have not fixed the deadlocks...)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2u3E0ACgkQMOfwapXb+vIRogCfcDU2rl8Gy4WaxP2SBP++g/Wu
q68AnRQ1GSsJkevFkhPO050e4TQz1LU5
=s4lE
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
