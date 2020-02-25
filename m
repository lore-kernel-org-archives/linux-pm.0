Return-Path: <SRS0=jPMq=4N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA7C35E01
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFE920637
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582634598;
	bh=PXzTH7KZxKOItfyn/9rstj3OLUD7ys7fVIMn3Z/PQLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AgISnQpNTo1jNAZHASCN5nYyCXWJFs0E010pjlU+0wK0osFi+AnD/BujzoQidLDBT
	 vD7lWphHFP6i/0atEVVBPvTL27+bXiFlHZAXnjDeG4Ux1squAhp9LTlTIkLakWy0Gi
	 OxZlysslv8zzy+kA1LozMaQzRVL2GXoyT1/DXPUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgBYMnS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:43:18 -0500
Received: from foss.arm.com ([217.140.110.172]:50270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgBYMnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 07:43:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6234030E;
        Tue, 25 Feb 2020 04:43:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D96393F6CF;
        Tue, 25 Feb 2020 04:43:16 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:43:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 6/6] regulator: Use driver_deferred_probe_timeout for
 regulator_init_complete_work
Message-ID: <20200225124315.GB4633@sirena.org.uk>
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200225050828.56458-7-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20200225050828.56458-7-john.stultz@linaro.org>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 05:08:28AM +0000, John Stultz wrote:
> The regulator_init_complete_work logic defers the cleanup for an
> arbitrary 30 seconds of time to allow modules loaded by userland
> to start.

Acked-by: Mark Brown <broonie@kernel.org>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VFmIACgkQJNaLcl1U
h9DzrQf/faqtOS9TdPP0gkC5NRJPMYTyyP/T4QP2bdax55Uhogt8rQ1GleRuUfp+
tkUWHP2MRfEzUkNR6wOMIDvmMIYijbn3an/laONAfMO5QRUHByFTF7tM4Vk8OuwL
3EG9MceIYNXRvYx8rlWmyFjZQoq7H9JAcNW+0LBGLJyqgkvWCevXX/LDOzXE2gP8
6wl8rHjqujyagDipgii40dM1287JWJKgBBGNSAqMQGkPCUIaaJkYYhPLWrf6PDy1
YUl2ZnWGod/PsL5FQCCQiFnVlfElWkYOhKw0bMaXUAJruPai5wG3icR4WfKfRrzj
ROwomfEBNpiaLPx9P4r2rRhZuhbmBQ==
=sUYb
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
