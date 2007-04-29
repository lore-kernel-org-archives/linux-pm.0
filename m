From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Sun, 29 Apr 2007 18:32:15 +0200
Message-ID: <200704291832.15959.rjw@sisk.pl>
References: <f129n6$mro$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f129n6$mro$1@sea.gmane.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm@lists.osdl.org, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 29 April 2007 16:22, Marcus Better wrote:
> Hi,
> 
> suspend-to-disk isn't working well anymore on my Thinkpad R60 with Intel
> Core 2 Duo and kernel 2.6.21 (x86_64). It's a Debian system with uswsusp
> 0.6~cvs20070202-1, and I'm using s2disk. I believe it was quite stable
> around 2.6.20. 
> 
> It does succeed sometimes, but often it fails at suspend. Several times it
> hung at "snapshotting system" with the sleep LED blinking. Once it just
> rebooted at that point. Sometimes it suspends correctly but the image is
> not recognized at boot.
> 
> I don't know if this is similar to any of the previously listed regressions,
> it's a bit daunting to wade through all the suspend-related threads...

We have some suspend regressions on Thinkpads reported, but I think they
are different to what you describe.

Can you please apply the appended patch and see if that helps?

Rafael

---
 kernel/power/disk.c |    4 ++--
 kernel/power/user.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.21-rc7/kernel/power/disk.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/disk.c
+++ linux-2.6.21-rc7/kernel/power/disk.c
@@ -170,9 +170,9 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
+		platform_finish();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -189,9 +189,9 @@ int pm_suspend_disk(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
 	device_resume();
 	resume_console();
+	platform_finish();
  Thaw:
 	unprepare_processes();
  Finish:
Index: linux-2.6.21-rc7/kernel/power/user.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/user.c
+++ linux-2.6.21-rc7/kernel/power/user.c
@@ -170,11 +170,11 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -202,11 +202,11 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
