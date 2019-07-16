Return-Path: <SRS0=uSiu=VN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85781C7618F
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jul 2019 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8D206C2
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jul 2019 18:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfGPSmh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:42:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46085 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPSmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 14:42:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6D00F80594; Tue, 16 Jul 2019 20:42:23 +0200 (CEST)
Date:   Tue, 16 Jul 2019 20:42:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/14] docs: power: add it to to the main documentation
 index
Message-ID: <20190716184234.GA9135@amd>
References: <cover.1563277838.git.mchehab+samsung@kernel.org>
 <95abe2e389f5bfb9dd03d55de384c2b9b5bb78da.1563277838.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <95abe2e389f5bfb9dd03d55de384c2b9b5bb78da.1563277838.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-07-16 09:10:41, Mauro Carvalho Chehab wrote:
> The power docs are orphaned at the documentation body.
>=20
> While it could likely be moved to be inside some guide, I'm opting to just
> adding it to the main index.rst, removing the :orphan: and adding the SPDX
> header.
>=20
> The reason is similar to what it was done for other driver-specific
> subsystems: the docs there contain a mix of Kernelspace, uAPI and
> admin-guide. So, better to keep them on its own directory,
> while the docs there are not properly classified.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0uGpkACgkQMOfwapXb+vJfowCaAuwW+xmLHrrmwuhNkdZ1vVlQ
oFYAn3cqyU/t9SNThnuhs5DCvj+U+q3r
=WP9m
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
