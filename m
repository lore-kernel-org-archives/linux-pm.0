From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] PM:Hibernation: drop the check of swap space
	size for compressed image
Date: Mon, 9 Jan 2012 12:56:23 +0800
Message-ID: <1326084983-22237-1-git-send-email-Barry.Song@csr.com>
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
To: rjw@sisk.pl, pavel@ucw.cz
Cc: linux-pm@lists.linux-foundation.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-pm@vger.kernel.org

From: Barry Song <Baohua.Song@csr.com>

For compressed image, the space required is not known until
we finish compressing and writing all pages.
This patch drops the check, and if swap space is not enough
finally, system can still restore to normal after writing
swap fails for compressed images.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 kernel/power/swap.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 11a594c..c8306a5 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -774,8 +774,7 @@ static int enough_swap(unsigned int nr_pages, unsigned int flags)
 
 	pr_debug("PM: Free swap pages: %u\n", free_swap);
 
-	required = PAGES_FOR_IO + ((flags & SF_NOCOMPRESS_MODE) ?
-		nr_pages : (nr_pages * LZO_CMP_PAGES) / LZO_UNC_PAGES + 1);
+	required = PAGES_FOR_IO + nr_pages;
 	return free_swap > required;
 }
 
@@ -803,10 +802,12 @@ int swsusp_write(unsigned int flags)
 		printk(KERN_ERR "PM: Cannot get swap writer\n");
 		return error;
 	}
-	if (!enough_swap(pages, flags)) {
-		printk(KERN_ERR "PM: Not enough free swap\n");
-		error = -ENOSPC;
-		goto out_finish;
+	if (flags & SF_NOCOMPRESS_MODE) {
+		if (!enough_swap(pages, flags)) {
+			printk(KERN_ERR "PM: Not enough free swap\n");
+			error = -ENOSPC;
+			goto out_finish;
+		}
 	}
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_read_next(&snapshot);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
