From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH RESEND v2 6/8] power: apm_power: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 04 Nov 2014 16:01:39 +0100
Message-ID: <1415113301-25661-7-git-send-email-k.kozlowski@samsung.com>
References: <1415113301-25661-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:16241 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaKDPBy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 10:01:54 -0500
In-reply-to: <1415113301-25661-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/apm_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/apm_power.c b/drivers/power/apm_power.c
index 39763015b360..2206f9ff6488 100644
--- a/drivers/power/apm_power.c
+++ b/drivers/power/apm_power.c
@@ -15,10 +15,10 @@
 #include <linux/apm-emulation.h>
 
 
-#define PSY_PROP(psy, prop, val) (psy->get_property(psy, \
+#define PSY_PROP(psy, prop, val) (power_supply_get_property(psy, \
 			 POWER_SUPPLY_PROP_##prop, val))
 
-#define _MPSY_PROP(prop, val) (main_battery->get_property(main_battery, \
+#define _MPSY_PROP(prop, val) (power_supply_get_property(main_battery, \
 							 prop, val))
 
 #define MPSY_PROP(prop, val) _MPSY_PROP(POWER_SUPPLY_PROP_##prop, val)
-- 
1.9.1

