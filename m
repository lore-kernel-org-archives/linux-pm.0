From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: [PATCH 2/5]  Move root swap declaration.
Date: Wed, 26 May 2010 17:10:00 +1000
Message-ID: <4BFCC948.8010603__38914.5431494855$1274857901$gmane$org@crca.org.au>
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

Move the declaration of root_swap in preparation for the
next patch.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
  kernel/power/swap.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 829f7b4..e555b6c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -63,6 +63,8 @@ struct swap_map_handle {
  	unsigned int k;
  };

+static unsigned short root_swap = 0xffff;
+
  struct swsusp_header {
  	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int)];
  	sector_t image;
@@ -217,7 +219,6 @@ int swsusp_swap_in_use(void)
   * General things
   */

-static unsigned short root_swap = 0xffff;
  struct block_device *hib_resume_bdev;

  /*
-- 
1.7.0.4
