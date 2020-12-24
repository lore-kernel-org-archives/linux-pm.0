Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32391C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 24 Dec 2020 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EC32151B
	for <linux-pm@archiver.kernel.org>; Thu, 24 Dec 2020 11:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgLXLYp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Dec 2020 06:24:45 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:20897 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgLXLYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 06:24:45 -0500
Date:   Thu, 24 Dec 2020 11:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608809042;
        bh=kdKn3PDdVjsSt9ViNOxevs6pAGOGkPzYhEj05jA5cRQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tHgeJlQsZEEjLZ8hH8r4e222g6XKJiZGUb5vJG8vzSP0kTBLLUZljyW67LMdyies9
         LtxE0qtqzyn9axbB+AhlWtd6UR9d8kCRyUSKCuYtDkq/GQtUClH+z3v4I4hyC0Zv/Q
         fRaLG8pEM1pFcyLHRjj/CGh/JjaTmKPuoREhHP3k=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v4 3/7] mfd: max8997: Add of_compatible to extcon and charger mfd_cell
Message-ID: <20201224122338.7183cf2e.timon.baetz@protonmail.com>
In-Reply-To: <20201223153207.GA300650@dell>
References: <20201223134221.804943-1-timon.baetz@protonmail.com> <20201223134221.804943-3-timon.baetz@protonmail.com> <20201223153207.GA300650@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 23 Dec 2020 15:32:07 +0000, Lee Jones wrote:
> On Wed, 23 Dec 2020, Timon Baetz wrote:
>=20
> > Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
> > of_node set in the extcon driver.
> >
> > Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configur=
e
> > the charger driver.
> >
> > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > ---
> >  drivers/mfd/max8997.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-) =20
>=20
> Why have you resent this?  It's already applied.
>=20

I made a change to an other patch in this series and wasn't sure if I
had to resubmit everything.=20

Thanks and sorry for the spam.
Timon

