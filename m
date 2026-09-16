Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512E3EC687;
	Wed, 16 Sep 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541732; cv=none; b=h7BhwRMKh+cqb3JwHEeUwv8Sk3xvpIuvkxigxZ9X4zQaH1eSdJAOOasl/Qbmz7F3f94dfRkzHkz3h9Nw+STFQzuusThUhXF/WLPxIz6BpqtzfiOnnV54PInJ/OpRW/mzAl8dcPSXq11W4jGrMUknWM0jRUvP2uXK5ts2PedcW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541732; c=relaxed/simple;
	bh=hOx6+HehGLpqTjaUsjvTe269B+sTWy2OqbWfsNAopY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lTcqdFTA0yPAJbYtxkrrgnVvAn+Gd+UbOt9T6uHLtTvlaVwI8iqb18Q0ya4625dIBfyn0ln4p9M/yW3eAzXrvHHKxzZyAEj8erW2khHVYw/SQO32Xw1a9HAksuvI21CC7xCCPd1vD3C9iEN6pNxPkeEFCRgy8zDWExL8XhOQrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-03 (Coremail) with SMTP id rQCowAAHET9VPapqgcreBw--.40492S2;
	Wed, 16 Sep 2026 14:55:18 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Wed, 16 Sep 2026 14:55:00 +0800
Subject: [PATCH] power: reset: th1520-aon: send RPCs from sleepable
 handlers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix-xuantieaon-v1-1-c6dc530a4884@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAEM9qmoC/x2MQQqAIBAAvyJ7TtCFhPpKdFhqq72soRVC+Pek4
 8DMvJA5CWcYzQuJH8kStYHvDCwH6c5W1saADoMbfLCbFFtu0kuYolrP5HwgxB4DtOhM3Ix/OM2
 1fqaSpRBgAAAA
X-Change-ID: 20260916-fix-xuantieaon-1ea016a22526
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Icenowy Zheng <uwu@icenowy.me>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAAHET9VPapqgcreBw--.40492S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4DJr4fJw48ArWxtF45trb_yoW7JFyxpa
	s7CF4FyFWkGF12gF4xZrWjgrWfZrn5Jr47WrWfG34UuFnxJr9YvFWUKFW2gFyftFW7u3W7
	Zrn0vrWUurn8W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBwMMDGqqB-XvawAAsy

The AON RPC takes a mutex and waits for mailbox interrupts. The final
sys-off handlers run on atomic notifier chains, where this can sleep
with interrupts disabled.

Send the requests from the preparation handlers before syscore shutdown.
Retain a final power-off handler to advertise capability and report
failure without issuing another RPC. Let other providers handle
fallback.

Report RPC errors and allow one second after a successful return for the
asynchronous operation to take effect. This is a software fallback
timeout, not a hardware timing requirement.

Fixes: 2d81a24a74e5 ("driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/power/reset/th1520-aon-reboot.c | 49 +++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/power/reset/th1520-aon-reboot.c b/drivers/power/reset/th1520-aon-reboot.c
index ec249667a0ffd74829357d57b9e63c3524ea3759..ace70491834dc9a63ed543427e40e4cbc0a9388f 100644
--- a/drivers/power/reset/th1520-aon-reboot.c
+++ b/drivers/power/reset/th1520-aon-reboot.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/firmware/thead/thead,th1520-aon.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -14,37 +15,46 @@
 #include <linux/slab.h>
 
 #define TH1520_AON_REBOOT_PRIORITY 200
+/* Allow an accepted asynchronous command to take effect before fallback. */
+#define TH1520_AON_REBOOT_TIMEOUT_MS 1000
 
 struct th1520_aon_msg_empty_body {
 	struct th1520_aon_rpc_msg_hdr hdr;
 	u16 reserved[12];
 } __packed __aligned(1);
 
-static int th1520_aon_pwroff_handler(struct sys_off_data *data)
+static int th1520_aon_reboot_request(struct sys_off_data *data, u8 func)
 {
 	struct th1520_aon_chan *aon_chan = data->cb_data;
 	struct th1520_aon_msg_empty_body msg = {};
+	int ret;
 
 	msg.hdr.svc = TH1520_AON_RPC_SVC_WDG;
-	msg.hdr.func = TH1520_AON_WDG_FUNC_POWER_OFF;
+	msg.hdr.func = func;
 	msg.hdr.size = TH1520_AON_RPC_MSG_NUM;
 
-	th1520_aon_call_rpc(aon_chan, &msg);
+	ret = th1520_aon_call_rpc(aon_chan, &msg);
+	if (ret)
+		dev_err(data->dev, "AON WDG command %u failed: %d\n", func, ret);
+	else
+		msleep(TH1520_AON_REBOOT_TIMEOUT_MS);
 
 	return NOTIFY_DONE;
 }
 
-static int th1520_aon_restart_handler(struct sys_off_data *data)
+static int th1520_aon_pwroff_handler(struct sys_off_data *data)
 {
-	struct th1520_aon_chan *aon_chan = data->cb_data;
-	struct th1520_aon_msg_empty_body msg = {};
-
-	msg.hdr.svc = TH1520_AON_RPC_SVC_WDG;
-	msg.hdr.func = TH1520_AON_WDG_FUNC_RESTART;
-	msg.hdr.size = TH1520_AON_RPC_MSG_NUM;
+	return th1520_aon_reboot_request(data, TH1520_AON_WDG_FUNC_POWER_OFF);
+}
 
-	th1520_aon_call_rpc(aon_chan, &msg);
+static int th1520_aon_restart_handler(struct sys_off_data *data)
+{
+	return th1520_aon_reboot_request(data, TH1520_AON_WDG_FUNC_RESTART);
+}
 
+static int th1520_aon_pwroff_failed(struct sys_off_data *data)
+{
+	dev_err(data->dev, "AON did not power off the system\n");
 	return NOTIFY_DONE;
 }
 
@@ -54,8 +64,11 @@ static int th1520_aon_reboot_probe(struct auxiliary_device *adev,
 	struct device *dev = &adev->dev;
 	int ret;
 
-	/* Expect struct th1520_aon_chan to be passed via platform_data */
-	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+	/*
+	 * RPC takes a mutex and waits for mailbox interrupts. Send after device
+	 * shutdown, but before syscore shutdown and the final atomic callbacks.
+	 */
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF_PREPARE,
 					    TH1520_AON_REBOOT_PRIORITY,
 					    th1520_aon_pwroff_handler,
 					    adev->dev.platform_data);
@@ -65,7 +78,7 @@ static int th1520_aon_reboot_probe(struct auxiliary_device *adev,
 		return ret;
 	}
 
-	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART,
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART_PREPARE,
 					    TH1520_AON_REBOOT_PRIORITY,
 					    th1520_aon_restart_handler,
 					    adev->dev.platform_data);
@@ -75,7 +88,13 @@ static int th1520_aon_reboot_probe(struct auxiliary_device *adev,
 		return ret;
 	}
 
-	return 0;
+	/*
+	 * Advertise power-off capability to kernel_can_power_off(). This final
+	 * callback must not send RPCs; let other providers try if AON failed.
+	 */
+	return devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+					     TH1520_AON_REBOOT_PRIORITY,
+					     th1520_aon_pwroff_failed, dev_get_platdata(dev));
 }
 
 static const struct auxiliary_device_id th1520_aon_reboot_id_table[] = {

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260916-fix-xuantieaon-1ea016a22526

Best regards,
-- 
Han Gao <gaohan@iscas.ac.cn>

