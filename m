From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] phy: core: Update the runtime PM section in the docs to reflect changes
Date: Tue, 19 Dec 2017 22:22:31 +0100
Message-ID: <1513718551-28624-4-git-send-email-ulf.hansson@linaro.org>
References: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513718551-28624-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Let's update and clarify he phy documentation, to reflect the latest
changes around the runtime PM deployment in the phy core.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/phy.txt | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/phy.txt b/Documentation/phy.txt
index 457c3e0..6d9e3d3 100644
--- a/Documentation/phy.txt
+++ b/Documentation/phy.txt
@@ -160,19 +160,21 @@ associated with this PHY.
 PM Runtime
 ==========
 
-This subsystem is pm runtime enabled. So while creating the PHY,
-pm_runtime_enable of the phy device created by this subsystem is called and
-while destroying the PHY, pm_runtime_disable is called. Note that the phy
-device created by this subsystem will be a child of the device that calls
-phy_create (PHY provider device).
-
-So pm_runtime_get_sync of the phy_device created by this subsystem will invoke
-pm_runtime_get_sync of PHY provider device because of parent-child relationship.
-It should also be noted that phy_power_on and phy_power_off performs
-phy_pm_runtime_get_sync and phy_pm_runtime_put respectively.
-There are exported APIs like phy_pm_runtime_get, phy_pm_runtime_get_sync,
-phy_pm_runtime_put, phy_pm_runtime_put_sync, phy_pm_runtime_allow and
-phy_pm_runtime_forbid for performing PM operations.
+This subsystem deploys runtime PM support. More precisely, calls to
+pm_runtime_get_sync() and to pm_runtime_put() surrounds calls to the phy
+provider callbacks, ->init|exit(), in phy_init|exit(). At phy_power_on(), the
+runtime PM usage count is raised again, via pm_runtime_get_sync(). The usage
+count remain raised, until the internal phy power on count reaches zero in
+phy_power_off(), at which point pm_runtime_put() is called to restore the
+runtime PM usage count. In this way, the device is guranteed to stay runtime
+resumed as long as the phy is powered on.
+
+In regards to the runtime PM deployment in the phy core, it should also be
+noted that it's deployed for the phy provider device, which is the parent of
+the phy child device. In other words, the phy device created by the phy core
+remains runtime PM disabled. Of course, whether runtime PM is really used or
+not, depends on whether the phy provider driver has enabled runtime PM for its
+provider device.
 
 PHY Mappings
 ============
-- 
2.7.4
