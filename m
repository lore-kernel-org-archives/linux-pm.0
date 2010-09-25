From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 06/22] Hiberation: Fix speed display.
Date: Sat, 25 Sep 2010 14:16:48 +1000
Message-ID: <1285388224-10012-7-git-send-email-nigel__12553.1158330434$1285388378$gmane$org@tuxonice.net>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
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

Correct the situation where, if an error occurs while writing an image,
the speed display still uses the number of pages that should have been
written, rather than the number of pages that were written.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index bebd2cf..2ef2bad 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -489,7 +489,7 @@ static int save_image(struct swap_map_handle *handle,
 		printk(KERN_CONT "\b\b\b\bdone\n");
 	else
 		printk(KERN_CONT "\n");
-	mps = swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+	mps = swsusp_show_speed(&start, &stop, nr_pages, "Wrote");
 	write_speed = (mps < 256) ? (char) mps : 0;
 	return ret;
 }
-- 
1.7.0.4
