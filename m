From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PM / wakeirq: forward declare 'struct device'
Date: Wed,  9 Nov 2016 18:02:57 -0800
Message-ID: <1478743377-15865-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35176 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbcKJCDj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 21:03:39 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so135834356pfk.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 18:03:39 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>

Drivers might include this header without <linux/device.h>.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/linux/pm_wakeirq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index cd5b62db9084..49c2220fb245 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -14,6 +14,8 @@
 #ifndef _LINUX_PM_WAKEIRQ_H
 #define _LINUX_PM_WAKEIRQ_H
 
+struct device;
+
 #ifdef CONFIG_PM
 
 extern int dev_pm_set_wake_irq(struct device *dev, int irq);
-- 
2.8.0.rc3.226.g39d4020

