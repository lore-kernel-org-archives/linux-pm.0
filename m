Return-Path: <SRS0=p2W0=7K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B7C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F383207D3
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590673425;
	bh=Wp2FVjSuQdQM5nY27/MBV/jRvPYPLJEl3U9GGXuCNz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLMZMiIUZZjYfaDIu8p5WjOdANUV+TfxxHGY+Bt/5c0eDNAEXarhEZoGD8UE92LLA
	 plYrGrumMbyQrDmJ2drlxZyp21zWSqsSD8AI8j7UEMmHvHbYl1DxcqYXBlWc4GwkDx
	 dJIfc3RDsn16PTgijdi6dKiUSonlp5u31pcs71qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390523AbgE1Nnn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 May 2020 09:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390468AbgE1Nnn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 May 2020 09:43:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D30820814;
        Thu, 28 May 2020 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590673422;
        bh=Wp2FVjSuQdQM5nY27/MBV/jRvPYPLJEl3U9GGXuCNz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KL6i5+zxr7qdEUS+an9gMNhOV6YmeiVg9QCnDHeRvlTgyPT3L9oUh/ULiwgUwqC2H
         CtIr9Q4vsabzxAkCFhJ6G+dhN7TeXGNpUbQvjENrCL8VsEA7cIJ8DjkATdZcByN1S5
         FVm4wRNC/0Gsl38YMGjH65aDyWyjEgVQXd7AzKGM=
Date:   Thu, 28 May 2020 14:43:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] regulator: do not balance regulators without constraints
Message-ID: <20200528134338.GD3606@sirena.org.uk>
References: <CGME20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba@eucas1p1.samsung.com>
 <20200528131130.17984-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20200528131130.17984-1-m.szyprowski@samsung.com>
X-Cookie: Small is beautiful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 03:11:30PM +0200, Marek Szyprowski wrote:

> Balancing coupled regulators must wait until the clients for all of the
> coupled regualtors set their constraints, otherwise the balancing code
> might change the voltage of the not-yet-constrained regulator to the
> value below the bootloader-configured operation point, what might cause a
> system crash.

This forces every supply to have something which explicitly manages
voltages which means that if one of the coupled supplies doesn't really
care about the voltage (perhaps doesn't even have any explicit
consumers) and just needs to be within a certain range of another supply
then it'll end up restricting things needlessly.

Saravana was trying to do some stuff with sync_state() which might be
interesting here although I have concerns with that approach too:

   https://lore.kernel.org/lkml/20200527074057.246606-1-saravanak@google.com/

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7PwAkACgkQJNaLcl1U
h9Cwxwf+OSNkA77PUJZjj12IQJX7dCNdc8t8C/rK9BDvMjxY2PfFPsPlffbc0g5B
pvA8cYyRD61MXZHFMQMcTz/padm+6CkIqNqdx3KYzBqjCe0fLhHPEzvmS0ha5rIJ
QWjf6ItLBSBriLcqZxGaAfFa5wljpxsChd4rr2qO8+ye4BiAkfBP25XP2b33JFYI
tJarx/8e2nvdZcQWao8WTzVcfEXoQZjYuD6OeZGME34cY+9F6MgGaPHqQbnhggC1
0HB0AWoOb/NeGCNCB8qa5k3qClZY2UzTXSz7/qr+cprSrakjdKyBlW7PBOkOAYYc
fJiKt3aeBIihleWiAyfBXrRfHlg89A==
=rsUY
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
