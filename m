From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 11/16] sh: support poweroff through poweroff handler call chain
Date: Tue, 30 Sep 2014 11:00:51 -0700
Message-ID: <1412100056-15517-12-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Sender: linux-sh-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 04afe5b..8e68926 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -53,6 +53,8 @@ static void native_machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 static void native_machine_halt(void)
-- 
1.9.1

