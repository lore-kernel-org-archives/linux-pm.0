From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] i7300_idle: fix typo in parameter description
Date: Sat, 29 Oct 2016 15:11:31 +0000
Message-ID: <1477753891-1841-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34147 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbcJ2PLt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2016 11:11:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id u84so4140948pfj.1
        for <linux-pm@vger.kernel.org>; Sat, 29 Oct 2016 08:11:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Henroid <andrew.d.henroid@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix typo in parameter description.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/idle/i7300_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index 9a104e5..b570560 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
 
 static int forceload;
 module_param_named(forceload, forceload, uint, 0644);
-MODULE_PARM_DESC(debug, "Enable driver testing on unvalidated i5000");
+MODULE_PARM_DESC(forceload, "Enable driver testing on unvalidated i5000");
 
 #define dprintk(fmt, arg...) \
 	do { if (debug) printk(KERN_INFO I7300_PRINT fmt, ##arg); } while (0)

