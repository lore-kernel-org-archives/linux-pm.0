From: Nick Crews <ncrews@chromium.org>
Subject: [PATCH v5 3/3] power_supply: Add missing documentation for CHARGE_CONTROL_* properties
Date: Thu, 18 Apr 2019 10:43:14 -0600
Message-ID: <20190418164314.161065-3-ncrews@chromium.org>
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418164314.161065-1-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dlaurie@chromium.org, lamzin@google.com, bartfab@google.com, derat@google.com, dtor@google.com, sjg@chromium.org, jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
List-Id: linux-pm@vger.kernel.org

The existing POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT and
POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX properties
don't have documentation. I add that documentation here.

v5 changes:
- Split this commit out from the previous two commits.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a5b144f61de8..b77e30b9014e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -114,6 +114,25 @@ Description:
 		Access: Read
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowable charging current. Used for charge rate
+		throttling for thermal cooling or improving battery health.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum legal value for the charge_control_limit property.
+
+		Access: Read
+		Valid values: Represented in microamps
+
 What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
 Date:		April 2019
 Contact:	linux-pm@vger.kernel.org
-- 
2.20.1
