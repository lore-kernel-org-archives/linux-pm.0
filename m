From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Fix header of acpi_dev_pm_detach() in acpi.h
Date: Wed, 05 Dec 2012 12:08:12 +0100
Message-ID: <3898205.CQSHFfLUWL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The header of acpi_dev_pm_detach() in include/linux/acpi.h has an
incorrect return type, which should be void.  Fix that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h
+++ linux/include/linux/acpi.h
@@ -506,7 +506,7 @@ static inline int acpi_subsys_resume_ear
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
-int acpi_dev_pm_detach(struct device *dev, bool power_off);
+void acpi_dev_pm_detach(struct device *dev, bool power_off);
 #else
 static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {

