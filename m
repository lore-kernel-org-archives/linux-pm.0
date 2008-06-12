From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/4] Remove definition of struct pm_dev
Date: Thu, 12 Jun 2008 10:30:25 +0200
Message-ID: <200806121030.26099.rjw__19418.9230482609$1213260194$gmane$org@sisk.pl>
References: <200806121025.24668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806121025.24668.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the definition of 'struct pm_dev', which is not used any more,
along with some related stuff from include/linux/pm.h .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pm.h |   24 ------------------------
 1 file changed, 24 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -68,30 +68,6 @@ enum
  */
 #define PM_PCI_ID(dev) ((dev)->bus->number << 16 | (dev)->devfn)
 
-/*
- * Request handler callback
- */
-struct pm_dev;
-
-typedef int (*pm_callback)(struct pm_dev *dev, pm_request_t rqst, void *data);
-
-/*
- * Dynamic device information
- */
-struct pm_dev
-{
-	pm_dev_t	 type;
-	unsigned long	 id;
-	pm_callback	 callback;
-	void		*data;
-
-	unsigned long	 flags;
-	unsigned long	 state;
-	unsigned long	 prev_state;
-
-	struct list_head entry;
-};
-
 /* Functions above this comment are list-based old-style power
  * management. Please avoid using them.  */
 
