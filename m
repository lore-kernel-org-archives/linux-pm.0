From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Add missing header file
Date: Fri, 26 Sep 2014 11:57:23 +0200
Message-ID: <1411725443-17328-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43814 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbaIZJ6G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 05:58:06 -0400
Received: by mail-lb0-f178.google.com with SMTP id z12so11464273lbi.37
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 02:58:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The commit below, starts using errno values in pm.h header file. But it
didn't include the header for these, let's add it.

46420dd73b800f87a19af13af5883855cf38cb08
(PM / Domains: Add APIs to attach/detach a PM domain for a device)

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Rafael, feel free to squash this change into the commit that was causing the
issue.

---
 include/linux/pm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index c4cbf48..69df420 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -27,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/timer.h>
 #include <linux/completion.h>
+#include <linux/errno.h>
 
 /*
  * Callbacks for platform drivers to implement.
-- 
1.9.1

