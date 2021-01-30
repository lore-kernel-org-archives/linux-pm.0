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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE5C433E9
	for <linux-pm@archiver.kernel.org>; Sat, 30 Jan 2021 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4278764E09
	for <linux-pm@archiver.kernel.org>; Sat, 30 Jan 2021 17:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhA3RaX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 30 Jan 2021 12:30:23 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:56666 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhA3RaW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2021 12:30:22 -0500
Date:   Sat, 30 Jan 2021 17:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612027780;
        bh=4eVGT5fGnXBDwcPzfkmp9J/JieDPT6/ded3iof5KfOA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=wChuA3TIYOvugxz0FnaYnnTCRwfUv25nY692W4mkM1Azx/pv2ZwhaXry8oF1kk5ML
         RDqFIJfiCGrHOkC5FwOPL9buNO+WqKF/RqbZ2MqFFG78fw2ALi4Uqe1fWQt1VQfeiK
         G5MIPtbNSwPIBzKqVo3V4sJFK5Vx6YqQ2EKmH1r0=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 2/3] ARM: dts: exynos: Add charger supply for I9100
Message-ID: <20210130172747.2022977-3-timon.baetz@protonmail.com>
In-Reply-To: <20210130172747.2022977-1-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The regulator is used for charging control by max8997_charger driver.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 304a8ee2364c..dad950daafb4 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -384,6 +384,8 @@ pmic@66 {
 =09=09pinctrl-0 =3D <&max8997_irq>, <&otg_gp>, <&usb_sel>;
 =09=09pinctrl-names =3D "default";
=20
+=09=09charger-supply =3D <&charger_reg>;
+
 =09=09regulators {
 =09=09=09vadc_reg: LDO1 {
 =09=09=09=09regulator-name =3D "VADC_3.3V_C210";
--=20
2.25.1


