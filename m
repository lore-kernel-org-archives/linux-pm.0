From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH 3/4] OOM, PM: OOM killed task shouldn't escape PM suspend
Date: Tue, 21 Oct 2014 15:14:45 +0200
Message-ID: <20141021131445.GC9415@dhcp22.suse.cz>
References: <1413876435-11720-1-git-send-email-mhocko@suse.cz>
 <1413876435-11720-4-git-send-email-mhocko@suse.cz>
 <3778374.avm26S62SZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50003 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300AbaJUNOr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Oct 2014 09:14:47 -0400
Content-Disposition: inline
In-Reply-To: <3778374.avm26S62SZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>

On Tue 21-10-14 14:09:27, Rafael J. Wysocki wrote:
[...]
> > @@ -131,12 +132,40 @@ int freeze_processes(void)
> >  
> >  	printk("Freezing user space processes ... ");
> >  	pm_freezing = true;
> > +	oom_kills_saved = oom_kills_count();
> >  	error = try_to_freeze_tasks(true);
> >  	if (!error) {
> > -		printk("done.");
> >  		__usermodehelper_set_disable_depth(UMH_DISABLED);
> >  		oom_killer_disable();
> > +
> > +		/*
> > +		 * There might have been an OOM kill while we were
> > +		 * freezing tasks and the killed task might be still
> > +		 * on the way out so we have to double check for race.
> > +		 */
> > +		if (oom_kills_count() != oom_kills_saved) {
> > +			struct task_struct *g, *p;
> > +
> > +			read_lock(&tasklist_lock);
> > +			for_each_process_thread(g, p) {
> > +				if (p == current || freezer_should_skip(p) ||
> > +				    frozen(p))
> > +					continue;
> > +				error = -EBUSY;
> > +				goto out_loop;
> > +			}
> > +out_loop:
> 
> Well, it looks like this will work here too:
> 
> 			for_each_process_thread(g, p)
> 				if (p != current && !frozen(p) &&
> 				    !freezer_should_skip(p)) {
> 					error = -EBUSY;
> 					break;
> 				}
> 
> or I am helplessly misreading the code.

break will not work because for_each_process_thread is a double loop.
Except for that the negated condition is OK as well. I can change that
if you prefer.

> > +			read_unlock(&tasklist_lock);
> > +
> > +			if (error) {
> > +				__usermodehelper_set_disable_depth(UMH_ENABLED);
> > +				printk("OOM in progress.");
> > +				goto done;
> > +			}
> > +		}
> > +		printk("done.");
> >  	}
> > +done:
> >  	printk("\n");
> >  	BUG_ON(in_atomic());
> >  
-- 
Michal Hocko
SUSE Labs
