From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] PM / runtime: Document steps for device removal
Date: Sun,  3 Apr 2016 12:23:07 +0900
Message-ID: <1459653787-5963-1-git-send-email-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45709 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbcDCDXa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 2 Apr 2016 23:23:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Krzysztof Kozlowski <krzk@kernel.org>

Put a reminder that during device removal drivers should revert all PM
runtime changes from the probe.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Address Alan's comments.
---
 Documentation/power/runtime_pm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 7328cf85236c..1fd1fbe9ce95 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -586,6 +586,10 @@ drivers to make their ->remove() callbacks avoid races with runtime PM directly,
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

