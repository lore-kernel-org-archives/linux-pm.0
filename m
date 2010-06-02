From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 15/21] Remove first_sector from swap_map_handle
Date: Wed,  2 Jun 2010 22:19:14 +1000
Message-ID: <1275481160-31150-16-git-send-email-nigel__38295.9105809734$1275482582$gmane$org@tuxonice.net>
References: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Remove the 'first_sector' variable from the swap_map_handle
struct. It will continue to be used whereas the other members
of the struct will be deleted in a following patch.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index 6745e77..9028f74 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -140,10 +140,10 @@ struct swap_map_page {
 struct swap_map_handle {
 	struct swap_map_page *cur;
 	sector_t cur_swap;
-	sector_t first_sector;
 	unsigned int k;
 };
 
+static sector_t first_sector;
 static struct swap_map_handle handle;
 
 extern struct hib_extent_state sector_extents;
@@ -159,7 +159,7 @@ unsigned int hib_bio_overhead(unsigned int nr_pages)
 /* Get the first sector of the image proper, for storing in the signature */
 sector_t hib_get_first_sector(void)
 {
-	return handle.first_sector;
+	return first_sector;
 }
 
 /**
@@ -213,7 +213,7 @@ int hib_bio_prepare_write(void)
 		return result;
 	}
 
-	handle.first_sector = hib_extent_current(&sector_extents);
+	first_sector = hib_extent_current(&sector_extents);
 
 	result = hib_extents_store(&sector_extents);
 	result2 = hib_flush_write_buffer();
-- 
1.7.0.4
