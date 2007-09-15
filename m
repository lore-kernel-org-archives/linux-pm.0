From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] Hibernation: Resume consoles if
	hibernation_platform_enter fails
Date: Sat, 15 Sep 2007 21:17:39 +0200
Message-ID: <200709152117.40581.rjw__43593.5154011988$1189883230$gmane$org@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[This is a fix on top of
hibernation-enter-platform-hibernation-state-in-a-consistent-way-rev-4.patch]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

If hibernation_platform_enter() fails, consoles should be resumed so that
diagnostic information related to the failure is available to the user.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc6/kernel/power/disk.c
===================================================================
--- linux-2.6.23-rc6.orig/kernel/power/disk.c
+++ linux-2.6.23-rc6/kernel/power/disk.c
@@ -293,7 +293,7 @@ int hibernation_platform_enter(void)
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
 	if (error)
-		return error;
+		goto Resume_console;
 
 	error = hibernation_ops->prepare();
 	if (error)
@@ -320,6 +320,8 @@ int hibernation_platform_enter(void)
 	hibernation_ops->finish();
  Resume_devices:
 	device_resume();
+ Resume_console:
+	resume_console();
 	return error;
 }
 
