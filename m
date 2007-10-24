From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] kernel/power/disk.c: make code static
Date: Wed, 24 Oct 2007 18:23:42 +0200
Message-ID: <20071024162342.GU30533@stusta.de>
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
To: pavel@suse.cz, rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

resume_file[] and create_image() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 kernel/power/disk.c |    4 ++--
 kernel/power/swap.c |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 8b15f77..cce9b9e 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -26,7 +26,7 @@
 
 
 static int noresume = 0;
-char resume_file[256] = CONFIG_PM_STD_PARTITION;
+static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 
@@ -145,7 +145,7 @@ static void platform_restore_cleanup(int platform_mode)
  *	reappears in this routine after a restore.
  */
 
-int create_image(int platform_mode)
+static int create_image(int platform_mode)
 {
 	int error;
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 917aba1..ef41440 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -28,8 +28,6 @@
 
 #include "power.h"
 
-extern char resume_file[];
-
 #define SWSUSP_SIG	"S1SUSPEND"
 
 struct swsusp_header {
