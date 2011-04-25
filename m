From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] freezer: use smp barriers
Date: Mon, 25 Apr 2011 12:38:35 +0200
Message-ID: <201104251238.36005.rjw__22766.6551051245$1303727984$gmane$org@sisk.pl>
References: <1303716665-27584-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1303716665-27584-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 25, 2011, Mike Frysinger wrote:
> The freezer processes are dealing with multiple threads running
> simultaneously, and on a UP system, the memory reads/writes do
> not need barriers to keep things in sync.  These are only needed
> on SMP systems, so use SMP barriers instead.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  kernel/freezer.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 66ecd2e..7b01de9 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -17,7 +17,7 @@ static inline void frozen_process(void)
>  {
>  	if (!unlikely(current->flags & PF_NOFREEZE)) {
>  		current->flags |= PF_FROZEN;
> -		wmb();
> +		smp_wmb();
>  	}
>  	clear_freeze_flag(current);
>  }
> @@ -93,7 +93,7 @@ bool freeze_task(struct task_struct *p, bool sig_only)
>  	 * the task as frozen and next clears its TIF_FREEZE.
>  	 */
>  	if (!freezing(p)) {
> -		rmb();
> +		smp_rmb();
>  		if (frozen(p))
>  			return false;
>  
> 
