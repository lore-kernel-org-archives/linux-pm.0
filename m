From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: [PATCH 2.6.19-rc3] (1/2) fix bd_claim_by_kobject error handling
Date: Mon, 30 Oct 2006 16:23:45 -0500
Message-ID: <45466D61.5070701@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000600020308020906090007"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161503AbWJ3VZs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org, rdunlap@xenotime.net, mst@mellanox.co.il, linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, pavel@suse.cz, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, martin@lorenz.eu.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600020308020906090007
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

Excuse me for the long Cc list.
I kept people in the thread below in Cc.
http://marc.theaimsgroup.com/?l=linux-kernel&m=116221664710826&w=2

The patch below fixes bd_claim_by_kobject to release bdev correctly
in case that bd_claim succeeds but following add_bd_holder fails.

If it happens, the caller takes it didn't bd_claim() where actually
it did. The bdev becomes no longer bd_claim-able from others.
I don't have any reproducible test case for it but it's a bug.
The bug is introduced in 2.6.18-rc1-mm2 and now in 2.6.19-rc3.

Please consider to apply.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America

--------------000600020308020906090007
Content-Type: text/x-patch;
 name="fix-bd_claim_by_kobject-error-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-bd_claim_by_kobject-error-handling.patch"

The patch below fixes bd_claim_by_kobject to release bdev correctly
in case that bd_claim succeeds but following add_bd_holder fails.

 fs/block_dev.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.orig/fs/block_dev.c	2006-10-30 10:07:16.000000000 -0500
+++ linux-2.6/fs/block_dev.c	2006-10-30 15:38:21.000000000 -0500
@@ -751,8 +751,11 @@ static int bd_claim_by_kobject(struct bl
 
 	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	res = bd_claim(bdev, holder);
-	if (res == 0)
+	if (res == 0) {
 		res = add_bd_holder(bdev, bo);
+		if (res)
+			bd_release(bdev);
+	}
 	if (res)
 		free_bd_holder(bo);
 	mutex_unlock(&bdev->bd_mutex);

--------------000600020308020906090007--
