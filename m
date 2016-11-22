From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 2/5] powercap/intel_rapl: Propagate error code when
 registration fails
Date: Tue, 22 Nov 2016 21:15:59 -0000
Message-ID: <20161122211438.510608208@linutronix.de>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=powercap-intel_rapl--Propagate-error-code-when-registration-fails.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

If rapl_package_register_powercap() fails in rapl_add_package() the
function happily returns 0.

Capture the error code and propagate it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/powercap/intel_rapl.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1563,9 +1563,8 @@ static void rapl_remove_package(struct r
 /* called from CPU hotplug notifier, hotplug lock held */
 static int rapl_add_package(int cpu)
 {
-	int ret = 0;
-	int phy_package_id;
 	struct rapl_package *rp;
+	int ret, phy_package_id;
 
 	phy_package_id = topology_physical_package_id(cpu);
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1583,10 +1582,11 @@ static int rapl_add_package(int cpu)
 		ret = -ENODEV;
 		goto err_free_package;
 	}
-	if (!rapl_package_register_powercap(rp)) {
+	ret = rapl_package_register_powercap(rp);
+	if (!ret) {
 		INIT_LIST_HEAD(&rp->plist);
 		list_add(&rp->plist, &rapl_packages);
-		return ret;
+		return 0;
 	}
 
 err_free_package:
