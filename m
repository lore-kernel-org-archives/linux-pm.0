From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC 1/4] OOM, PM: Do not miss OOM killed frozen tasks
Date: Fri, 14 Nov 2014 12:55:34 -0500
Message-ID: <20141114175534.GH25889@htj.dyndns.org>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1415818732-27712-1-git-send-email-mhocko@suse.cz>
 <1415818732-27712-2-git-send-email-mhocko@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1415818732-27712-2-git-send-email-mhocko@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello, Michal.

On Wed, Nov 12, 2014 at 07:58:49PM +0100, Michal Hocko wrote:
> Also change the return value semantic as the current one is little bit
> awkward. There is just one caller (try_to_freeze_tasks) which checks
> the return value and it is only interested whether the request was
> successful or the task blocks the freezing progress. It is natural to
> reflect the success by true rather than false.

I don't know about this.  It's also customary to return %true when
further action needs to be taken.  I don't think either is
particularly wrong but the flip seems gratuitous.

>  bool freeze_task(struct task_struct *p)
>  {
> @@ -129,12 +130,20 @@ bool freeze_task(struct task_struct *p)
>  	 * normally.
>  	 */
>  	if (freezer_should_skip(p))
> +		return true;
> +
> +	/*
> +	 * Do not check freezing state or attempt to freeze a task
> +	 * which has been killed by OOM killer. We are just waiting
> +	 * for the task to wake up and die.

Maybe saying sth like "consider the task freezing as ...." is a
clearer way to put it?

> +	 */
> +	if (!test_tsk_thread_flag(p, TIF_MEMDIE))
>  		return false;

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
