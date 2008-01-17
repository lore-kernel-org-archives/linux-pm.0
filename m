From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] (2.4.25 material?) Fix unbalanced
	helper_lock in kernel/kmod.c
Date: Thu, 17 Jan 2008 19:02:43 +0100
Message-ID: <200801171902.44133.rjw__40819.9667501778$1200593000$gmane$org@sisk.pl>
References: <478EA17B.30601@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <478EA17B.30601@nigel.suspend2.net>
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
To: nigel@nigel.suspend2.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 17 of January 2008, Nigel Cunningham wrote:
> Hi all.

Hi,

> First up, sorry for not inlining the patch - trouble with line wrapping.

No big deal.

> In 2.6.24-rc8, call_usermodehelper_exec has an exit path that can leave
> the helper_lock() call at the top of the routine unbalanced. The
> attached patch fixes this issue.

Thanks a lot for the patch (reproduced below), I think it's 2.6.24 material.
Andrew?

> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

---
From: Nigel Cunningham <nigel@tuxonice.net>

In 2.6.24-rc8, call_usermodehelper_exec has an exit path that can leave
the helper_lock() call at the top of the routine unbalanced.  Fix it.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
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
 
