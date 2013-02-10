From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/16] PM idle: remove global declaration of pm_idle
Date: Sun, 10 Feb 2013 00:58:22 -0500
Message-ID: <9ba4b07d809ec52dad63f11365df5166989edb46.1360475150.git.len.brown@intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

pm_idle appears in no generic Linux code,
it appears only in architecture-specific code.

Thus, pm_idle should not be declared in pm.h.

Architectures that  use an idle function pointer
should delcare one local to their architecture,
and/or use cpuidle.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 include/linux/pm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 03d7bb1..97bcf23 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -31,7 +31,6 @@
 /*
  * Callbacks for platform drivers to implement.
  */
-extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
-- 
1.8.1.3.535.ga923c31
