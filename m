From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/5] input: gpio-keys: switch to new dev_pm_ops
Date: Wed,  5 Aug 2009 20:29:30 +0200
Message-ID: <1249496971-9019-4-git-send-email-daniel__32096.2470410906$1249507279$gmane$org@caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
	<1249496971-9019-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249496971-9019-3-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Phil Blundell <pb@handhelds.org>, Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Phil Blundell <pb@handhelds.org>
Cc: linux-input@vger.kernel.org
---
 drivers/input/keyboard/gpio_keys.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index efed0c9..bfb6fc3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -216,12 +216,12 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 
 
 #ifdef CONFIG_PM
-static int gpio_keys_suspend(struct platform_device *pdev, pm_message_t state)
+static int gpio_keys_suspend(struct device *dev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
 			if (button->wakeup) {
@@ -234,12 +234,12 @@ static int gpio_keys_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gpio_keys_resume(struct platform_device *pdev)
+static int gpio_keys_resume(struct device *dev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
 			if (button->wakeup) {
@@ -251,19 +251,27 @@ static int gpio_keys_resume(struct platform_device *pdev)
 
 	return 0;
 }
+
+static struct dev_pm_ops gpio_keys_pm_ops = {
+	.suspend	= gpio_keys_suspend,
+	.freeze		= gpio_keys_suspend,
+	.resume		= gpio_keys_resume,
+	.thaw		= gpio_keys_resume,
+};
+
+#define GPIO_KEYS_PM_OPS (&gpio_keys_pm_ops)
+
 #else
-#define gpio_keys_suspend	NULL
-#define gpio_keys_resume	NULL
+#define GPIO_KEYS_PM_OPS NULL
 #endif
 
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
 	.remove		= __devexit_p(gpio_keys_remove),
-	.suspend	= gpio_keys_suspend,
-	.resume		= gpio_keys_resume,
 	.driver		= {
 		.name	= "gpio-keys",
 		.owner	= THIS_MODULE,
+		.pm	= GPIO_KEYS_PM_OPS,
 	}
 };
 
-- 
1.6.3.3
