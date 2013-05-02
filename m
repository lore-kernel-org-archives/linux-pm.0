From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, RFC 03/22] cpuidle: calxeda: select ARM_CPU_SUSPEND
Date: Thu,  2 May 2013 17:16:07 +0200
Message-ID: <1367507786-505303-4-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60085 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158Ab3EBPQg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2013 11:16:36 -0400
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

Like other ARM specific drivers, this one requires ARM_CPU_SUSPEND,
as shown by this linker error:

drivers/built-in.o: In function `calxeda_pwrdown_idle':
drivers/cpuidle/cpuidle-calxeda.c:84: undefined reference to `cpu_suspend'
drivers/cpuidle/cpuidle-calxeda.c:86: undefined reference to `cpu_resume'

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpuidle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..e21cdfa 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -36,6 +36,7 @@ if CPU_IDLE
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
+	select ARM_CPU_SUSPEND
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
-- 
1.8.1.2

