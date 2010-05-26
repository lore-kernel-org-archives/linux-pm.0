From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: [PATCH 5/5] Hiberation: Fix speed display
Date: Wed, 26 May 2010 17:10:14 +1000
Message-ID: <4BFCC956.1070205__24198.3843771324$1274857900$gmane$org@crca.org.au>
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

Correct the situation where, if an error occurs while writing an image,
the speed display still uses the number of pages that should have been
written, rather than the number of pages that were written.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
  kernel/power/swap.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ff2fc15..1e6e5b6 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -485,7 +485,7 @@ static int save_image(struct swap_map_handle *handle,
  		printk(KERN_CONT "\b\b\b\bdone\n");
  	else
  		printk(KERN_CONT "\n");
-	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+	swsusp_show_speed(&start, &stop, nr_pages, "Wrote");
  	return ret;
  }

-- 
1.7.0.4
