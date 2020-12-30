Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA47C43381
	for <linux-pm@archiver.kernel.org>; Wed, 30 Dec 2020 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E6E221FA
	for <linux-pm@archiver.kernel.org>; Wed, 30 Dec 2020 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgL3Uxg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:53:36 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:37671 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgL3Uxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 15:53:36 -0500
Date:   Wed, 30 Dec 2020 20:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609361573;
        bh=q6zf8+wkY7PqGfPONtRPsNnxAOyfEBsV5INoxBIqKUo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=vXmnafD6/V8kFRqhP13sAKsp69W7k2ETGKkdA4iWbGcPEhdAsp9G6AJWx3hYks5OJ
         nwlsmqgI7GSRLJHDiDUHX7CX45ssoOwySL5A1kddRFA3ubbQoDeZAVmhQOOyTyshzi
         JvD+8TjEQqdifo+ifIbytsZMxSSCsFlMJfWS8f94=
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
Subject: [PATCH v6 6/8] ARM: dts: exynos: Add muic and charger nodes for Trats
Message-ID: <20201230205139.1812366-6-timon.baetz@protonmail.com>
In-Reply-To: <20201230205139.1812366-1-timon.baetz@protonmail.com>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

muic node is only used for extcon consumers.
charger node is used to point to muic.

Note: charging control is not working as we don't have a charger-supply.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
v6: No change.
v5: Add patch.

 arch/arm/boot/dts/exynos4210-trats.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exy=
nos4210-trats.dts
index a226bec56a45..686465f0044b 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -459,6 +459,15 @@ EN32KHZ_CP {
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
+=09=09=09extcon =3D <&muic>;
+=09=09};
 =09};
 };
=20
--=20
2.25.1


