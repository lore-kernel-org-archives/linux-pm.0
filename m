From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] MAINTAINERS: Hibernation or S2R doesn't cover entire power directory
Date: Wed, 20 Sep 2017 08:58:52 -0700
Message-ID: <18e729501c1ebe4798d17b8d8a60ba102ebc2837.1505922834.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43691 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdITP7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 11:59:03 -0400
Received: by mail-pg0-f51.google.com with SMTP id u18so1924435pgo.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2017 08:59:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, pavel@ucw.cz, len.brown@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

The command:

 $ scripts/get_maintainer.pl -f drivers/base/power/opp/core.c

is incorrectly picking maintainers from Hibernation and Suspend to RAM
as well, simply because the entries in MAINTAINERS file contains the
entire power directory. Though the only concerning file is main.c
really. Mention the exact file name to fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2281af4b41b6..59521c15c65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6150,7 +6150,7 @@ L:	linux-pm@vger.kernel.org
 B:	https://bugzilla.kernel.org
 S:	Supported
 F:	arch/x86/power/
-F:	drivers/base/power/
+F:	drivers/base/power/main.c
 F:	kernel/power/
 F:	include/linux/suspend.h
 F:	include/linux/freezer.h
@@ -12809,7 +12809,7 @@ B:	https://bugzilla.kernel.org
 S:	Supported
 F:	Documentation/power/
 F:	arch/x86/kernel/acpi/
-F:	drivers/base/power/
+F:	drivers/base/power/main.c
 F:	kernel/power/
 F:	include/linux/suspend.h
 F:	include/linux/freezer.h
-- 
2.7.4
