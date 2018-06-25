From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] kernel/power: cast PAGE_SIZE to int when comparing with error code
Date: Mon, 25 Jun 2018 13:30:58 +0800
Message-ID: <20180625053058.25206-1-cgxu519@gmx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
List-Id: linux-pm@vger.kernel.org

If PAGE_SIZE is unsigned type then negative error code will be
larger than PAGE_SIZE.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c2bcf97d24c8..d7f6c1a288d3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -923,7 +923,7 @@ int swsusp_write(unsigned int flags)
 	}
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_read_next(&snapshot);
-	if (error < PAGE_SIZE) {
+	if (error < (int)PAGE_SIZE) {
 		if (error >= 0)
 			error = -EFAULT;
 
@@ -1483,7 +1483,7 @@ int swsusp_read(unsigned int *flags_p)
 
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_write_next(&snapshot);
-	if (error < PAGE_SIZE)
+	if (error < (int)PAGE_SIZE)
 		return error < 0 ? error : -EFAULT;
 	header = (struct swsusp_info *)data_of(snapshot);
 	error = get_swap_reader(&handle, flags_p);
-- 
2.17.1
