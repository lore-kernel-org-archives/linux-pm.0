From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH] ARM: machine_power_off should not return
Date: Mon, 24 Mar 2014 11:13:04 -0700
Message-ID: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Add loop to prevent return from machine_power_off if
pm_power_off is null or does not halt the system.
This caused a panic during hibernation testing on Kirkwood
Openblocks A6 board.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/arm/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f58b723..6ffdc2c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -217,6 +217,8 @@ void machine_power_off(void)
 
 	if (pm_power_off)
 		pm_power_off();
+	while (1)
+		cpu_relax();
 }
 
 /*
-- 
1.7.9.5
