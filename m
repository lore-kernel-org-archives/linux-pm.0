From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] PM / runtime: Document steps for device removal
Date: Sat, 12 Mar 2016 15:01:55 +0900
Message-ID: <1457762515-10295-1-git-send-email-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50410 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbcCLGCL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Mar 2016 01:02:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Krzysztof Kozlowski <krzk@kernel.org>

Put a reminder that during device removal drivers should revert all PM
runtime changes from the probe. Also add a note that
pm_runtime_disable() won't wait for pending suspend requests if
autosuspend is not disabled before.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/power/runtime_pm.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 7328cf85236c..c05e5a17a52d 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -410,7 +410,8 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       field was previously zero, this prevents subsystem-level runtime PM
       callbacks from being run for the device), make sure that all of the
       pending runtime PM operations on the device are either completed or
-      canceled; returns 1 if there was a resume request pending and it was
+      canceled (although this depends on disabling autosuspend before
+      calling this); returns 1 if there was a resume request pending and it was
       necessary to execute the subsystem-level resume callback for the device
       to satisfy that request, otherwise 0 is returned
 
@@ -586,6 +587,10 @@ drivers to make their ->remove() callbacks avoid races with runtime PM directly,
 but also it allows of more flexibility in the handling of devices during the
 removal of their drivers.
 
+Drivers in ->remove() callback should undo the runtime PM changes done
+in ->probe(). Usually this means calling pm_runtime_disable(),
+pm_runtime_dont_use_autosuspend() etc.
+
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
 attribute to "on", which causes pm_runtime_forbid() to be called.  In principle,
-- 
2.1.4

