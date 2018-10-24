From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/3] net: ethernet: Remove dummy runtime PM callbacks from Renesas drivers
Date: Wed, 24 Oct 2018 16:51:33 +0300
Message-ID: <20181024135134.28456-3-jarkko.nikula@linux.intel.com>
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
success in order to have runtime PM happening. This has changed since
following commits:

05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Only build tested.
---
 drivers/net/ethernet/renesas/ravb_main.c | 13 -------------
 drivers/net/ethernet/renesas/sh_eth.c    | 13 -------------
 2 files changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index defed0d0c51d..9498f9d67501 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2335,21 +2335,8 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
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
 static const struct dev_pm_ops ravb_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index f27a0dc8c563..980310686d45 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3447,21 +3447,8 @@ static int sh_eth_resume(struct device *dev)
 }
 #endif
 
-static int sh_eth_runtime_nop(struct device *dev)
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
 static const struct dev_pm_ops sh_eth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sh_eth_suspend, sh_eth_resume)
-	SET_RUNTIME_PM_OPS(sh_eth_runtime_nop, sh_eth_runtime_nop, NULL)
 };
 #define SH_ETH_PM_OPS (&sh_eth_dev_pm_ops)
 #else
-- 
2.19.1
