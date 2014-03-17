From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] PM / Runtime: Update runtime_idle() documentation for return value meaning
Date: Mon, 17 Mar 2014 21:26:11 +0100
Message-ID: <1395087971-31897-2-git-send-email-geert@linux-m68k.org>
References: <1395087971-31897-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395087971-31897-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

As of commit 45f0a85c8258741d11bda25c0a5669c06267204a ('PM / Runtime:
Rework the "runtime idle" helper routine'), the return value of
->runtime_idle() is no longer ignored by the PM core, but used to decide
whether to suspend the device or not.

Update the documentation to match the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 include/linux/pm.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 22ba7338d48c..dce45304f77e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -264,9 +264,9 @@ typedef struct pm_message {
  *	registers, so that it is fully operational.
  *
  * @runtime_idle: Device appears to be inactive and it might be put into a
- *	low-power state if all of the necessary conditions are satisfied.  Check
- *	these conditions and handle the device as appropriate, possibly queueing
- *	a suspend request for it.  The return value is ignored by the PM core.
+ *	low-power state if all of the necessary conditions are satisfied.
+ *	Check these conditions, and return 0 if it's appropriate to let the PM
+ *	core queue a suspend request for the device.
  *
  * Refer to Documentation/power/runtime_pm.txt for more information about the
  * role of the above callbacks in device runtime power management.
-- 
1.7.9.5
