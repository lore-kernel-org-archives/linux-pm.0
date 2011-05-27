From: Ankita Garg <ankita@in.ibm.com>
Subject: [PATCH 06/10] mm: Verify zonelists
Date: Fri, 27 May 2011 18:01:34 +0530
Message-ID: <1306499498-14263-7-git-send-email-ankita__26852.0647463903$1306508234$gmane$org@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: thomas.abraham@linaro.org, ankita@in.ibm.com
List-Id: linux-pm@vger.kernel.org

Verify that the zonelists were created appropriately. Below is the output in
the dmesg for the verification of creation of zonelists. 4 regions, each of
size 512MB were created on the Samsung Orion/Exynos board (board has 2G RAM).

The regions were created as follows:

created region 0 in nid 0 start pfn 262144 spanned pages 131072
created region 1 in nid 0 start pfn 393216 spanned pages 131072
created region 2 in nid 0 start pfn 524288 spanned pages 131072
created region 3 in nid 0 start pfn 655360 spanned pages 57344

mminit::zonelist general 0:Normal = 0:Normal 0:Normal 0:Normal 0:Normal
mminit::zonelist general 0:Normal = 0:Normal 0:Normal 0:Normal 0:Normal
mminit::zonelist general 0:Normal = 0:Normal 0:Normal 0:Normal 0:Normal
mminit::zonelist general 0:Normal = 0:Normal 0:Normal 0:Normal 0:Normal

Since now 4 zones are present inside a node, the above shows 4 zonelists
being created.

Signed-off-by: Ankita Garg <ankita@in.ibm.com>
---
 mm/mm_init.c |   51 +++++++++++++++++++++++++++------------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4e0e265..77468f8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -21,44 +21,47 @@ int mminit_loglevel;
 /* The zonelists are simply reported, validation is manual. */
 void mminit_verify_zonelist(void)
 {
-	int nid;
+	int nid, p;
 
 	if (mminit_loglevel < MMINIT_VERIFY)
 		return;
 
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
-		struct zone *zone;
-		struct zoneref *z;
-		struct zonelist *zonelist;
-		int i, listid, zoneid;
-
-		BUG_ON(MAX_ZONELISTS > 2);
-		for (i = 0; i < MAX_ZONELISTS * MAX_NR_ZONES; i++) {
-
-			/* Identify the zone and nodelist */
-			zoneid = i % MAX_NR_ZONES;
-			listid = i / MAX_NR_ZONES;
-			zonelist = &pgdat->node_zonelists[listid];
-			zone = &pgdat->node_zones[zoneid];
-			if (!populated_zone(zone))
-				continue;
-
-			/* Print information about the zonelist */
-			printk(KERN_DEBUG "mminit::zonelist %s %d:%s = ",
-				listid > 0 ? "thisnode" : "general", nid,
-				zone->name);
-
-			/* Iterate the zonelist */
-			for_each_zone_zonelist(zone, z, zonelist, zoneid) {
+		for_each_mem_region_in_nid(p, nid) {
+			mem_region_t *mem_region = &(NODE_DATA(nid)->mem_regions[p]);
+			struct zone *zone;
+			struct zoneref *z;
+			struct zonelist *zonelist;
+			int i, listid, zoneid;
+
+			BUG_ON(MAX_ZONELISTS > 2);
+			for (i = 0; i < MAX_ZONELISTS * MAX_NR_ZONES; i++) {
+
+				/* Identify the zone and nodelist */
+				zoneid = i % MAX_NR_ZONES;
+				listid = i / MAX_NR_ZONES;
+				zonelist = &pgdat->node_zonelists[listid];
+				zone = &mem_region->zones[zoneid];
+				if (!populated_zone(zone))
+					continue;
+
+				/* Print information about the zonelist */
+				printk(KERN_DEBUG "mminit::zonelist %s %d:%s = ",
+					listid > 0 ? "thisnode" : "general", nid,
+					zone->name);
+
+				/* Iterate the zonelist */
+				for_each_zone_zonelist(zone, z, zonelist, zoneid) {
 #ifdef CONFIG_NUMA
-				printk(KERN_CONT "%d:%s ",
-					zone->node, zone->name);
+					printk(KERN_CONT "%d:%s ",
+						zone->node, zone->name);
 #else
-				printk(KERN_CONT "0:%s ", zone->name);
+					printk(KERN_CONT "0:%s ", zone->name);
 #endif /* CONFIG_NUMA */
+				}
+				printk(KERN_CONT "\n");
 			}
-			printk(KERN_CONT "\n");
 		}
 	}
 }
-- 
1.7.4
