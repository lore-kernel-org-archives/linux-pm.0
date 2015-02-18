From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 5/8] tools/thermal: tmon: add .gitignore
Date: Tue, 17 Feb 2015 18:18:33 -0800
Message-ID: <1424225916-13488-6-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36704 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbBRCTe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 21:19:34 -0500
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/thermal/tmon/.gitignore

diff --git a/tools/thermal/tmon/.gitignore b/tools/thermal/tmon/.gitignore
new file mode 100644
index 000000000000..06e96be65276
--- /dev/null
+++ b/tools/thermal/tmon/.gitignore
@@ -0,0 +1 @@
+/tmon
-- 
1.9.1

