From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 7/19] TuxOnIce: Modify swsusp bitmaps to allow
	modification during scanning.
Date: Thu,  7 May 2009 00:39:03 +1000
Message-ID: <1241620755-22133-8-git-send-email-nigel__28000.1911953606$1241621855$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

The version of the bitmap code currently in vanilla uses one struct
bm_position only. This prevents code from modifying a bitmap while
iterating through it. Add an extra struct bm_position and use it in
memory_bm_next_pfn so that this is no longer an issue.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/power.h    |    3 +++
 kernel/power/snapshot.c |   13 ++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index ce81df1..4cc59d5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -287,6 +287,9 @@ struct memory_bitmap {
 					 * objects
 					 */
 	struct bm_position cur;		/* most recently used bit position */
+	struct bm_position iter;	/* most recently used bit position
+					 * when iterating over a bitmap.
+					 */
 };
 
 extern int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 8020644..786227c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -234,6 +234,9 @@ void memory_bm_position_reset(struct memory_bitmap *bm)
 {
 	bm->cur.block = list_entry(bm->blocks.next, struct bm_block, hook);
 	bm->cur.bit = 0;
+
+	bm->iter.block = list_entry(bm->blocks.next, struct bm_block, hook);
+	bm->iter.bit = 0;
 }
 
 /**
@@ -519,23 +522,23 @@ unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
 	struct bm_block *bb;
 	int bit;
 
-	bb = bm->cur.block;
+	bb = bm->iter.block;
 	do {
-		bit = bm->cur.bit;
+		bit = bm->iter.bit;
 		bit = find_next_bit(bb->data, bm_block_bits(bb), bit);
 		if (bit < bm_block_bits(bb))
 			goto Return_pfn;
 
 		bb = list_entry(bb->hook.next, struct bm_block, hook);
-		bm->cur.block = bb;
-		bm->cur.bit = 0;
+		bm->iter.block = bb;
+		bm->iter.bit = 0;
 	} while (&bb->hook != &bm->blocks);
 
 	memory_bm_position_reset(bm);
 	return BM_END_OF_MAP;
 
  Return_pfn:
-	bm->cur.bit = bit + 1;
+	bm->iter.bit = bit + 1;
 	return bb->start_pfn + bit;
 }
 
-- 
1.5.6.3
