From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: [PATCH 1/2] Move swap functions to kernel/power/swap.c.
Date: Mon, 28 Sep 2009 14:09:29 +1000
Message-ID: <4AC036F9.5000003__10626.3677975678$1254111287$gmane$org@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rafael Wysocki <rjw@sisk.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Move hibernation code's functions for allocating and freeing swap
from swsusp.c to swap.c, which is where you'd expect to find them.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c   |  101 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c |  101 -------------------------------------------------
 2 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 8ba052c..ce2d8a7 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -39,6 +39,107 @@ struct swsusp_header {
 
 static struct swsusp_header *swsusp_header;
 
+/**
+ *	The following functions are used for tracing the allocated
+ *	swap pages, so that they can be freed in case of an error.
+ */
+
+struct swsusp_extent {
+	struct rb_node node;
+	unsigned long start;
+	unsigned long end;
+};
+
+static struct rb_root swsusp_extents = RB_ROOT;
+
+static int swsusp_extents_insert(unsigned long swap_offset)
+{
+	struct rb_node **new = &(swsusp_extents.rb_node);
+	struct rb_node *parent = NULL;
+	struct swsusp_extent *ext;
+
+	/* Figure out where to put the new node */
+	while (*new) {
+		ext = container_of(*new, struct swsusp_extent, node);
+		parent = *new;
+		if (swap_offset < ext->start) {
+			/* Try to merge */
+			if (swap_offset == ext->start - 1) {
+				ext->start--;
+				return 0;
+			}
+			new = &((*new)->rb_left);
+		} else if (swap_offset > ext->end) {
+			/* Try to merge */
+			if (swap_offset == ext->end + 1) {
+				ext->end++;
+				return 0;
+			}
+			new = &((*new)->rb_right);
+		} else {
+			/* It already is in the tree */
+			return -EINVAL;
+		}
+	}
+	/* Add the new node and rebalance the tree. */
+	ext = kzalloc(sizeof(struct swsusp_extent), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	ext->start = swap_offset;
+	ext->end = swap_offset;
+	rb_link_node(&ext->node, parent, new);
+	rb_insert_color(&ext->node, &swsusp_extents);
+	return 0;
+}
+
+/**
+ *	alloc_swapdev_block - allocate a swap page and register that it has
+ *	been allocated, so that it can be freed in case of an error.
+ */
+
+sector_t alloc_swapdev_block(int swap)
+{
+	unsigned long offset;
+
+	offset = swp_offset(get_swap_page_of_type(swap));
+	if (offset) {
+		if (swsusp_extents_insert(offset))
+			swap_free(swp_entry(swap, offset));
+		else
+			return swapdev_block(swap, offset);
+	}
+	return 0;
+}
+
+/**
+ *	free_all_swap_pages - free swap pages allocated for saving image data.
+ *	It also frees the extents used to register which swap entres had been
+ *	allocated.
+ */
+
+void free_all_swap_pages(int swap)
+{
+	struct rb_node *node;
+
+	while ((node = swsusp_extents.rb_node)) {
+		struct swsusp_extent *ext;
+		unsigned long offset;
+
+		ext = container_of(node, struct swsusp_extent, node);
+		rb_erase(node, &swsusp_extents);
+		for (offset = ext->start; offset <= ext->end; offset++)
+			swap_free(swp_entry(swap, offset));
+
+		kfree(ext);
+	}
+}
+
+int swsusp_swap_in_use(void)
+{
+	return (swsusp_extents.rb_node != NULL);
+}
+
 /*
  * General things
  */
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 6a07f4d..57222d2 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -58,107 +58,6 @@
 int in_suspend __nosavedata = 0;
 
 /**
- *	The following functions are used for tracing the allocated
- *	swap pages, so that they can be freed in case of an error.
- */
-
-struct swsusp_extent {
-	struct rb_node node;
-	unsigned long start;
-	unsigned long end;
-};
-
-static struct rb_root swsusp_extents = RB_ROOT;
-
-static int swsusp_extents_insert(unsigned long swap_offset)
-{
-	struct rb_node **new = &(swsusp_extents.rb_node);
-	struct rb_node *parent = NULL;
-	struct swsusp_extent *ext;
-
-	/* Figure out where to put the new node */
-	while (*new) {
-		ext = container_of(*new, struct swsusp_extent, node);
-		parent = *new;
-		if (swap_offset < ext->start) {
-			/* Try to merge */
-			if (swap_offset == ext->start - 1) {
-				ext->start--;
-				return 0;
-			}
-			new = &((*new)->rb_left);
-		} else if (swap_offset > ext->end) {
-			/* Try to merge */
-			if (swap_offset == ext->end + 1) {
-				ext->end++;
-				return 0;
-			}
-			new = &((*new)->rb_right);
-		} else {
-			/* It already is in the tree */
-			return -EINVAL;
-		}
-	}
-	/* Add the new node and rebalance the tree. */
-	ext = kzalloc(sizeof(struct swsusp_extent), GFP_KERNEL);
-	if (!ext)
-		return -ENOMEM;
-
-	ext->start = swap_offset;
-	ext->end = swap_offset;
-	rb_link_node(&ext->node, parent, new);
-	rb_insert_color(&ext->node, &swsusp_extents);
-	return 0;
-}
-
-/**
- *	alloc_swapdev_block - allocate a swap page and register that it has
- *	been allocated, so that it can be freed in case of an error.
- */
-
-sector_t alloc_swapdev_block(int swap)
-{
-	unsigned long offset;
-
-	offset = swp_offset(get_swap_page_of_type(swap));
-	if (offset) {
-		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
-		else
-			return swapdev_block(swap, offset);
-	}
-	return 0;
-}
-
-/**
- *	free_all_swap_pages - free swap pages allocated for saving image data.
- *	It also frees the extents used to register which swap entres had been
- *	allocated.
- */
-
-void free_all_swap_pages(int swap)
-{
-	struct rb_node *node;
-
-	while ((node = swsusp_extents.rb_node)) {
-		struct swsusp_extent *ext;
-		unsigned long offset;
-
-		ext = container_of(node, struct swsusp_extent, node);
-		rb_erase(node, &swsusp_extents);
-		for (offset = ext->start; offset <= ext->end; offset++)
-			swap_free(swp_entry(swap, offset));
-
-		kfree(ext);
-	}
-}
-
-int swsusp_swap_in_use(void)
-{
-	return (swsusp_extents.rb_node != NULL);
-}
-
-/**
  *	swsusp_show_speed - print the time elapsed between two events represented by
  *	@start and @stop
  *
-- 
1.6.3.3
