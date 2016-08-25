From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 1/4] cpu: clean up register_cpu func
Date: Thu, 25 Aug 2016 16:42:39 +0800
Message-ID: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35563 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933610AbcHYInk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 04:43:40 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so15906151pfd.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Aug 2016 01:42:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

This patch could reduce one branch in this function. Also
make the code more readble.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
To: linux-kernel@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 691eeea..4c28e1a 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -371,12 +371,13 @@ int register_cpu(struct cpu *cpu, int num)
 	if (cpu->hotpluggable)
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
 	error = device_register(&cpu->dev);
-	if (!error)
-		per_cpu(cpu_sys_devices, num) = &cpu->dev;
-	if (!error)
-		register_cpu_under_node(num, cpu_to_node(num));
+	if (error)
+		return error;
 
-	return error;
+	per_cpu(cpu_sys_devices, num) = &cpu->dev;
+	register_cpu_under_node(num, cpu_to_node(num));
+
+	return 0;
 }
 
 struct device *get_cpu_device(unsigned cpu)
-- 
2.8.1.101.g72d917a

