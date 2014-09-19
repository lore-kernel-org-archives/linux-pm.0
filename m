From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5 01/11] PM / Domains: Add a detach callback to the struct dev_pm_domain
Date: Fri, 19 Sep 2014 20:27:34 +0200
Message-ID: <1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45737 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757666AbaISS1z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 14:27:55 -0400
Received: by mail-pa0-f50.google.com with SMTP id fa1so606588pad.37
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2014 11:27:55 -0700 (PDT)
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The intent of this callback is to simplify detachment of devices from
their PM domains. Further patches will show the benefit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 72c0fe0..ef4e16f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -619,6 +619,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
  */
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
+	void (*detach)(struct device *, bool);
 };
 
 /*
-- 
1.9.1

