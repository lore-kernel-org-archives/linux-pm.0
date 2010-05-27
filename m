From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] ACPI: allow a native cpuidle driver to
	displace ACPI
Date: Wed, 26 May 2010 22:42:27 -0400
Message-ID: <c5e048dcef31b8c306995b7239a0cbd4511f9828.1274926772.git.len.brown__40716.9492137202$1274929192$gmane$org@intel.com>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1274928151-30919-1-git-send-email-lenb@kernel.org>
In-reply-to: <e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
References: <e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The ACPI driver would fail probe when it found that
another driver had previously registered with cpuidle.

But this is a natural situation, as a native hardware
cpuidle driver should be able to bind instead of ACPI,
and the ACPI processor driver should be able to handle
yielding control of C-states while still handling
P-states and T-states.

Add a KERN_DEBUG line showing when acpi_idle
does successfully register.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 5675d97..deefa85 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -616,7 +616,8 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 	acpi_processor_get_limit_info(pr);
 
 
-	acpi_processor_power_init(pr, device);
+	if (cpuidle_get_driver() == &acpi_idle_driver)
+		acpi_processor_power_init(pr, device);
 
 	pr->cdev = thermal_cooling_device_register("Processor", device,
 						&processor_cooling_ops);
@@ -920,9 +921,10 @@ static int __init acpi_processor_init(void)
 	if (!acpi_processor_dir)
 		return -ENOMEM;
 #endif
-	result = cpuidle_register_driver(&acpi_idle_driver);
-	if (result < 0)
-		goto out_proc;
+
+	if (!cpuidle_register_driver(&acpi_idle_driver))
+		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
+			acpi_idle_driver.name);
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0)
@@ -941,7 +943,6 @@ static int __init acpi_processor_init(void)
 out_cpuidle:
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
-out_proc:
 #ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 #endif
-- 
1.6.0.6
