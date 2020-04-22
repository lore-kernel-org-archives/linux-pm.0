Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02974C5518A
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08252070B
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587542060;
	bh=MQTSD86O6M1bnIYylRa49DyZsLKtJ923VHornbG4pFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mQxn6pI32GdzPbJ8pflvsexFde0aH73q/RGEQ74xvD/8PBAFIeS4z5x2GpGn2TaCg
	 voVHQbNx+527LktFrE7KezeElHBvMjTXiLLEqtA+nH+2xBxzNqzFtnFmdlhERVFuWD
	 2HQ8zXX0D9jvBYDiAyRuZ5QleWDiLkvXT4A34gM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgDVHyR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVHyQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 03:54:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5019206E9;
        Wed, 22 Apr 2020 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587542056;
        bh=MQTSD86O6M1bnIYylRa49DyZsLKtJ923VHornbG4pFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODrN1YCgNkSTo2qwVq75iqXrl0LUlqKYqkHzbr0TbJIas5h/yMiva+AgZp/ZZYOCB
         c/vOXxqqGU8Foe3VgZ8rRPpUeLncfff5j5bn0M3fKAL+gKvxioN4hGEGfdPHl+f2Db
         zPsKTrvrFN3p9Ym5tg6ZYj28k8TNt1g987eqYRf0=
Date:   Wed, 22 Apr 2020 08:54:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
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
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup
 driver_deferred_probe_check_state()
Message-ID: <20200422075413.GB4898@sirena.org.uk>
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200421235836.GA8319@lxhi-065.adit-jv.com>
 <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
X-Cookie: A stitch in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 06:16:31PM -0700, John Stultz wrote:

> The second reverts the default timeout back to 0:
>   https://lore.kernel.org/lkml/20200413204253.84991-1-john.stultz@linaro.org/

If you're reverting the timeout we should revert the regulator change
too I think.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6f+CUACgkQJNaLcl1U
h9B2jAf+I1mw+3l5JPlDd66CSUBQXlljbUBT3lc2RE8ju3Zyn95lDo4bojHerldP
Sr96/KmiB2DYmvb//TfWyw+eRuGLJfVYOphRGPO7j8o2IV3qiG7wf6j0IVy2Ozu3
eOnIQiRcqFLQopyzLdHDTrLoSlyrxj82JFeEJTpbaGld1zXkUqkO67clZo8kO1rm
oHA+nFbEFlkOKkmEP/VcfxCruRfmfzXNZUuTWcFuIvJAd6T/M1oF4+9O8pkJAQXe
EPKzlPSZ+GYF1YNO/gqNfeVBzjm40tIMWxfpMewXk6IUWlyIeeXjoKEX5MTl6ZT6
mdWU5m7iIxqu4ktvs5Ive0JwTedMUA==
=3Hk5
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
