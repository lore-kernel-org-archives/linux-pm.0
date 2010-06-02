From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 03/21] Hibernation: Add mass swap allocation
	routine
Date: Wed,  2 Jun 2010 22:19:02 +1000
Message-ID: <1275481160-31150-4-git-send-email-nigel__9062.05512951619$1275481247$gmane$org@tuxonice.net>
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

Add a routine to allocate swap from a device en masse. This is only
for use by the in-kernel implementation, not uswsusp.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e555b6c..550c1ed 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -187,6 +187,19 @@ sector_t alloc_swapdev_block(int swap)
 	return 0;
 }
 
+int alloc_swapdev_blocks(int needed)
+{
+	int i;
+
+	for (i = 0; i < needed; i++) {
+		sector_t res = alloc_swapdev_block(root_swap);
+		if (!res)
+			break;
+	}
+
+	return i;
+}
+
 /**
  *	free_all_swap_pages - free swap pages allocated for saving image data.
  *	It also frees the extents used to register which swap entres had been
-- 
1.7.0.4
