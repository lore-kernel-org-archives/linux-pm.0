From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/11] amba: Respect all error codes from
 dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 10:53:05 +0200
Message-ID: <1524732790-2234-7-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..79fcbff 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -243,7 +243,7 @@ static int amba_probe(struct device *dev)
 			break;
 
 		ret = dev_pm_domain_attach(dev, true);
-		if (ret == -EPROBE_DEFER)
+		if (ret)
 			break;
 
 		ret = amba_get_enable_pclk(pcdev);
@@ -370,7 +370,7 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	}
 
 	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret == -EPROBE_DEFER) {
+	if (ret) {
 		iounmap(tmp);
 		goto err_release;
 	}
-- 
2.7.4
