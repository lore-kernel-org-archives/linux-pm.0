Return-Path: <SRS0=4Unk=4M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E6C11D30
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 11:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A830F20CC7
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582545474;
	bh=TQUIowE30VdAV33/T/Y32SzcQ1qQJwEAknSYGo0aouQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=litVvzjVPqIZHRoiu3rYZaRzFS8l9fQvtXtbSTYHu3TlEHzCEpIv1YGjtGJFGzH9S
	 bLp0lCUhu4YdEXit+1NIhQMq27oiSjbKHqf2JSy2Dez3DtqWfA3IZ/zhCYinyXKAlF
	 C83WEAtFbJVIiqG7xZUKX6Wrbr6YTx3mWr78o990=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXL5y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:57:54 -0500
Received: from foss.arm.com ([217.140.110.172]:35990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXL5x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 06:57:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B73D30E;
        Mon, 24 Feb 2020 03:57:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A943F534;
        Mon, 24 Feb 2020 03:57:52 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:57:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 5/8] regulator: use linear_ranges helper
Message-ID: <20200224115751.GE6215@sirena.org.uk>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <ba2eb2d7363b386136a546a769a6e2d077558094.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <ba2eb2d7363b386136a546a769a6e2d077558094.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 09:36:38AM +0200, Matti Vaittinen wrote:
> Change the regulator helpers to use common linear_ranges code.

This needs to be squashed in with the previous commit to avoid build
breaks.

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Tuj4ACgkQJNaLcl1U
h9A5bQf/c4NDAlkQYJrML9SwHTF60tD0f1c0dJS+Yp8mVWpsiRYH6J1Sl4x4+Ru+
X4T2HfntKJBGkXNERIAZ4GwzpsN/O3oiADfVbsy1IqQuz9eFG1k6k7XLVo81J1iD
mVptuQuSWgi6bmtETBLwYxRHunxFNSod/cMEROMPYFMRxos8oA9MiiIYlgYN1eSA
ll1OvO1fyUIsjG+4gVayDyPRIVmY1D/65VKs50eyhp2PTenK6CGED0zfuqmqBV3p
yXukhloW+FocYcEHTrIfk2XevHfJEOM9PJdIGD4aXzqfNOZnZb3p4A0d5vLn9LnG
p2ITROFZ1P/XSRcV2OCDSIzdr68vgg==
=+guT
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
