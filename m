From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 03/19] ACPI: add ACPI_TYPE_LOCAL_REFERENCE support to acpi_extract_package()
Date: Thu, 18 Sep 2014 09:53:34 +0800
Message-ID: <1411005230-2227-4-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Add ACPI_TYPE_LOCAL_REFERENCE support to acpi_extract_package(),
so that we can use this helper for more cases like _ART/_TRT.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/utils.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 07c8c5a..1ed7aba 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -149,6 +149,21 @@ acpi_extract_package(union acpi_object *package,
 				break;
 			}
 			break;
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			switch (format_string[i]) {
+			case 'R':
+				size_required += sizeof(void *);
+				tail_offset += sizeof(void *);
+				break;
+			default:
+				printk(KERN_WARNING PREFIX "Invalid package element"
+					      " [%d] got reference,"
+					      " expecting [%c]\n",
+					      i, format_string[i]);
+				return AE_BAD_DATA;
+				break;
+			}
+			break;
 
 		case ACPI_TYPE_PACKAGE:
 		default:
@@ -247,7 +262,18 @@ acpi_extract_package(union acpi_object *package,
 				break;
 			}
 			break;
-
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			switch (format_string[i]) {
+			case 'R':
+				*(void **)head =
+				    (void *)element->reference.handle;
+				head += sizeof(void *);
+				break;
+			default:
+				/* Should never get here */
+				break;
+			}
+			break;
 		case ACPI_TYPE_PACKAGE:
 			/* TBD: handle nested packages... */
 		default:
-- 
1.8.3.2

