From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 04/23] Hibernation: Move root_swap declaration.
Date: Mon, 27 Sep 2010 15:43:39 +1000
Message-ID: <1285566238-10966-5-git-send-email-nigel__2721.41999234936$1285566345$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
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
index 4e5f6e3..25090ed 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -44,6 +44,8 @@ struct swap_map_page {
 	sector_t next_swap;
 };
 
+static unsigned short root_swap = 0xffff;
+
 struct swsusp_header {
 	char reserved[PAGE_SIZE - 21 - sizeof(sector_t) - sizeof(int)];
 	char write_speed;
@@ -199,7 +201,6 @@ int swsusp_swap_in_use(void)
  * General things
  */
 
-static unsigned short root_swap = 0xffff;
 struct block_device *hib_resume_bdev;
 char __nosavedata write_speed, read_speed;
 
-- 
1.7.0.4
