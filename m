From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Thu, 25 Aug 2011 17:21:40 +0900
Message-ID: <20110825172140.eb34809f.kamezawa.hiroyu__49967.4710831188$1314261208$gmane$org@jp.fujitsu.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-4-git-send-email-tj@kernel.org>
	<20110825093958.75b95bd8.kamezawa.hiroyu@jp.fujitsu.com>
	<20110825082049.GC3286@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110825082049.GC3286@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Aug 2011 10:20:49 +0200
Tejun Heo <tj@kernel.org> wrote:

> Hello, KAMEZAWA.
> 

> > > @@ -5460,8 +5460,9 @@ static void mem_cgroup_clear_mc(void)
> > >  
> > >  static int mem_cgroup_can_attach(struct cgroup_subsys *ss,
> > >  				struct cgroup *cgroup,
> > > -				struct task_struct *p)
> > > +				struct cgroup_taskset *tset)
> > >  {
> > > +	struct task_struct *p = cgroup_taskset_first(tset);
> > >  	int ret = 0;
> > >  	struct mem_cgroup *mem = mem_cgroup_from_cont(cgroup);
> > >  
> > 
> > Ah..hmm. I think this doesn't work as expected for memcg.
> > Maybe code like this will be required.
> 
> Hmmm... the above is basically identity transformation of the existing
> code.  If the above is broken, the current code is broken too.  Is it?
> 
Current code is not broken.

mem_cgroup_can_attach(....., task) need to do real job only when task->mm->owner
== task. In this modification, you pass a set of task at once.
So, mem_cgroup_can_attach() need to check _all_ tasks in tset rather than a
first task in tset. please scan and find mm->owner.

Anyway, if you merge this onto mm-tree first, I think I can have time to
write a fix up if complicated.

Thanks,
-Kame
