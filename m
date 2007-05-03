From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Thu, 3 May 2007 10:06:26 +0200
Message-ID: <200705031006.27068.rjw@sisk.pl>
References: <f129n6$mro$1@sea.gmane.org> <200704301621.11826.rjw@sisk.pl>
	<200705021341.32454.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705021341.32454.marcus@better.se>
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
To: Marcus Better <marcus@better.se>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 May 2007 13:41, Marcus Better wrote:
> Rafael J. Wysocki wrote:
> > OK, so please run with it applied for a while to make sure it helps.
> 
> I have tested some more, and it seems to work. There was only the one reboot 
> during writing that happened on my first attempt, but it hasn't happened 
> since then.

Could you please test the appended patch instead of the previous one?

Rafael

---
 kernel/power/disk.c |    4 +++-
 kernel/power/user.c |   15 +++------------
 2 files changed, 6 insertions(+), 13 deletions(-)

Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c	2007-05-02 22:09:55.000000000 +0200
+++ linux-2.6.21/kernel/power/disk.c	2007-05-02 22:18:06.000000000 +0200
@@ -215,7 +215,9 @@ int hibernate(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
+	if (error)
+		platform_finish();
+
 	device_resume();
 	resume_console();
  Thaw:
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-02 22:09:55.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-02 22:18:06.000000000 +0200
@@ -169,7 +169,7 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
+	if (platform_suspend && (!in_suspend || error))
 		platform_finish();
 
 	device_resume();
@@ -179,17 +179,12 @@ static inline int snapshot_suspend(int p
 	return error;
 }
 
-static inline int snapshot_restore(int platform_suspend)
+static inline int snapshot_restore(void)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
@@ -201,12 +196,8 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
 	device_resume();
 	resume_console();
- Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore(data->platform_suspend);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:
