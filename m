From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] (2.4.25 material?) Fix unbalanced
 helper_lock in kernel/kmod.c
Date: Thu, 17 Jan 2008 11:23:32 -0800
Message-ID: <20080117112332.9e34b7d9.akpm@linux-foundation.org>
References: <478EA17B.30601@nigel.suspend2.net>
	<200801171902.44133.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171902.44133.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, nigel@nigel.suspend2.net, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Jan 2008 19:02:43 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday, 17 of January 2008, Nigel Cunningham wrote:
> > Hi all.
> 
> Hi,
> 
> > First up, sorry for not inlining the patch - trouble with line wrapping.
> 
> No big deal.
> 
> > In 2.6.24-rc8, call_usermodehelper_exec has an exit path that can leave
> > the helper_lock() call at the top of the routine unbalanced. The
> > attached patch fixes this issue.
> 
> Thanks a lot for the patch (reproduced below), I think it's 2.6.24 material.
> Andrew?
> 
> > Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
> 
> ---
> From: Nigel Cunningham <nigel@tuxonice.net>
> 
> In 2.6.24-rc8, call_usermodehelper_exec has an exit path that can leave
> the helper_lock() call at the top of the routine unbalanced.  Fix it.
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index c6a4f8a..de27e15 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -468,8 +468,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info,
>  	sub_info->wait = wait;
>  
>  	queue_work(khelper_wq, &sub_info->work);
> -	if (wait == UMH_NO_WAIT) /* task has freed sub_info */
> +	if (wait == UMH_NO_WAIT) { /* task has freed sub_info */
> +		helper_unlock();
>  		return 0;
> +	}
>  	wait_for_completion(&done);
>  	retval = sub_info->retval;
>  

Yup, I ended up queueing this:

From: Nigel Cunningham <nigel@nigel.suspend2.net>

call_usermodehelper_exec() has an exit path that can leave the
helper_lock() call at the top of the routine unbalanced.  The attached
patch fixes this issue.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kmod.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff -puN kernel/kmod.c~fix-unbalanced-helper_lock-in-kernel-kmodc kernel/kmod.c
--- a/kernel/kmod.c~fix-unbalanced-helper_lock-in-kernel-kmodc
+++ a/kernel/kmod.c
@@ -451,13 +451,11 @@ int call_usermodehelper_exec(struct subp
 			     enum umh_wait wait)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	int retval;
+	int retval = 0;
 
 	helper_lock();
-	if (sub_info->path[0] == '\0') {
-		retval = 0;
+	if (sub_info->path[0] == '\0')
 		goto out;
-	}
 
 	if (!khelper_wq || usermodehelper_disabled) {
 		retval = -EBUSY;
@@ -468,13 +466,14 @@ int call_usermodehelper_exec(struct subp
 	sub_info->wait = wait;
 
 	queue_work(khelper_wq, &sub_info->work);
-	if (wait == UMH_NO_WAIT) /* task has freed sub_info */
-		return 0;
+	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
+		goto unlock;
 	wait_for_completion(&done);
 	retval = sub_info->retval;
 
-  out:
+out:
 	call_usermodehelper_freeinfo(sub_info);
+unlock:
 	helper_unlock();
 	return retval;
 }
_
