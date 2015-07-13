From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC message type
Date: Mon, 13 Jul 2015 19:39:58 +0530
Message-ID: <1436796602-10228-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Add OPAL_MSG_OCC message definition to opal_message_type to receive
OCC events like reset, load and throttled. Host performance can be
affected when OCC is reset or OCC throttles the max Pstate.
We can register to opal_message_notifier to receive OPAL_MSG_OCC type
of message and report it to the userspace so as to keep the user
informed about the reason for a performance drop in workloads.

The reset and load OCC events are notified to kernel when FSP sends
OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
sent to kernel on successful completion of reset and load operation
respectively.

The throttle OCC event indicates that the Pmax of the chip is reduced.
The chip_id and throttle reason for reducing Pmax is also queued along
with the message.

CC: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v3:
- '0d7cd8550d3 powerpc/powernv: Add opal-prd channel' this patch adds
  the definition of OPAL_MSG_PRD, so remove it and update the
  changelog.
- Move the definitions of OCC_RESET, OCC_LOAD and OCC_THROTTLE from 
  drivers/cpufreq/powernv-cpufreq.c to arch/powerpc/include/asm/opal-api.h
- Define OCC_MAX_THROTTLE_STATUS 
- Add a wrapper structure 'opal_occ_msg' to copy 'struct opal_msg.params[0..2]'
  This structure will define the parameters received from firmware to
  maintain compatibility for any future additions.

No change from v2

Change from v1:
- Update the commit changelog

 arch/powerpc/include/asm/opal-api.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e9e4c52..64dc9f5 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -361,6 +361,7 @@ enum opal_msg_type {
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
 	OPAL_MSG_PRD,
+	OPAL_MSG_OCC,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -700,6 +701,17 @@ struct opal_prd_msg_header {
 
 struct opal_prd_msg;
 
+#define OCC_RESET                       0
+#define OCC_LOAD                        1
+#define OCC_THROTTLE                    2
+#define OCC_MAX_THROTTLE_STATUS         5
+
+struct opal_occ_msg {
+	__be64 type;
+	__be64 chip;
+	__be64 throttle_status;
+};
+
 /*
  * SG entries
  *
-- 
1.9.3
