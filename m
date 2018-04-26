From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/11] mmc: sdio: Respect all error codes from dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:08 +0200
Message-ID: <1524732790-2234-10-git-send-email-ulf.hansson@linaro.org>
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

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2b32b88..b6d8203 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -139,7 +139,7 @@ static int sdio_bus_probe(struct device *dev)
 		return -ENODEV;
 
 	ret = dev_pm_domain_attach(dev, false);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		return ret;
 
 	/* Unbound SDIO functions are always suspended.
-- 
2.7.4
