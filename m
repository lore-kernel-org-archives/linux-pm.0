From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH -v2 5/5] OOM, PM: make OOM detection in the freezer path
 raceless
Date: Wed, 7 Jan 2015 19:48:47 +0100
Message-ID: <20150107184847.GH16553@dhcp22.suse.cz>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <1417797707-31699-6-git-send-email-mhocko@suse.cz>
 <20150107184124.GI4395@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20150107184124.GI4395@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 07-01-15 13:41:24, Tejun Heo wrote:
> Hello, Michal.  Sorry about the long delay.
> 
> On Fri, Dec 05, 2014 at 05:41:47PM +0100, Michal Hocko wrote:
> ...
> > @@ -252,6 +220,8 @@ void thaw_kernel_threads(void)
> >  {
> >  	struct task_struct *g, *p;
> >  
> > +	oom_killer_enable();
> > +
> 
> Wouldn't it be more symmetrical and make more sense to enable oom
> killer after kernel threads are thawed?  Until kernel threads are
> thawed, it isn't guaranteed that oom killer would be able to make
> forward progress, right?

Makes sense, fixed.

> Other than that, looks good to me.

Thanks! Btw. I plan to repost after Andrew releases new mmotm as there
are some dependencies in oom area.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
