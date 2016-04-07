From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] PM / sleep: add a helper function to inherit child ignorance
Date: Thu,  7 Apr 2016 15:20:35 +0200
Message-ID: <1460035237-12037-2-git-send-email-linus.walleij@linaro.org>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35365 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcDGNU6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 09:20:58 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so56888168lfb.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 06:20:57 -0700 (PDT)
In-Reply-To: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

A few subsystems dealing with peripherals on slow buses with
transfer-oriented runtime PM will need to inherit the child
ignorance property of their parent hardware devices.

Especially struct i2c_adapter and struct spi_master needs
this.

This adds a helper function to deal with this and make it
clear what is going on.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/device.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 002c59728dbe..675c09e62239 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -961,6 +961,13 @@ static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 	dev->power.ignore_children = enable;
 }
 
+static inline void pm_suspend_inherit_ignore_children(struct device *dev)
+{
+	if (!dev->parent)
+		return;
+	dev->power.ignore_children = dev->parent->power.ignore_children;
+}
+
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
 {
 #ifdef CONFIG_PM_SLEEP
-- 
2.4.3

