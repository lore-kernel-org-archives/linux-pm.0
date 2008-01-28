From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make suspend_device() static
Date: Tue, 29 Jan 2008 00:10:24 +0200
Message-ID: <20080128221024.GO8767__35940.8108554364$1201558413$gmane$org@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

suspend_device() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
344fcfcea0df8cbaa83e10d7e66b826ead67290b 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 200ed5f..cfcc54f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  */
-int suspend_device(struct device *dev, pm_message_t state)
+static int suspend_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
