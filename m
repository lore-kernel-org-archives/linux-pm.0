From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/8] firmware: arm_scmi: improve code readability using
 bitfield accessor macros
Date: Wed,  9 May 2018 18:07:07 +0100
Message-ID: <1525885634-22348-2-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

By using FIELD_{FIT,GET,PREP} and GENMASK macro accessors we can avoid
some clumpsy custom shifting and masking macros and also improve the
code better readability.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  9 +++++----
 drivers/firmware/arm_scmi/driver.c | 31 ++++++++++++++-----------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 0c30234f9098..e8f332c9c469 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -7,6 +7,7 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -14,10 +15,10 @@
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
-#define PROTOCOL_REV_MINOR_BITS	16
-#define PROTOCOL_REV_MINOR_MASK	((1U << PROTOCOL_REV_MINOR_BITS) - 1)
-#define PROTOCOL_REV_MAJOR(x)	((x) >> PROTOCOL_REV_MINOR_BITS)
-#define PROTOCOL_REV_MINOR(x)	((x) & PROTOCOL_REV_MINOR_MASK)
+#define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
+#define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
+#define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
+#define PROTOCOL_REV_MINOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x)))
 #define MAX_PROTOCOLS_IMP	16
 #define MAX_OPPS		16
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 14b147135a0c..917786d91f55 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -29,16 +29,12 @@
 
 #include "common.h"
 
-#define MSG_ID_SHIFT		0
-#define MSG_ID_MASK		0xff
-#define MSG_TYPE_SHIFT		8
-#define MSG_TYPE_MASK		0x3
-#define MSG_PROTOCOL_ID_SHIFT	10
-#define MSG_PROTOCOL_ID_MASK	0xff
-#define MSG_TOKEN_ID_SHIFT	18
-#define MSG_TOKEN_ID_MASK	0x3ff
-#define MSG_XTRACT_TOKEN(header)	\
-	(((header) >> MSG_TOKEN_ID_SHIFT) & MSG_TOKEN_ID_MASK)
+#define MSG_ID_MASK		GENMASK(7, 0)
+#define MSG_TYPE_MASK		GENMASK(9, 8)
+#define MSG_PROTOCOL_ID_MASK	GENMASK(17, 10)
+#define MSG_TOKEN_ID_MASK	GENMASK(27, 18)
+#define MSG_XTRACT_TOKEN(hdr)	FIELD_GET(MSG_TOKEN_ID_MASK, (hdr))
+#define MSG_TOKEN_MAX		(MSG_XTRACT_TOKEN(MSG_TOKEN_ID_MASK) + 1)
 
 enum scmi_error_codes {
 	SCMI_SUCCESS = 0,	/* Success */
@@ -255,9 +251,9 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
  */
 static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 {
-	return ((hdr->id & MSG_ID_MASK) << MSG_ID_SHIFT) |
-	   ((hdr->seq & MSG_TOKEN_ID_MASK) << MSG_TOKEN_ID_SHIFT) |
-	   ((hdr->protocol_id & MSG_PROTOCOL_ID_MASK) << MSG_PROTOCOL_ID_SHIFT);
+	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
+		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
+		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
 }
 
 /**
@@ -621,9 +617,9 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	struct scmi_xfers_info *info = &sinfo->minfo;
 
 	/* Pre-allocated messages, no more than what hdr.seq can support */
-	if (WARN_ON(desc->max_msg >= (MSG_TOKEN_ID_MASK + 1))) {
-		dev_err(dev, "Maximum message of %d exceeds supported %d\n",
-			desc->max_msg, MSG_TOKEN_ID_MASK + 1);
+	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
+		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
+			desc->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
 
@@ -840,7 +836,8 @@ static int scmi_probe(struct platform_device *pdev)
 		if (of_property_read_u32(child, "reg", &prot_id))
 			continue;
 
-		prot_id &= MSG_PROTOCOL_ID_MASK;
+		if (!FIELD_FIT(MSG_PROTOCOL_ID_MASK, prot_id))
+			dev_err(dev, "Out of range protocol %d\n", prot_id);
 
 		if (!scmi_is_protocol_implemented(handle, prot_id)) {
 			dev_err(dev, "SCMI protocol %d not implemented\n",
-- 
2.7.4
