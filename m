From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 15/17] ir-hix5hd2: drop the use of IRQF_NO_SUSPEND
Date: Mon, 21 Sep 2015 16:47:11 +0100
Message-ID: <1442850433-5903-16-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Fabio Estevam <fabio.estevam@freescale.com>, Guoxiong Yan <yanguoxiong@huawei.com>, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This driver doesn't claim the IR transmitter to be wakeup source. It
even disables the clock and the IR during suspend-resume cycle.

This patch removes yet another misuse of IRQF_NO_SUSPEND.

Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Guoxiong Yan <yanguoxiong@huawei.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/media/rc/ir-hix5hd2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 1c087cb76815..d0549fba711c 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -257,7 +257,7 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 		goto clkerr;
 
 	if (devm_request_irq(dev, priv->irq, hix5hd2_ir_rx_interrupt,
-			     IRQF_NO_SUSPEND, pdev->name, priv) < 0) {
+			     0, pdev->name, priv) < 0) {
 		dev_err(dev, "IRQ %d register failed\n", priv->irq);
 		ret = -EINVAL;
 		goto regerr;
-- 
1.9.1
