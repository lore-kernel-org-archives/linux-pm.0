From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] cpuidle: big_little: Fix build error
Date: Mon, 28 Jul 2014 10:28:59 +0530
Message-ID: <1406523539-23823-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39535 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaG1E70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 00:59:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so9750565pab.40
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2014 21:59:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, rjw@rjwysocki.net, afaerber@suse.de, spk.linux@gmail.com

big_little CPU idle driver references functions defined in MCPM driver.
Thus make it depend on MCPM to avoid the following errors:

drivers/built-in.o: In function `bl_enter_powerdown':
drivers/cpuidle/cpuidle-big_little.c:134: undefined reference to `mcpm_=
cpu_powered_up'
drivers/built-in.o: In function `bl_powerdown_finisher':
drivers/cpuidle/cpuidle-big_little.c:104: undefined reference to `mcpm_=
set_entry_vector'
drivers/cpuidle/cpuidle-big_little.c:111: undefined reference to `mcpm_=
cpu_suspend'
make: *** [vmlinux] Error 1

Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 drivers/cpuidle/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 33fc0ff..38cff69 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -4,6 +4,7 @@
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
+	depends on MCPM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	help
--=20
1.8.1.2

