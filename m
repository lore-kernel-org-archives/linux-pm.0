From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v2 2/5] OOM: thaw the OOM victim if it is frozen
Date: Sun, 7 Dec 2014 08:59:40 -0500
Message-ID: <20141207135940.GB19034@htj.dyndns.org>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <1417797707-31699-3-git-send-email-mhocko@suse.cz>
 <20141206130657.GC18711@htj.dyndns.org>
 <20141207102430.GF15892@dhcp22.suse.cz>
 <20141207104539.GK15892@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141207104539.GK15892@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 07, 2014 at 11:45:39AM +0100, Michal Hocko wrote:
....
>  void mark_tsk_oom_victim(struct task_struct *tsk)
>  {
>  	set_tsk_thread_flag(tsk, TIF_MEMDIE);
> +	__thaw_task(tsk);

Yeah, this is a lot better.  Maybe we can add a comment at least
pointing readers to where to look at to understand what's going on?
This stems from the fact that OOM killer which essentially is a memory
reclaim operation overrides freezing.  It'd be nice if that is
documented somehow.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
