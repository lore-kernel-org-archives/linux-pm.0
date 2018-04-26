From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/11] i2c: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:07 +0200
Message-ID: <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb..a17f46a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -363,7 +363,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	status = dev_pm_domain_attach(&client->dev, true);
-	if (status == -EPROBE_DEFER)
+	if (status)
 		goto err_clear_wakeup_irq;
 
 	/*
-- 
2.7.4
