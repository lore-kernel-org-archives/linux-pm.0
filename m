From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/8] PM: subsys_data in struct dev_pm_info need
	not depend on RM_RUNTIME
Date: Sat, 11 Jun 2011 22:27:11 +0200
Message-ID: <201106112227.11933.rjw__28681.4595260241$1307824932$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The subsys_data field of struct dev_pm_info, introduced by commit
1d2b71f61b6a10216274e27b717becf9ae101fc7 (PM / Runtime: Add subsystem
data field to struct dev_pm_info), is going to be used even if
CONFIG_PM_RUNTIME is not set, so move it from under the #ifdef.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -460,8 +460,8 @@ struct dev_pm_info {
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
-	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	void			*subsys_data;  /* Owned by the subsystem. */
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
