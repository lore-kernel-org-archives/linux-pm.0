From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] freezer: remove obsolete comments in __thaw_task()
Date: Tue, 21 Oct 2014 14:04:14 +0200
Message-ID: <706964547.3XIII6QxY2@vostro.rjw.lan>
References: <1413876435-11720-1-git-send-email-mhocko@suse.cz> <1413876435-11720-3-git-send-email-mhocko@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1413876435-11720-3-git-send-email-mhocko@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 21, 2014 09:27:13 AM Michal Hocko wrote:
> From: Cong Wang <xiyou.wangcong@gmail.com>
> 
> __thaw_task() no longer clears frozen flag since commit a3201227f803
> (freezer: make freezing() test freeze conditions in effect instead of TIF_FREEZE).
> 
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Michal Hocko <mhocko@suse.cz>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

ACK

> ---
>  kernel/freezer.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 8f9279b9c6d7..a8900a3bc27a 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -150,12 +150,6 @@ void __thaw_task(struct task_struct *p)
>  {
>  	unsigned long flags;
>  
> -	/*
> -	 * Clear freezing and kick @p if FROZEN.  Clearing is guaranteed to
> -	 * be visible to @p as waking up implies wmb.  Waking up inside
> -	 * freezer_lock also prevents wakeups from leaking outside
> -	 * refrigerator.
> -	 */
>  	spin_lock_irqsave(&freezer_lock, flags);
>  	if (frozen(p))
>  		wake_up_process(p);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
