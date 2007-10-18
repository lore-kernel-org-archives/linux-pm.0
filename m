From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm] Freezer: Do not allow freezing
	processes to clear TIF_SIGPENDING
Date: Fri, 19 Oct 2007 00:22:35 +0200
Message-ID: <200710190022.36145.rjw__47094.8128299371$1192747463$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Do not allow processes to clear their TIF_SIGPENDING if TIF_FREEZE is set,
to prevent them from racing with the freezer (like mysqld does, for example).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23-mm1/kernel/signal.c
===================================================================
--- linux-2.6.23-mm1.orig/kernel/signal.c
+++ linux-2.6.23-mm1/kernel/signal.c
@@ -124,7 +124,7 @@ void recalc_sigpending_and_wake(struct t
 
 void recalc_sigpending(void)
 {
-	if (!recalc_sigpending_tsk(current))
+	if (!recalc_sigpending_tsk(current) && !freezing(current))
 		clear_thread_flag(TIF_SIGPENDING);
 
 }
