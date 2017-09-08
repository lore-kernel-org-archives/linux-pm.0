From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] device property: Align return codes of acpi_fwnode_get_reference_with_args
Date: Fri,  8 Sep 2017 15:21:56 +0300
Message-ID: <20170908122156.2493-1-sakari.ailus@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:46548 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754951AbdIHMV6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 08:21:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: mika.westerberg@intel.com

acpi_fwnode_get_reference_with_args(), the function implementing ACPI
support for fwnode_property_get_reference_with_args(), returns directly
error codes from __acpi_node_get_property_reference(). The latter uses
different error codes than the OF implementation. In particular, the OF
implementation uses -ENOENT to indicate there are no more entries whereas
the former uses -ENODATA for the purpose.

To make matters more complicated, the ACPI implementation uses -ENOENT but
for a different purpose --- when an entry exists but contains no
reference. This isn't recognised by OF.

Document and align the error codes for property for
fwnode_property_get_reference_with_args() so that they match with
of_parse_phandle_with_args(), with the difference that -ENODATA is
returned whenever an entry exists but contains no reference.

Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 4 ++++
 drivers/base/property.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a65c09cc223f..17d760b89908 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1207,6 +1207,10 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 
 	ret = __acpi_node_get_property_reference(fwnode, prop, index,
 						 args_count, &acpi_args);
+	if (ret == -ENODATA)
+		return -ENOENT;
+	if (ret == -ENOENT)
+		return -ENODATA;
 	if (ret < 0)
 		return ret;
 	if (!args)
diff --git a/drivers/base/property.c b/drivers/base/property.c
index d0b65bbe7e15..686e48f3a617 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -682,6 +682,10 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * Caller is responsible to call fwnode_handle_put() on the returned
  * args->fwnode pointer.
  *
+ * Returns: %0 on success
+ *	    %-EINVAL on parse error
+ *	    %-ENODATA when an entry exists but contains no reference
+ *	    %-ENOENT when the index is out of bounds
  */
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
-- 
2.11.0
