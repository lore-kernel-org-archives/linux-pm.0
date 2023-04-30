Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B6C77B73
	for <linux-pm@archiver.kernel.org>; Sun, 30 Apr 2023 06:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjD3GMC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 30 Apr 2023 02:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD3GMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2023 02:12:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA619A6;
        Sat, 29 Apr 2023 23:11:58 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1682835116;
        bh=EWND/P5khW/j9msjU3H9jrXagHPGsVQxvQ8akYP7ayI=;
        h=From:Date:Subject:To:Cc:From;
        b=MDhUIn1eWSNUftjkq02ZdQnnr27CEXFpWLMoCamhu5s9gj4Rb2BrvD0scQ1Uxv+j2
         zTxxoYM4t9LPB42i06M/zj4Z+KyuwmhqpBSKOOgdVOtIP0vclFHSsjGoY3WHRQ5JEW
         BP99PbBBXOUrg4wlP70IDqvancS1KtiBqPDtfLgc=
Date:   Sun, 30 Apr 2023 08:11:53 +0200
Subject: [PATCH] power: supply: remove unneeded include of linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230212-include-power_supply-leds-v1-1-7adbf7424002@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKgGTmQC/x2NSwrDMAwFrxK0riB2F4ZepZTij9IIhGMk3KaE3
 L2my3kwbw4wUiaD23SA0puNtzrAXSbIa6wvQi6Dwc/+OnvnkWuWXgjb9iF9Wm9NvihUDBdyJbg
 cUkgehp+iESaNNa/joXaRMTalhfd/8P44zx8hMs9XgAAAAA==
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682835115; l=1310;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EWND/P5khW/j9msjU3H9jrXagHPGsVQxvQ8akYP7ayI=;
 b=VH/gXETeC6s11ytN6rvcKxK5qUEpEwcKdrw+devE/9e8YR+2NwkaqZLZxjmaWx8YafYa1V7JC
 9eHbD20/9UZBVnRBmQoNW7ds5Kgzeps5nlOXpBJq8tJMgJ8DAV2bjNp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of including the full linux/leds.h header file a single
forward-declaration is enough.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Currently power_supply.h includes leds.h to get access to
struct led_trigger.
This propagates the inclusion unnecessarily to all users of
power_supply.h.

Replace this inclusion by a single forward declaration.
---
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/power_supply.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a427f13c757f..dc5e17e8c919 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -14,10 +14,11 @@
 
 #include <linux/device.h>
 #include <linux/workqueue.h>
-#include <linux/leds.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 
+struct led_trigger;
+
 /*
  * All voltages, currents, charges, energies, time and temperatures in uV,
  * µA, µAh, µWh, seconds and tenths of degree Celsius unless otherwise

---
base-commit: 825a0714d2b3883d4f8ff64f6933fb73ee3f1834
change-id: 20230212-include-power_supply-leds-fe1d71c7b7b2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

