From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] driver core: Add missing description of new struct device_link field
Date: Thu, 21 Feb 2019 12:28:05 +0100
Message-ID: <1917831.AxOkpi0hM7@aspire.rjw.lan>
References: <201902202102.r25FNhNI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201902202102.r25FNhNI%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 36003d4cf57c ("driver core: Fix PM-runtime for links added
during consumer probe") forgot to add a kerneldoc decription for the
new struct device_link member added by it, so do that now.

Fixes: 36003d4cf57c ("driver core: Fix PM-runtime for links added during consumer probe")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Sorry about missing this.

---
 include/linux/device.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -848,6 +848,7 @@ enum device_link_state {
  * @rpm_active: Whether or not the consumer device is runtime-PM-active.
  * @kref: Count repeated addition of the same link.
  * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
  */
 struct device_link {
 	struct device *supplier;
