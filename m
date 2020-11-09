Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90168C2D0A3
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 19:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12235206D8
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 19:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kixyinjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgKITni (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:43:38 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:43806 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKITni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 14:43:38 -0500
Date:   Mon, 09 Nov 2020 19:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604951015;
        bh=mtivj5a3XDETnPGPkas832MpzL65lI8aIeNWoK/8gGo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kixyinjHwdKmPBsHmFx6FQWzE/5u2SNePLwIGcGi0pd0ZBFB0Quy7kxyVoVFBeDZ6
         H1v2mVfUPvixXvB25T7Zzrh2GVHIFm0cjU1wbH7VoB5trqO2m6yOu0SdikUEhiIlT1
         zal8mh8MiMt1Q3uk9qPj6YsNpvx+JQkdziU4+SVE=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 2/3] power: supply: max8997-charger: Fix platform data retrieval
Message-ID: <20201109194251.562203-2-timon.baetz@protonmail.com>
In-Reply-To: <20201109194251.562203-1-timon.baetz@protonmail.com>
References: <20201109194251.562203-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use pdata field of max8998_dev struct to obtain platform data.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/power/supply/max8997_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index 94d1ade047a7..8fccd58dac67 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -84,7 +84,7 @@ static int max8997_battery_probe(struct platform_device *=
pdev)
 =09int ret =3D 0;
 =09struct charger_data *charger;
 =09struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
-=09struct max8997_platform_data *pdata =3D dev_get_platdata(iodev->dev);
+=09struct max8997_platform_data *pdata =3D iodev->pdata;
 =09struct power_supply_config psy_cfg =3D {};
=20
 =09if (!pdata)
--=20
2.25.1


