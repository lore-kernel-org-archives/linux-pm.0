From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: APM_EMULATION does not depend on PM
Date: Mon, 25 Jan 2016 16:48:28 +0100
Message-ID: <1453736913-1959469-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Jiri Kosina <jikos@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The APM emulation code does multiple things, and some of them depend on
PM_SLEEP, while the battery management does not. However, selecting
the symbol like SHARPSL_PM does causes a Kconfig warning:

warning: (SHARPSL_PM && PMAC_APM_EMU) selects APM_EMULATION which has unmet direct dependencies (PM && SYS_SUPPORTS_APM_EMULATION)

>From all I can tell, this is completely harmless, and we can simply allow
APM_EMULATION to be enabled here, even if PM is not.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 02e8dfaa1ce2..68d3ebc12601 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -235,7 +235,7 @@ config PM_TRACE_RTC
 
 config APM_EMULATION
 	tristate "Advanced Power Management Emulation"
-	depends on PM && SYS_SUPPORTS_APM_EMULATION
+	depends on SYS_SUPPORTS_APM_EMULATION
 	help
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
-- 
2.7.0
