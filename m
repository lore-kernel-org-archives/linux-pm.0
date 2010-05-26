From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: [PATCH 1/5]  Swap iteration functions.
Date: Wed, 26 May 2010 17:09:56 +1000
Message-ID: <4BFCC944.1010104__45193.6917649165$1274857895$gmane$org@crca.org.au>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Add the data structure 'storage_position' and routines that allow
a caller to iterate over swap in sector order. Note that calling
reset_storage_pos only resets the position. next_swapdev_block
must also be called to get the address of the first (and subsequent
sectors).

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
  kernel/power/swap.c |   39 +++++++++++++++++++++++++++++++++++++++
  1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index b0bb217..829f7b4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -86,6 +86,45 @@ struct swsusp_extent {

  static struct rb_root swsusp_extents = RB_ROOT;

+struct storage_position {
+	struct rb_node *node;
+	struct swsusp_extent *cur_ext;
+	unsigned long offset;
+};
+
+static struct storage_position pos;
+
+static void reset_storage_pos(void)
+{
+	pos.node = rb_first(&swsusp_extents);
+
+	if (!pos.node) {
+		pos.cur_ext = NULL;
+		pos.offset = 0;
+		return;
+	}
+
+	pos.cur_ext = container_of(pos.node, struct swsusp_extent, node);
+	pos.offset = pos.cur_ext->start;
+}
+
+static sector_t next_swapdev_block(void)
+{
+	if (!pos.node)
+		return 0;
+
+	if (pos.cur_ext->end >= pos.offset)
+		return pos.offset++;
+
+	pos.node = rb_next(pos.node);
+	if (!pos.node)
+		return 0;
+
+	pos.cur_ext = container_of(pos.node, struct swsusp_extent, node);
+	pos.offset = pos.cur_ext->start;
+	return pos.offset;
+}
+
  static int swsusp_extents_insert(unsigned long swap_offset)
  {
  	struct rb_node **new = &(swsusp_extents.rb_node);
-- 
1.7.0.4
