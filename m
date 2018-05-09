From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 6/8] firmware: arm_scmi: remove unnecessary bitmap_zero
Date: Wed,  9 May 2018 18:07:12 +0100
Message-ID: <1525885634-22348-7-git-send-email-sudeep.holla@arm.com>
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

kcalloc zeros the memory and it's totally unnecessary to zero the bitmap
again using bitmap_zero. This patch just drops the unnecessary use of
the bitmap_zero in the context.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 33d2b78af3ff..4087d6c50ecd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -636,8 +636,6 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	if (!info->xfer_alloc_table)
 		return -ENOMEM;
 
-	bitmap_zero(info->xfer_alloc_table, desc->max_msg);
-
 	/* Pre-initialize the buffer pointer to pre-allocated buffers */
 	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
 		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
-- 
2.7.4
