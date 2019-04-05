Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECCC4360F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B0218A6
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554472962;
	bh=YLyD9UK7a58sm+ZbvEW72Sy8kRoXPbd/NMxTrhRVJD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WPTWOpeUxhK0n/I1fVx27PKNkZV1vIFsnNgYTcBSBWevkyPFWdbp+HIlOB/WklVX7
	 o0rTn/flQ4+elqQR48AkAT4s8/rKtf7zB73Vs+oUFWsVcR2Lt7jrXNR5EX2H+X9MjR
	 H9x50nMpyef1K7+186lKjUrXkL8s4B6beJMIzJWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDEOCm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfDEOCl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Apr 2019 10:02:41 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26BB21850;
        Fri,  5 Apr 2019 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554472961;
        bh=YLyD9UK7a58sm+ZbvEW72Sy8kRoXPbd/NMxTrhRVJD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHwtm14y7bhronDTuOzNEOHHemteTxG0ANMmmUZ8oy1Q7gwGWnfDa2bgVOCYofcUu
         dvG4sgqSRxYNEiGRYwdIfH2bWOE52GUjyBCWmbgSo6FLGLFTbVaIlwTSCjcxCWHco4
         OSFTQjlnO4i4FbN/3e20jAEoV3T1ialIhjCjvmvQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 1E9703C08D5; Fri,  5 Apr 2019 16:02:39 +0200 (CEST)
Date:   Fri, 5 Apr 2019 16:02:38 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix the simple battery property names
Message-ID: <20190405140238.yuugynxoiyeh2nru@earth.universe>
References: <20190318133629.17144-1-maxime.ripard@bootlin.com>
 <20190402132245.wvakxqkhyyl66gbs@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgrhiohv2dkdy3ud"
Content-Disposition: inline
In-Reply-To: <20190402132245.wvakxqkhyyl66gbs@flea>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hgrhiohv2dkdy3ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 02, 2019 at 03:22:45PM +0200, Maxime Ripard wrote:
> On Mon, Mar 18, 2019 at 02:36:29PM +0100, Maxime Ripard wrote:
> > Commit c08b1f45d7d1 ("power: supply: core: Add power_supply_battery_info
> > and API") introduced code to parse the simple-battery node and express
> > battery charging constraints. However, it parsed that node using the
> > properties constant_charge_current_max_microamp and
> > constant_charge_voltage_max_microvolt, while the device tree binding for
> > the simple-battery node uses dashes to separate the words in those
> > properties (constant-charge-current-max-microamp and
> > constant-charge-voltage-max-microvolt).
> >
> > Let's make the code match the binding.
> >
> > Fixes: c08b1f45d7d1 ("power: supply: core: Add power_supply_battery_inf=
o and API")
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Ping?
>=20
> Maxime

Pong. Sorry for the delay, queued.

-- Sebastian

--hgrhiohv2dkdy3ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynX/4ACgkQ2O7X88g7
+prAzg/+L4tcUDf1Fne3MaHoABeJeMAVgCwbtRqbMnlh9EvK2VGIHD8fUOws/W2s
vxp0bm96UUbkfJEEavhAQvNOXTH/hQahZZAZiK41L5VvvQOl32G1tI1qkxJyYCH2
tBXzQzMdoSZzr9UNIaoxPQCn3N6pRHVogG8ZSZkqQ6CS5b/tNLIfIAN1iVFeHWlD
lUv8XSaBPbQAK99sWua1WDM7k+uzoNHx7JYNMgdvHJjN9d+VZ92bJC4K1/zxaQo7
f5d3l6gN+d7pwGhxbeb4ZsEBM7kOQbs96E+RmxIbTbyuUCEPSl4gHJQTQftXaoqf
SYMf/mTQYzAaqV01lfFyIX0de1vM4aQbKDTvHVsnSC07RClnDsIrF07wOhIriQIh
eCLy3QMYPJmFEUs4jYJdia/uk1m4fAbKJSkgzzUFK06zkFuuTE9S1SnfeMUcFIay
Q6rpQO6u7m5QboSFluHxxdV0U2R5m9Dpt0pjdttTGcAqCPDuE9zFKAVWmtIpu1VG
jkQwiZHD/RuZ0+dHRvvle2jkAXev1PwUK6OnifzLXUcVPXEw+VPTyt9sTzqV2IgG
WHrx0elNs2LQEBrMvijRbNC/ktM6vYrmYV6Hbv0E+Yhjqoj56sO+2y08iB7E2Lhm
bs0Vmsf9cY2yL7bjKOMpcgzkoEfJJOaR9Y3daDm0ykhHFxFqoR8=
=wW/4
-----END PGP SIGNATURE-----

--hgrhiohv2dkdy3ud--
