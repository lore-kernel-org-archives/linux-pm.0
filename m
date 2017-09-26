From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Move the OPP directory out of power/
Date: Mon, 25 Sep 2017 17:05:24 -0700
Message-ID: <2767b448493ca16f064618d36387ac56dfec0e56.1506384278.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:46642 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966655AbdIZAFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 20:05:35 -0400
Received: by mail-pg0-f50.google.com with SMTP id i130so4940040pgc.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2017 17:05:35 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org

The drivers/base/power/ directory is special and contains code related
to power management core like system suspend/resume, hibernation, etc.
It was fine to keep the OPP code inside it when we had just one file for
it, but it is growing now and already has a directory for itself.

Lets move it directly under drivers/ directory, just like cpufreq and
cpuidle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/Makefile                       | 1 +
 drivers/base/power/Makefile            | 1 -
 drivers/{base/power => }/opp/Makefile  | 0
 drivers/{base/power => }/opp/core.c    | 0
 drivers/{base/power => }/opp/cpu.c     | 0
 drivers/{base/power => }/opp/debugfs.c | 0
 drivers/{base/power => }/opp/of.c      | 0
 drivers/{base/power => }/opp/opp.h     | 0
 8 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{base/power => }/opp/Makefile (100%)
 rename drivers/{base/power => }/opp/core.c (100%)
 rename drivers/{base/power => }/opp/cpu.c (100%)
 rename drivers/{base/power => }/opp/debugfs.c (100%)
 rename drivers/{base/power => }/opp/of.c (100%)
 rename drivers/{base/power => }/opp/opp.h (100%)

diff --git a/drivers/Makefile b/drivers/Makefile
index d90fdc413648..dd718a3007e9 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_ACCESSIBILITY)	+= accessibility/
 obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_EDAC)		+= edac/
 obj-$(CONFIG_EISA)		+= eisa/
+obj-$(CONFIG_PM_OPP)		+= opp/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-y				+= mmc/
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 5998c53280f5..73a1cffc0a5f 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,7 +1,6 @@
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
-obj-$(CONFIG_PM_OPP)	+= opp/
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
diff --git a/drivers/base/power/opp/Makefile b/drivers/opp/Makefile
similarity index 100%
rename from drivers/base/power/opp/Makefile
rename to drivers/opp/Makefile
diff --git a/drivers/base/power/opp/core.c b/drivers/opp/core.c
similarity index 100%
rename from drivers/base/power/opp/core.c
rename to drivers/opp/core.c
diff --git a/drivers/base/power/opp/cpu.c b/drivers/opp/cpu.c
similarity index 100%
rename from drivers/base/power/opp/cpu.c
rename to drivers/opp/cpu.c
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/opp/debugfs.c
similarity index 100%
rename from drivers/base/power/opp/debugfs.c
rename to drivers/opp/debugfs.c
diff --git a/drivers/base/power/opp/of.c b/drivers/opp/of.c
similarity index 100%
rename from drivers/base/power/opp/of.c
rename to drivers/opp/of.c
diff --git a/drivers/base/power/opp/opp.h b/drivers/opp/opp.h
similarity index 100%
rename from drivers/base/power/opp/opp.h
rename to drivers/opp/opp.h
-- 
2.7.4
