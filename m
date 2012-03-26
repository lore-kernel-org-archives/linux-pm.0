From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/3] cpuidle: use the driver's state_count as
	default
Date: Mon, 26 Mar 2012 14:51:26 +0200
Message-ID: <1332766288-30412-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

If the state_count is not initialized for the device use
the driver's state count as the default. That will prevent
to add it manually in the cpuidle driver initialization
routine and will save us from duplicate line of code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 drivers/cpuidle/driver.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 27f77a4..b8a1faf 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -268,7 +268,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
 	if (!dev->state_count)
-		return -EINVAL;
+		dev->state_count = drv->state_count;
 
 	if (dev->registered == 0) {
 		ret = __cpuidle_register_device(dev);
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 284d7af..40cd3f3 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -47,7 +47,7 @@ static void __cpuidle_register_driver(struct cpuidle_driver *drv)
  */
 int cpuidle_register_driver(struct cpuidle_driver *drv)
 {
-	if (!drv)
+	if (!drv || !drv->state_count)
 		return -EINVAL;
 
 	if (cpuidle_disabled())
-- 
1.7.5.4
