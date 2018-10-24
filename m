From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/3] i2c: sh_mobile: Remove dummy runtime PM callbacks
Date: Wed, 24 Oct 2018 16:51:32 +0300
Message-ID: <20181024135134.28456-2-jarkko.nikula@linux.intel.com>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Platform drivers don't need dummy runtime PM callbacks that just return
success and non-NULL pm pointer in their struct device_driver in order
to have runtime PM happening. This has changed since following commits:

05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Only build tested.
---
 drivers/i2c/busses/i2c-sh_mobile.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 818cab14e87c..a7a7a9c3bc7c 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -947,27 +947,9 @@ static int sh_mobile_i2c_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int sh_mobile_i2c_runtime_nop(struct device *dev)
-{
-	/* Runtime PM callback shared between ->runtime_suspend()
-	 * and ->runtime_resume(). Simply returns success.
-	 *
-	 * This driver re-initializes all registers after
-	 * pm_runtime_get_sync() anyway so there is no need
-	 * to save and restore registers here.
-	 */
-	return 0;
-}
-
-static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
-	.runtime_suspend = sh_mobile_i2c_runtime_nop,
-	.runtime_resume = sh_mobile_i2c_runtime_nop,
-};
-
 static struct platform_driver sh_mobile_i2c_driver = {
 	.driver		= {
 		.name		= "i2c-sh_mobile",
-		.pm		= &sh_mobile_i2c_dev_pm_ops,
 		.of_match_table = sh_mobile_i2c_dt_ids,
 	},
 	.probe		= sh_mobile_i2c_probe,
-- 
2.19.1
