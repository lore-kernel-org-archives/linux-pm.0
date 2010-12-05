From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Hibernate: Restore old swap signature to
	avoid user space breakage
Date: Sun, 5 Dec 2010 23:24:30 +0100
Message-ID: <201012052324.30231.rjw__49641.1843029366$1291587997$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 3624eb0 (PM / Hibernate: Modify signature used to mark swap)
modified hibernate signature used to mark swap partitions containing
hibernation images, but that turns out to have caused problems in
libblkid on recent Ubuntu.  Restore the old signature to avoid those
problems.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 kernel/power/swap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -30,7 +30,7 @@
 
 #include "power.h"
 
-#define HIBERNATE_SIG	"LINHIB0001"
+#define HIBERNATE_SIG	"S1SUSPEND"
 
 /*
  *	The swap map is a data structure used for keeping track of each page
