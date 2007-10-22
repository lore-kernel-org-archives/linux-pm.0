From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hibernate fails to freeze tasks
Date: Tue, 23 Oct 2007 00:36:37 +0200
Message-ID: <200710230036.37838.rjw@sisk.pl>
References: <1193062945.9793.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1193062945.9793.15.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 22 October 2007 16:22, Johannes Berg wrote:
> On my quad powermac, with a current git snapshot, hibernating fails to
> freeze tasks and then dumps me a snapshot of the tasks. I've uploaded it
> here because it's so long:
> http://johannes.sipsolutions.net/files/quad-syslog-hibernate-fails
> 
> Haven't found time to look into it yet, any ideas are appreciated.

Please try the patch below.

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Do not allow processes to clear their TIF_SIGPENDING if TIF_FREEZE is set,
so that they will not race with the freezer (like mysqld, for example).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23/kernel/signal.c
===================================================================
--- linux-2.6.23.orig/kernel/signal.c
+++ linux-2.6.23/kernel/signal.c
@@ -124,7 +124,7 @@ void recalc_sigpending_and_wake(struct t
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current))
+	if (!recalc_sigpending_tsk(current) && !freezing(current))
 		clear_thread_flag(TIF_SIGPENDING);
 
 }
