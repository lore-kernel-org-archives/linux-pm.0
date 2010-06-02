From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 02/21] Hibernation: Move root_swap declaration.
Date: Wed,  2 Jun 2010 22:19:01 +1000
Message-ID: <1275481160-31150-3-git-send-email-nigel__46030.9795490049$1275481248$gmane$org@tuxonice.net>
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
