Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F4C433E9
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013F823A23
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 08:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbhAPIEP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Jan 2021 03:04:15 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:41308 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAPIEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 03:04:11 -0500
Date:   Sat, 16 Jan 2021 08:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610784208;
        bh=RTo2buFROqeDl4B9r3Quwwc7fkgEhCDar0wfjKOstSk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Uxl3SyllkBfAjI9P9Ycjc6Q6LijLObxongn3PpKEQW1K1EisBxANoVWI8LxcBgYwG
         /GHZxMTr8CUUGHK3MFua9gHKLS8SgPweVLCw4cBP38dRjXJXrZ+O6P0/Rcw5W+BwZO
         z0zkK8Fi7NJTme3u4vF+FYFBC3Gg2wrxr0UO8ddI=
To:     Mark Brown <broonie@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic nodes
Message-ID: <20210116090306.7c3d8023.timon.baetz@protonmail.com>
In-Reply-To: <20210115134213.GB4384@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com> <20210104183821.GA29033@kozik-lap> <20210104212449.GJ5645@sirena.org.uk> <20210105165529.GB20401@kozik-lap> <20210106145931.GE4752@sirena.org.uk> <20210108161635.1b9303c8.timon.baetz@protonmail.com> <20210108161653.GA4554@sirena.org.uk> <20210115071914.0407a928.timon.baetz@protonmail.com> <20210115134213.GB4384@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Jan 2021 13:42:14 +0000, Mark Brown wrote:
> On Fri, Jan 15, 2021 at 06:19:28AM +0000, Timon Baetz wrote:
> > On Fri, 8 Jan 2021 16:16:53 +0000, Mark Brown wrote: =20
> > > On Fri, Jan 08, 2021 at 03:16:48PM +0000, Timon Baetz wrote: =20
>=20
> > > > Muic needs a node to be used with extcon_get_edev_by_phandle().
> > > > Charger needs a node to reference a regulator.   =20
>=20
> > > The pattern is to use the parent device's node. =20
>=20
> > So is extcon going to be a self-reference then? =20
>=20
> I guess, assuming you even need to look this up via the device tree.

I could use extcon_get_extcon_dev("max8997-muic") and basically hard
code the extcon device name in the charger driver. Then I only need
charger-supply in DTS which could be added to the parent device's node.

Would that be acceptable for everyone?

Thanks,
Timon

