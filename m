From: Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 4/4] drivers: qcom: rpmh: add RPMH helper functions
Date: Thu, 18 Jan 2018 17:01:57 -0700
Message-ID: <20180119000157.7380-5-ilina@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180119000157.7380-1-ilina@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Sending RPMH requests and waiting for response from the controller
through a callback is common functionality across all platform drivers.
To simplify drivers, add a library functions to create RPMH client and
send resource state requests.

rpmh_write() is a synchronous blocking call that can be used to send
active state requests.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/Makefile        |   2 +-
 drivers/soc/qcom/rpmh-internal.h |   2 +
 drivers/soc/qcom/rpmh-rsc.c      |   1 +
 drivers/soc/qcom/rpmh.c          | 264 +++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  41 ++++++
 5 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 include/soc/qcom/rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index b7951ce87663..0dba46387f1c 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
-obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
+obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o rpmh.o
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 0b482f788aa1..059637dcb55a 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -21,4 +21,6 @@ struct rsc_drv;
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_mbox_msg *msg);
 
+void rpmh_tx_done(struct tcs_mbox_msg *msg, int r);
+
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 424dc939b2e6..e4f307c54567 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -374,6 +374,7 @@ static void tcs_notify_tx_done(unsigned long data)
 		msg = resp->msg;
 		free_response(resp);
 		trace_rpmh_notify(drv->name, m, msg->payload[0].addr, err);
+		rpmh_tx_done(msg, err);
 	} while (1);
 }
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 000000000000..ad1def2c362c
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,264 @@
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/atomic.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <soc/qcom/rpmh.h>
+
+#include "rpmh-internal.h"
+
+#define RPMH_MAX_MBOXES			2
+#define RPMH_TIMEOUT			msecs_to_jiffies(10000)
+
+#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)	\
+	struct rpmh_msg name = {			\
+		.msg = {				\
+			.state = s,			\
+			.payload = name.cmd,		\
+			.num_payload = 0,		\
+			.is_complete = true,		\
+			.invalidate = false,		\
+		},					\
+		.cmd = { { 0 } },			\
+		.completion = q,			\
+		.wait_count = c,			\
+		.rc = rc,				\
+	}
+
+/**
+ * rpmh_msg: the message to be sent to rpmh-rsc
+ *
+ * @msg: the request
+ * @cmd: the payload that will be part of the @msg
+ * @completion: triggered when request is done
+ * @wait_count: count of waiters for this completion
+ * @err: err return from the controller
+ */
+struct rpmh_msg {
+	struct tcs_mbox_msg msg;
+	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
+	struct completion *completion;
+	atomic_t *wait_count;
+	struct rpmh_client *rc;
+	int err;
+};
+
+/**
+ * rpmh_ctrlr: our representation of the controller
+ *
+ * @drv: the controller instance
+ */
+struct rpmh_ctrlr {
+	struct rsc_drv *drv;
+};
+
+/**
+ * rpmh_client: the client object
+ *
+ * @dev: the platform device that is the owner
+ * @ctrlr: the controller associated with this client.
+ */
+struct rpmh_client {
+	struct device *dev;
+	struct rpmh_ctrlr *ctrlr;
+};
+
+static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_MBOXES];
+static DEFINE_MUTEX(rpmh_ctrlr_mutex);
+
+void rpmh_tx_done(struct tcs_mbox_msg *msg, int r)
+{
+	struct rpmh_msg *rpm_msg = container_of(msg, struct rpmh_msg, msg);
+	atomic_t *wc = rpm_msg->wait_count;
+	struct completion *compl = rpm_msg->completion;
+
+	rpm_msg->err = r;
+
+	if (r)
+		dev_err(rpm_msg->rc->dev,
+			"RPMH TX fail in msg addr 0x%x, err=%d\n",
+			rpm_msg->msg.payload[0].addr, r);
+
+	/* Signal the blocking thread we are done */
+	if (wc && atomic_dec_and_test(wc))
+		if (compl)
+			complete(compl);
+}
+EXPORT_SYMBOL(rpmh_tx_done);
+
+/**
+ * wait_for_tx_done: Wait until the response is received.
+ *
+ * @rc: The RPMH client
+ * @compl: The completion object
+ * @addr: An addr that we sent in that request
+ * @data: The data for the address in that request
+ *
+ */
+static inline int wait_for_tx_done(struct rpmh_client *rc,
+		struct completion *compl, u32 addr, u32 data)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(compl, RPMH_TIMEOUT);
+	if (ret)
+		dev_dbg(rc->dev,
+			"RPMH response received addr=0x%x data=0x%x\n",
+			addr, data);
+	else
+		dev_err(rc->dev,
+			"RPMH response timeout addr=0x%x data=0x%x\n",
+			addr, data);
+
+	return  (ret > 0) ? 0 : -ETIMEDOUT;
+}
+
+/**
+ * __rpmh_write: send the RPMH request
+ *
+ * @rc: The RPMH client
+ * @state: Active/Sleep request type
+ * @rpm_msg: The data that needs to be sent (payload).
+ */
+int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+			struct rpmh_msg *rpm_msg)
+{
+	int ret = -EFAULT;
+
+	rpm_msg->msg.state = state;
+
+	if (state == RPMH_ACTIVE_ONLY_STATE) {
+		WARN_ON(irqs_disabled());
+		ret = rpmh_rsc_send_data(rc->ctrlr->drv, &rpm_msg->msg);
+		if (!ret)
+			dev_dbg(rc->dev,
+				"RPMH request sent addr=0x%x, data=0x%x\n",
+				rpm_msg->msg.payload[0].addr,
+				rpm_msg->msg.payload[0].data);
+		else
+			dev_warn(rc->dev,
+				"Error in RPMH request addr=0x%x, data=0x%x\n",
+				rpm_msg->msg.payload[0].addr,
+				rpm_msg->msg.payload[0].data);
+	}
+
+	return ret;
+}
+
+/**
+ * rpmh_write: Write a set of RPMH commands and block until response
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * May sleep. Do not call from atomic contexts.
+ */
+int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+			struct tcs_cmd *cmd, int n)
+{
+	DECLARE_COMPLETION_ONSTACK(compl);
+	atomic_t wait_count = ATOMIC_INIT(1);
+	DEFINE_RPMH_MSG_ONSTACK(rc, state, &compl, &wait_count, rpm_msg);
+	int ret;
+
+	if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	might_sleep();
+
+	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
+	rpm_msg.msg.num_payload = n;
+
+	ret = __rpmh_write(rc, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);
+}
+EXPORT_SYMBOL(rpmh_write);
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
+{
+	int i;
+	struct rsc_drv *drv = dev_get_drvdata(pdev->dev.parent);
+	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EFAULT);
+
+	if (!drv)
+		return ctrlr;
+
+	mutex_lock(&rpmh_ctrlr_mutex);
+	for (i = 0; i < RPMH_MAX_MBOXES; i++)
+		if (rpmh_rsc[i].drv == drv) {
+			ctrlr = &rpmh_rsc[i];
+			goto unlock;
+		}
+
+	if (i == RPMH_MAX_MBOXES)
+		for (i = 0; i < RPMH_MAX_MBOXES; i++)
+			if (rpmh_rsc[i].drv == NULL) {
+				ctrlr = &rpmh_rsc[i];
+				ctrlr->drv = drv;
+				break;
+			}
+unlock:
+	mutex_unlock(&rpmh_ctrlr_mutex);
+	return ctrlr;
+}
+
+/**
+ * rpmh_get_client: Get the RPMh handle
+ *
+ * @pdev: the platform device which needs to communicate with RPM
+ * accelerators
+ * May sleep.
+ */
+struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
+{
+	struct rpmh_client *rc;
+
+	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
+	if (!rc)
+		return ERR_PTR(-ENOMEM);
+
+	rc->dev = &pdev->dev;
+	rc->ctrlr = get_rpmh_ctrlr(pdev);
+	if (IS_ERR(rc->ctrlr)) {
+		kfree(rc);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(rpmh_get_client);
+
+/**
+ * rpmh_release: Release the RPMH client
+ *
+ * @rc: The RPMh handle to be freed.
+ */
+void rpmh_release(struct rpmh_client *rc)
+{
+	kfree(rc);
+}
+EXPORT_SYMBOL(rpmh_release);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
new file mode 100644
index 000000000000..bd1e316f0bbf
--- /dev/null
+++ b/include/soc/qcom/rpmh.h
@@ -0,0 +1,41 @@
+/* Copyright (c) 2016-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __SOC_QCOM_RPMH_H__
+#define __SOC_QCOM_RPMH_H__
+
+#include <soc/qcom/tcs.h>
+#include <linux/platform_device.h>
+
+struct rpmh_client;
+
+#ifdef CONFIG_QCOM_RPMH
+int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+			struct tcs_cmd *cmd, int n);
+
+struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
+
+void rpmh_release(struct rpmh_client *rc);
+
+#else
+
+static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+			struct tcs_cmd *cmd, int n)
+{ return -ENODEV; }
+
+struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
+{ return ERR_PTR(-ENODEV); }
+
+static inline void rpmh_release(struct rpmh_client *rc) { }
+#endif /* CONFIG_QCOM_RPMH */
+
+#endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
