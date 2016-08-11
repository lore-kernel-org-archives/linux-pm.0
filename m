From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] Documentation/: update hibernation debug documentation
Date: Thu, 11 Aug 2016 20:18:11 +0800
Message-ID: <1470917891-8386-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34253 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbcHKMKU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 08:10:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM List <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Update the description of test_resume mode for hibernation.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 Documentation/power/basic-pm-debugging.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
index b96098c..5f1f228 100644
--- a/Documentation/power/basic-pm-debugging.txt
+++ b/Documentation/power/basic-pm-debugging.txt
@@ -36,6 +36,13 @@ button to make the system resume).
 If neither "platform" nor "shutdown" hibernation mode works, you will need to
 identify what goes wrong.
 
+Besides, if all the modes described above work, "test_resume" mode can be used to
+verify if the snapshot data written to swap device can be successfully restored
+to memory:
+# echo test_resume > /sys/power/disk
+# echo disk > /sys/power/state
+If everything goes well, the system will resume back without BIOSes involved in.
+
 a) Test modes of hibernation
 
 To find out why hibernation fails on your system, you can use a special testing
-- 
2.7.4

