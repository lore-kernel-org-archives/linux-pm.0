From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/76] thermal_sys: remove unnecessary line
	continuations
Date: Fri, 30 Mar 2012 06:13:17 -0400
Message-ID: <886ee5463530036f6171e1376118e7014cf33f7f.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Joe Perches <joe@perches.com>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Joe Perches <joe@perches.com>

Line continations are not necessary in function calls or statements.
Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Jesper Juhl <jj@chaosbits.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 859b80b..71802ca 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -281,8 +281,7 @@ passive_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
-static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
-		   passive_store);
+static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 
 static struct device_attribute trip_point_attrs[] = {
 	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
@@ -1313,8 +1312,8 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
 	static unsigned int thermal_event_seqnum;
 
 	/* allocate memory */
-	size = nla_total_size(sizeof(struct thermal_genl_event)) + \
-				nla_total_size(0);
+	size = nla_total_size(sizeof(struct thermal_genl_event)) +
+	       nla_total_size(0);
 
 	skb = genlmsg_new(size, GFP_ATOMIC);
 	if (!skb)
@@ -1330,8 +1329,8 @@ int thermal_generate_netlink_event(u32 orig, enum events event)
 	}
 
 	/* fill the data */
-	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT, \
-			sizeof(struct thermal_genl_event));
+	attr = nla_reserve(skb, THERMAL_GENL_ATTR_EVENT,
+			   sizeof(struct thermal_genl_event));
 
 	if (!attr) {
 		nlmsg_free(skb);
-- 
1.7.10.rc2.19.gfae9d
