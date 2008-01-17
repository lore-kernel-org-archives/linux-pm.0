From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: [PATCH] (2.4.25 material?) Fix unbalanced helper_lock in
	kernel/kmod.c
Date: Thu, 17 Jan 2008 11:29:47 +1100
Message-ID: <478EA17B.30601__23062.2094627053$1200529899$gmane$org@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010902060709000307020500"
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
To: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902060709000307020500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all.

First up, sorry for not inlining the patch - trouble with line wrapping.

In 2.6.24-rc8, call_usermodehelper_exec has an exit path that can leave
the helper_lock() call at the top of the routine unbalanced. The
attached patch fixes this issue.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>




--------------010902060709000307020500
Content-Type: text/x-patch;
 name="helper-lock-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="helper-lock-fix.patch"

diff --git a/kernel/kmod.c b/kernel/kmod.c
index c6a4f8a..de27e15 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -468,8 +468,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info,
 	sub_info->wait = wait;
 
 	queue_work(khelper_wq, &sub_info->work);
-	if (wait == UMH_NO_WAIT) /* task has freed sub_info */
+	if (wait == UMH_NO_WAIT) { /* task has freed sub_info */
+		helper_unlock();
 		return 0;
+	}
 	wait_for_completion(&done);
 	retval = sub_info->retval;
 


--------------010902060709000307020500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010902060709000307020500--
