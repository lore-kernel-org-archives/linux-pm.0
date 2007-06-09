From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/2] PM: Remove saved_state from dev_pm_info
Date: Sat, 9 Jun 2007 23:32:05 +0200
Message-ID: <200706092332.06553.rjw@sisk.pl>
References: <200706092329.08166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706092329.08166.rjw@sisk.pl>
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
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The saved_state member of struct dev_pm_info, defined in include/linux/pm.h, is
not used anywhere, so it can be removed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/pm.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.22-rc4/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc4.orig/include/linux/pm.h	2007-06-09 21:12:45.000000000 +0200
+++ linux-2.6.22-rc4/include/linux/pm.h	2007-06-09 22:26:13.000000000 +0200
@@ -236,7 +236,6 @@ struct dev_pm_info {
 #ifdef	CONFIG_PM
 	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
-	void			* saved_state;
 	struct list_head	entry;
 #endif
 };
