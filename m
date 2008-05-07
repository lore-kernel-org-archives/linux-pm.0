From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/2] Freezer: Try to handle killable
	tasks
Date: Wed, 7 May 2008 11:41:50 +0200
Message-ID: <20080507094150.GG13858__22896.6051633053$1210153496$gmane$org@elf.ucw.cz>
References: <200805070003.56387.rjw@sisk.pl> <200805070007.56998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805070007.56998.rjw@sisk.pl>
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
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Liam Howlett <howlett@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-05-07 00:07:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The introduction of TASK_KILLABLE allows the freezer to work in some situation
> that it could not handle before.
> 
> Make the freezer handle killable tasks and add try_to_freeze() in some places
> where it is safe to freeze a (killable) task.  Introduce the
> wait_event_killable_freezable() macro to be used wherever the freezing of
> a waiting killable task is desirable.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  fs/nfs/inode.c          |    2 ++
>  fs/nfs/nfs3proc.c       |    2 ++
>  fs/nfs/nfs4proc.c       |    4 ++++
>  fs/nfs/pagelist.c       |    8 ++++++--
>  fs/smbfs/request.c      |    2 ++
>  include/linux/freezer.h |   20 +++++++++++++++++---
>  kernel/mutex.c          |    3 +++
>  kernel/power/process.c  |    6 ++++--
>  kernel/sched.c          |    2 ++
>  net/sunrpc/sched.c      |    2 ++
>  10 files changed, 44 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6/fs/nfs/nfs3proc.c
> ===================================================================
> --- linux-2.6.orig/fs/nfs/nfs3proc.c
> +++ linux-2.6/fs/nfs/nfs3proc.c
> @@ -17,6 +17,7 @@
>  #include <linux/nfs_page.h>
>  #include <linux/lockd/bind.h>
>  #include <linux/nfs_mount.h>
> +#include <linux/freezer.h>
>  
>  #include "iostat.h"
>  #include "internal.h"
> @@ -33,6 +34,7 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, 
>  		if (res != -EJUKEBOX)
>  			break;
>  		schedule_timeout_killable(NFS_JUKEBOX_RETRY_TIME);
> +		try_to_freeze();
>  		res = -ERESTARTSYS;
>  	} while (!fatal_signal_pending(current));
>  	return res;
> Index: linux-2.6/fs/nfs/nfs4proc.c
> ===================================================================
> --- linux-2.6.orig/fs/nfs/nfs4proc.c
> +++ linux-2.6/fs/nfs/nfs4proc.c
> @@ -48,6 +48,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/namei.h>
>  #include <linux/mount.h>
> +#include <linux/freezer.h>
>  
>  #include "nfs4_fs.h"
>  #include "delegation.h"
> @@ -2788,6 +2789,7 @@ static int nfs4_wait_bit_killable(void *
>  	if (fatal_signal_pending(current))
>  		return -ERESTARTSYS;
>  	schedule();
> +	try_to_freeze();
>  	return 0;
>  }

I'd say try_to_freeze() belongs close to the other signal check,
i.e. before schedule?

> @@ -180,10 +182,12 @@ static int nfs_wait_bit_killable(void *w
>  {
>  	int ret = 0;
>  
> -	if (fatal_signal_pending(current))
> +	if (fatal_signal_pending(current)) {
>  		ret = -ERESTARTSYS;
> -	else
> +	} else {
>  		schedule();
> +		try_to_freeze();
> +	}

Same here?

> @@ -109,6 +110,7 @@ struct smb_request *smb_alloc_request(st
>  			return ERR_PTR(-ERESTARTSYS);
>  		current->policy = SCHED_YIELD;
>  		schedule();
> +		try_to_freeze();

And here?

> @@ -182,6 +183,8 @@ __mutex_lock_common(struct mutex *lock, 
>  		/* didnt get the lock, go to sleep: */
>  		spin_unlock_mutex(&lock->wait_lock, flags);
>  		schedule();
> +		if (state == TASK_KILLABLE)
> +			try_to_freeze();
>  		spin_lock_mutex(&lock->wait_lock, flags);
>  	}
>  

I'm not comfortable with this one. Can the task be killable, but still
hold some _other_ mutex? (and then release it only if it actually gets
the signal?)


> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -4769,6 +4769,8 @@ do_wait_for_common(struct completion *x,
>  			__set_current_state(state);
>  			spin_unlock_irq(&x->wait.lock);
>  			timeout = schedule_timeout(timeout);
> +			if (state == TASK_KILLABLE)
> +				try_to_freeze();
>  			spin_lock_irq(&x->wait.lock);
>  			if (!timeout) {
>  				__remove_wait_queue(&x->wait, &wait);

Same here. I can't see why we could not be holding mutexes.

> @@ -227,6 +228,7 @@ static int rpc_wait_bit_killable(void *w
>  	if (fatal_signal_pending(current))
>  		return -ERESTARTSYS;
>  	schedule();
> +	try_to_freeze();
>  	return 0;
>  }

Swap?

> @@ -426,6 +427,7 @@ static int nfs_wait_schedule(void *word)
>  	if (signal_pending(current))
>  		return -ERESTARTSYS;
>  	schedule();
> +	try_to_freeze();
>  	return 0;
>  }
>  

Swap?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
