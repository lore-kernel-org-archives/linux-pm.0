From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PM: rwsem.h need not be included into main.c
Date: Sun, 13 Dec 2009 23:09:32 +0100
Message-ID: <200912132309.33054.rjw__7094.70943916148$1260742230$gmane$org@sisk.pl>
References: <200912132306.57741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912132306.57741.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It is not necessary to include <linux/rwsem.h> into
drivers/base/power/main.c, so don't do that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -23,7 +23,6 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/resume-trace.h>
-#include <linux/rwsem.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 
