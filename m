From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] kernel/power/swap.c: fix typos in comments
Date: Wed, 26 May 2010 21:49:00 -0300
Message-ID: <1274921340-4894-1-git-send-email-cesarb__20633.4460796372$1274973743$gmane$org@cesarb.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, Cesar Eduardo Barros <cesarb@cesarb.net>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 kernel/power/swap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 66824d7..5846a02 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -114,7 +114,7 @@ sector_t alloc_swapdev_block(int swap)
 
 /**
  *	free_all_swap_pages - free swap pages allocated for saving image data.
- *	It also frees the extents used to register which swap entres had been
+ *	It also frees the extents used to register which swap entries had been
  *	allocated.
  */
 
@@ -315,7 +315,7 @@ static int write_page(void *buf, sector_t offset, struct bio **bio_chain)
 /*
  *	The swap map is a data structure used for keeping track of each page
  *	written to a swap partition.  It consists of many swap_map_page
- *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	structures that contain each an array of MAP_PAGE_ENTRIES swap entries.
  *	These structures are stored on the swap and linked together with the
  *	help of the .next_swap member.
  *
-- 
1.6.6.1
