From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 14/21] Hibernation: Use block extents for reading
	image
Date: Wed,  2 Jun 2010 22:19:13 +1000
Message-ID: <1275481160-31150-15-git-send-email-nigel__46674.8010986068$1275482626$gmane$org@tuxonice.net>
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

Switch from using swap map pages to using block extents for
knowing where the next page needs to be read from.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index 7fabb0c..6745e77 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -332,7 +332,7 @@ int swap_read_page(void *buf, int sync)
 
 	if (!handle.cur)
 		return -EINVAL;
-	offset = handle.cur->entries[handle.k];
+	offset = hib_extent_next(&sector_extents);
 	if (!offset)
 		return -EFAULT;
 	error = hib_bio_read_page(offset, buf, sync);
@@ -341,7 +341,7 @@ int swap_read_page(void *buf, int sync)
 	if (++handle.k >= MAP_PAGE_ENTRIES) {
 		error = hib_wait_on_bio_chain();
 		handle.k = 0;
-		offset = handle.cur->next_swap;
+		offset = hib_extent_next(&sector_extents);
 		if (!offset)
 			release_swap_reader();
 		else if (!error)
-- 
1.7.0.4
