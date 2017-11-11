From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mailbox/omap: unregister mbox class
Date: Sat, 11 Nov 2017 23:39:18 +0530
Message-ID: <014a4c5cd6008a42621d45f34d57b9e1a72d3c76.1510423634.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jassisinghbrar@gmail.com, s-anna@ti.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

platform_driver_register() can fail here and we must unregister mbox
class.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mailbox/omap-mailbox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index c5e8b9c..2517038 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -906,7 +906,11 @@ static int __init omap_mbox_init(void)
 	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
 							sizeof(mbox_msg_t));
 
-	return platform_driver_register(&omap_mbox_driver);
+	err = platform_driver_register(&omap_mbox_driver);
+	if (err)
+		class_unregister(&omap_mbox_class);
+
+	return err;
 }
 subsys_initcall(omap_mbox_init);
 
-- 
2.7.4
