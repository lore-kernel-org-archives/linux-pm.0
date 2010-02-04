From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Net / pktgen: Fix freezing problem
Date: Thu, 4 Feb 2010 22:50:58 +0100
Message-ID: <201002042250.58944.rjw__23008.201926905$1265325047$gmane$org@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: NetDev <netdev@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ciprian Dorin Craciun <ciprian.craciun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: Net / pktgen: Fix freezing problem

Add missing try_to_freeze() to one of the pktgen_thread_worker() code
paths so that it doesn't block suspend/hibernation.

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=15006

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
---
 net/core/pktgen.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/net/core/pktgen.c
===================================================================
--- linux-2.6.orig/net/core/pktgen.c
+++ linux-2.6/net/core/pktgen.c
@@ -3524,6 +3524,7 @@ static int pktgen_thread_worker(void *ar
 			wait_event_interruptible_timeout(t->queue,
 							 t->control != 0,
 							 HZ/10);
+			try_to_freeze();
 			continue;
 		}
 
