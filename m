From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 02/19] ACPI: make acpi_create_platform_device() an external API
Date: Thu, 18 Sep 2014 09:53:33 +0800
Message-ID: <1411005230-2227-3-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5126 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686AbaIRByR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:17 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_platform.c | 1 +
 include/linux/acpi.h         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 2bf9082..a3c89a1 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -113,3 +113,4 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	kfree(resources);
 	return pdev;
 }
+EXPORT_SYMBOL_GPL(acpi_create_platform_device);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 807cbc4..3dd743d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -432,6 +432,7 @@ static inline bool acpi_driver_match_device(struct device *dev,
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
 int acpi_device_modalias(struct device *, char *, int);
 
+struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
 #else	/* !CONFIG_ACPI */
@@ -523,6 +524,12 @@ static inline int acpi_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline struct platform_device *acpi_create_platform_device(
+				struct acpi_device *)
+{
+	return NULL;
+}
+
 #define ACPI_PTR(_ptr)	(NULL)
 
 #endif	/* !CONFIG_ACPI */
-- 
1.8.3.2

