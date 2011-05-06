From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Hibernate: Make snapshot_release()
	restore GFP mask
Date: Sat, 7 May 2011 00:31:16 +0200
Message-ID: <201105070031.17048.rjw__16449.2353018888$1304721621$gmane$org@sisk.pl>
References: <201105070029.44623.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105070029.44623.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If the process using the hibernate user space interface closes
/dev/snapshot after creating a hibernation image without thawing
tasks, snapshot_release() should call pm_restore_gfp_mask() to
restore the GFP mask used before the creation of the image.  Make
that happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -135,8 +135,10 @@ static int snapshot_release(struct inode
 	free_basic_memory_bitmaps();
 	data = filp->private_data;
 	free_all_swap_pages(data->swap);
-	if (data->frozen)
+	if (data->frozen) {
+		pm_restore_gfp_mask();
 		thaw_processes();
+	}
 	pm_notifier_call_chain(data->mode == O_RDONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	atomic_inc(&snapshot_device_available);
