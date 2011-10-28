From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 1/2] sunrpc: make rpc_wait_bit_killable handle
	freeze events
Date: Fri, 28 Oct 2011 02:08:31 -0400
Message-ID: <1319782112-15094-1-git-send-email-jlayton__49172.6347514943$1320296207$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, john@calva.com, trond.myklebust@netapp.com, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Allow the wait_on_bit_killable sleeps in SUNRPC layer to respect the
freezer. This should allow suspend and hibernate events to occur, even
when there are RPC's pending on the wire.

Tested-by: John Hughes <john@Calva.COM>
Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 net/sunrpc/sched.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index d12ffa5..09bb64e 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 
 #include <linux/sunrpc/clnt.h>
 
@@ -231,7 +232,8 @@ static int rpc_wait_bit_killable(void *word)
 {
 	if (fatal_signal_pending(current))
 		return -ERESTARTSYS;
-	schedule();
+	if (!try_to_freeze())
+		schedule();
 	return 0;
 }
 
-- 
1.7.6.4
