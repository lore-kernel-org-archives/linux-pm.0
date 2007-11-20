From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.25] ACPI: enable CPU_IDLE by default on ACPI systems
Date: Mon, 19 Nov 2007 22:15:24 -0500
Message-ID: <200711192215.24748.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: venkatesh.pallipadi@intel.com, Adam Belay <abelay@novell.com>, Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

In Linux-2.6.24, CPU_IDLE went upstream, default =n.
For Linux-2.6.25, enable it by default on ACPI systems.
For Linux-2.6.26, we plan to enable it always on ACPI systems.

Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 3bed412..7dbc4a8 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,13 +1,13 @@
 
 config CPU_IDLE
 	bool "CPU idle PM support"
+	default ACPI
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
 	  governors that can be swapped during runtime.
 
-	  If you're using a mobile platform that supports CPU idle PM (e.g.
-	  an ACPI-capable notebook), you should say Y here.
+	  If you're using an ACPI-enabled platform, you should say Y here.
 
 config CPU_IDLE_GOV_LADDER
 	bool
