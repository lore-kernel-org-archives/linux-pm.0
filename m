Return-Path: <SRS0=vVHs=37=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC09C35242
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CE02173E
	for <linux-pm@archiver.kernel.org>; Tue, 11 Feb 2020 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581447977;
	bh=nrvRIWnQUnk1P/L5m9G2XIN8KKI3HWQAciY5bRTbzJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q01iNundGWJ0FSN/JeoCmOgSXa8O1Yb51/71aavvlL7VTjPlqVidc/LX4sEdJ7VW1
	 Tz+c5ZyuzuNVW04QHDp3Aun2kSRZOFifpVwIh4Kdb1kHmwZg+XweWLSGq+grgndWg6
	 KtQPaiTC9vEkX49WTOXlFlqtfmEjBe6Gw2x3yBbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgBKTGR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:06:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgBKTGR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Feb 2020 14:06:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447741FB;
        Tue, 11 Feb 2020 11:06:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8913F68F;
        Tue, 11 Feb 2020 11:06:15 -0800 (PST)
Date:   Tue, 11 Feb 2020 19:06:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, mikko.mutanen@fi.rohmeurope.com,
        markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Message-ID: <20200211190614.GP4543@sirena.org.uk>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
 <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftQmbtOmUf2cr8rB"
Content-Disposition: inline
In-Reply-To: <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ftQmbtOmUf2cr8rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 02:13:13PM +0200, Matti Vaittinen wrote:

> Provide a linear_range helper which can do conversion from user value
> to register value 'selector'.

> Mark, this is loosely bound to register handling... Do you think
> the regmap could host these helpers?

There's no real tie to regmap here, something like this could quite
happily be used by memory mapped devices where regmap has limited uses
and would be a lot to pull in.  A separate library would probably make
more sense.  Not sure how many users there would be outside of power
related stuff, I don't recall seeing the pattern elsewhere.

Note also that we already have quite extensive helpers for this sort of
stuff in the regulator API which I sense may have been involved in this
implementation and to an extent in ALSA which takes a different approach
with TLVs since it baked selectors directly into the ABI.

--ftQmbtOmUf2cr8rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5C+yUACgkQJNaLcl1U
h9BvKAf/RRzCbi0uxTdR1wgKG+fIeGPs3TkKagNkbWs4xD+Ppm3RpSu7lGNVDe2P
pNzxz4qP/9Q46Dm6iRplC5CsAARbYKjkflALvQ1TvuZB+vss5jc/9ARdOeKpRuhJ
T9kFP6CfRPh5JgDPwqqk/lUhe9fe5Ta26uoegdG9wZsn8J/vW5pnY7EDUkV4axPt
43zEvmzeyYnSBMARnvl9jdj4ysDEh6YpGy/lKGV9wvUMN8JmwtuEqbXgrtrVFzBd
dS12KPckixezMm7VwMrcZ9ain+W5knJt1yh/fjnBCqjd73rsWvsD8ijNNn7U0wPR
NdkkyrqpvCiXu7Om10I9uS2DhFOfYg==
=hzV/
-----END PGP SIGNATURE-----

--ftQmbtOmUf2cr8rB--
