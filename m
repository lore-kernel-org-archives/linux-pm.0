Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0308C388F9
	for <linux-pm@archiver.kernel.org>; Thu, 19 Nov 2020 21:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CD3221FC
	for <linux-pm@archiver.kernel.org>; Thu, 19 Nov 2020 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="j1Oh3LXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKSVc7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:32:59 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:33136 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSVc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 16:32:59 -0500
Date:   Thu, 19 Nov 2020 21:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605821575;
        bh=vV9btdBNr+r/Yu6y6o0Vn/OnbnYaki7TR3vd4fgrem4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=j1Oh3LXxCkA1rxFaO4vZ+wCxSujB3t+Ao9YLvpGKU2OrWXUu7cKrn9MOid8j0pFq3
         lgeQFGBtXgSmzVwuQQpdgpgurlOiSR7rTKnbGqem/Z1tDuYnscZYtRdzcRp/FxKiuj
         tKAru7JujK3QCK+zLgBY0PVt1KS9rg2+hvNDbfkw=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Timon Baetz <timon.baetz@protonmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH] power: supply: max17042_battery: Reorder power supply properties
Message-ID: <20201119213117.1385219-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 21b01cc879cc ("power: supply: max17042_battery: Add support for
the TTE_NOW prop") added a new property (TIME_TO_EMPTY_NOW) at end of
max17042_battery_props.

Reorder max17042_battery_props to properly ignore CURRENT_NOW and
CURRENT_AVG when current sense is disabled.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply=
/max17042_battery.c
index f284547913d6..672c75639a37 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -85,9 +85,9 @@ static enum power_supply_property max17042_battery_props[=
] =3D {
 =09POWER_SUPPLY_PROP_TEMP_MAX,
 =09POWER_SUPPLY_PROP_HEALTH,
 =09POWER_SUPPLY_PROP_SCOPE,
+=09POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 =09POWER_SUPPLY_PROP_CURRENT_NOW,
 =09POWER_SUPPLY_PROP_CURRENT_AVG,
-=09POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 };
=20
 static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
--=20
2.25.1


