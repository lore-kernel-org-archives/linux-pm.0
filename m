From: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RFC 1/3] thermal: broadcom: Allow for NSP to use ns-thermal driver
Date: Thu, 23 Mar 2017 15:18:46 -0400
Message-ID: <1490296728-14733-2-git-send-email-jon.mason@broadcom.com>
References: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490296728-14733-1-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
the ns-thermal driver to be selected via menuconfig.  Also, change the
ns-thermal driver to work on any iProc based SoC.

Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-bcm/Kconfig        | 2 ++
 drivers/thermal/broadcom/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f9389c5..b96840a 100644
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
index 08457a4..39b92a1 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,6 +1,6 @@
 config BCM_NS_THERMAL
 	tristate "Northstar thermal driver"
-	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	help
 	  Northstar's DMU (Device Management Unit) block contains a thermal
 	  sensor that allows checking CPU temperature. This driver provides
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
