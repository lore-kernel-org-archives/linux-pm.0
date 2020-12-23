Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD826C4332E
	for <linux-pm@archiver.kernel.org>; Wed, 23 Dec 2020 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C6723128
	for <linux-pm@archiver.kernel.org>; Wed, 23 Dec 2020 13:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgLWNoW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Dec 2020 08:44:22 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:16582 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgLWNoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:44:20 -0500
Date:   Wed, 23 Dec 2020 13:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608731017;
        bh=CZAYsRHV593ZQXe0ik2Cb4E+1qQpPIw5P6nDjWNCENA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=t+2ntKFI97kioYC0Q+Rf4hYCMYler6OEO+Vap4VG39PoRhLzQDFr+5JoVN9DiqTpR
         dVk4H4VRVppCnvZI80Frog8VtT69QHOGIL6XqA4F8ZI25LKr7GVmh4ZnTopxTuV/m4
         Yvx7pYMgCvCmnt8JX2znfpOoWWluVjndDB6wd3U8=
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
Subject: [PATCH v4 7/7] ARM: dts: exynos: Add top-off charging regulator node for i9100
Message-ID: <20201223134221.804943-7-timon.baetz@protonmail.com>
In-Reply-To: <20201223134221.804943-1-timon.baetz@protonmail.com>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Value taken from Galaxy S2 Epic 4G Touch SPH-D710 Android vendor
kernel [0] which always sets 200mA.

Also rearrange regulators based on definition in max8997.h.

[0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/power/sec_battery_u1.c#L1525

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 586d801af0b5..e702adb69670 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -560,6 +560,16 @@ safe2_sreg: ESAFEOUT2 {
 =09=09=09=09regulator-boot-on;
 =09=09=09};
=20
+=09=09=09EN32KHZ_AP {
+=09=09=09=09regulator-name =3D "EN32KHZ_AP";
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
+=09=09=09EN32KHZ_CP {
+=09=09=09=09regulator-name =3D "EN32KHZ_CP";
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
 =09=09=09charger_reg: CHARGER {
 =09=09=09=09regulator-name =3D "CHARGER";
 =09=09=09=09regulator-min-microamp =3D <200000>;
@@ -573,13 +583,10 @@ chargercv_reg: CHARGER_CV {
 =09=09=09=09regulator-always-on;
 =09=09=09};
=20
-=09=09=09EN32KHZ_AP {
-=09=09=09=09regulator-name =3D "EN32KHZ_AP";
-=09=09=09=09regulator-always-on;
-=09=09=09};
-
-=09=09=09EN32KHZ_CP {
-=09=09=09=09regulator-name =3D "EN32KHZ_CP";
+=09=09=09CHARGER_TOPOFF {
+=09=09=09=09regulator-name =3D "CHARGER_TOPOFF";
+=09=09=09=09regulator-min-microamp =3D <200000>;
+=09=09=09=09regulator-max-microamp =3D <200000>;
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
--=20
2.25.1


