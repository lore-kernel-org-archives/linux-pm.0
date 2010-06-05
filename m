From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH v2 1/3] mm/swapfile.c: better messages for
	swap_info_get
Date: Sat,  5 Jun 2010 20:14:34 -0300
Message-ID: <1275779676-19120-1-git-send-email-cesarb__13232.8580636115$1275779738$gmane$org@cesarb.net>
References: <4C0ADA44.4020406@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0ADA44.4020406@cesarb.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-mm@kvack.org
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-pm@lists.linux-foundation.org, Cesar Eduardo Barros <cesarb@cesarb.net>, Avi Kivity <avi@redhat.com>
List-Id: linux-pm@vger.kernel.org

swap_info_get() is used for more than swap_free().

Use "swap_info_get:" instead of "swap_free:" in the error messages.

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 mm/swapfile.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 03aa2d5..68765c9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -525,16 +525,16 @@ static struct swap_info_struct *swap_info_get(swp_entry_t entry)
 	return p;
 
 bad_free:
-	printk(KERN_ERR "swap_free: %s%08lx\n", Unused_offset, entry.val);
+	printk(KERN_ERR "swap_info_get: %s%08lx\n", Unused_offset, entry.val);
 	goto out;
 bad_offset:
-	printk(KERN_ERR "swap_free: %s%08lx\n", Bad_offset, entry.val);
+	printk(KERN_ERR "swap_info_get: %s%08lx\n", Bad_offset, entry.val);
 	goto out;
 bad_device:
-	printk(KERN_ERR "swap_free: %s%08lx\n", Unused_file, entry.val);
+	printk(KERN_ERR "swap_info_get: %s%08lx\n", Unused_file, entry.val);
 	goto out;
 bad_nofile:
-	printk(KERN_ERR "swap_free: %s%08lx\n", Bad_file, entry.val);
+	printk(KERN_ERR "swap_info_get: %s%08lx\n", Bad_file, entry.val);
 out:
 	return NULL;
 }
-- 
1.6.6.1
