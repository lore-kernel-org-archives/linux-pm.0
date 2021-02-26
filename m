Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E8C433DB
	for <linux-pm@archiver.kernel.org>; Fri, 26 Feb 2021 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9613D64EE7
	for <linux-pm@archiver.kernel.org>; Fri, 26 Feb 2021 11:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhBZLB2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Feb 2021 06:01:28 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42556 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBZLA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 06:00:57 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C0CA81C0B78; Fri, 26 Feb 2021 12:00:10 +0100 (CET)
Date:   Fri, 26 Feb 2021 12:00:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     wangjingyu <wangjingyu@uniontech.com>
Cc:     rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, pa@zytor.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: x86/power Missing a blank line after declarations
Message-ID: <20210226110009.GA26606@amd>
References: <20210226090205.24132-1-wangjingyu@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20210226090205.24132-1-wangjingyu@uniontech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-02-26 17:02:05, wangjingyu wrote:
> Ensure checkpatch compliance
>=20
> Signed-off-by: wangjingyu <wangjingyu@uniontech.com>

NAK.

--=20
http://www.livejournal.com/~pavelmachek

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmA41LkACgkQMOfwapXb+vJTeQCfYvgfX2bMk/ACZR0DeJoW9eQm
1lAAnjLY1Lac7jkGrOxD2OmlF67xx1We
=+qgJ
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
