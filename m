From: Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 1/4] drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
Date: Thu, 18 Jan 2018 17:01:54 -0700
Message-ID: <20180119000157.7380-2-ilina@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180119000157.7380-1-ilina@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add controller driver for QCOM SoCs that have hardware based shared
resource management. The hardware IP known as RSC (Resource State
Coordinator) houses multiple Direct Resource Voter (DRV) for different
execution levels. A DRV is a unique voter on the state of a shared
resource. A Trigger Control Set (TCS) is a bunch of slots that can house
multiple resource state requests, that when triggered will issue those
requests through an internal bus to the Resource Power Manager Hardened
(RPMH) blocks. These hardware blocks are capable of adjusting clocks,
voltages etc. The resource state request from a DRV are aggregated along
with state requests from other processors in the SoC and the aggregate
value is applied on the resource.

Some important aspects of the RPMH communication -
- Requests are <addr, value> with some header information
- Multiple requests (upto 16) may be sent through a TCS, at a time
- Requests in a TCS are sent in sequence
- Requests may be fire-n-forget or completion (response expected)
- Multiple TCS from the same DRV may be triggered simultaneously
- Cannot send a request if another reques for the same addr is in
  progress from the same DRV
- When all the requests from a TCS are complete, an IRQ is raised
- The IRQ handler needs to clear the TCS before it is available for
  reuse
- TCS configuration is specific to a DRV
- Platform drivers may use DRV from different RSCs to make requests

Resource state requests made when CPUs are active are called 'active'
state requests. Requests made when all the CPUs are powered down (idle
state) are called 'sleep' state requests. They are matched by a
corresponding 'wake' state requests which puts the resources back in to
previously requested active state before resuming any CPU. TCSes are
dedicated for each type of requests. Control TCS are used to provide
specific information to the controller.

Only active requests are currently supported by the driver.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/Kconfig                |   7 +
 drivers/soc/qcom/Makefile               |   1 +
 drivers/soc/qcom/rpmh-internal.h        |  24 ++
 drivers/soc/qcom/rpmh-rsc.c             | 674 ++++++++++++++++++++++++++++++++
 include/dt-bindings/soc/qcom,rpmh-rsc.h |  16 +
 include/soc/qcom/tcs.h                  |  38 ++
 6 files changed, 760 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/soc/qcom/tcs.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index f21c5d53e721..d331bb9e83d9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -104,4 +104,11 @@ config QCOM_COMMAND_DB
 	  Command DB queries shared memory by key string for shared system
 	  resources
 
+config QCOM_RPMH
+	bool "Qualcomm RPM-Hardened (RPMH) Communication"
+	depends on ARCH_QCOM && OF
+	help
+	  Support for communication with the hardened-RPM blocks in
+	  Qualcomm Technologies Inc (QTI) SoCs.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 7b64135b22eb..b7951ce87663 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
+obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
new file mode 100644
index 000000000000..0b482f788aa1
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -0,0 +1,24 @@
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
+
+#ifndef __RPM_INTERNAL_H__
+#define __RPM_INTERNAL_H__
+
+#include <soc/qcom/tcs.h>
+
+struct rsc_drv;
+
+int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_mbox_msg *msg);
+
+#endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
new file mode 100644
index 000000000000..3e68cef5513e
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -0,0 +1,674 @@
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
+#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm-generic/io.h>
+#include <soc/qcom/tcs.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+#include "rpmh-internal.h"
+
+#define MAX_CMDS_PER_TCS		16
+#define MAX_TCS_PER_TYPE		3
+
+#define RSC_DRV_TCS_OFFSET		672
+#define RSC_DRV_CMD_OFFSET		20
+
+/* DRV Configuration Information Register */
+#define DRV_PRNT_CHLD_CONFIG		0x0C
+#define DRV_NUM_TCS_MASK		0x3F
+#define DRV_NUM_TCS_SHIFT		6
+#define DRV_NCPT_MASK			0x1F
+#define DRV_NCPT_SHIFT			27
+
+/* Register offsets */
+#define RSC_DRV_IRQ_ENABLE		0x00
+#define RSC_DRV_IRQ_STATUS		0x04
+#define RSC_DRV_IRQ_CLEAR		0x08
+#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10
+#define RSC_DRV_CONTROL			0x14
+#define RSC_DRV_STATUS			0x18
+#define RSC_DRV_CMD_ENABLE		0x1C
+#define RSC_DRV_CMD_MSGID		0x30
+#define RSC_DRV_CMD_ADDR		0x34
+#define RSC_DRV_CMD_DATA		0x38
+#define RSC_DRV_CMD_STATUS		0x3C
+#define RSC_DRV_CMD_RESP_DATA		0x40
+
+#define TCS_AMC_MODE_ENABLE		BIT(16)
+#define TCS_AMC_MODE_TRIGGER		BIT(24)
+
+/* TCS CMD register bit mask */
+#define CMD_MSGID_LEN			8
+#define CMD_MSGID_RESP_REQ		BIT(8)
+#define CMD_MSGID_WRITE			BIT(16)
+#define CMD_STATUS_ISSUED		BIT(8)
+#define CMD_STATUS_COMPL		BIT(16)
+
+#define TCS_TYPE_NR			4
+#define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+
+struct rsc_drv;
+
+/**
+ * tcs_response: Response object for a request
+ *
+ * @drv: the controller
+ * @msg: the request for this response
+ * @m: the tcs identifier
+ * @err: error reported in the response
+ * @list: link list object.
+ */
+struct tcs_response {
+	struct rsc_drv *drv;
+	struct tcs_mbox_msg *msg;
+	u32 m;
+	int err;
+	struct list_head list;
+};
+
+/**
+ * tcs_mbox: group of TCSes for a request state
+ *
+ * @type: type of the TCS in this group - active, sleep, wake
+ * @tcs_mask: mask of the TCSes relative to all the TCSes in the RSC
+ * @tcs_offset: start of the TCS group relative to the TCSes in the RSC
+ * @num_tcs: number of TCSes in this type
+ * @ncpt: number of commands in each TCS
+ * @tcs_lock: lock for synchronizing this TCS writes
+ * @responses: response objects for requests sent from each TCS
+ */
+struct tcs_mbox {
+	struct rsc_drv *drv;
+	int type;
+	u32 tcs_mask;
+	u32 tcs_offset;
+	int num_tcs;
+	int ncpt;
+	spinlock_t tcs_lock;
+	struct tcs_response *responses[MAX_TCS_PER_TYPE];
+};
+
+/**
+ * rsc_drv: the RSC controller
+ *
+ * @pdev: platform device of this controller
+ * @name: controller identifier
+ * @base: start address of the controller
+ * @reg_base: start address of the registers in this controller
+ * @drv_id: instance id in the controller (DRV)
+ * @num_tcs: number of TCSes in this DRV
+ * @tasklet: handle responses, off-load work from IRQ handler
+ * @response_pending: list of responses that needs to be sent to caller
+ * @tcs: TCS groups
+ * @tcs_in_use: s/w state of the TCS
+ * @drv_lock: synchronize state of the controller
+ */
+struct rsc_drv {
+	struct platform_device *pdev;
+	const char *name;
+	void __iomem *base;
+	void __iomem *reg_base;
+	int drv_id;
+	int num_tcs;
+	struct tasklet_struct tasklet;
+	struct list_head response_pending;
+	struct tcs_mbox tcs[TCS_TYPE_NR];
+	atomic_t tcs_in_use[MAX_TCS_NR];
+	spinlock_t drv_lock;
+};
+
+static inline struct tcs_mbox *get_tcs_from_index(struct rsc_drv *drv, int m)
+{
+	struct tcs_mbox *tcs = NULL;
+	int i;
+
+	for (i = 0; i < drv->num_tcs; i++) {
+		tcs = &drv->tcs[i];
+		if (tcs->tcs_mask & (u32)BIT(m))
+			break;
+	}
+
+	if (i == drv->num_tcs) {
+		WARN(1, "Incorrect TCS index %d", m);
+		tcs = NULL;
+	}
+
+	return tcs;
+}
+
+static struct tcs_response *setup_response(struct rsc_drv *drv,
+			struct tcs_mbox_msg *msg, int m)
+{
+	struct tcs_response *resp;
+	struct tcs_mbox *tcs;
+
+	resp = kcalloc(1, sizeof(*resp), GFP_ATOMIC);
+	if (!resp)
+		return ERR_PTR(-ENOMEM);
+
+	resp->drv = drv;
+	resp->msg = msg;
+	resp->err = 0;
+
+	tcs = get_tcs_from_index(drv, m);
+	if (!tcs)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * We should have been called from a TCS-type locked context, and
+	 * we overwrite the previously saved response.
+	 */
+	tcs->responses[m - tcs->tcs_offset] = resp;
+
+	return resp;
+}
+
+static void free_response(struct tcs_response *resp)
+{
+	kfree(resp);
+}
+
+static inline struct tcs_response *get_response(struct rsc_drv *drv, u32 m)
+{
+	struct tcs_mbox *tcs = get_tcs_from_index(drv, m);
+
+	return tcs->responses[m - tcs->tcs_offset];
+}
+
+static inline u32 read_drv_config(void __iomem *base)
+{
+	return le32_to_cpu(readl_relaxed(base + DRV_PRNT_CHLD_CONFIG));
+}
+
+static inline u32 read_tcs_reg(void __iomem *base, int reg, int m, int n)
+{
+	return le32_to_cpu(readl_relaxed(base + reg +
+			RSC_DRV_TCS_OFFSET * m + RSC_DRV_CMD_OFFSET * n));
+}
+
+static inline void write_tcs_reg(void __iomem *base, int reg, int m, int n,
+				u32 data)
+{
+	writel_relaxed(cpu_to_le32(data), base + reg +
+			RSC_DRV_TCS_OFFSET * m + RSC_DRV_CMD_OFFSET * n);
+}
+
+static inline void write_tcs_reg_sync(void __iomem *base, int reg, int m, int n,
+				u32 data)
+{
+	do {
+		write_tcs_reg(base, reg, m, n, data);
+		if (data == read_tcs_reg(base, reg, m, n))
+			break;
+		udelay(1);
+	} while (1);
+}
+
+static inline bool tcs_is_free(struct rsc_drv *drv, int m)
+{
+	void __iomem *base = drv->reg_base;
+
+	return read_tcs_reg(base, RSC_DRV_STATUS, m, 0) &&
+			!atomic_read(&drv->tcs_in_use[m]);
+}
+
+static inline struct tcs_mbox *get_tcs_of_type(struct rsc_drv *drv, int type)
+{
+	int i;
+	struct tcs_mbox *tcs;
+
+	for (i = 0; i < TCS_TYPE_NR; i++)
+		if (type == drv->tcs[i].type)
+			break;
+
+	if (i == TCS_TYPE_NR)
+		return ERR_PTR(-EINVAL);
+
+	tcs = &drv->tcs[i];
+	if (!tcs->num_tcs)
+		return ERR_PTR(-EINVAL);
+
+	return tcs;
+}
+
+static inline struct tcs_mbox *get_tcs_for_msg(struct rsc_drv *drv,
+						struct tcs_mbox_msg *msg)
+{
+	int type = -1;
+
+	switch (msg->state) {
+	case RPMH_ACTIVE_ONLY_STATE:
+		type = ACTIVE_TCS;
+		break;
+	default:
+		break;
+	}
+
+	if (type < 0)
+		return ERR_PTR(-EINVAL);
+
+	return get_tcs_of_type(drv, type);
+}
+
+static inline void send_tcs_response(struct tcs_response *resp)
+{
+	struct rsc_drv *drv = resp->drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->drv_lock, flags);
+	INIT_LIST_HEAD(&resp->list);
+	list_add_tail(&resp->list, &drv->response_pending);
+	spin_unlock_irqrestore(&drv->drv_lock, flags);
+
+	tasklet_schedule(&drv->tasklet);
+}
+
+/**
+ * tcs_irq_handler: TX Done interrupt handler
+ */
+static irqreturn_t tcs_irq_handler(int irq, void *p)
+{
+	struct rsc_drv *drv = p;
+	void __iomem *base = drv->reg_base;
+	int m, i;
+	u32 irq_status, sts;
+	struct tcs_response *resp;
+	struct tcs_cmd *cmd;
+	int err;
+
+	irq_status = read_tcs_reg(base, RSC_DRV_IRQ_STATUS, 0, 0);
+
+	for (m = 0; m < drv->num_tcs; m++) {
+		if (!(irq_status & (u32)BIT(m)))
+			continue;
+
+		err = 0;
+		resp = get_response(drv, m);
+		if (!resp) {
+			for (i = 0; i < resp->msg->num_payload; i++) {
+				cmd = &resp->msg->payload[i];
+				sts = read_tcs_reg(base, RSC_DRV_CMD_STATUS,
+							m, i);
+				if ((!(sts & CMD_STATUS_ISSUED)) ||
+					((resp->msg->is_complete ||
+					  cmd->complete) &&
+					(!(sts & CMD_STATUS_COMPL)))) {
+					resp->err = -EIO;
+					break;
+				}
+			}
+		}
+
+		write_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0, 0);
+		write_tcs_reg(base, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
+		atomic_set(&drv->tcs_in_use[m], 0);
+
+		if (resp) {
+			resp->err = err;
+			send_tcs_response(resp);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tcs_notify_tx_done: TX Done for requests that got a response
+ *
+ * @data: the tasklet argument
+ *
+ * Tasklet function to notify MBOX that we are done with the request.
+ * Handles all pending reponses whenever run.
+ */
+static void tcs_notify_tx_done(unsigned long data)
+{
+	struct rsc_drv *drv = (struct rsc_drv *)data;
+	struct tcs_response *resp;
+	unsigned long flags;
+	int err;
+
+	do {
+		spin_lock_irqsave(&drv->drv_lock, flags);
+		if (list_empty(&drv->response_pending)) {
+			spin_unlock_irqrestore(&drv->drv_lock, flags);
+			break;
+		}
+		resp = list_first_entry(&drv->response_pending,
+					struct tcs_response, list);
+		list_del(&resp->list);
+		spin_unlock_irqrestore(&drv->drv_lock, flags);
+		err = resp->err;
+		free_response(resp);
+	} while (1);
+}
+
+static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
+				struct tcs_mbox_msg *msg)
+{
+	void __iomem *base = drv->reg_base;
+	u32 msgid, cmd_msgid = 0;
+	u32 cmd_enable = 0;
+	u32 cmd_complete;
+	struct tcs_cmd *cmd;
+	int i;
+
+	cmd_msgid = CMD_MSGID_LEN;
+	cmd_msgid |= (msg->is_complete) ? CMD_MSGID_RESP_REQ : 0;
+	cmd_msgid |= CMD_MSGID_WRITE;
+
+	cmd_complete = read_tcs_reg(base, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
+
+	for (i = 0; i < msg->num_payload; i++) {
+		cmd = &msg->payload[i];
+		cmd_enable |= BIT(n + i);
+		cmd_complete |= cmd->complete << (n + i);
+		msgid = cmd_msgid;
+		msgid |= (cmd->complete) ? CMD_MSGID_RESP_REQ : 0;
+		write_tcs_reg(base, RSC_DRV_CMD_MSGID, m, n + i, msgid);
+		write_tcs_reg(base, RSC_DRV_CMD_ADDR, m, n + i, cmd->addr);
+		write_tcs_reg(base, RSC_DRV_CMD_DATA, m, n + i, cmd->data);
+	}
+
+	write_tcs_reg(base, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
+	cmd_enable |= read_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0);
+	write_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
+}
+
+static void __tcs_trigger(struct rsc_drv *drv, int m)
+{
+	void __iomem *base = drv->reg_base;
+	u32 enable;
+
+	/*
+	 * HW req: Clear the DRV_CONTROL and enable TCS again
+	 * While clearing ensure that the AMC mode trigger is cleared
+	 * and then the mode enable is cleared.
+	 */
+	enable = read_tcs_reg(base, RSC_DRV_CONTROL, m, 0);
+	enable &= ~TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(base, RSC_DRV_CONTROL, m, 0, enable);
+	enable &= ~TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(base, RSC_DRV_CONTROL, m, 0, enable);
+
+	/* Enable the AMC mode on the TCS and then trigger the TCS */
+	enable = TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(base, RSC_DRV_CONTROL, m, 0, enable);
+	enable |= TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(base, RSC_DRV_CONTROL, m, 0, enable);
+}
+
+static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_mbox *tcs,
+						struct tcs_mbox_msg *msg)
+{
+	u32 curr_enabled, addr;
+	int i, j, k;
+	void __iomem *base = drv->reg_base;
+	int m = tcs->tcs_offset;
+
+	for (i = 0; i < tcs->num_tcs; i++, m++) {
+		if (tcs_is_free(drv, m))
+			continue;
+
+		curr_enabled = read_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0);
+
+		for (j = 0; j < MAX_CMDS_PER_TCS; j++) {
+			if (!(curr_enabled & (u32)BIT(j)))
+				continue;
+
+			addr = read_tcs_reg(base, RSC_DRV_CMD_ADDR, m, j);
+			for (k = 0; k < msg->num_payload; k++) {
+				if (addr == msg->payload[k].addr)
+					return -EBUSY;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int find_free_tcs(struct tcs_mbox *tcs)
+{
+	int m;
+
+	for (m = 0; m < tcs->num_tcs; m++)
+		if (tcs_is_free(tcs->drv, tcs->tcs_offset + m))
+			break;
+
+	return (m != tcs->num_tcs) ? m : -EBUSY;
+}
+
+static int tcs_mbox_write(struct rsc_drv *drv, struct tcs_mbox_msg *msg)
+{
+	struct tcs_mbox *tcs;
+	int m;
+	struct tcs_response *resp = NULL;
+	unsigned long flags;
+	int ret = 0;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->tcs_lock, flags);
+	m = find_free_tcs(tcs);
+	if (m < 0) {
+		ret = m;
+		goto done_write;
+	}
+
+	/*
+	 * The h/w does not like if we send a request to the same address,
+	 * when one is already in-flight or bring processed.
+	 */
+	ret = check_for_req_inflight(drv, tcs, msg);
+	if (ret)
+		goto done_write;
+
+	resp = setup_response(drv, msg, m);
+	if (IS_ERR_OR_NULL(resp)) {
+		ret = PTR_ERR(resp);
+		goto done_write;
+	}
+	resp->m = m;
+
+	atomic_set(&drv->tcs_in_use[m], 1);
+	__tcs_buffer_write(drv, m, 0, msg);
+	__tcs_trigger(drv, m);
+
+done_write:
+	spin_unlock_irqrestore(&tcs->tcs_lock, flags);
+	return ret;
+}
+
+/**
+ * rpmh_rsc_send_data: Validate the incoming message and write to the
+ * appropriate TCS block.
+ *
+ * @drv: the controller
+ * @msg: the data to be sent
+ *
+ * Returns a negative error for invalid message structure and invalid
+ * message combination, -EBUSY if there is an other active request for
+ * the channel in process, otherwise bubbles up internal error.
+ */
+int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_mbox_msg *msg)
+{
+	int ret = 0;
+
+	if (!msg || !msg->payload || !msg->num_payload ||
+			msg->num_payload > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	do {
+		ret = tcs_mbox_write(drv, msg);
+		if (ret == -EBUSY) {
+			pr_info_ratelimited(
+			"TCS Busy, retrying RPMH message send: addr=0x%x\n",
+			msg->payload[0].addr);
+			udelay(10);
+		}
+	} while (ret == -EBUSY);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_rsc_send_data);
+
+static int rpmh_rsc_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct rsc_drv *drv;
+	struct tcs_mbox *tcs;
+	int irq;
+	u32 val[8] = { 0 };
+	int st = 0;
+	int i, ret, nelem;
+	u32 config, max_tcs, ncpt;
+	int tcs_type_count[TCS_TYPE_NR] = { 0 };
+	struct resource *res;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dn, "qcom,drv-id", &drv->drv_id);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+	drv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drv->base))
+		return PTR_ERR(drv->base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -EINVAL;
+	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drv->reg_base))
+		return PTR_ERR(drv->reg_base);
+
+	config = read_drv_config(drv->base);
+	max_tcs = config & (DRV_NUM_TCS_MASK <<
+				(DRV_NUM_TCS_SHIFT * drv->drv_id));
+	max_tcs = max_tcs >> (DRV_NUM_TCS_SHIFT * drv->drv_id);
+	ncpt = config & (DRV_NCPT_MASK << DRV_NCPT_SHIFT);
+	ncpt = ncpt >> DRV_NCPT_SHIFT;
+
+	nelem = of_property_count_elems_of_size(dn, "qcom,tcs-config",
+						sizeof(u32));
+	if (!nelem || (nelem % 2) || (nelem > 2 * TCS_TYPE_NR))
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(dn, "qcom,tcs-config", val, nelem);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < (nelem / 2); i++) {
+		if (val[2 * i] >= TCS_TYPE_NR)
+			return -EINVAL;
+		tcs_type_count[val[2 * i]]++;
+		if (tcs_type_count[val[2 * i]] > 1)
+			return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tcs_type_count); i++)
+		if (!tcs_type_count[i])
+			return -EINVAL;
+
+	for (i = 0; i < (nelem / 2); i++) {
+		tcs = &drv->tcs[val[2 * i]];
+		tcs->drv = drv;
+		tcs->type = val[2 * i];
+		tcs->num_tcs = val[2 * i + 1];
+		tcs->ncpt = ncpt;
+		spin_lock_init(&tcs->tcs_lock);
+
+		if (tcs->num_tcs <= 0 || tcs->type == CONTROL_TCS)
+			continue;
+
+		if (tcs->num_tcs > MAX_TCS_PER_TYPE ||
+			st + tcs->num_tcs > max_tcs ||
+			st + tcs->num_tcs >= 8 * sizeof(tcs->tcs_mask))
+			return -EINVAL;
+
+		tcs->tcs_mask = ((1 << tcs->num_tcs) - 1) << st;
+		tcs->tcs_offset = st;
+		st += tcs->num_tcs;
+	}
+
+	drv->num_tcs = st;
+	drv->pdev = pdev;
+	INIT_LIST_HEAD(&drv->response_pending);
+	spin_lock_init(&drv->drv_lock);
+	tasklet_init(&drv->tasklet, tcs_notify_tx_done, (unsigned long)drv);
+
+	drv->name = of_get_property(pdev->dev.of_node, "label", NULL);
+	if (!drv->name)
+		drv->name = dev_name(&pdev->dev);
+
+	irq = of_irq_get(dn, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, tcs_irq_handler,
+			IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, drv->name, drv);
+	if (ret)
+		return ret;
+
+	write_tcs_reg(drv->reg_base, RSC_DRV_IRQ_ENABLE, 0, 0,
+					drv->tcs[ACTIVE_TCS].tcs_mask);
+
+	for (i = 0; i < ARRAY_SIZE(drv->tcs_in_use); i++)
+		atomic_set(&drv->tcs_in_use[i], 0);
+
+	dev_set_drvdata(&pdev->dev, drv);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id rpmh_drv_match[] = {
+	{ .compatible = "qcom,rpmh-rsc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpm_drv_match);
+
+static struct platform_driver rpmh_driver = {
+	.probe = rpmh_rsc_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = rpmh_drv_match,
+	},
+};
+
+static int __init rpmh_driver_init(void)
+{
+	return platform_driver_register(&rpmh_driver);
+}
+arch_initcall(rpmh_driver_init);
diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
new file mode 100644
index 000000000000..24a56a5cf096
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
@@ -0,0 +1,16 @@
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
+ */
+
+#define SLEEP_TCS	0
+#define WAKE_TCS	1
+#define ACTIVE_TCS	2
+#define CONTROL_TCS	3
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
new file mode 100644
index 000000000000..07cf6d8d43e3
--- /dev/null
+++ b/include/soc/qcom/tcs.h
@@ -0,0 +1,38 @@
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
+#ifndef __SOC_QCOM_TCS_H__
+#define __SOC_QCOM_TCS_H__
+
+#define MAX_RPMH_PAYLOAD	16
+
+struct tcs_cmd {
+	u32 addr;		/* slv_id:18:16 | offset:0:15 */
+	u32 data;		/* data for resource (or read response) */
+	bool complete;		/* wait for completion before sending next */
+};
+
+enum rpmh_state {
+	RPMH_ACTIVE_ONLY_STATE,	/* Active only (= AMC) */
+	RPMH_WAKE_ONLY_STATE,	/* Wake only */
+	RPMH_SLEEP_STATE,	/* Sleep */
+};
+
+struct tcs_mbox_msg {
+	enum rpmh_state state;	/* request state */
+	bool is_complete;	/* wait for resp from accelerator */
+	u32 num_payload;	/* Limited to MAX_RPMH_PAYLOAD in one msg */
+	struct tcs_cmd *payload;/* array of tcs_cmds */
+};
+
+#endif /* __SOC_QCOM_TCS_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
