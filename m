From: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] thermal: broadcom: Allow for NSP to use ns-thermal driver
Date: Tue, 25 Apr 2017 16:49:10 -0400
Message-ID: <1493153351-12698-2-git-send-email-jon.mason@broadcom.com>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493153351-12698-1-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <florian.fainelli-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
the ns-thermal driver to be selected via menuconfig.  Also, change the
ns-thermal driver to work on any iProc based SoC.  Finally, tweak the
Kconfig description to mention support for NSP and make the default on
for iProc based platforms.

Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-bcm/Kconfig        | 2 ++
 drivers/thermal/broadcom/Kconfig | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8..da2bfeb 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select THERMAL
+	select THERMAL_OF
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index f0dea8a..26d706c 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,8 +1,9 @@
 config BCM_NS_THERMAL
 	tristate "Northstar thermal driver"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
 	help
-	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
-	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
-	  with a thermal sensor that allows checking CPU temperature. This
-	  driver provides support for it.
+	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
+	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
+	  Management Unit) block with a thermal sensor that allows checking CPU
+	  temperature.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
