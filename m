From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 19/21] Hibernation: Prepare for handle.cur removal
Date: Wed,  2 Jun 2010 22:19:18 +1000
Message-ID: <1275481160-31150-20-git-send-email-nigel__42690.5646840625$1275482616$gmane$org@tuxonice.net>
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

Prepare for the removal of handle.cur by stopping using
it in get_swap_reader.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index c71c7c3..dd71ef2 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -276,29 +276,29 @@ int get_swap_reader(unsigned int *flags_p, sector_t first_page)
 	if (!handle.cur)
 		return -ENOMEM;
 
-	error = hib_bio_read_page(first_page, handle.cur, 1);
+	error = hib_prepare_buffer();
 	if (error) {
 		release_swap_reader();
 		return error;
 	}
 
-	error = hib_prepare_buffer();
+	/* Bootstrap reading the extents */
+	error = hib_bio_read_page(first_page, hib_ppio_buffer, 1);
 	if (error) {
 		release_swap_reader();
+		hib_free_buffer();
 		return error;
 	}
 
 	handle.k = 0;
 
-	/* Bootstrap reading the extents */
-	memcpy(hib_ppio_buffer, handle.cur, PAGE_SIZE);
 	error = hib_extents_load(&sector_extents, 1);
 
 	if (error) {
 		release_swap_reader();
-		return error;
 	}
 
+	hib_free_buffer();
 	return error;
 }
 
-- 
1.7.0.4
