From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 1/3] plist: add plist_last
Date: Mon, 28 Jun 2010 12:41:25 -0500
Message-ID: <1277746885.10879.197.camel@mulgrave.site>
References: <1277746434.10879.191.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277746434.10879.191.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM <linux-pm@lists.linux-foundation.org>
Cc: Daniel Walker <dwalker@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

plist is currently used by the scheduler, which only needs to know the
highest item in the list.  This adds plist_last which allows you to
find the lowest.  This is necessary for using plists to implement a
fast search of dynamic ranges in pm_qos which can have both highest
and lowest criteria.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 include/linux/plist.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/plist.h b/include/linux/plist.h
index 6898985..7254eda 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -260,6 +260,23 @@ static inline int plist_node_empty(const struct plist_node *node)
 #endif
 
 /**
+ * plist_last_entry - get the struct for the last entry
+ * @head:	the &struct plist_head pointer
+ * @type:	the type of the struct this is embedded in
+ * @member:	the name of the list_struct within the struct
+ */
+#ifdef CONFIG_DEBUG_PI_LIST
+# define plist_last_entry(head, type, member)	\
+({ \
+	WARN_ON(plist_head_empty(head)); \
+	container_of(plist_last(head), type, member); \
+})
+#else
+# define plist_last_entry(head, type, member)	\
+	container_of(plist_last(head), type, member)
+#endif
+
+/**
  * plist_first - return the first node (and thus, highest priority)
  * @head:	the &struct plist_head pointer
  *
@@ -271,4 +288,16 @@ static inline struct plist_node *plist_first(const struct plist_head *head)
 			  struct plist_node, plist.node_list);
 }
 
+/**
+ * plist_last - return the last node (and thus, lowest priority)
+ * @head:	the &struct plist_head pointer
+ *
+ * Assumes the plist is _not_ empty.
+ */
+static inline struct plist_node *plist_last(const struct plist_head *head)
+{
+	return list_entry(head->node_list.prev,
+			  struct plist_node, plist.node_list);
+}
+
 #endif
-- 
1.6.4.2
