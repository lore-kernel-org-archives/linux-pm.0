From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH 3/4] OOM, PM: OOM killed task shouldn't escape PM suspend
Date: Mon, 10 Nov 2014 17:30:55 +0100
Message-ID: <20141110163055.GC18373@dhcp22.suse.cz>
References: <20141105160115.GA28226@dhcp22.suse.cz>
 <20141105162929.GD14386@htj.dyndns.org>
 <20141105163956.GD28226@dhcp22.suse.cz>
 <20141105165428.GF14386@htj.dyndns.org>
 <20141105174609.GE28226@dhcp22.suse.cz>
 <20141105175527.GH14386@htj.dyndns.org>
 <20141106124953.GD7202@dhcp22.suse.cz>
 <20141106150121.GA25642@htj.dyndns.org>
 <20141106160223.GJ7202@dhcp22.suse.cz>
 <20141106162845.GD25642@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141106162845.GD25642@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 06-11-14 11:28:45, Tejun Heo wrote:
> On Thu, Nov 06, 2014 at 05:02:23PM +0100, Michal Hocko wrote:
[...]
> > > We're doing one thing for non-PM freezing and the other way around for
> > > PM freezing, which indicates one of the two directions is wrong.
> > 
> > Because those two paths are quite different in their requirements. The
> > cgroup freezer only cares about freezing tasks and it doesn't have to
> > care about tasks accessing a possibly half suspended device on their way
> > out.
> 
> I don't think the fundamental relationship between freezing and oom
> killing are different between the two and the failure to recognize
> that is what's leading to these weird issues.

I do not understand the above. Could you be more specific, please?
AFAIU cgroup freezer requires that no task will leak into userspace
while the cgroup is frozen. This is naturally true for the OOM path
whether the two are synchronized or not.
The PM freezer, on the other hand, requires that no task is _woken up_
after all tasks are frozen. This requires synchronization between the
freezer and OOM path because allocations are allowed also after tasks
are frozen.
What am I missing?

> > > Shouldn't it be that OOM killing happening while PM freezing is in
> > > progress cancels PM freezing rather than the other way around?  Find a
> > > point in PM suspend/hibernation operation where everything must be
> > > stable, disable OOM killing there and check whether OOM killing
> > > happened inbetween and if so back out. 
> > 
> > This is freeze_processes AFAIU. I might be wrong of course but this is
> > the time since when nobody should be waking processes up because they
> > could access half suspended devices.
> 
> No, you're doing it before freezing starts.  The system is in no way
> in a quiescent state at that point.

You are right! Userspace shouldn't see any unexpected allocation
failures just because PM freezing is in progress. This whole process
should be transparent from userspace POV.

I am getting back to
	oom_killer_lock();
	error = try_to_freeze_tasks();
	if (!error)
		oom_killer_disable();
	oom_killer_unlock();

Thanks!
-- 
Michal Hocko
SUSE Labs
