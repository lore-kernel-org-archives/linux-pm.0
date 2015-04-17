From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH] PM / Runtime: add note about re-calling in during device
 probe()
Date: Fri, 17 Apr 2015 01:14:15 +0100
Message-ID: <1429229655.8341.73.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org, CT kernel <linux-kernel@lists.codethink.co.uk>
List-Id: linux-pm@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The sh_eth driver has come up with an issue where the runtime_pm
code suspends it during the probe() method due to the network
device registration re-calling into the driver.

Add a note about this into the documentation.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 Documentation/power/runtime_pm.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 44fe1d28a163..e76dc0ad4d2b 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -556,6 +556,12 @@ helper functions described in Section 4.  In that case, pm_runtime_resume()
 should be used.  Of course, for this purpose the device's runtime PM has to be
 enabled earlier by calling pm_runtime_enable().
 
+Note, if the device may execute pm_runtime calls during the probe (such as
+if it is registers with a subsystem that may call back in) then the
+pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
+appropriate to ensure that the device is not put back to sleep during the
+probe. This can happen with systems such as the network device layer.
+
 It may be desirable to suspend the device once ->probe() has finished.
 Therefore the driver core uses the asyncronous pm_request_idle() to submit a
 request to execute the subsystem-level idle callback for the device at that
-- 
1.7.10.4



