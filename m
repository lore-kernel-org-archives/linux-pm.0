Return-Path: <SRS0=R0/j=5J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52FC54EEB
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 20:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA563208D5
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 20:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585082318;
	bh=Aju3aIKRNZNL2dK+17kKvTquLg4F6PBlwz2wsFmpc1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNSRyHDcXDV2D0ugtjRqpbbOeTIv4ZWyfsfqtALISPzoWAcLEhLWHUHA1wqFVaeAU
	 OOjFnrpgZAsVKkPJ0a0idc3Sgf9HEejMTlNYPtpIsSvsJQ3w4J9OXA+LB/MPXSOqrn
	 Ni5rTCQIexebwKv7eUOSSXTQkisR33lZ/VasNe64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXUih (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:38:37 -0400
Received: from foss.arm.com ([217.140.110.172]:40576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgCXUih (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 16:38:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F36731B;
        Tue, 24 Mar 2020 13:38:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE7A3F71F;
        Tue, 24 Mar 2020 13:38:35 -0700 (PDT)
Date:   Tue, 24 Mar 2020 20:38:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH V4 11/13] dt-bindings: regulator: add DVFSRC regulator
 dt-bindings
Message-ID: <20200324203833.GL7039@sirena.org.uk>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
 <1584092066-24425-12-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <1584092066-24425-12-git-send-email-henryc.chen@mediatek.com>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 05:34:24PM +0800, Henry Chen wrote:

> +- regulator : The DVFSRC regulator is modelled as a subdevice of the DVFSRC.
> +	Because DVFSRC can request power directly via register read/write, likes
> +	vcore which is a core power of mt8183. As such, the DVFSRC regulator
> +	requires that DVFSRC nodes be present. shall contain only one of the
> +	following: "mediatek,mt8183-dvfsrc-regulator"

Why do we even need a compatible here - it's not adding any new
information to the parent mt8183 node, the compatible is mainly for the
way Linux divides things up rather than a description of the hardware.
We could just say that the regulator node always has a particular name
instead.

It's also not quite true that it contains "only" the compatible - it
also allows the regulator constraints to be defined.

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl56b8kACgkQJNaLcl1U
h9BVDwf/RAYKDpswM9LzY+qhfj6MLLg7KpdzLRHMUjmy5/LLU1HpBEtu8YhHSzBX
/+V7JmuFIoswcuE1W6nL9Rvtxp5cNAFwUbWyHKeP+wKCRrMRy3BCwICR/CqLTt4i
aloftUH1AythmDbWKFeMF47RRo5cqaEklU5MW4MK+b+mGluEyvX2AEiqvIwgEyi3
+a5P7KtSH22jRWOx5z7B5/zMRIrG3kSReLWh3nTeRX7ky5tV/sKVW/2Z1MgRyxyF
VReF9OlRZyAvNJ6IqfjjOXwroaJs0nTWR3MXRFd5xf+RTIdvkvU+YH6nvrIwxpqi
gU0MdPkAAbq4e7HzdchQ/hsXz16mOw==
=f2rY
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
