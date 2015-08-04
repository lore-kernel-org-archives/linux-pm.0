From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] thermal: remove power allocator from list of default
 governors
Date: Tue, 4 Aug 2015 09:39:21 -0700
Message-ID: <20150804163921.GA36852@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javi Merino <javi.merino@arm.com>, Tushar Dave <tushar.n.dave@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As it currently stands the power allocator governor can not handle
thermal zones that are not specifically crafted and therefore can not be
used as a default governor.

Users need to explicitly enable this governor for thermal zones that do
have enough information for its operation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/thermal/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0390044..34d05d3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -82,14 +82,6 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 	  Select this if you want to let the user space manage the
 	  platform thermals.
 
-config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
-	bool "power_allocator"
-	select THERMAL_GOV_POWER_ALLOCATOR
-	help
-	  Select this if you want to control temperature based on
-	  system and device power allocation. This governor can only
-	  operate on cooling devices that implement the power API.
-
 endchoice
 
 config THERMAL_GOV_FAIR_SHARE
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
