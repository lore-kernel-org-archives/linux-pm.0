From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal/x86 pkg temp: Remove debugfs_create_u32() casts
Date: Tue,  2 Jan 2018 16:30:57 +0100
Message-ID: <1514907057-9917-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

When exposing data access through debugfs, the correct
debugfs_create_*() functions must be used, depending on data type.

Remove all casts from data pointers passed to debugfs_create_*()
functions, as such casts prevent the compiler from flagging bugs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/thermal/x86_pkg_temp_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index d93eee2f101b0aee..1a6c88b10a396e37 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -96,12 +96,12 @@ static int pkg_temp_debugfs_init(void)
 		return -ENOENT;
 
 	d = debugfs_create_u32("pkg_thres_interrupt", S_IRUGO, debugfs,
-				(u32 *)&pkg_interrupt_cnt);
+			       &pkg_interrupt_cnt);
 	if (!d)
 		goto err_out;
 
 	d = debugfs_create_u32("pkg_thres_work", S_IRUGO, debugfs,
-				(u32 *)&pkg_work_cnt);
+			       &pkg_work_cnt);
 	if (!d)
 		goto err_out;
 
-- 
2.7.4
