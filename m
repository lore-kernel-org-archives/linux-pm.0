From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] Freezer: Remove redundant check in
	try_to_freeze_tasks
Date: Sat, 26 May 2007 23:29:07 +0200
Message-ID: <200705262329.07758.rjw@sisk.pl>
References: <200705262317.48604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705262317.48604.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

We don't need to check if todo is positive before calling time_after() in
try_to_freeze_tasks(), because if todo is zero at this point, the loop will
be broken anyway due to the while () condition being false.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22-rc2/kernel/power/process.c
===================================================================
--- linux-2.6.22-rc2.orig/kernel/power/process.c
+++ linux-2.6.22-rc2/kernel/power/process.c
@@ -149,7 +149,7 @@ static int try_to_freeze_tasks(int freez
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, end_time))
+		if (time_after(jiffies, end_time))
 			break;
 	} while (todo);
 
