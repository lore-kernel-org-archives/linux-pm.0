From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make kernel/power/main.c:suspend_enter()
	static
Date: Tue, 14 Aug 2007 23:26:26 +0200
Message-ID: <20070814212626.GB18945__35175.8027835332$1187130801$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Andrew Morton <akpm@linux-foundation.org>, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

suspend_enter() can now become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch has been sent on:
- 29 Jul 2007

--- linux-2.6.23-rc1-mm1/kernel/power/main.c.old	2007-07-26 14:49:44.000000000 +0200
+++ linux-2.6.23-rc1-mm1/kernel/power/main.c	2007-07-26 14:50:05.000000000 +0200
@@ -120,7 +120,7 @@
  *
  *	This function should be called after devices have been suspended.
  */
-int suspend_enter(suspend_state_t state)
+static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 
