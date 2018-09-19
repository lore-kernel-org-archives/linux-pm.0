From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 05/12][RFC v3] x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER set on 32bit system
Date: Wed, 19 Sep 2018 15:38:43 +0800
Message-ID: <ec80ac5b3ef0505e4f4786c4ed1e4f88a7770f12.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Enable CONFIG_ARCH_HIBERNATION_HEADER for 32bit system so that
md5 check is enabled and prepare for relocated code executing
and jump address mapping.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..e8de5de1057f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
-- 
2.17.1
