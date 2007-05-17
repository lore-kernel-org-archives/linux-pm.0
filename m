From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/4] swsusp: Fix hibernation code ordering
Date: Fri, 18 May 2007 00:26:20 +0200
Message-ID: <200705180026.20647.rjw__19046.6753476814$1179440744$gmane$org@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705180019.35548.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Change the code ordering so that hibernation_ops->prepare() is called after
device_suspend().  This is needed so that we don't violate the ACPI
specification, which states that the _PTS and _GTS system-control methods,
executed from acpi_sleep_prepare(), ought to be called after devices have been
put in low power states.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22-rc1/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc1.orig/kernel/power/disk.c	2007-05-17 22:53:27.000000000 +0200
+++ linux-2.6.22-rc1/kernel/power/disk.c	2007-05-17 22:56:24.000000000 +0200
@@ -135,15 +135,15 @@ int hibernation_snapshot(int platform_mo
 	if (error)
 		goto Finish;
 
-	error = platform_prepare(platform_mode);
-	if (error)
-		goto Finish;
-
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
 		goto Resume_devices;
 
+	error = platform_prepare(platform_mode);
+	if (error)
+		goto Resume_devices;
+
 	error = disable_nonboot_cpus();
 	if (!error) {
 		if (hibernation_mode != HIBERNATION_TEST) {
