From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] kernel/power/disk.c: make code static
Date: Tue, 5 Jun 2007 23:50:49 +0200
Message-ID: <20070605215049.GI5500@stusta.de>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070530235823.793f00d9.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 30, 2007 at 11:58:23PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.22-rc2-mm1:
>...
> +swsusp-remove-code-duplication-between-diskc-and-userc.patch
>...
>  freezer/swsusp updates
>...

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/power/disk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.22-rc3-mm1/kernel/power/disk.c.old	2007-06-05 22:12:07.000000000 +0200
+++ linux-2.6.22-rc3-mm1/kernel/power/disk.c	2007-06-05 22:13:37.000000000 +0200
@@ -45,7 +45,7 @@
 
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
-struct hibernation_ops *hibernation_ops;
+static struct hibernation_ops *hibernation_ops;
 
 /**
  * hibernation_set_ops - set the global hibernate operations
@@ -231,7 +231,7 @@
  *	to power off or reboot.
  */
 
-void power_down(void)
+static void power_down(void)
 {
 	switch (hibernation_mode) {
 	case HIBERNATION_TEST:
