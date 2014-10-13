From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 3/9] amba: Keep PM domain powered during ->probe()
Date: Mon, 13 Oct 2014 16:02:04 +0200
Message-ID: <1413208930-26019-4-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 47bbdc1..a8a8e13 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -187,8 +187,15 @@ static int amba_probe(struct device *dev)
 		if (ret == -EPROBE_DEFER)
 			break;
 
+		ret = dev_pm_domain_get(dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
+			break;
+		}
+
 		ret = amba_get_enable_pclk(pcdev);
 		if (ret) {
+			dev_pm_domain_put(dev->pm_domain);
 			dev_pm_domain_detach(dev, true);
 			break;
 		}
@@ -198,6 +205,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_enable(dev);
 
 		ret = pcdrv->probe(pcdev, id);
+		dev_pm_domain_put(dev->pm_domain);
 		if (ret == 0)
 			break;
 
-- 
1.9.1
