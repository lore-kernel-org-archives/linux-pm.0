From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/50] ACPICA: Put back the call to acpi_os_validate_address
Date: Tue, 17 Jan 2012 07:20:54 -0500
Message-ID: <da4d8b287abe783d30e968155614531a0937d090.1326802228.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
In-reply-to: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org.#.2.6.38+, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Lin Ming <ming.m.lin@intel.com>

The call to acpi_os_validate_address in acpi_ds_get_region_arguments was
removed by mistake in commit 9ad19ac(ACPICA: Split large dsopcode and
dsload.c files).

Put it back.

Cc: stable@vger.kernel.org # 2.6.38+
Reported-and-bisected-by: Luca Tettamanti <kronos.it@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsargs.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 8c7b997..42163d8 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -387,5 +387,29 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate the region address/length via the host OS */
+
+	status = acpi_os_validate_address(obj_desc->region.space_id,
+					  obj_desc->region.address,
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * Invalid address/length. We will emit an error message and mark
+		 * the region as invalid, so that it will cause an additional error if
+		 * it is ever used. Then return AE_OK.
+		 */
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During address validation of OpRegion [%4.4s]",
+				node->name.ascii));
+		obj_desc->common.flags |= AOPOBJ_INVALID;
+		status = AE_OK;
+	}
+
 	return_ACPI_STATUS(status);
 }
-- 
1.7.9.rc1

