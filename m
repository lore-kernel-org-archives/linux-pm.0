Return-Path: <SRS0=mnou=4A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C67C2BA83
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA86A2073C
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581502094;
	bh=PnUHhbL5EBNau7gDirwckZRcXzaNtj8tI2PqO1V/IHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A2oS93OzzpGevAAw3BauPNEBeGDbYtjqLQ7U7TMNrzZbz8t0cBaR04VDL/ZAYLUM8
	 YajfileqHOoB4xzsg4I6n1Tl8vR/tK7sqPrCi1egY+iocP2b6DoXw48exn0MIWu2xr
	 Xn34We6ygRVjI0/eGkNqQWNaO5f0088duKE5riA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBLKIN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:08:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgBLKIN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D3930E;
        Wed, 12 Feb 2020 02:08:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC6E3F68F;
        Wed, 12 Feb 2020 02:08:11 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:08:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 24/28] sound: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200212100810.GA4028@sirena.org.uk>
References: <1654227.8mz0SueHsU@kreacher>
 <197693303.hiACyxC3Vm@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <197693303.hiACyxC3Vm@kreacher>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 12:34:15AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/update/remove_request() and
> cpu_latency_qos_request_active() instead of
> pm_qos_add/update/remove_request() and pm_qos_request_active(),
> respectively, because the latter are going to be dropped.

What's the story with dependencies here, I only have this patch and not
the cover letter?

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5DzocACgkQJNaLcl1U
h9CdQwf/Q2e/vTZXZOGkQc4SmmLKO8vWdGP403zQCNWSaKnp8IbFP281lmCkdON+
JzyFvlSUWFUEE8U7sSIuzWo7dLQurQkEq1O2klXl8W4HXo0W+8MZtsfFWQHt48ST
vCwe03qod15tZiXHwCfZzIxrwpM5/GfyX9EvFpa7BXCrHPkYs6R9Nr6W6txlwVQC
2Ase3vHCV8SycxbO7t5i4IYkKbjqhy9w/tw0SC+CtUVYCPKwnNXOMESjAnlKeec+
lpaW2Csy6UPWrWTPI8+03haZjxWMAk1zeL3F1ke8jYRCJly/2msG2px7DU1fKXRM
4mHpdaPzJIFLlB4tZFcse46+9ckXyQ==
=Qcri
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
