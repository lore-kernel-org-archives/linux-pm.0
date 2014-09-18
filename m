From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 05/19] Thermal: int3400 thermal: add capability to detect supporting UUIDs
Date: Thu, 18 Sep 2014 09:53:36 +0800
Message-ID: <1411005230-2227-6-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 308c185..65c63ba 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -41,14 +41,79 @@ struct trt {
 	u64 reverved4;
 };
 
+enum int3400_thermal_uuid {
+	INT3400_THERMAL_PASSIVE_1,
+	INT3400_THERMAL_PASSIVE_2,
+	INT3400_THERMAL_ACTIVE,
+	INT3400_THERMAL_CRITICAL,
+	INT3400_THERMAL_COOLING_MODE,
+	INT3400_THERMAL_MAXIMUM_UUID,
+};
+
+static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
+	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
+	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
+	"3A95C389-E4B8-4629-A526-C52C88626BAE",
+	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
+	"16CAF1B7-DD38-40ed-B1C1-1B8A1913D531",
+};
+
 struct int3400_thermal_priv {
 	struct acpi_device *adev;
 	int art_count;
 	struct art *arts;
 	int trt_count;
 	struct trt *trts;
+	u8 uuid_bitmap;
 };
 
+static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obja, *objb;
+	int i, j;
+	int result = 0;
+	acpi_status status;
+
+	status = acpi_evaluate_object(priv->adev->handle, "IDSP", NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obja = (union acpi_object *)buf.pointer;
+	if (obja->type != ACPI_TYPE_PACKAGE) {
+		result = -EINVAL;
+		goto end;
+	}
+
+	for (i = 0; i < obja->package.count; i++) {
+		objb = &obja->package.elements[i];
+		if (objb->type != ACPI_TYPE_BUFFER) {
+			result = -EINVAL;
+			goto end;
+		}
+
+		/* UUID must be 16 bytes */
+		if (objb->buffer.length != 16) {
+			result = -EINVAL;
+			goto end;
+		}
+
+		for (j = 0; j < INT3400_THERMAL_MAXIMUM_UUID; j++) {
+			u8 uuid[16];
+
+			acpi_str_to_uuid(int3400_thermal_uuids[j], uuid);
+			if (!strncmp(uuid, objb->buffer.pointer, 16)) {
+				priv->uuid_bitmap |= (1 << j);
+				break;
+			}
+		}
+	}
+
+end:
+	kfree(buf.pointer);
+	return result;
+}
+
 static int parse_art(struct int3400_thermal_priv *priv)
 {
 	acpi_handle handle = priv->adev->handle;
@@ -193,6 +258,10 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	priv->adev = adev;
 
+	result = int3400_thermal_get_uuids(priv);
+	if (result)
+		goto free_priv;
+
 	result = parse_art(priv);
 	if (result)
 		goto free_priv;
-- 
1.8.3.2

