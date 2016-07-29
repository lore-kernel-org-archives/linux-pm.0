From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] ACPICA: adapt buffer length for Field Attrib Raw Process in Ops Region
Date: Fri, 29 Jul 2016 17:49:25 +0200
Message-ID: <1469807366-24642-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Detected on the Surface 3:
The MSHW0011 driver uses Field Attrib Raw Process to return information
for the ACPI Battery. The DSDT declares a parameter of 2 though
functions like _BST or _BIX require a much bigger out buffer.

It looks like the incoming buffer has the requested size and we can
work around the issue by using this input size as the output and
parameters size.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/acpi/acpica/exfield.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index d7d3ee3..a1bd041 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -413,6 +413,17 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 			 *     Data[x-1]: (Bytes 2-x of the arbitrary length data buffer)
 			 */
 			length += 2;
+
+			/*
+			 * When using Field Attrib Raw Process, it looks like
+			 * the parameter access_length can be wrong and the
+			 * required output buffer can be much bigger.
+			 * So just take the incoming buffer length as the
+			 * reference.
+			 */
+			if (accessor_type == AML_FIELD_ATTRIB_RAW_PROCESS)
+				length = source_desc->buffer.length;
+
 			function = ACPI_WRITE | (accessor_type << 16);
 		} else {	/* IPMI */
 
-- 
2.5.5

