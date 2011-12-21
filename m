From: Colin Cross <ccross@android.com>
Subject: [PATCH 2/3] cpuidle: fix error handling in
	__cpuidle_register_device
Date: Tue, 20 Dec 2011 16:09:06 -0800
Message-ID: <1324426147-16735-3-git-send-email-ccross__32372.6550014273$1324426171$gmane$org@android.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1324426147-16735-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Fix the error handling in __cpuidle_register_device to include
the missing list_del.  Move it to a label, which will simplify
the error handling when coupled states are added.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/cpuidle/cpuidle.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1486b3c..ea00a16 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -318,13 +318,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
-	if ((ret = cpuidle_add_sysfs(sys_dev))) {
-		module_put(cpuidle_driver->owner);
-		return ret;
-	}
+	ret = cpuidle_add_sysfs(sys_dev);
+	if (ret)
+		goto err_sysfs;
 
 	dev->registered = 1;
 	return 0;
+
+err_sysfs:
+	module_put(cpuidle_driver->owner);
+	list_del(&dev->device_list);
+	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+	return ret;
 }
 
 /**
-- 
1.7.4.1
