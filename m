From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 04/12] PM / devfreq: Add dependency on PM_OPP
Date: Thu, 24 Aug 2017 10:42:51 +0900
Message-ID: <1503538979-22693-5-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p2d2b85a7c324b101e7e4e8551873ca3ab@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq ues the OPP library to handle the voltage and frequency
for the device basically. This patch adds the dependency on CONFIG_PM_OPP
in order to prevent either the build break or the unknow behavior.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 41254e702f1e..6a172d338f6d 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -1,6 +1,7 @@
 menuconfig PM_DEVFREQ
 	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
 	select SRCU
+	select PM_OPP
 	help
 	  A device may have a list of frequencies and voltages available.
 	  devfreq, a generic DVFS framework can be registered for a device
-- 
1.9.1
