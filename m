From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PM / QoS: mark expected switch fall-throughs
Date: Fri, 30 Mar 2018 16:18:44 -0500
Message-ID: <20180330211844.GA23072@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 kernel/power/qos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 9d75039..fa39092 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -295,6 +295,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 		 * changed
 		 */
 		plist_del(node, &c->list);
+		/* fall through */
 	case PM_QOS_ADD_REQ:
 		plist_node_init(node, new_value);
 		plist_add(node, &c->list);
@@ -367,6 +368,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 		break;
 	case PM_QOS_UPDATE_REQ:
 		pm_qos_flags_remove_req(pqf, req);
+		/* fall through */
 	case PM_QOS_ADD_REQ:
 		req->flags = val;
 		INIT_LIST_HEAD(&req->node);
-- 
2.7.4
