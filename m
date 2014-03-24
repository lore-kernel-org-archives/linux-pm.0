From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] PM / Runtime: Split line longer than 80 characters
Date: Mon, 24 Mar 2014 21:31:28 +0100
Message-ID: <1395693091-4813-2-git-send-email-geert@linux-m68k.org>
References: <1395693091-4813-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395693091-4813-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/power/runtime_pm.txt |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index a5683a5662cb..f62deb66d5c1 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -401,11 +401,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
   int pm_runtime_disable(struct device *dev);
     - increment the device's 'power.disable_depth' field (if the value of that
       field was previously zero, this prevents subsystem-level runtime PM
-      callbacks from being run for the device), make sure that all of the pending
-      runtime PM operations on the device are either completed or canceled;
-      returns 1 if there was a resume request pending and it was necessary to
-      execute the subsystem-level resume callback for the device to satisfy that
-      request, otherwise 0 is returned
+      callbacks from being run for the device), make sure that all of the
+      pending runtime PM operations on the device are either completed or
+      canceled; returns 1 if there was a resume request pending and it was
+      necessary to execute the subsystem-level resume callback for the device
+      to satisfy that request, otherwise 0 is returned
 
   int pm_runtime_barrier(struct device *dev);
     - check if there's a resume request pending for the device and resume it
-- 
1.7.9.5
