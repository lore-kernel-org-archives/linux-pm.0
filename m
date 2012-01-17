From: Len Brown <lenb@kernel.org>
Subject: [PATCH 50/50] ACPI processor: Fix error path, also remove sysdev link
Date: Tue, 17 Jan 2012 07:21:42 -0500
Message-ID: <3333ea7804201918aa241641cf8493a62b8ad527.1326802230.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 9d7bc9f..90719d1 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -539,6 +539,7 @@ err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
 	acpi_processor_power_exit(pr, device);
+	sysfs_remove_link(&device->dev.kobj, "sysdev");
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 
-- 
1.7.9.rc1
