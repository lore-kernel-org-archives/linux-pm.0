From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/4] power: reset: at91-poweroff: Fix module autoload
Date: Mon, 17 Oct 2016 15:36:13 -0300
Message-ID: <1476729375-17526-3-git-send-email-javier@osg.samsung.com>
References: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/power/reset/at91-poweroff.ko | grep alias
$

After this patch:

$ modinfo drivers/power/reset/at91-poweroff.ko | grep alias
alias:          of:N*T*Catmel,at91sam9x5-shdwcC*
alias:          of:N*T*Catmel,at91sam9x5-shdwc
alias:          of:N*T*Catmel,at91sam9rl-shdwcC*
alias:          of:N*T*Catmel,at91sam9rl-shdwc
alias:          of:N*T*Catmel,at91sam9260-shdwcC*
alias:          of:N*T*Catmel,at91sam9260-shdwc

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/reset/at91-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index e9e24df35f26..a85dd4d233af 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -169,6 +169,7 @@ static const struct of_device_id at91_poweroff_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-shdwc", },
 	{ /*sentinel*/ }
 };
+MODULE_DEVICE_TABLE(of, at91_poweroff_of_match);
 
 static struct platform_driver at91_poweroff_driver = {
 	.remove = __exit_p(at91_poweroff_remove),
-- 
2.7.4
