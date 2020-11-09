Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2204C2D0A3
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 19:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482FD206E3
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 19:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vBpfDwVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKITnT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:43:19 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:43802 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 14:43:19 -0500
Date:   Mon, 09 Nov 2020 19:43:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604950996;
        bh=WWGg03QUSz8PBJdw2YBA5VdrpzjAwQHTpCcW+I2ahXs=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=vBpfDwVVkNeqEnOFDm/vxPrXTkAd9EOKzpkdEBsrs+xEPtvSYeS+uhbdBHu0cV48m
         s+EtmdoJslTlv2F3+wdug9eTYyVa6BflSe4JwBYiY075ieM6pKDuPKcfB9WkPyINbD
         a93Ras1HIARq+YcUMx3JM3sXEWAYwqzutwy8GbLk=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 1/3] power: supply: max8997-charger: Use module_platform_driver()
Message-ID: <20201109194251.562203-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace register and unregister function calls with
module_platform_driver().

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/power/supply/max8997_charger.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index f5e84cd47924..94d1ade047a7 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -168,18 +168,7 @@ static struct platform_driver max8997_battery_driver =
=3D {
 =09.probe =3D max8997_battery_probe,
 =09.id_table =3D max8997_battery_id,
 };
-
-static int __init max8997_battery_init(void)
-{
-=09return platform_driver_register(&max8997_battery_driver);
-}
-subsys_initcall(max8997_battery_init);
-
-static void __exit max8997_battery_cleanup(void)
-{
-=09platform_driver_unregister(&max8997_battery_driver);
-}
-module_exit(max8997_battery_cleanup);
+module_platform_driver(max8997_battery_driver);
=20
 MODULE_DESCRIPTION("MAXIM 8997/8966 battery control driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
--=20
2.25.1


