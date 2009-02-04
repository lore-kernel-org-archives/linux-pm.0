From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH] Fix pm_notifiers during user mode hibernation
Date: Wed, 04 Feb 2009 12:15:37 +0300
Message-ID: <20090204091509.9383.43143.stgit__14467.7134034739$1233739237$gmane$org@cooker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Snapshot device is opened with O_RDONLY during suspend and
O_WRONLY durig resume. Make sure we also call notifiers with
correct parameter telling them what we are really doing.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

---

 kernel/power/user.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 005b93d..6c85359 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -95,15 +95,15 @@ static int snapshot_open(struct inode *inode, struct file *filp)
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
