Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4AC61DA4
	for <linux-pm@archiver.kernel.org>; Wed, 15 Feb 2023 01:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBOBOA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjBOBN6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 20:13:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678F100;
        Tue, 14 Feb 2023 17:13:28 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423577;
        bh=0EOu0cCkF35D/w+sZ0yv5mJB46tZwLdnadArvhgAu40=;
        h=From:Date:Subject:To:Cc:From;
        b=anzssgxwre8WmjpDWy9/mZqkzXe43u1FSr22ZNV6UWBWvSIaZIZd0P4huGTMtMHt4
         kXqZvSbwEdNaTrpt6BfrLCxw0tRMoaf4vcWpTvSQvf+FK0i90M9VfdPwdF16WFK18b
         Vs0/oQsJW9f1fcn/+Qre6X8fYkJTGO5p7hKkRVLo=
Date:   Wed, 15 Feb 2023 01:12:55 +0000
Subject: [PATCH] power: supply: leds: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230215-power_supply-leds-pm-v1-1-fa79f846b04d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJYx7GMC/x2N0QrCMAwAf2Xk2cCWqg/+ioi0a+oKtQsN042xf
 zf4eAfH7aDcMivcuh0af7LmuRoMpw7GydcXY47GQD25noYLyvzl9tRFpGxYOCrKG4MjcteYwjk
 msDR4ZQzN13GyuC6lmJTGKa//1/1xHD8EMAwGewAAAA==
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423575; l=824;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0EOu0cCkF35D/w+sZ0yv5mJB46tZwLdnadArvhgAu40=;
 b=V+KzfR2xX/8fmciWfy+GV97kGbDvRS/R5g77ivD0Slbqo7nJhxoxao5iHmtyLgXmXkgoRj0Ap
 5ZziJSMEgKlDb+y8UNxErCS8gE6SW0Jvu3sCz6eRdN02D9O5HatDXBE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of relying on an accidental, transitive inclusion of linux/leds.h
use it directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_leds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index d69880cc3593..702bf83f6e6d 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/leds.h>
 
 #include "power_supply.h"
 

---
base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
change-id: 20230215-power_supply-leds-pm-b32236dfb4df

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

