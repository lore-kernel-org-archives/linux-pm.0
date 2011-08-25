From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fuse: Freeze client on suspend when request
	sent to userspace
Date: Thu, 25 Aug 2011 16:20:07 +0200
Message-ID: <87hb55fu94.fsf__19000.7320525639$1314282068$gmane$org@tucsk.pomaz.szeredi.hu>
References: <1314230364-776-1-git-send-email-toddpoynor@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314230364-776-1-git-send-email-toddpoynor@google.com> (Todd
	Poynor's message of "Wed, 24 Aug 2011 16:59:24 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Todd Poynor <toddpoynor@google.com> writes:

> Suspend attempts can abort when the FUSE daemon is already frozen
> and a client is waiting uninterruptibly for a response, causing
> freezing of tasks to fail.
>
> Use the freeze-friendly wait API, but disregard other signals.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
> Have seen reports in which repeated suspend attempts were aborted
> due to a task waiting uninterruptibly in this function, but
> have only reproduced this artificially, by causing the daemon to
> sleep.  Only modified the normal request path, not request aborts
> and such, under the assumption that these should be rare and
> should make progress upon resume.  Certain apps that read or
> write a lot of data on the filesystem may apparently run into
> this case rather frequently.


Yes, this is a well known problem with no (known) trivial solutions.

Problem with the patch is, it's going to solve only a subset of the
suspend aborts.  It will allow any operation sent to userspace to
freeze, which is fine.  But imagine that such a request is holding a VFS
lock (e.g. write(2) is hoding i_mutex) and another operation is waiting
on that lock.  That one still won't be freezable and will prevent
suspend to proceed.

I'm not sure it's really worth fixing only a subset of the problematic
cases.  We should definitely be thinking about solving it properly, in
all cases.

Thanks,
Miklos

>
>  fs/fuse/dev.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 168a80f..bded2e5 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -19,6 +19,7 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/swap.h>
>  #include <linux/splice.h>
> +#include <linux/freezer.h>
>  
>  MODULE_ALIAS_MISCDEV(FUSE_MINOR);
>  MODULE_ALIAS("devname:fuse");
> @@ -383,7 +384,10 @@ __acquires(fc->lock)
>  	 * Wait it out.
>  	 */
>  	spin_unlock(&fc->lock);
> -	wait_event(req->waitq, req->state == FUSE_REQ_FINISHED);
> +
> +	while (req->state != FUSE_REQ_FINISHED)
> +		wait_event_freezable(req->waitq,
> +				     req->state == FUSE_REQ_FINISHED);
>  	spin_lock(&fc->lock);
>  
>  	if (!req->aborted)
