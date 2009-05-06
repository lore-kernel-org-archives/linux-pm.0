From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 19/19] TuxOnIce: Don't try to wake kswapd if the
	freezer is on.
Date: Thu,  7 May 2009 00:39:15 +1000
Message-ID: <1241620755-22133-20-git-send-email-nigel__4326.35151451013$1241622114$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

If a process gets into wakeup_kswapd while other processes are frozen,
we don't want it to actually wake kswapd (memory pressure may be caused
by TuxOnIce trying to free memory).

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 mm/vmscan.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5fa3eda..ae44189 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2034,6 +2034,9 @@ void wakeup_kswapd(struct zone *zone, int order)
 	if (!populated_zone(zone))
 		return;
 
+	if (freezer_is_on())
+		return;
+
 	pgdat = zone->zone_pgdat;
 	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0))
 		return;
-- 
1.5.6.3
