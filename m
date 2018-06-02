From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] power: reset: zx-reboot: put device node in zx_reboot_probe()
Date: Sun,  3 Jun 2018 01:22:05 +0300
Message-ID: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: linux-pm@vger.kernel.org

zx_reboot_probe() increments refcnt of zx296702-pcu device node by
of_find_compatible_node() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/power/reset/zx-reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index c03e96e6a041..186901c96c01 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -51,6 +51,7 @@ static int zx_reboot_probe(struct platform_device *pdev)
 
 	np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
 	pcu_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!pcu_base) {
 		iounmap(base);
 		WARN(1, "failed to map pcu_base address");
-- 
2.7.4
