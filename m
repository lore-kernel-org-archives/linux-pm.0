From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/9] PM: Fix pm_notifiers during user mode
	hibernation
Date: Sat, 14 Feb 2009 02:05:14 +0100
Message-ID: <200902140205.16278.rjw__47321.9367828735$1234575968$gmane$org@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Andrey Borzenkov <arvidjaar@mail.ru>

Snapshot device is opened with O_RDONLY during suspend and O_WRONLY durig
resume.  Make sure we also call notifiers with correct parameter telling
them what we are really doing.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---

 kernel/power/user.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -95,15 +95,15 @@ static int snapshot_open(struct inode *i
 		data->swap = swsusp_resume_device ?
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
-		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 		if (error)
-			pm_notifier_call_chain(PM_POST_RESTORE);
+			pm_notifier_call_chain(PM_POST_HIBERNATION);
 	} else {
 		data->swap = -1;
 		data->mode = O_WRONLY;
-		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
+		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 		if (error)
-			pm_notifier_call_chain(PM_POST_HIBERNATION);
+			pm_notifier_call_chain(PM_POST_RESTORE);
 	}
 	if (error)
 		atomic_inc(&snapshot_device_available);
