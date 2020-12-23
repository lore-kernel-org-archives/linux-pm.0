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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A198C433E0
	for <linux-pm@archiver.kernel.org>; Wed, 23 Dec 2020 13:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7146422BF3
	for <linux-pm@archiver.kernel.org>; Wed, 23 Dec 2020 13:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgLWNno (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Dec 2020 08:43:44 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:62065 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgLWNno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:43:44 -0500
Date:   Wed, 23 Dec 2020 13:42:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608730982;
        bh=acDpNkZlgg3POOor0u+D9TYzB52a154XD9l+kpesuTk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AguaoofohIlTlVaVpj7MsfX9TD1jLpcEY2wSG1Aobc3kchAgao6UewQhmGnvExFOD
         60pOO93PC/da2RTKO7qJBvzbJ0KngW6Wf29Fb4979+ZhH8uBGZzZWLi6AoMba1XbhH
         9c1A5A1aw+o+13kFRqYRGQ95vCEKVR8LDZcSx1AI=
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
Subject: [PATCH v4 3/7] mfd: max8997: Add of_compatible to extcon and charger mfd_cell
Message-ID: <20201223134221.804943-3-timon.baetz@protonmail.com>
In-Reply-To: <20201223134221.804943-1-timon.baetz@protonmail.com>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
of_node set in the extcon driver.

Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configure
the charger driver.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/mfd/max8997.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 68d8f2b95287..55d3a6f97783 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -29,9 +29,9 @@
 static const struct mfd_cell max8997_devs[] =3D {
 =09{ .name =3D "max8997-pmic", },
 =09{ .name =3D "max8997-rtc", },
-=09{ .name =3D "max8997-battery", },
+=09{ .name =3D "max8997-battery", .of_compatible =3D "maxim,max8997-batter=
y", },
 =09{ .name =3D "max8997-haptic", },
-=09{ .name =3D "max8997-muic", },
+=09{ .name =3D "max8997-muic", .of_compatible =3D "maxim,max8997-muic", },
 =09{ .name =3D "max8997-led", .id =3D 1 },
 =09{ .name =3D "max8997-led", .id =3D 2 },
 };
--=20
2.25.1


