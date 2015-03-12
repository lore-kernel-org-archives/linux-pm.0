From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 18/22] x86/olpc/xo15/sci: Use newly added
 power_supply_put API
Date: Thu, 12 Mar 2015 08:44:16 +0100
Message-ID: <1426146260-30081-19-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace direct usage of put_device() with new API: power_supply_put().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 186634e9021d..55130846ac87 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -83,7 +83,7 @@ static void battery_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(&psy->dev);
+		power_supply_put(psy);
 	}
 }
 
@@ -93,7 +93,7 @@ static void ac_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(&psy->dev);
+		power_supply_put(psy);
 	}
 }
 
-- 
1.9.1

