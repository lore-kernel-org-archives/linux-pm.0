Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC33C43219
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41A923120
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgLVHcg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Dec 2020 02:32:36 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:21870 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLVHcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 02:32:32 -0500
Date:   Tue, 22 Dec 2020 07:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608622310;
        bh=yKsd9EiB1lb1beK3a4KefGe56jveojVKszto/Y3gwDs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=a4wvvJF5NU49JOEzl7ir6mlYaDTcXn7LtTc8pvhMJCTnTjX651pM88QxVth3aQYDv
         jBXf03nbjwQGtj9fCujbRgEEzsdf3kpWekPAzNFbrQJh/VsG9t6C5/EJdbDiM1Ydsv
         vHYWnRgvvt95RpYGDH4u2oHKPKw+y6E0CNSTEufk=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: [PATCH v3 5/7] ARM: dts: exynos: Added muic and charger nodes for i9100
Message-ID: <20201222070520.710096-5-timon.baetz@protonmail.com>
In-Reply-To: <20201222070520.710096-1-timon.baetz@protonmail.com>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

muic node is only used for extcon consumers.
charger node is used to specify muic and regulator.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 5370ee477186..8fa704babd5e 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -584,6 +584,16 @@ EN32KHZ_CP {
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
+
+=09=09muic: max8997-muic {
+=09=09=09compatible =3D "maxim,max8997-muic";
+=09=09};
+
+=09=09charger {
+=09=09=09compatible =3D "maxim,max8997-battery";
+=09=09=09charger-supply =3D <&charger_reg>;
+=09=09=09extcon =3D <&muic>;
+=09=09};
 =09};
 };
=20
--=20
2.25.1


