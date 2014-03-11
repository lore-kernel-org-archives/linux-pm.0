From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH trivial 06/16] PM / Runtime: Add missing "it" in comment
Date: Tue, 11 Mar 2014 11:23:40 +0100
Message-ID: <1394533430-4746-6-git-send-email-geert@linux-m68k.org>
References: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4776cf528d08..67c7938e430b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1131,7 +1131,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
  * @dev: Device to handle.
  * @check_resume: If set, check if there's a resume request for the device.
  *
- * Increment power.disable_depth for the device and if was zero previously,
+ * Increment power.disable_depth for the device and if it was zero previously,
  * cancel all pending runtime PM requests for the device and wait for all
  * operations in progress to complete.  The device can be either active or
  * suspended after its runtime PM has been disabled.
-- 
1.7.9.5
