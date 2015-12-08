From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] PCI / PM: Fix small typo in documentation
Date: Tue,  8 Dec 2015 16:17:25 +0200
Message-ID: <1449584245-4347-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50669 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964904AbbLHORt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 09:17:49 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

cuased -> caused

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/power/pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/pci.txt b/Documentation/power/pci.txt
index b0e911e0e8f5..44558882aa60 100644
--- a/Documentation/power/pci.txt
+++ b/Documentation/power/pci.txt
@@ -999,7 +999,7 @@ from its probe routine to make runtime PM work for the device.
 
 It is important to remember that the driver's runtime_suspend() callback
 may be executed right after the usage counter has been decremented, because
-user space may already have cuased the pm_runtime_allow() helper function
+user space may already have caused the pm_runtime_allow() helper function
 unblocking the runtime PM of the device to run via sysfs, so the driver must
 be prepared to cope with that.
 
-- 
2.6.2

