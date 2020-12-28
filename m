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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA16BC433E6
	for <linux-pm@archiver.kernel.org>; Mon, 28 Dec 2020 11:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD39D221F0
	for <linux-pm@archiver.kernel.org>; Mon, 28 Dec 2020 11:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgL1LhH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:37:07 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:44236 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbgL1LhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 06:37:07 -0500
Date:   Mon, 28 Dec 2020 11:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609155385;
        bh=VJNktw6SWHb4HCSmN1XyzvQQtDw1HX3X6t+P/K46JgU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bNhIX59XvV+alI+ld2pfBTgORo4ntSsosfLzEBPON9Kf16u6JFoe+swNjYpH3/WbD
         Se7v25CAP/Y09ls0Kd8vQZIWhBXiz1IMm4edS5d9pm6440oLGvsLTMRb3dlBhhMsDP
         aBJEphh+ptvaeCqvaR7qTq/OFthQc9/q98axgD+Q=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v5 5/8] ARM: dts: exynos: Add muic and charger nodes for Origen
Message-ID: <20201228113507.1292506-5-timon.baetz@protonmail.com>
In-Reply-To: <20201228113507.1292506-1-timon.baetz@protonmail.com>
References: <20201228113507.1292506-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both nodes are disabled as there is no battery and pins are not
connected.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/ex=
ynos4210-origen.dts
index 7d2cfbafefb2..9792531ac3da 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -312,6 +312,16 @@ EN32KHZ_AP {
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
+
+=09=09muic {
+=09=09=09compatible =3D "maxim,max8997-muic";
+=09=09=09status =3D "disabled";
+=09=09};
+
+=09=09charger {
+=09=09=09compatible =3D "maxim,max8997-battery";
+=09=09=09status =3D "disabled";
+=09=09};
 =09};
 };
=20
--=20
2.25.1


